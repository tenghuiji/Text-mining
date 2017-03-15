library(jiebaR)
library(wordcloud2)

#文件路径
readChineseWords<-function(path){
  rawstring = readLines(path)
  rawstring = paste0(rawstring,collapse = ' ')
  s <- gsub('\\w','',rawstring,perl = T)
  s <- gsub('[[:punct:]]',' ',s)
  return(s)
}

#url
male_link <- 'https://s.taobao.com/search?q=男'
female_link <- 'https://s.taobao.com/search?q=女'

male_str <- readChineseWords(male_link)
female_str <- readChineseWords(female_link)

#分词
cc <- worker()
new_user_word(cc,'打底裤','n')
male_words <- cc[male_str]
female_words <- cc[female_str]

male_df <- freq(male_words)
wordcloud2(male_df,figPath = 'male.png',backgroundColor = 'black',color = 'random-light')

female_df <- freq(female_words)
wordcloud2(female_df,figPath = 'female.png',backgroundColor = 'black',color = 'random-light')

