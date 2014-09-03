# coding: utf-8

require 'thinreports'

report = ThinReports::Report.create do
  use_layout 'multiple_layouts_default', default: true
  use_layout 'multiple_layouts_cover', id: :cover

  # Add :cover layout (using multiple_layouts_cover.tlf).
  start_new_page layout: :cover

  # Add 5 page using :default layout (multiple_layouts_default.tlf).
  5.times do |t|
    start_new_page do |page|
      page.item(:content).value(t + 1)
    end
  end

  # Add "multiple_layouts_back_cover.tlf" layout.
  start_new_page layout: 'multiple_layouts_back_cover.tlf'
end

report.generate filename: 'multiple_layouts.pdf'
