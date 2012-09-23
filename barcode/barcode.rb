# coding: utf-8

require 'rubygems'
require 'bundler'
Bundler.require

require 'barby/barcode/ean_13'
require 'barby/barcode/ean_8'
require 'barby/barcode/qr_code'
require 'barby/outputter/png_outputter'

def barcode(type, data, png_opts = {})
  code = case type
  when :ean_13
    Barby::EAN13.new(data)
  when :ean_8
    Barby::EAN8.new(data)
  when :qr_code
    Barby::QrCode.new(data)
  end
  StringIO.new(code.to_png(png_opts))
end

ThinReports::Report.generate_file('barcode.pdf', :layout => 'barcode') do
  start_new_page
  
  # JAN13
  page.item(:jan_13).src(barcode(:ean_13, '491234567890'))
  
  # JAN8
  page.item(:jan_8).src(barcode(:ean_8, '4512345'))
  
  # QR Code
  page.item(:qr_code).src(barcode(:qr_code, 'http://www.thinreports.org/',
                                  :ydim => 5, :xdim => 5))
end
