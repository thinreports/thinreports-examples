# coding: utf-8

require 'bundler'
Bundler.require

report = Thinreports::Report.new layout: 'advanced_list'

report.list do |list|
  # Define the variables used in list.
  row_count = 0
  total_row_count = 0

  list.on_page_footer_insert do |page_footer|
    page_footer.item(:page_footer).value("Page row count: #{row_count}")

    total_row_count += row_count
    row_count = 0
  end

  # Dispatched at list-footer insertion.
  list.on_footer_insert do |footer|
    footer.item(:footer).value("Row count: #{total_row_count}")
  end

  30.times do |t|
    # Internaly #start_new_page() method is called,
    # the page break automatically.
    list.add_row detail: "Detail##{t}"
    row_count += 1
  end
end

report.generate filename: 'result.pdf'
