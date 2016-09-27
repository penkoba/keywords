#!/usr/bin/env ruby

def gen_key_hash(keys)
  key_h = {}
  keys.each { |key|
    len = key.length
    if (key_h.has_key?(len))
      key_h[len] << key
    else
      key_h[len] = [key]
    end
  }

  key_h
end

def common(keys, xxx1, xxx2)
  key_h = gen_key_hash(keys)

  print "\"ingress passcode file syntax definition\n"
  xxx1.each { |x|
    print "syntax match ", x, "\n"
  }
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
      xxx2.each { |x|
        print "syntax match ipcMatchedKey ", x.sub("KKK", key), "\n"
      }
    }
  }
  print "\n"

  print "highlight link ipcKey Define\n"
  print "highlight link ipcKeyLocation Exception\n"
  print "highlight link ipcMatchedKey String\n"
end

def gen_normal()
  keys = IO.foreach("sorted.txt").collect { |l| l.chomp }
  xxx1 = ["ipcKeyLocation /^\\d\\a\\a\\a\\d.*\\a\\d\\a\\d\\a$/hs=s+5,he=e-5",
          "ipcKeyLocation /^\\a\\a\\a\\d\\d.*\\d\\d\\d\\a\\a$/hs=s+5,he=e-5"]
  xxx2 = ["/^[2-9]\\a\\a\\a[2-9]KKK\\a[2-9]\\a[2-9]\\a$/hs=s+5,he=e-5",
          "/^\\a\\a\\a[2-9][2-9]KKK[2-9][2-9][2-9]\\a\\a$/hs=s+5,he=e-5"]
  common(keys, xxx1, xxx2)
end

def gen_jojo()
  keys = IO.foreach("jojowotd.txt").collect { |l| l.chomp }
  xxx1 = ["ipcKeyLocation /^\\a\\d\\a\\d.*\\a\\d\\a\\a$/hs=s+4,he=e-4"]
  xxx2 = ["/^\\a\\d\\a\\dKKK\\a\\d\\a\\a$/hs=s+4,he=e-4"]
  common(keys, xxx1, xxx2)
end

cmd = $0.sub(/(.*\/)/, "")
if (cmd == "gen-vim-syntax-jojo.rb")
  gen_jojo()
else
  gen_normal()
end
