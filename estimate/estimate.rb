# coding: utf-8

require 'rubygems'
require 'thinreports'

# Prepare sample data.
estimates = []

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

estimates << d1 << d2

# Generate reports.
report = ThinReports::Report.create do |r|
  # Setting the layout for 'estimate.tlf'
  r.use_layout 'estimate.tlf' do |config|
    # Setting the :details list.
    config.list do
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
  
  estimates.each do |estimate|
    r.start_new_page
    
    # Set estimate datas.
    r.page.values(:no          => estimate[:no],
                  :created_d   => estimate[:created_d],
                  :customer    => estimate[:customer],
                  :title       => estimate[:title],
                  :price       => estimate[:price],
                  :tax         => estimate[:tax],
                  :total_price => estimate[:total_price],
                  :note        => estimate[:note])
    
    estimate[:details].each do |detail|
      # Add an row of list.
      r.page.list.add_row(detail)
      
      # Calculate totla price.
      r.page.list do |list|
        list.store.price       += detail[:price]
        list.store.total_price += detail[:price]
      end
    end
  end
end

report.generate_file('estimate.pdf')
