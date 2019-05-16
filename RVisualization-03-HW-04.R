# 請先用`substring`擷取site_id的前三個字，取得台灣的縣市級行政區名稱(取名為city)
# 然後利用filter取出自己感興趣的行政區 (題目圖是雲林和新北)
# 透過對city, age 做分組加總
# 再利用group_by分組對人數取平均，算出各年齡的人數比例
# 最後利用ggplot來繪圖


cityAgeRatio <- function() {
  library(dplyr)
  library(ggplot2)
  
  g <-
    mutate(population, city = substring(site_id, 1, 3)) %>% # 多個city的部分方便行事
      filter(city %in% c("雲林縣", "新北市")) %>% # %in% c("雲林縣", "新北市" %in%的寫法有空查查，我原本寫==("雲林縣" | "新北市") 不行 參考了一下==c("雲林縣", "新北市")可以
      group_by(city, age) %>% # 以city分組,age也可以分因為後面算平均
      summarise(count = sum(count)) %>%
      group_by(city) %>% # 再用city分一次組，因為剛剛分組時有考慮age所以同一個city會有很多種age，現在要真的分邊
      mutate(ratio = count / sum(count)) %>% # 新增各city年齡的人數比例，因為剛剛分組了，所以向量式來說，count就是一個city內一個年齡的人，sum(count)就是一個city內所有人
      
      ggplot(aes(x = age, y = ratio, color = city)) +
      geom_point() + geom_line()
      
  print(g)
  invisible(NULL)
  # 正解最後有一段我不知幹嘛的
  #if (Sys.info()["sysname"] == "Darwin" & interactive()) {
  #  print(g + theme_grey(base_family="STKaiti"))
  #} else {
  #  print(g)
  #}
}

cityAgeRatio()