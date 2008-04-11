class Report < ActiveRecord::Base
  
  validates_presence_of :code, :name, :kind
  validates_uniqueness_of :name
  
  
  def run
    if kind == 'sql'
      ActiveRecord::Base.connection.select_all(code).map(&:values)
    else
      eval(code)
    end
  end
end
