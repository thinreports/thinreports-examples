# coding: utf-8

require 'bundler'
Bundler.require

report = Thinreports::Report.new layout: 'permission.tlf'
report.start_new_page

# See more details:
#  [Prawn Documentation]
#   http://prawn.majesticseacreature.com/docs/0.11.1/Prawn/Document/Security.html#method-i-encrypt_document
security_settings = {
  user_password: 'foo',
  owner_password: :random,
  permissions: {
    print_document: false,
    modify_contents: false,
    copy_contents: false
  }
}

report.generate filename: 'result.pdf', security: security_settings
