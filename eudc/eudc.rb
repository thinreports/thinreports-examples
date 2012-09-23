# coding: utf-8

require 'rubygems'
require 'thinreports'

ThinReports.configure do
  generator.pdf.eudc_fonts = 'eudc.ttf'
end

ThinReports::Report.generate_file('eudc.pdf', :layout => 'eudc.tlf') do
  start_new_page
  page.item(:eudc).value("日本で生まれ世界が育てた言語\nuby") # "□" is External Character (Gaiji)
end

