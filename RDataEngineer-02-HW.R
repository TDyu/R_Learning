
# 這個段落的程式碼，是先幫助同學觀察資料的，不包含在作答的檢查範圍
if (FALSE) {
  # 我們先來看看政府電子採購網<http://web.pcc.gov.tw>所爬下來的決標資料。
  # 這個檔案的路徑已經設定到tender_path了。首先，請同學先用`readLines`
  # 來看這個檔案的前100行。

  readLines(tender_path, n = 100)

  # 這樣的內容要直接處理是很挑戰的
  # 但是我們可以先透過瀏覽器來觀察這個HTML文件所夾帶的內容

  browseURL(tender_path)

  # 同學的預設瀏覽器應該會打開這個網頁
}

# 首先請同學用read_html載入網頁內容
tender <- read_html(tender_path)

# 接下來，我們的目標是抓出所有的投標廠商名稱
# 透過瀏覽器的開發工具可以發現，裝載著廠商名稱的標籤是像這樣的：
# <tr>
#		<th class="T11b" bgcolor="#ffdd83" align="left" valign="middle" width="200">　廠商名稱</th>
#		<td class="newstop" bgcolor="#EFF1F1">
#			台灣翔登股份有限公司
#		</td>
#	</tr>
# 所以我們的策略是：
# 1. 先找出所有的tr標籤
# 2. 再找出底下有th的tr
# 3. th的內容必須要是"廠商名稱"

##
# 首先，找出所有的上一層是tr的th標籤的 nodesets
# 提示：你的xpath應該為 "//tr/th"
ths <- {
  # 請在這裡填寫你的程式碼
  xml_find_all(tender, "//tr/th")
}

stopifnot(class(ths) == "xml_nodeset")
stopifnot(length(ths) == 116)

# 請取出每個ths中的th標籤的值
ths_text <- {
  # 請在這裡填寫你的程式碼
  xml_text(ths)
}
# 在Windows上的機器，必需要額外告訴R 說這段文字是UTF-8編碼
Encoding(ths_text) <- "UTF-8"

# 請拿ths_text和 "　廠商名稱" 作比較
is_target <- { # logic
  ths_text == "　廠商名稱"
}

stopifnot(class(is_target) == "logical")
stopifnot(sum(is_target) == 4)
stopifnot(which(is_target)[1] == 36)

# 我們可以利用 `[`來從ths中選出那些值為 "　廠商名稱" 的xml_nodeset
ths2 <- ths[is_target]

stopifnot(class(ths2) == "xml_nodeset")
stopifnot(length(ths2) == 4)

# 因為我們的目標是th旁邊的td，所以要先透過`xml_parent`回到tr層級
trs <- {
  # 請在這裡填寫你的程式碼
  xml_parent(ths2)
}

stopifnot(class(trs) == "xml_nodeset")
stopifnot(length(trs) == 4)

# 然後我們直接用xml_children取得這些tr的所有子標籤
trs_children <- {
  # 請在這裡填寫你的程式碼
  xml_children(trs)
}

stopifnot(class(trs_children) == "xml_nodeset")
stopifnot(length(trs_children) == 8) # 一個tr有兩個子標籤

# 取出這些標籤的值
trs_children_text <- {
  # 請在這裡填寫你的程式碼
  xml_text(trs_children)
}
# 在Windows上的機器，必需要額外告訴R 說這段文字是UTF-8編碼
Encoding(trs_children_text) <- "UTF-8"

stopifnot(class(trs_children_text) == "character")
stopifnot(length(trs_children_text) == 8)

# 只挑出那些值「不是」 "　廠商名稱"的元素
players <- {
  # 請在這裡填寫你的程式碼
  trs_children_text[!is_target]
}
#大概流程是，先用" 廠商名稱"截取，且弄一個布林向量，再找父親，再找不是" 廠商名稱"的兄弟

# 其實這樣取出的廠商名稱還是很髒，有一大堆換行、tab字元等等
# 但是我們就先練習到這裡了
