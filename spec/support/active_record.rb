require 'active_record'
require 'html_terminator'

ActiveRecord::Base.establish_connection({
  :adapter => 'sqlite3',
  :database => ':memory:'
})

ActiveRecord::Schema.define do
  create_table "users", :force => true do |t|
    t.column "first_name",  :text
    t.column "last_name",  :text
    t.column "age", :integer
  end

  create_table "students", :force => true do |t|
    t.column "first_name",  :text
    t.column "last_name",  :text
    t.column "age", :integer
  end
end

class User < ActiveRecord::Base
  include HtmlTerminator

  terminate_html :first_name
end

class Student < ActiveRecord::Base
  include HtmlTerminator

  terminate_html :except => [:first_name]
end