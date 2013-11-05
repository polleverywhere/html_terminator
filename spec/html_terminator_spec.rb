require 'spec_helper'

describe HtmlTerminator do
  it "should terminate name only fields specified" do
    @user = User.new

    @user.first_name = "Hello <img>"
    @user.first_name.should == "Hello"

    @user.last_name = "Hello <img>"
    @user.last_name.should == "Hello <img>"

    @user.age = 3
    @user.age.should == 3
  end

  it "should terminate all except what is specified" do
    @student = Student.new

    @student.first_name = "Hello <img>"
    @student.first_name.should == "Hello <img>"

    @student.last_name = "Hello <img>"
    @student.last_name.should == "Hello"
  end
end