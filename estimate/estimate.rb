# coding: utf-8

require 'thinreports'

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
report = ThinReports::Report.create do |r|
  # Setting the layout for 'estimate.tlf'
  r.use_layout 'estimate.tlf' do |config|
    # Setting the :details list.
    config.list(:details) do
      use_stores sub_total: 0, total: 0
      # Dispatch at list-page-footer insertion.
      events.on :page_footer_insert do |e|
        # Set subtotal.
        e.section.item(:sub_total).value(e.store.sub_total)
        # Initialize subtotal to 0.
        e.store.sub_total = 0
      end

      # Dispatch at list-footer insertion.
      events.on :footer_insert do |e|
        # Set total.
        e.section.item(:total).value(e.store.total)
      end
    end
  end

  data.each do |header|
    r.start_new_page

    # Set header datas.
    r.page.values(no: header[:no],
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

    header[:details].each do |detail|
      # Add an row of list.
      r.page.list(:details).add_row(detail)

      # Calculate the amount.
      r.page.list(:details) do |list|
        list.store.sub_total += detail[:amount]
        list.store.total += detail[:amount]
      end
    end
  end
end

report.generate filename: 'estimate.pdf'
