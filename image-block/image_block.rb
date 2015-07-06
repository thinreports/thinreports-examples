# coding: utf-8

require 'bundler'
Bundler.require

require 'open-uri'

report = Thinreports::Report.new layout: 'image_block.tlf'
report.start_new_page do |page|
  page.item(:local_image).src('file/rails.png')
  page.item(:remote_image).value(open('http://rubyonrails.org/images/rails.png'))
end

report.generate filename: 'result.pdf'
