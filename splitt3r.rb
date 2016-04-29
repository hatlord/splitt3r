#!/usr/bin/env ruby
#splitt3r script for reports weee 
require 'trollop'

def arguments

  opts = Trollop::options do 
    version "splitter"
    banner <<-EOS
    BANNER GOES HERE
    EOS

    opt :ips, "List of IP addresses to split for Vuln Totals", :type => String
    opt :social, "List of e-mail addresses for AppendixD", :type => String
    opt :meta, "Metadata List for Appendix C", :type => String
    opt :emails, "Email List for Appendix B", :type => String

    if ARGV.empty?
      puts "Need Help? Try ./rsdns --help or -h"
      exit
    end
  end
  opts
end

def vulntotals(arg)
  if arg[:ips]
    puts "VULN TOTALS SECTION"
    ips = File.readlines(arg[:ips]).map(&:chomp)
    tab1 = "\t0\t0\t0\t0\t0\t\t"
    tab2 = "\t0\t0\t0\t0\t0"

    split = ips.each_slice(2).to_a
    split.each do |split|
      puts "#{split[0]}#{tab1}#{split[1]}#{tab2}"
    end
  end
end

def socialnetwork(arg)
  if arg[:social]
    puts "\nSOCIAL NETWORKING - APPENDIX D"
    social = File.readlines(arg[:social]).map(&:chomp)
    splitter = social.each_slice(4).to_a
    splitter.each do |split|
      puts "#{split[0]}\t\t#{split[1]}\t\t#{split[2]}\t\t#{split[3]}"
    end
  end
end

def metadata(arg)
  if arg[:meta]
    puts "\nMETADATA - APPENDIX C"
    meta = File.readlines(arg[:meta]).map(&:chomp)
    splitter = meta.each_slice(4).to_a
    splitter.each do |split|
      puts "#{split[0]}\t\t#{split[1]}\t\t#{split[2]}\t\t#{split[3]}"
    end
  end
end

def emails(arg)
  if arg[:emails]
    puts "\nEMAILS - APPENDIX B"
    emails = File.readlines(arg[:emails]).map(&:chomp)
    splitter = emails.each_slice(3).to_a
    splitter.each do |split|
      puts "#{split[0]}\t\t#{split[1]}\t\t#{split[2]}"
    end
  end
end

arg = arguments
vulntotals(arg)
socialnetwork(arg)
metadata(arg)
emails(arg)