# coding: utf-8

require 'thinreports'

ThinReports::Report.generate filename: 'textblock_tool.pdf', layout: 'textblock_tool.tlf' do
  start_new_page

  page.values single_line_left: 'Left(Default)',
    single_line_center: 'Center', single_line_right: 'Right'

  page.item(:multi_line).value("ThinReports Text Block Tool.\n" + "ThinReports Text Block Tool.")

  page.values datetime_format: Time.now,
    number_format: 99999.9999, padding_format: 999, basic_format: 1980
end
