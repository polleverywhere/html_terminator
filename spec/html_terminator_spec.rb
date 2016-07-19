require "spec_helper"

describe HtmlTerminator do
  it "sanitizes only fields specified" do
    user = OnlyFirstName.new

    user.first_name = "Hello <img>"
    expect(user.first_name).to eql("Hello")

    user.last_name = "Hello <img>"
    expect(user.last_name).to eql("Hello <img>")

    user.age = 3
    expect(user.age).to eql(3)
  end

  it "doesn't escape ampersands" do
    user = OnlyFirstName.new

    user.first_name = "A & B & C"
    expect(user.first_name).to eql("A & B & C")
  end

  it "skips sanitize when only one bracket" do
    user = OnlyFirstName.new

    user.first_name = "1 < 2"
    expect(user.first_name).to eql("1 < 2")

    user.first_name = "2 > 1"
    expect(user.first_name).to eql("2 > 1")
  end

  it "handles ampersands" do
    user = OnlyFirstName.new

    user.first_name = "Mr. & Mrs. Smith"
    expect(user.first_name).to eql("Mr. & Mrs. Smith")
  end

  it "doesn't blow up if value is not a string" do
    user = OnlyFirstName.new
    user.first_name = 1
    expect(user.first_name).to eql("1")
  end

  it "honors options that are passed in" do
    user = FirstNameWithOptions.new
    user.first_name = "Hello <flexbox></flexbox><hr><br><img>"
    expect(user.first_name).to eql("Hello <flexbox></flexbox>")
  end

  describe "#sanitize" do
    it "strips out all html by default" do
      val = HtmlTerminator.sanitize "<flexbox></flexbox><hr><br><img>"
      expect(val).to eql("")
    end

    it "marks the output as html_safe" do
      val = HtmlTerminator.sanitize "<flexbox></flexbox><hr><br><img>"
      expect(val.html_safe?).to eql(true)
    end
  end

  it "sanitizes different fields with different options" do
    user = TwoFieldsWithOptions.new
    user.first_name = "Hello <br><strong>strong</strong><em>em</em>"
    user.last_name = "Hello <br><strong>strong</strong><em>em</em>"

    expect(user.first_name).to eql("Hello  <strong>strong</strong>em")
    expect(user.last_name).to eql("Hello  strong<em>em</em>")
  end

  it "sanitizes on validation" do
    user = TwoFieldsWithOptions.new
    user.first_name = "Hello <br><strong>strong</strong><em>em</em>"
    user.last_name = "Hello <br><strong>strong</strong><em>em</em>"
    user.valid?

    expect(user.read_attribute(:first_name)).to eql("Hello  <strong>strong</strong>em")
    expect(user.read_attribute(:last_name)).to eql("Hello  strong<em>em</em>")
  end
end
