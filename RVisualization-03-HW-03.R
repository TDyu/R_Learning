# 1. 利用dplyr::filter 篩選出自己居住的里
# 2. 利用ggplot2 依據人數與年齡繪製，依據年齡排序，繪製散佈圖與折線圖(geom_line)

# 看題目圖
#    x : age
#    y : count
#    color : sex

villageAgeSex <- function() {
  library(dplyr)
  library(ggplot2)
  
  g <- 
    filter(population, site_id == "新北市板橋區", village == "留侯里") %>%
    ggplot(aes(x = age, y = count, color = sex)) +
    geom_point() + geom_line()
  
  print(g)
  invisible(NULL)
}


villageAgeSex()