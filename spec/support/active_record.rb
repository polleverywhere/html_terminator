require "active_record"
require "html_terminator"

ActiveRecord::Base.establish_connection({
  :adapter => "sqlite3",
  :database => ":memory:"
})

ActiveRecord::Schema.define do
  create_table "only_first_names", :force => true do |t|
    t.column "first_name",  :text
    t.column "last_name",  :text
    t.column "age", :integer
  end

  create_table "two_fields_with_options", :force => true do |t|
    t.column "first_name",  :text
    t.column "last_name",  :text
    t.column "age", :integer
  end

  create_table "first_name_with_options", :force => true do |t|
    t.column "first_name",  :text
    t.column "last_name",  :text
    t.column "age", :integer
  end
end

class OnlyFirstName < ActiveRecord::Base
  include HtmlTerminator

  terminate_html :first_name
end

class TwoFieldsWithOptions < ActiveRecord::Base
  include HtmlTerminator

  terminate_html :first_name, elements: ["strong"]
  terminate_html :last_name, elements: ["em"]
end

class FirstNameWithOptions < ActiveRecord::Base
  include HtmlTerminator

  terminate_html :first_name, :elements => ["flexbox"]
end
