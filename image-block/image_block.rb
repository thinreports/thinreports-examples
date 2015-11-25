# coding: utf-8

require 'bundler'
Bundler.require

require 'open-uri'

require 'base64'
require 'stringio'

report = Thinreports::Report.new layout: 'image_block.tlf'
report.start_new_page do |page|
  page.item(:local_image).src('file/rails.png')
  page.item(:remote_image).value(open('http://rubyonrails.org/images/rails.png'))

  red_dot = 'iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4' +
            '//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg=='
  base64_image = StringIO.new(Base64.decode64(red_dot))
  page.item(:base64_image).value(base64_image)
end

report.generate filename: 'result.pdf'
