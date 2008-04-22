require "spreadsheet/excel"
require 'iconv'

class ReportsController < ApplicationController
  include Spreadsheet

  def index
    @reports = Report.find :all
  end
  
  def show
    @report = Report.find(params[:id])
    data = @report.run
    respond_to do |format|
      format.html do
        @table = create_html_table data
      end
      format.csv do
        render :text => create_csv_table(data)
        headers['Content-Disposition'] = "attachment; filename=\"#{@report.name.downcase.gsub(/\s+/, '_')}_#{Date.today.to_s}.csv\""
      end
      format.xls do
        render :text => create_excel_table(data)
        headers['Content-Disposition'] = "attachment; filename=\"#{@report.name.downcase.gsub(/\s+/, '_')}_#{Date.today.to_s}.xls\""
        headers['Cache-Control'] = ''
      end
    end
  end
  
  def create_html_table(_table)
    _table.inject('<table>') do |table, row|
      table << '<tr>'
      table << row.inject('') {|_row, cell| _row << "<td>#{cell.to_s}</td>"}
      table << '</tr>'
    end << '</table>'
  end
  
  def create_csv_table(_table)
    _table.inject('') do |table, row|
      table << row.map {|cell| cell.to_s.gsub(/\s+/, ' ')}.join(';')
      table << "\n"
    end
  end
  
  def create_excel_table(_table)
    out = StringIO.new
    workbook = Excel.new(out)
    format = Format.new
    
    worksheet = workbook.add_worksheet
    _table.each_with_index do |row, i| 
      row.each_with_index do |col, j|
        worksheet.write i, j, convert_encoding(col.to_s), format # excel doesn't seem to like utf-8
      end
    end
    
    workbook.close
    out.string
  end
  
  def convert_encoding(string)
    begin
      Iconv.conv('ISO-8859-1', 'UTF-8', string)
    rescue Iconv::IllegalSequence
      string
    end
  end
  
end
