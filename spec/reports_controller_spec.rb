require File.dirname(__FILE__) + '/spec_helper'

describe 'ReportsController' do
  
  class Report; end
  require File.dirname(__FILE__) + '/../lib/controllers/reports_controller'
  
  before(:each) do
    @controller = ReportsController.new
  end
  
  describe "index" do
    it "should load all reports" do
      Report.should_receive(:find).with(:all)
      @controller.index
    end
    
    it "should assign the reports" do
      Report.stub!(:find).and_return(:reports)
      @controller.index
      @controller.instance_eval("@reports").should == :reports
    end
  end
  
  describe ReportsController, 'show' do
    
    before(:each) do
      report = stub 'report', :run => [['hello', 'world']], :name => 'report1'
      Report.stub!(:find).and_return(report)
    end
    
    it "should render an html table" do
      @controller.show.html_view
      @controller.instance_eval("@table").should == '<table><tr><td>hello</td><td>world</td></tr></table>'
    end
    
    it "should render a csv table" do
      @controller.show.csv_view
      @controller.view.should == "hello;world\n"
    end
    
    it "should render an excel file" do
      @controller.show.xls_view
      @controller.view.should include('hello')
      @controller.view.should include('world')
    end
    
    it "should render the orginal string if iconv raises an illegal sequence error" do
      Iconv.stub!(:conv).and_raise(Iconv::IllegalSequence.new(nil, nil, nil))
      @controller.show.xls_view
      @controller.view.should include('hello')
      @controller.view.should include('world')
    end
    
    it "should render the orginal string if iconv raises an illegal character error" do
      Iconv.stub!(:conv).and_raise(Iconv::InvalidCharacter.new(nil, nil, nil))
      @controller.show.xls_view
      @controller.view.should include('hello')
      @controller.view.should include('world')
    end
  end
  
end