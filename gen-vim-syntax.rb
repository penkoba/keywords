#!/usr/bin/env ruby

keys = []

IO.foreach("sorted.txt") do |key|
  keys << key.chomp
end

print "\"ingress passcode file syntax definition\n"
print "\"syntax match ipcKeyLocation /^[2-9]\\a\\a\\a[2-9].*\\a[2-9]\\a[2-9]\\a$/hs=s+5,he=e-5\n"
print "syntax match ipcKeyLocation /^\\d\\a\\a\\a\\d.*\\a\\d\\a\\d\\a$/hs=s+5,he=e-5\n"
print "\n"
print "syntax case ignore\n"
print "\n"

keys.each { |key|
  print "syntax match ipcKey /#{key}/\n"
}
print "\n"

keys.each { |key|
  print "syntax match ipcMatchedKey /^[2-9]\\a\\a\\a[2-9]#{key}\\a[2-9]\\a[2-9]\\a$/hs=s+5,he=e-5\n"
}
print "\n"

print "highlight link ipcKey Define\n"
print "highlight link ipcKeyLocation Exception\n"
print "highlight link ipcMatchedKey String\n"
