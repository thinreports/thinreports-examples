# coding: utf-8

require 'bundler'
Bundler.require

Thinreports::Report.generate filename: 'result.pdf', layout: 'event' do |report|
  # It will be called before finalizing each page
  report.on_page_create do |page|
    page.item(:event_page_create).value('Dispatched at before page creating.')

    # Set page-number.
    page.item(:page).value(page.no)
  end

  3.times { report.start_new_page }

  report.pages.each do |page|
    page.item(:event_generate).value('Dispatch at before report generating.')

    # Set total-page-number.
    page.item(:total).value(report.page_count)
  end
end
