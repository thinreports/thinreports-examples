# coding: utf-8

require 'bundler'
Bundler.require

Person = Struct.new :name, :blood_type, :age

people = [
  Person.new('Smith', 'A', 21),
  Person.new('Johnson', 'B', 35),
  Person.new('James', 'A', 18),
  Person.new('Linda', 'O', 25),
  Person.new('Robert', 'B', 24),
  Person.new('Mary', 'O', 39)
]

# Sort people by :blood_type
people.sort_by!(&:blood_type)

def insert_header(list, blood_group)
  list.add_row blood_group: blood_group do |row|
    row.item(:border).hide
  end
end

blood_group = nil

report = ThinReports::Report.new layout: 'group_rows.tlf'

people.each do |person|
  # Insert group header when blood type has changed
  unless blood_group == person.blood_type
    blood_group = person.blood_type
    insert_header(report.list, blood_group)
  end

  report.list.add_row do |row|
    row.item(:name).value(person.name)
    row.item(:age).value(person.age)
  end
end

report.generate filename: 'result.pdf'
