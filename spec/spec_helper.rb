require "rubygems"
require "bundler/setup"

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require "support/active_record"
require "active_support"
require "active_support/core_ext/string/output_safety.rb"