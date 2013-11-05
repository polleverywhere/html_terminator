require "html_terminator/version"
require 'sanitize'

module HtmlTerminator
  SANITIZE_OPTIONS = {
    :elements => ["b", "em", "i", "strong", "u", "br"]
  }

  def self.sanitize(val)
    Sanitize.clean(val, SANITIZE_OPTIONS).strip
  end

  module ClassMethods
    def terminate_html(*args)
      class_attribute :html_terminator_fields

      # By default all fields are to be seen by the terminator
      self.html_terminator_fields = self.columns.inject([]) do |list, col|
        if col.type == :string or col.type == :text
          list << col.name.to_sym
        end

        list
      end

      if args.is_a?(Array)
        self.html_terminator_fields = args
      elsif args.is_a?(Object) and args.include?(:except)
        self.html_terminator_fields -= args[:except]
      end

      unless self.html_terminator_fields.empty?
        # sanitize writes
        before_validation :terminate_html

        # sanitize reads
        self.html_terminator_fields.each do |attr|
          define_method "#{attr}" do |*args|
            # sanitize it
            HtmlTerminator.sanitize super(*args)
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
          self[field] = HtmlTerminator.sanitize(value)
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