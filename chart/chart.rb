# coding: utf-8

require 'bundler'
require 'open-uri'
Bundler.require

def open_chart(*params)
  URI.open('http://chart.googleapis.com/chart?' + URI.encode(params.join('&')))
end

report = Thinreports::Report.new layout: 'chart.tlf'
report.start_new_page do
  # Basic Bar Chart
  bar_chart_png = open_chart('cht=bhs', 'chs=240x140', 'chco=4d89f9,c6d9fd',
    'chd=t:10,50,60,80,40|50,60,100,40,20', 'chds=0,160')
  item(:bar_chart).src(bar_chart_png)

  # Basic Line Chart
  line_chart_png = open_chart('cht=lc', 'chs=240x140',
    'chd=t:40,60,60,45,47,75,70,72')
  item(:line_chart).value(line_chart_png)

  # Basic Pie and Radar Chart
  pie_chart_png = open_chart('cht=p', 'chs=240x140',
    'chdl=30°|40°|50°|60°', 'chd=s:Uf9a', 'chl=Jan|Feb|Mar|Apr')
  radar_chart_png = open_chart('cht=r', 'chs=140x140',
    'chm=B,FF990080,0,0,5', 'chls=3,0,0', 'chxt=x,y',
    'chd=t:80,30,99,60,50,20',
    'chxl=0:|Str|Vit|Agi|Dex|Int|Lux|1:|||||')
  values(pie_chart: pie_chart_png, radar_chart: radar_chart_png)

  # 3D-Pie Chart
  pie_3d_chart_png = open_chart('cht=p3', 'chs=250x140',
    'chco=0092b9,86ad00,f2b705,bc3603',
    'chd=t:21,55.3,18,5.7',
    'chl=A|B|C|D')
  item(:pie_3d_chart).src(pie_3d_chart_png)

  # QR Code
  qr_code_png = open_chart('cht=qr', 'chs=150x150',
    'chl=http://www.thinreports.org/')
  item(:qr_code).src(qr_code_png)
end

report.generate filename: 'result.pdf'
