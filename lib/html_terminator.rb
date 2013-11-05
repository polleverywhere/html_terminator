require "html_terminator/version"
require 'sanitize'

module HtmlTerminator
  SANITIZE_OPTIONS = {
    :elements => ["b", "em", "i", "strong", "u", "br"]
  }

  def self.sanitize(val)
    Sanitize.clean(val, SANITIZE_OPTIONS).strip unless val.nil?
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

      if args.length == 1
        if args[0].is_a?(Symbol)
          self.html_terminator_fields = args
        elsif args[0].is_a?(Object)
          self.html_terminator_fields -= (args[0][:except] || [])
        end
      elsif args.length > 1
        self.html_terminator_fields = args
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