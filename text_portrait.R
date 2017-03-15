library(jiebaR)
library(wordcloud2)

#读取中文并去掉非中文及注音符号
readChineseWords<-function(path){
  rawstring = readLines(path)
  rawstring = paste0(rawstring,collapse = ' ')
  s <- gsub(' ','',rawstring)
  s <- gsub('\\w','',rawstring,perl = T)
  s <- gsub('[[:punct:]]',' ',s)
  
  return(s)
}

#文件路径
uri <- 'gov_report.txt'
Rt<-readChineseWords(uri)
Rt<-gsub(' ','',Rt)

#stop.txt为停用词表
words<-worker(stop_word = 'stop.txt')

#添加新词
new_user_word(words,c('大数据','n','新中国','n'))
seg<-segment(Rt,words)

#获取top30的关键字
keys<-worker('keywords',topn=30)
v<-vector_keywords(seg,keys)

#转为data.frame格式
df<-stack(v)
df$ind<-as.numeric(as.character(df$ind))

#生成词云
wordcloud2(df)

