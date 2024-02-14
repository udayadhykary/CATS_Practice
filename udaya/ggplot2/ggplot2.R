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

#percentages

prop.table(table(titanic$Survived))

#Adding some customization

ggplot(titanic, aes(x = Survived))+ 
  theme_classic() +
  geom_bar() +
  labs(y = "Passenger Count", title = "Titanic Survival Rates")

#Survival rate by gender

ggplot(titanic, aes(x = Sex, fill = Survived))+ 
  theme_classic() +
  geom_bar() +
  labs(y = "Passenger Count", title = "Titanic Survival Rates by Sex")



