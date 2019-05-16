# 繪製全台各年齡層的總人口數
# 點和線條的部分可以透過 + geom_point() + geom_line() 來同時繪製


# 首先分析要求整理資料(建立data.frame，或是直接來也行) : 
#   分群的是 : age
#   計算總值 : 根據age分群的，count加總

# 畫圖注意
#   類別-x軸 : age
#   計數-y軸 : count
function() {
  g <- 
    group_by(population, age) %>%
    summarise(count = sum(count)) %>%
    arrange(age) %>% # 保險起見(?)做個排序
    ggplot(aes(x = age, y = count)) + # 要繪圖了用+
    geom_point() + geom_line() # 可加上連線
  print(g) # 給別人的印出
  invisible(NULL)  # 不隱藏
}