answer02 <- local({
  # 請從flights篩選出dep_delay > 0的資料
  target <- filter(flights, dep_delay > 0) # 請填寫你的程式碼
  nrow(target)
})
# = `answer02 <- nrow(filter(flights, dep_delay > 0))
# 完成後請在console輸入submit()
