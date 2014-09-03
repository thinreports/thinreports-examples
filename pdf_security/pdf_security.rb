# coding: utf-8

require 'thinreports'

report = ThinReports::Report.new layout: 'pdf_security.tlf'
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

report.generate filename: 'pdf_security.pdf', security: security_settings
