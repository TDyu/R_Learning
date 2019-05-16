answer01 <- local({
  # 請在此填寫你的程式碼
  # 請同學從flights中「依序」選出`year:day, hour, origin, dest, tailnum, carrier` 等欄位，再抽出前100筆記資料，最後和`airlines`做`left_join`。
  slice(flights, 1:100) %>% # 其實要先選要的資料，也就是100完整資料才能做下面細項的
    select(year:day, hour, origin, dest, tailnum, carrier) %>%
    left_join(y = airlines, by = "carrier")
})
# 結束之後請回到console輸入`submit()`
