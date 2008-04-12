require 'rubygems'
gem 'activerecord'
require 'activerecord'

__DIR__ = File.dirname __FILE__

FileUtils.rm_rf __DIR__ + '/../test.sqlite3'
ActiveRecord::Base.establish_connection :adapter => 'sqlite3', :database => File.join(File.dirname(__FILE__), '..', 'test.sqlite3')

# migrate

require File.dirname(__FILE__) + '/../generators/dead_simple_reports/templates/migration'
CreateDeadSimpleReports.up

# rails controller stuff

class ApplicationController
  class MimeTypeFormat
    
    [:html, :csv, :xls].each do |mime_type|
    
      eval <<-CODE
      def #{mime_type}(&block)
        @#{mime_type}_block = block
      end
      
      def #{mime_type}_view
        @#{mime_type}_block.call
      end
      
      CODE
      
    end
    
  end
  
  def respond_to(&formatter)
    @format = MimeTypeFormat.new
    formatter.call @format
    @format
  end
  
  def params
    {}
  end
  
  def headers
    {}
  end
  
  def render(options = {})
    @view = options[:text]
  end
  
  def view
    @view
  end
end