require "html_terminator/version"
require "html_terminator/extract_options"
require "sanitize"

module HtmlTerminator
  SANITIZE_OPTIONS = {
    :elements => []
  }

  def self.sanitize(val, config = {})
    if val.is_a?(String)
      # Sanitize produces escaped content.
      # Unescape it to get the raw html
      CGI.unescapeHTML(Sanitize.fragment(val, config).strip)
    else
      val
    end
  end

  module ClassMethods
    def fields
      self.columns.inject([]) do |list, col|
        if col.type == :string or col.type == :text
          list << col.name.to_sym
        end

        list
      end
    end

    def terminate_html(*args)
      # object key/value of field => options
      unless method_defined?(:html_terminator_fields)
        class_attribute :html_terminator_fields
        self.html_terminator_fields = {}
      end

      options = args.extract_options!
      options = SANITIZE_OPTIONS.clone.merge(options)

      args.each do |field|
        self.html_terminator_fields[field] = options.deep_dup
      end

      unless self.html_terminator_fields.empty?
        before_validation :terminate_html

        # sanitize reads
        args.each do |attr|
          define_method(attr) do |*rargs|
            # sanitize it
            HtmlTerminator.sanitize super(*rargs), options
          end
        end
      end
    end
  end

  module InstanceMethods
    def terminate_html
      self.html_terminator_fields.each do |field, options|
        value = self[field]

        unless value.nil?
          self[field] = HtmlTerminator.sanitize(value, options)
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
