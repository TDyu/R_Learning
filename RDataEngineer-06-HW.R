#我們的目標，是要比對房貸餘額是否超過GDP的40%。這是一種拿來評估房地產是否會泡沫化 的指標。
#' 請用各種方式讀取`gdp_path`的資料、整理資料，並把最後的結果存到變數`gdp`。
#' 提示：`gdp_path`中的第一欄數據是年/季、第二欄數據是該季的GDP(百萬)
#' 結果應該要有兩欄的數據，第一欄是年，第二欄是我國每年的GDP
#' 具體細節請參考最後的`stopifnot`的檢查事項
#' 提示：拿掉數據中間的逗號，請用：`gsub(pattern = ",", replacement = "", x = <你的字串向量>)`
gdp <- local({
  # 請填寫你的程式碼
  # read.table(gdp_path, header = FALSE, sep = ",") 先看看情況，發現前四行應該拿掉，亂七八糟不知道是啥
  # read.table(gdp_path, skip = 4, header = FALSE, sep = ",") # skip = 4 然後觀察情況 看到欄位名等等的 並且觀察到最後有用的只到132
  read.table(gdp_path, skip = 4, header = FALSE, sep = ",") %>% # 所以先讀這樣
    slice(1:132) %>% # 再挑出有用的
    select(season = V1, gdp = V2) %>% # 再挑出要處理的，而且給個方便辨識的名字(會覆蓋掉原本的名字)
    mutate(
      season = as.character(season), # 處理season : 根據下面的檢查，要確保是character
      year = substring(season, 1, 4), # 加個真的要用的其中一個資料year : 是從season割下來的(season是年+季度)
      gdp = gsub(pattern = ",", replacement = "", x = gdp), # 處理gdp : 是從上個步驟的gdp做處理(也就是從v2做處理)，用gsub拿掉逗號，因為我們要純數字
      gdp = as.numeric(gdp) * 1000000) %>% # 再處理一次gdp，要把它變純數字，而且原本單位是百萬，所以要把它完整的0加上去
    group_by(year) %>% # 因為有很多種年份的gdp要計算，所以要先切割
    summarise(gdp = sum(gdp)) # 把同一年份的gdp加在一起(原本是有分季度的)
})
stopifnot(is.data.frame(gdp))
stopifnot(colnames(gdp) == c("year", "gdp"))
stopifnot(class(gdp$year) == "character")
stopifnot(class(gdp$gdp) == "numeric")
stopifnot(nrow(gdp) == 33)
stopifnot(range(gdp$year) == c("1981", "2013"))
stopifnot(range(gdp$gdp) == c(1810829,14564242) * 1000000)

#' cl_info的資料包含各家銀行的房貸餘額（mortgage_bal）資訊與資料的時間（data_dt）。
#' 請用各種方法整理cl_info的資料，把最後的結果整理至`cl_info_year`
#' 結果應該要有兩欄的數據，第一欄是年，第二欄是每年房貸餘額的值(請以每年的一月份資料為準)
#' 具體細節請參考最後的`stopifnot`檢查事項
cl_info_year <- local({
  # 請填寫你的程式碼
  select(cl_info, mortgage_bal, data_dt) %>% # 先選出要的
    mutate(month = substring(data_dt,1,7)) %>% # 安插月份的欄位(為了方便檢視想要的月份)，從date_dt截下，因為最終目的是要年，所以這裡還是留下年
    group_by(month) %>% # 因為有多種月份要處理 所以先切割
    summarise(mortgage_total_bal = sum(mortgage_bal, na.rm = TRUE)) %>% # 多個各月份的總貸款餘額
    mutate(year = substring(month, 1, 4)) %>% # 新增年的欄位，從原本的月份切出年
    group_by(year) %>% # 多種年份要處理，所以切割
    arrange(month) %>% # 為了找1月份，所以先排序
    summarise(month = head(month, 1), mortgage_total_bal = head(mortgage_total_bal, 1)) %>% # 剛剛已經排序過了，所以從頭掃(會掃到同樣的結束為止，也就是只取1月份)成1個，接著把1月分所有的總貸款餘額都加起來成1個。並切因為上面做了切割年的動作了，所以等於它會對所有年份都進行這個動作
    select(year, mortgage_total_bal) # 然後按題目選擇出第一欄是年，第二欄是每年房貸餘額的值
})

stopifnot(is.data.frame(cl_info_year))
stopifnot(colnames(cl_info_year) == c("year", "mortgage_total_bal"))
stopifnot(class(cl_info_year$year) == "character")
stopifnot(class(cl_info_year$mortgage_total_bal) == "numeric")
stopifnot(nrow(cl_info_year) == 9)
stopifnot(range(cl_info_year$year) == c("2006", "2014"))
stopifnot(range(cl_info_year$mortgage_total_bal) == c(3.79632e+12, 5.726784e+12))

#' 最後請同學用這門課程所學的技術整合`gdp`與`cl_info`的資料，
#' 計算出房貸餘額與gdp的比率（mortgage_total_bal / gdp）。
#' 請將結果輸出到一個data.frame，第一攔是年份，第二欄是房貸餘額的GDP佔有比率。
#' 細節請參考`stopifnot`的檢查
answerHW <- local({
  # 請在這邊填寫你的程式碼
  inner_join(cl_info_year, gdp, by = "year") %>% # 按上面的處理，每一年只會有一種資料，採用inner在此把兩邊都有的才計算 (要不有其中一邊沒有的話，你是要計算個鬼)
    mutate(index = mortgage_total_bal / gdp) %>% # 計算出房貸餘額與gdp的比率，並新增欄位
    select(year, index) # 最後選擇所要
})

stopifnot(is.data.frame(answerHW))
stopifnot(nrow(answerHW) == 8)
stopifnot(colnames(answerHW) == c("year", "index"))
stopifnot(class(answerHW$year) == "character")
stopifnot(class(answerHW$index) == "numeric")
stopifnot(min(answerHW$index) > 0.3)
stopifnot(max(answerHW$index) < 0.4)
#' 完成後請存檔，並回到console執行`submit()`