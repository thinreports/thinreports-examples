# coding: utf-8

require 'bundler'
Bundler.require

Thinreports::Report.generate filename: 'result.pdf', layout: 'text_block.tlf' do
  start_new_page

  # Basic Features
  page.item(:single_line_left).value('Left(Default)')
  page[:single_line_center].value = 'Center'
  # Item#set(value, style_settings = {})
  page.item('single_line_right').set('Right')
  page.item(:multi_line).value("Thinreports Text Block Tool.\n" + "Thinreports Text Block Tool.")

  # Simple Format
  page.values datetime_format: Time.now,
    number_format: 99999.9999, padding_format: 999, basic_format: 1980

  # Dynamic Style
  page.values bold_and_italic: "To bold from normal.\nTo italic from normal.",
    underline_and_linethrough: "To underline from normal.\nTo line-through from normal.",
    font_size_12: 'To 18 from 12', font_color_black: 'To red from black.',
    text_align_and_vertical_align: "To right from left.\nTo bottom from top."

  # Item#style(:visible, true) == Item#show or Item.visible(true)
  page.item(:show_text_block).style(:visible, true).value = 'To true from false.'
  page.item(:bold_and_italic).styles(bold: true, italic: true)
  page.item(:underline_and_linethrough).styles(underline: true, linethrough: true)
  page.item(:font_size_12).style(:font_size, 18)
  page.item(:font_color_black).style(:color, 'red')
  page.item(:text_align_and_vertical_align).styles(align: :right, valign: :bottom)
end
