class DeadSimpleReportsGenerator < Rails::Generator::Base 
  
  def manifest
    record do |r|
      r.migration_template 'migration.rb', "db/migrate"
    end
  end
  
  def file_name
    "create_dead_simple_reports" 
  end
  
end