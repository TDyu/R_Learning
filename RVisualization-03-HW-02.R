# 1. 利用dplyr::filter 篩選出自己居住的里(題目圖顯示是"新北市板橋區 留侯里")
# 2. 利用group_by + summarise 依據性別做加總
# 3. 利用ggplot2 繪製長條圖

# colnames(population) # 怕是資料太多(剛剛直接當了...)所以先看看欄位名，才知道打啥啊
# head(population) # 看看幾筆資料 

villageSex <- function() {
  library(dplyr) # 安全起見先載入
  library(ggplot2)
  g <- 
    filter(population, site_id == "新北市板橋區", village == "留侯里") %>% # 篩選
      group_by(village, sex) %>% # 分群(village雖然已經是一個了，但只是因為要把它留下，因為後面要用)
      summarise(count = sum(count)) %>% # 總值
      
      ggplot(aes(x = village, y = count, fill = sex)) + # 生ggplot物件
      geom_bar(position = "dodge", stat = "identity")
  
  print(g)
  invisible(NULL)
}

villageSex()