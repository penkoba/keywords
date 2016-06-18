#!/usr/bin/env ruby

key_h = {}

IO.foreach("sorted.txt") do |l|
  key = l.chomp
  len = key.length
  if (key_h.has_key?(len))
    key_h[len] << key
  else
    key_h[len] = [key]
  end
end

print "\"ingress passcode file syntax definition\n"
print "\"syntax match ipcKeyLocation /^[2-9]\\a\\a\\a[2-9].*\\a[2-9]\\a[2-9]\\a$/hs=s+5,he=e-5\n"
print "syntax match ipcKeyLocation /^\\d\\a\\a\\a\\d.*\\a\\d\\a\\d\\a$/hs=s+5,he=e-5\n"
print "syntax match ipcKeyLocation /^\\a\\a\\a\\d\\d.*\\d\\d\\d\\a\\a$/hs=s+5,he=e-5\n"
print "\n"
print "syntax case ignore\n"
print "\n"

len_list_sort = key_h.keys.sort

len_list_sort.each { |len|
  key_h[len].each { |key|
    print "syntax match ipcKey /#{key}/\n"
  }
}
print "\n"

len_list_sort.each { |len|
  key_h[len].each { |key|
    print "syntax match ipcMatchedKey /^[2-9]\\a\\a\\a[2-9]#{key}\\a[2-9]\\a[2-9]\\a$/hs=s+5,he=e-5\n"
    print "syntax match ipcMatchedKey /^\\a\\a\\a[2-9][2-9]#{key}[2-9][2-9][2-9]\\a\\a$/hs=s+5,he=e-5\n"
  }
}
print "\n"

print "highlight link ipcKey Define\n"
print "highlight link ipcKeyLocation Exception\n"
print "highlight link ipcMatchedKey String\n"
