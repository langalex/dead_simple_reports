require 'fileutils'

dir = File.dirname(__FILE__)
FileUtils.cp Dir[File.join(dir, 'lib', 'controllers', '*.rb')], File.join(dir, '../../../app/controllers')
FileUtils.cp_r Dir[File.join(dir, 'views', '*')], File.join(dir, '../../../app/views')


puts IO.read(File.join(File.dirname(__FILE__), 'INSTALL'))