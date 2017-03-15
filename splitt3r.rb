#!/usr/bin/env ruby
#splitt3r takes an list of data as input, and outputs CSV with a column count of your choosing

require 'trollop'
require 'csv'

def arguments
  opts = Trollop::options do 
    opt :data, "List of data to split in a custom format", :type => String
    opt :columns, "Number of columns required", :type => Integer
    opt :uniq, "Remove dupes from input file"
    if ARGV.empty?
      puts "Need Help? Try ./splitt3r --help or -h"
      exit
    end
  end
  opts
end

def custom_split(arg)
  if arg[:uniq]
    stuff = File.readlines(arg[:data]).map(&:chomp &&:strip).uniq
  else
    stuff = File.readlines(arg[:data]).map(&:chomp &&:strip)
  end
    splitter = stuff.each_slice(arg[:columns]).to_a
end

def create_file(custom)
  CSV.open("output_#{Time.now.strftime("%H%M%S")}.csv", 'w+') do |csv|
    custom.each do |column|
      csv << column
    end
  end
  puts "Output written to current directory"
end

arg = arguments
custom = custom_split(arg)
create_file(custom)