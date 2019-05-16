# 請計算sex類別的個數

answer01 <- local({
  # 請在這邊填寫你的程式碼
  group_by(hsb, sex) %>% 
    summarise(count = n()) # n() 計數。前面把sex分群了，根據向量式，這裡計數也會計兩個，而且建立的data.frame只有sex(請複習)，但是多個欄位叫count
})

# 請先確定你的答案通過以下測試
stopifnot(colnames(answer01) == c("sex", "count"))
stopifnot(nrow(answer01) == 2)
stopifnot(is.data.frame(answer01))
stopifnot(sum(answer01$count) == nrow(hsb))
stopifnot(sort(answer01$sex) == sort(c("female", "male")))

# 確認完畢之後，請回到console輸入`submit()`
