require 'spec_helper'

describe HtmlTerminator do
  it "sanitizes only fields specified" do
    @user = OnlyFirstName.new

    @user.first_name = "Hello <img>"
    @user.first_name.should == "Hello"

    @user.last_name = "Hello <img>"
    @user.last_name.should == "Hello <img>"

    @user.age = 3
    @user.age.should == 3
  end

  it "sanitizes all except what is specified" do
    @user = ExceptFirstName.new

    @user.first_name = "Hello <img>"
    @user.first_name.should == "Hello <img>"

    @user.last_name = "Hello <img>"
    @user.last_name.should == "Hello"
  end

  it "doesn't blow up if value is nil" do
    @user = ExceptFirstName.new
    @user.first_name = nil
    @user.first_name.should == nil
  end

  it "doesn't blow up if value is not a string" do
    @user = OnlyFirstName.new
    @user.first_name = 1
    @user.first_name.should == 1
  end
end