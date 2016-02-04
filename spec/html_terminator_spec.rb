require "spec_helper"

describe HtmlTerminator do
  it "sanitizes only fields specified" do
    user = OnlyFirstName.new

    user.first_name = "Hello <img>"
    user.first_name.should == "Hello"

    user.last_name = "Hello <img>"
    user.last_name.should == "Hello <img>"

    user.age = 3
    user.age.should == 3
  end

  it "doesn't escape ampersands" do
    user = OnlyFirstName.new

    user.first_name = "A & B & C"
    user.first_name.should == "A & B & C"
  end

  it "skips sanitize when only one bracket" do
    user = OnlyFirstName.new

    user.first_name = "1 < 2"
    user.first_name.should == "1 < 2"

    user.first_name = "2 > 1"
    user.first_name.should == "2 > 1"
  end

  it "handles ampersands" do
    user = OnlyFirstName.new

    user.first_name = "Mr. & Mrs. Smith"
    user.first_name.should == "Mr. & Mrs. Smith"
  end

  it "doesn't blow up if value is not a string" do
    user = OnlyFirstName.new
    user.first_name = 1
    user.first_name.should == "1"
  end

  it "honors options that are passed in" do
    user = FirstNameWithOptions.new
    user.first_name = "Hello <flexbox></flexbox><hr><br><img>"
    user.first_name.should == "Hello <flexbox></flexbox>"
  end

  describe "#sanitize" do
    it "strips out all html by default" do
      val = HtmlTerminator.sanitize "<flexbox></flexbox><hr><br><img>"
      val.should == ""
    end

    it "marks the output as html_safe" do
      val = HtmlTerminator.sanitize "<flexbox></flexbox><hr><br><img>"
      val.html_safe?.should == true
    end
  end

  it "sanitizes different fields with different options" do
    user = TwoFieldsWithOptions.new
    user.first_name = "Hello <br><strong>strong</strong><em>em</em>"
    user.last_name = "Hello <br><strong>strong</strong><em>em</em>"

    user.first_name.should == "Hello  <strong>strong</strong>em"
    user.last_name.should == "Hello  strong<em>em</em>"
  end

  it "sanitizes on validation" do
    user = TwoFieldsWithOptions.new
    user.first_name = "Hello <br><strong>strong</strong><em>em</em>"
    user.last_name = "Hello <br><strong>strong</strong><em>em</em>"
    user.valid?

    user.read_attribute(:first_name).should == "Hello  <strong>strong</strong>em"
    user.read_attribute(:last_name).should == "Hello  strong<em>em</em>"
  end
end
