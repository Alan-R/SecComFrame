#!/opt/puppet/bin/ruby
#
#
#
# So far the inputs are hard coded because the STIG XML file
# headers seem difficult to munge. Working on that.
#
# TODO:
#
# 1. Deal with first three header lines.
# 2. Be able to use command line option for input file.
# 3. Output files that are useful to other programs and people.
# 4. Maybe use newer versions of tools?
# 5. Maybe use a stored array of Vulnerabilites so we can identify
#    new ones?
#

require 'rubygems'
require 'nokogiri'

infile5 = '5_stig.infile'
infile6 = '6_stig.infile'

f5 = File.open(infile5)
f6 = File.open(infile6)

doc5 = Nokogiri::XML(f5)
doc6 = Nokogiri::XML(f6)

vulns = Hash.new

def new_vuln(group)
  #print "#{group.attributes['id'].value}:\t"
  #print "#{group.xpath('title').text} \t"
  #rule_severity = group.xpath('Rule').attributes['severity'].value
  #rule_severity = group.xpath('Rule').attr('severity')
  #print "#{rule_severity} \t"
  #rule_title = group.xpath('Rule/title').text
  #puts "#{rule_title}"
  puts "\n"
end

def dup_vuln(group)
  puts "Not used yet."
end

doc5.xpath('//Group').each do  |group|
  vuln_number = group.attributes['id']
  unless vulns.include? vuln_number
    vulns[vuln_number] = Hash.new
    vulns[vuln_number]['title'] = group.xpath('Rule/title').text
    vulns[vuln_number]['severity'] = group.xpath('Rule').attr('severity')
  end
end

