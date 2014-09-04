# coding: utf-8

require 'open-uri'
require 'bundler'
bundler.require

report = ThinReports::Report.new layout: 'image.tlf'
report.start_new_page do |page|
  page.item(:local_image).src('file/rails.png')
  page.item(:remote_image).src(open('http://rubyonrails.org/images/rails.png'))
end

report.generate filename: 'result.pdf'
