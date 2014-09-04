# coding: utf-8

require 'bundler'
Bundler.require

ThinReports::Report.generate filename: 'result.pdf', layout: 'text_block.tlf' do
  start_new_page

  page.values single_line_left: 'Left(Default)',
    single_line_center: 'Center', single_line_right: 'Right'

  page.item(:multi_line).value("ThinReports Text Block Tool.\n" + "ThinReports Text Block Tool.")

  page.values datetime_format: Time.now,
    number_format: 99999.9999, padding_format: 999, basic_format: 1980
end
