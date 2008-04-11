class ReportsController < ApplicationController

  def index
    @reports = Report.find :all
  end
  
  def show
    @report = Report.find(params[:id])
    @results = @report.run
    respond_to do |format|
      format.html do
        if @results.is_a? Array
          @results = @results.inject('<table>') do |table, row|
            table << '<tr>'
            table << row.inject('') {|_row, cell| _row << "<td>#{cell.to_s}</td>"}
            table << '</tr>'
          end << '</table>'
        end
      end
      format.csv do
        if @results.is_a? Array
          @results = @results.inject('') do |table, row|
            table << row.map {|cell| cell.to_s.gsub(/\s+/, ' ')}.join(';')
            table << "\n"
          end
        end
        render :text => @results
      end
    end
  end
  
end
