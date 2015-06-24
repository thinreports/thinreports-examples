# coding: utf-8

require 'bundler'
Bundler.require

# Prepare sample data.
data = []

my_info = {
  my_name: 'Matsukei Co., Ltd.',
  my_address: '735-211, Nogifukutomicho, Matsue-shi, Shimane, Japan',
  my_post_code: '690-0046',
  my_tel_number: '+81-854-32-1616',
  my_fax_number: '+81-852-32-1629'
}

# Sample Data 1
d1 = {
  no: 1234,
  issued_date: Time.now,
  customer_name: 'Sample1 Co., Ltd.',
  customer_address: '1234, Sample1cho, Sample1-shi, Shimane, Japan',
  customer_post_code: '123-4567',
  details: [],
  notes: 'Estimate exsample1!'
}

d1.merge!(my_info)

d1[:details] << {
  no: 1,
  name: 'iPon6',
  rate: 199,
  qty: 1,
  amount: 199
}
d1[:details] << {
  no: 2,
  name: 'PearBook Pro 13-inch: 2.9GHz',
  rate: 1499,
  qty: 2,
  amount: 2998
}

# Sample Data 2
d2 = {
  no: 3456,
  issued_date: Time.now,
  customer_name: 'Sample2 Co., Ltd.',
  customer_address: '3456, Sample2cho, Sample2-shi, Shimane, Japan',
  customer_post_code: '345-6789',
  details: [],
  notes: 'Estimate exsample2!'
}

d2.merge!(my_info)

35.times do |t|
  d2[:details] <<  {
    no: t + 1,
    name: 'xxxxxxxxxx',
    rate: 500,
    qty: 1,
    amount: 500
  }
end

data << d1 << d2

# Generate reports.
report = Thinreports::Report.new layout: 'estimate.tlf'

data.each do |header|
  report.start_new_page

  # Set header datas.
  report.page.values(no: header[:no],
    issued_date: header[:issued_date],
    customer_name: header[:customer_name],
    customer_address: header[:customer_address],
    customer_post_code: header[:customer_post_code],
    my_name: header[:my_name],
    my_address: header[:my_address],
    my_post_code: header[:my_post_code],
    my_tel_number: header[:my_tel_number],
    my_fax_number: header[:my_fax_number],
    notes: header[:notes])

  report.page.list do |list|
    sub_total = 0
    total = 0

    # Dispatch at list-page-footer insertion.
    list.on_page_footer_insert do |page_footer|
      # Set subtotal.
      page_footer.item(:sub_total).value(sub_total)
      # Initialize subtotal to 0.
      sub_total = 0
    end

    # Dispatch at list-footer insertion.
    list.on_footer_insert do |footer|
      # Set total.
      footer.item(:total).value(total)
    end

    header[:details].each do |detail|
      # Add an row of list.
      list.add_row(detail)

      # Calculate the amount.
      sub_total += detail[:amount]
      total += detail[:amount]
    end
  end
end

report.generate filename: 'result.pdf'
