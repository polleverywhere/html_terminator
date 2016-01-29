require "html_terminator/version"
require "html_terminator/extract_options"
require 'sanitize'

module HtmlTerminator
  SANITIZE_OPTIONS = {
    :elements => []
  }

  def self.sanitize(val, config)
    if val.is_a?(String)
      # Sanitize produces escaped content.
      # Unescape it to get the raw html
      CGI.unescapeHTML Sanitize.fragment(val, config).strip
    else
      val
    end
  end

  module ClassMethods
    def terminate_html(*args)
      class_attribute :html_terminator_fields
      class_attribute :html_terminator_options

      # Table may not exist yet when schema is initially getting loaded
      if self.table_exists?
        # By default all fields are to be seen by the terminator
        self.html_terminator_fields = self.columns.inject([]) do |list, col|
          if col.type == :string or col.type == :text
            list << col.name.to_sym
          end

          list
        end

        self.html_terminator_options = SANITIZE_OPTIONS.merge(args.extract_options!)
        self.html_terminator_fields = args if args.length > 0

        # Handle exceptions
        exceptions = self.html_terminator_options.delete(:except) || []
        self.html_terminator_fields -= (exceptions)

        unless self.html_terminator_fields.empty?
          # sanitize writes
          before_validation :terminate_html

          # sanitize reads
          self.html_terminator_fields.each do |attr|
            define_method(attr) do |*rargs|
              # sanitize it
              HtmlTerminator.sanitize super(*rargs), self.html_terminator_options
            end
          end
        end
      end
    end
  end

  module InstanceMethods
    def terminate_html
      self.html_terminator_fields.each do |field|
        value = self[field]

        unless value.nil?
          self[field] = HtmlTerminator.sanitize(value, self.html_terminator_options)
        end
      end
    end
  end

  def self.included(base)
    base.send :extend, ClassMethods
    base.send :include, InstanceMethods
  end
end

ActiveRecord::Base.send :include, HtmlTerminator
