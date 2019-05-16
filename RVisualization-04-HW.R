# 請先用RDataMining-01所教，從pirate_path中抽取經緯度
# ps. 1分 = 1/60度
# 在利用這門課程所學會的知識，將事件繪製於地圖上
# 你可以輸入 hw() 來觀看參考答案

# readLines(file(pirate_path, encoding = "BIG5"), n = 10) # 先try編碼，順便看一點內容

pirateContent <- readLines(file(pirate_path, encoding = "BIG5")) # 讀進內容

# 以下經緯度萃取是直接貼之前的(除了改變數)，有時間你再研究參考答案，感覺簡潔多了
# 接著我們要把經緯度從這份資料中萃取出來
# 這份資料的格式，基本上可以用`：`分割出資料的欄位與內容
# 請同學利用`strsplit`將`pirate_info`做切割
# 並把結果儲存到`pirate_info_key_value`之中
pirateContentKeyValue <- {
  .delim <- strsplit(pirateContent[2], "")[[1]][3] # 這個寫法主要是假如不知道可以用":"分割，先自己割出切割符，以第一個元素值來拿就好，然後是第3個位置，所以後面寫了個[[1]][3]，另外注意第一行並沒有這個資訊，所以從第二行pirate_info[2]
  strsplit(pirateContent, .delim) # 再執行切割
}

# 我們需要的欄位名稱是「經緯度」
# 請同學先把`pirate_info_key_value`中每個元素（這些元素均為字串向量）的第一個值取出
# 你的答案鷹該要是字串向量
pirateContentKey <- {
  sapply(pirateContentKeyValue, "[", 1)
}

# 我們將`pirate_info_key`和`"經緯度"`做比較後，把結果存到變數`pirate_is_coordinate`
# 結果應該為一個布林向量
pirate_is_coordinate <- {
  pirateContentKey == pirateContentKey[8] # 先用pirate_info_key看到經緯度在第8個
}

# 接著我們可以利用`pirate_is_coordinate`和`pirate_info_key_value`
# 找出所有的經緯度資料
# 請把這個資料存到變數`pirate_coordinate_raw`中，並且是個長度為11的字串向量
pirate_coordinate_raw <- {
  .tmp <- sapply(pirateContentKeyValue, "[", 2) # 從剛剛切的pirate_info_key_value，因為資料是在第2個位置(第一個位置是名字)，所以拿出第二個
  .tmp[pirate_is_coordinate] # 再用剛剛取好的判定是經緯度的布林向量作取值
}

# 我們接著可以使用`substring`抓出經緯度的數字
# 請先抓出緯度並忽略「分」的部份
# 結果應該是整數（請用as.integer轉換）
pirate_coordinate_latitude <- {
  as.integer(substring(pirate_coordinate_raw, 3, 4))
}
# 請用同樣的要領取出經度並忽略「分」的部份
# 結果同樣應該是整數
pirate_coordinate_longitude <- {
  as.integer(substring(pirate_coordinate_raw, 12, 14))
}

# 為了方便後續的分析，我們常常把非結構化的資料整理為結構化資料。
# 在R 中，結構化的資料結構就是data.frame
# 請同學利用上述的數據，建立一個有11筆資料的data.frame
# 其中有兩個欄位，一個是latitude, 另一個是longitude
# 這兩個欄位紀錄著海盜事件的位置
pirate_df <- data.frame(
  latitude = pirate_coordinate_latitude,
  longitude = pirate_coordinate_longitude
)

if (!exists("twmap")) twmap <- readRDS(.get_path("twmap.Rds")) # 確保圖資

g <- ggmap(twmap, extent = "device")
g + geom_point(aes(x = longitude, y = latitude), data = pirate_df)
