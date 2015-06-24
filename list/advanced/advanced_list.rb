# coding: utf-8

require 'bundler'
Bundler.require

report = Thinreports::Report.new layout: 'advanced_list'

report.layout.config.list :advanced_list  do
  # Define the variables used in list.
  use_stores row_count: 0, total_row_count: 0

  # Dispatched at list-page-footer insertion.
  events.on :page_footer_insert do |e|
    e.section.item(:page_footer).value("Page row count: #{e.store.row_count}")

    e.store.total_row_count += e.store.row_count
    e.store.row_count = 0
  end

  # Dispatched at list-footer insertion.
  events.on :footer_insert do |e|
    e.section.item(:footer).value("Row count: #{e.store.total_row_count}")
  end
end

report.start_new_page

30.times do |t|
  # Internaly #start_new_page() method is called,
  # the page break automatically.
  report.page.list(:advanced_list) do |list|
    list.add_row detail: "Detail##{t}"
    list.store.row_count += 1
  end
end

report.generate filename: 'result.pdf'
