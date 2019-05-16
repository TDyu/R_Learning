#' 請同學用這章節所學的技巧，讀取`orglist.path`的檔案
#' 資料來源：<http://data.gov.tw/node/7307>

# <你可以在這裡做各種嘗試>

#' 前置工作 : 先看檔案
readBin(lvr_land.path, what = "raw", n = 3) # 先查BOM (結果:沒有)
readLines(file(orglist.path, encoding = "BIG5"), n = 5) # try BIG5 (結果:讀不出)
readLines(file(orglist.path, encoding = "UTF-8"), n = 1) # try UTF-8 (結果:讀不出)
readLines(file(orglist.path, encoding = "UTF-16"), n = 1) # try UTF-16 (結果:有讀出 順便觀察分隔符，和第一行是否為資料，另外還出現了警告的意外，所以大概也不是真的是UTF-16(但還可以寫我也不知道為啥，然後一個個try太慢了，可以顯示就很好了??)，安全起見等等選擇先轉位元再轉碼的方式處理)
#' 開始處理
orglist.info <- file.info(orglist.path) # 先存個資料資訊(或是不存額外變數其實也可以，就直接打指令)
answer.raw <- readBin(orglist.path, what = "raw", n = orglist.info$size) # 先存成binary的raw
library(stringi) # 載入轉碼要用的套件 這裡因為swirl相依stringi所以可以直接載入 (或是不載入，等等要用的時候(可能因為有相依了)所以寫stringi::再寫要用的函式)
answer.txt <- stri_encode(answer.raw, from = "UTF-16", to = "UTF-8") # 轉碼(似乎可以前面也不測試，就直接用這個轉碼的方法，因為from可以不填 不確定這樣的作法有沒有問題，不過還是要先看看分隔符那些的就是了)
ensureTextConnection <- function(txt) { # 查詢作業系統對於各種Encoding的支援狀況，然後建立一個 connection 因為要讓它能自己聰明做判斷，所以寫成函式檢測，不能只用l10n_info，因為只寫這樣...電腦又不會自己判斷，需要人看 ，就等於寫一個聰明一點的textConnection()# txt 是自己取的
  systemEncodingInfo <- l10n_info()
  if(systemEncodingInfo$MBCS & !systemEncodingInfo$`UTF-8`) { #用``安全
      textConnection(txt)
  } else {
      textConnection(txt, encoding = "UTF-8")
  }
}
answer <- read.table(ensureTextConnection(answer.txt), header = TRUE, sep = ",") # 最後讀取