#!/opt/puppet/bin/ruby
#
# open_stig.rb
# Version: 0.2
# Used to read DISA STIG files and sort out the vulnerabilities.
# Sorts by Vulnerability ID. For example, "V-12345". 
#
# So far the inputs are hard coded because the STIG XML file
# headers seem difficult to munge. Working on that. 
#
# TODO:
#
# 1. Deal with first three header lines. 
#    Question is out to the Nokogiri group
# 2. Be able to use command line option for input file. 
# 3. Output files that are useful to other programs and people. 
# 4. Maybe use newer versions of tools?
# 5. Maybe use a stored array of Vulnerabilites so we can identify 
#    new ones?
#

require 'rubygems'
require 'nokogiri'

$vulns = Hash.new
duplicate_vulns = Array.new

def new_vuln(vuln_number, group)
    vuln = Hash.new
    vuln['title'] = group.xpath('Rule/title').text
    vuln['severity'] = group.xpath('Rule').attr('severity')
    $vulns[vuln_number] = vuln
end

# At present this script requires the STIG files be munged.
# The first three lines, containing the xml scheme and Benchmark
# line, must be reduced to just:
#   <Benchmark>

in_files = %w(5_stig.infile 6_stig.infile)

in_files.each do |file|
  f = File.open(file)
  doc = Nokogiri::XML(f)
  doc.xpath('//Group').each do  |group|
    vuln_number = group.attributes['id']
    if $vulns.has_key? vuln_number
      duplicate_vulns.push(vuln_number)
    end
    unless $vulns[vuln_number]
      new_vuln(vuln_number, group)
    end
  end
  f.close
end

$vulns.each_key do | vul_id |
  id = vul_id
  sev = $vulns[vul_id]['severity']
  title = $vulns[vul_id]['title']
  printf("%-8s %-8s %-10s \n", id, sev, title)
end

if duplicate_vulns.count > 0
  puts "Duplicate Vulnerabilities IDs:"
  puts duplicate_vulns
end

