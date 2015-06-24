# coding: utf-8

require 'bundler'
Bundler.require

Thinreports.configure do
  generator.pdf.eudc_fonts = 'eudc.ttf'
end

Thinreports::Report.generate filename: 'result.pdf', layout: 'eudc.tlf' do
  start_new_page

  # "□" is External Character (Gaiji)
  page.item(:eudc).value("日本で生まれ世界が育てた言語\nuby")
end
