require 'fileutils'

dir = File.dirname(__FILE__)
FileUtils.cp File.join(dir, 'lib', 'controllers', 'reports_controller.rb.template'), File.join(dir, '../../../app/controllers/reports_controller.rb')
FileUtils.cp_r Dir[File.join(dir, 'views', '*')], File.join(dir, '../../../app/views')

puts IO.read(File.join(File.dirname(__FILE__), 'INSTALL'))