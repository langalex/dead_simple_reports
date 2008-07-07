class Report < ActiveRecord::Base
  
  validates_presence_of :code, :name, :kind
  validates_uniqueness_of :name
  
  def run
    if kind == 'sql'
      rows = ActiveRecord::Base.connection.select_all(code)
      header(rows) + rows.map(&:values)
    else
      eval(code)
    end
  end
  
  private
  
  def header(rows)
    if rows.first
      [rows.first.map{|k,v| k}]
    else
      []
    end
  end
end
