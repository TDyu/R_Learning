answer03 <- local({
  # 請用filter挑出dep_time為NA的資料
  # 你可以用is.na
  result1 <- dplyr::filter(flights, is.na(dep_time)) # 執行的不一定有先載入dplyr所以寫著安全
  # 請用select從result1挑出year, month 和day
  select(result1, year:day)
})
# 完成後，請回到console輸入submit()
