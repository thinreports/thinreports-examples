# coding: utf-8

require 'bundler'
Bundler.require

Thinreports::Report.generate filename: 'result.pdf' do
  use_layout 'event'

  events.on :page_create do |e|
    e.page.item(:event_page_create).value('Dispatched at before page creating.')
    # Set page-number.
    e.page.item(:page).value(e.page.no)
  end

  events.on :generate do |e|
    e.pages.each do |page|
      page.item(:event_generate).value('Dispatch at before report generating.')
      # Set total-page-number.
      page.item(:total).value(e.report.page_count)
    end
  end

  3.times { start_new_page }
end
