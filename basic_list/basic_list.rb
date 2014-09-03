# coding: utf-8

require 'thinreports'

report = ThinReports::Report.new layout: 'basic_list.tlf'

30.times do |t|
  # Internaly #start_new_page() method is called,
  # the page break automatically.
  #
  # [NOTE] In thinreports < 0.7.5:
  #   report.page.list(:default).add_row do |row|
  #     :
  report.list.add_row do |row|
    row.item(:detail).value("row##{t}")
  end
end

# [NOTE] In thinreports < 0.7.7:
#   report.generate_file 'basic_list.pdf'
report.generate filename: 'basic_list.pdf'
