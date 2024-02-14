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

#Survival rate by class of ticket

ggplot(titanic, aes(x = Pclass, fill = Survived))+ 
  theme_classic() +
  geom_bar() +
  labs(y = "Passenger Count", title = "Titanic Survival Rates by Passenger Class")

#Survival rate by ticket class and gender

ggplot(titanic, aes(x = Sex, fill = Survived))+ 
  theme_classic() +
  facet_wrap(~ Pclass)+
  geom_bar() +
  labs(y = "Passenger Count", title = "Titanic Survival Rates by Pclass and Sex")

#Distribution of Passenger ages

ggplot(titanic, aes(x = Age)) +
  theme_classic() +
  geom_histogram(binwidth = 5) +
  labs(y = "Passenger Count",
       x = "Age (binwidth = 5)",
       title = "Titanic Dataset Age Distribtion")


