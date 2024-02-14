library(ggplot2)

titanic <- read.csv("C:\\Users\\udaya\\OneDrive\\Desktop\\practice\\CATS_Practice\\udaya\\ggplot2\\titanic.csv",stringsAsFactors = FALSE)

titanic
View(titanic)

titanic$Pclass <- as.factor(titanic$Pclass)
titanic$Survived <- as.factor(titanic$Survived)
titanic$Sex <- as.factor(titanic$Sex)
titanic$Embarked <- as.factor(titanic$Embarked)


#survival_rate

ggplot(titanic, aes(x = Survived))+ 
  geom_bar()
