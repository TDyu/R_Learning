math <- hsb$math
plot(density(math))
math.sj <- density(math, bw = "SJ")
plot(math.sj)
# 線的粗細
plot(math.sj, lwd = 2) # lwd越大越粗
# 線的型態
plot(math.sj, lty = 2) 
if (FALSE) {
  # 以下指令可以畫出lty的數字與畫圖後的結果
  showLty <- function(ltys, xoff = 0, ...) { # 先寫個函數好用，ltys可能會是一個序列，不過利用向量式的特性，就寫一個變數即可。留"..."大概是保留餘地
    stopifnot((n <- length(ltys)) >= 1) # 大於等於1才有畫的必要 因為可能是序列所以用lengh算，也就是要畫一種線((但是它是不是忘了先判斷如果0啊...))，順便用個變數把種類計下，等等用到，這裡發現n居然是整個函數通用變數啊...不是在這一句裡面而已
    # 下面看不懂了...你有時間再研究...
    op <- par(mar = rep(.5,4)); on.exit(par(op))
    plot(0:1, 0:1, type = "n", axes = FALSE, ann = FALSE)
    y <- (n:1)/(n+1)
    clty <- as.character(ltys)
    mytext <- function(x, y, txt)
      text(x, y, txt, adj = c(0, -.3), cex = 0.8, ...)
    abline(h = y, lty = ltys, ...); mytext(xoff, y, clty)
    y <- y - 1/(3*(n+1))
    abline(h = y, lty = ltys, lwd = 2, ...)
    mytext(1/8+xoff, y, paste(clty," lwd = 2"))
  }
  showLty(1:6)
}
# 線的顏色
plot(math.sj, col = "red")
# 對線之下的面積著色
polygon(math.sj, col = "red") # 這是一個低階繪圖函數
# 標題
plot(math.sj, main = "math")
# x軸標題
plot(math.sj, xlab = "math")
# 請回到console輸入`submit()`
