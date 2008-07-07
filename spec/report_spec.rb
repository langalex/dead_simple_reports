require File.dirname(__FILE__) + '/spec_helper'
require File.dirname(__FILE__) + '/../lib/report'

describe Report do
  before(:each) do
    @report = Report.new
  end

  it "should run the code and return the result" do
    @report.code = "21 + 6"
    @report.run.should == 27
  end
  
  it "should return an array" do
    @report.code = "[]"
    @report.run.should == []
  end
  
  it "should run the sql and return an array of arrays" do
    @report.kind = 'sql'
    @report.code = 'SELECT 1 AS col_1, 2 AS col_2 UNION SELECT 2 AS col_1, 3 AS col_3'
    @report.run.should == [['col_1', 'col_2'], ['1', '2'], ['2', '3']]
  end
  
  it "should return an empty array if no results" do
    @report.kind = 'sql'
    @report.code = 'SELECT 1 WHERE 0'
    @report.run.should == []
  end
end
