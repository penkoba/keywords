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

  print "syntax match ipcPhonetic /zero/\n"
  print "syntax match ipcPhonetic /one/\n"
  print "syntax match ipcPhonetic /two/\n"
  print "syntax match ipcPhonetic /three/\n"
  print "syntax match ipcPhonetic /four/\n"
  print "syntax match ipcPhonetic /five/\n"
  print "syntax match ipcPhonetic /six/\n"
  print "syntax match ipcPhonetic /seven/\n"
  print "syntax match ipcPhonetic /eight/\n"
  print "syntax match ipcPhonetic /nine/\n"
  print "syntax match ipcPhonetic /uno/\n"
  print "syntax match ipcPhonetic /due/\n"
  print "syntax match ipcPhonetic /tre/\n"
  print "syntax match ipcPhonetic /quattro/\n"
  print "syntax match ipcPhonetic /cinque/\n"
  print "syntax match ipcPhonetic /sei/\n"
  print "syntax match ipcPhonetic /sette/\n"
  print "syntax match ipcPhonetic /otto/\n"
  print "syntax match ipcPhonetic /nove/\n"
  print "syntax match ipcPhonetic /nihil/\n"
  print "syntax match ipcPhonetic /unus/\n"
  print "syntax match ipcPhonetic /duo/\n"
  print "syntax match ipcPhonetic /tres/\n"
  print "syntax match ipcPhonetic /quattuor/\n"
  print "syntax match ipcPhonetic /quinque/\n"
  print "syntax match ipcPhonetic /sex/\n"
  print "syntax match ipcPhonetic /septem/\n"
  print "syntax match ipcPhonetic /octo/\n"
  print "syntax match ipcPhonetic /novem/\n"
  print "syntax match ipcPhonetic /trois/\n"
  print "syntax match ipcPhonetic /quatre/\n"
  print "syntax match ipcPhonetic /cinq/\n"
  print "syntax match ipcPhonetic /sept/\n"
  print "syntax match ipcPhonetic /huit/\n"
  print "syntax match ipcPhonetic /neuf/\n"
  print "syntax match ipcPhonetic /cero/\n"
  print "syntax match ipcPhonetic /dos/\n"
  print "syntax match ipcPhonetic /cuatro/\n"
  print "syntax match ipcPhonetic /cinco/\n"
  print "syntax match ipcPhonetic /seis/\n"
  print "syntax match ipcPhonetic /siete/\n"
  print "syntax match ipcPhonetic /ocho/\n"
  print "syntax match ipcPhonetic /nueve/\n"
  print "syntax match ipcPhonetic /null/\n"
  print "syntax match ipcPhonetic /eins/\n"
  print "syntax match ipcPhonetic /zwei/\n"
  print "syntax match ipcPhonetic /drei/\n"
  print "syntax match ipcPhonetic /vier/\n"
  print "syntax match ipcPhonetic /funf/\n"
  print "syntax match ipcPhonetic /sechs/\n"
  print "syntax match ipcPhonetic /sieben/\n"
  print "syntax match ipcPhonetic /acht/\n"
  print "syntax match ipcPhonetic /neum/\n"
  print "\n"

  print "highlight link ipcKey Define\n"
  print "highlight link ipcKeyLocation Exception\n"
  print "highlight link ipcMatchedKey String\n"
  print "highlight link ipcPhonetic Type\n"
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
