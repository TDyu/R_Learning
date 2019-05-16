# 我們定義gain為arr_delay - dep_delay

# 請算出1 月份平均的gain
answer04.1 <- local({
  # 請填寫你的程式碼
  filter(flights, month == 1) %>% # 先選出1月份的 # 我合理的認為%>%就是利用前面的資料當後面要處理的，也就是第一個參數(事實證明我猜對的:pipeline oprator)
    mutate(gain = arr_delay - dep_delay) %>% # 再用前面資料新增gain欄位
    summarise(mean(gain, na.rm = TRUE)) %>% # 接著算出平均值
    `[[`(1) # 因為上一個動作算出平均值還是在data.frme形式裡(大概)，所以在用[[函數取出參數1的值，也就是真的平均值的數字
})
stopifnot(class(answer04.1) == "numeric")
stopifnot(length(answer04.1) == 1)

# 請問carrier為AA的飛機，是不是tailnum都有AA字眼？
answer04.2 <- local({
  # 請填寫你的程式碼
  # 請給出你的答案： TRUE or FALSE
  filter(flights, carrier == "AA", !grepl("AA", tailnum)) %>% ## 因為要都有還要知道全部幾筆，乾脆挑都沒有，那如果都有的話挑都沒有的就代表或沒資料
    nrow == 0 # 接著用nrow函數算有幾筆  接著 == 0 和0比較，如果真的都有那就是沒有沒有AA的，比了之後就是TRUE，否則(有沒有AA的)就是FALSE
})
stopifnot(class(answer04.2) == "logical")
stopifnot(length(answer04.2) == 1)

# 請問dep_time介於 2301至2400之間的平均dep_delay為何
answer04.3 <- local({
  # 請填寫你的程式碼
  filter(flights, dep_time >= 2301, dep_time <= 2400) %>% # 要分開寫
    summarise(mean(dep_delay, na.rm = TRUE)) %>%
    `[[`(1)
})
stopifnot(class(answer04.3) == "numeric")
stopifnot(length(answer04.3) == 1)

# 請問dep_time介於 1至 100之間的平均dep_delay為何
answer04.4 <- local({
  # 請填寫你的程式碼
  filter(flights, dep_time >= 1, dep_time <= 100) %>%
    summarise(mean(dep_delay, na.rm = TRUE)) %>%
    `[[`(1)
})
stopifnot(class(answer04.4) == "numeric")
stopifnot(length(answer04.4) == 1)

# 完成後請存檔，並回到console輸入`submit()`
