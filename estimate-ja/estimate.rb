# coding: utf-8

require 'bundler'
Bundler.require

# Prepare sample data.
data = []

# Sample Data 1
d1 = {:no          => 1234,
      :created_d   => Time.now,
      :customer    => '㈱テストコム',
      :title       => 'PC及び関連機器ご購入について',
      :price       => 1000000,
      :tax         => 50000,
      :total_price => 1050000,
      :details     => []}
d1[:details] << {:no         => 1,
                 :title      => 'ノートパソコン',
                 :amount     => 4,
                 :unit_price => 200000,
                 :price      => 800000}
d1[:details] << {:no         => 2,
                 :title      => 'プリンタ',
                 :amount     => 2,
                 :unit_price => 100000,
                 :price      => 200000,
                 :note       => 'トナー×2本含む'}
 
# Sample Data 2
d2 = {:no          => 3456,
      :created_d   => '2011年1月1日',
      :customer    => '㈱○○○○',
      :title       => '□□□□□□□□□',
      :price       => 100000,
      :tax         => 5000,
      :total_price => 105000,
      :note        => '△' * 40,
      :details     => []}
20.times do |t|
  d2[:details] << {:no         => t + 1,
                   :title      => '×××××××××',
                   :amount     => 1,
                   :unit_price => 5000,
                   :price      => 5000}
end

data << d1 << d2

# Generate reports.
report = Thinreports::Report.create do |r|
  # Setting the layout for 'estimate.tlf'
  r.use_layout 'estimate.tlf' do |config|
    # Setting the :details list.
    config.list(:details) do
      use_stores :price       => 0,
                 :total_price => 0

      # Dispatch at list-page-footer insertion.
      events.on :page_footer_insert do |e|
        # Set subtotal price.
        e.section.item(:price).value(e.store.price)
        # Initialize subtotal price to 0.
        e.store.price = 0
      end

      # Dispatch at list-footer insertion.
      events.on :footer_insert do |e|
        # Set total price.
        e.section.item(:price).value(e.store.total_price)
      end
    end
  end

  data.each do |header|
    r.start_new_page

    # Set header datas.
    r.page.values(:no          => header[:no],
                  :created_d   => header[:created_d],
                  :customer    => header[:customer],
                  :title       => header[:title],
                  :price       => header[:price],
                  :tax         => header[:tax],
                  :total_price => header[:total_price],
                  :note        => header[:note])

    header[:details].each do |detail|
      # Add an row of list.
      r.page.list(:details).add_row(detail)

      # Calculate the price.
      r.page.list(:details) do |list|
        list.store.price       += detail[:price]
        list.store.total_price += detail[:price]
      end
    end
  end
end

report.generate filename: 'result.pdf'
