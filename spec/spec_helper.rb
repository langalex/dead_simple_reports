require 'rubygems'
gem 'activerecord'
require 'activerecord'

__DIR__ = File.dirname __FILE__

FileUtils.rm_rf __DIR__ + '/../test.sqlite3'
ActiveRecord::Base.establish_connection :adapter => 'sqlite3', :database => File.join(File.dirname(__FILE__), '..', 'test.sqlite3')

# migrate

require File.dirname(__FILE__) + '/../generators/dead_simple_reports/templates/migration'
CreateDeadSimpleReports.up