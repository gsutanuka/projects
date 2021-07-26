fifa_data = read.csv("C:/Users/Sutanuka Ghosh/Downloads/Fifa19.csv", na.strings = c(" ",""))
head(fifa_data)
nrow(fifa_data)
ncol(fifa_data)
View(fifa_data)
library(stringr)

#############1############

#1. Explain the command to print the list of columns containing NULL data.

lengthofcolumns = length(colnames(fifa_data))
i = 0
for(i in 1:lengthofcolumns){
    if(sum(is.na(fifa_data[i])) > 0){
      print(colnames(fifa_data)[i])
    }
}

#For missing values, pseudo code for
# a. setting column mean values as default for columns
col = c( "ShortPassing", "Volleys", 
         "Dribbling", "Curve", "FKAccuracy", "LongPassing", "BallControl", 
         "HeadingAccuracy", "Finishing", "Crossing")
for(each in col){
  index = which(colnames(fifa_data) == each)
  fifa_data[which(is.na(fifa_data[,index])), index] = mean(fifa_data[,index], na.rm = TRUE)
}

# b. Set Weight = 200lbs
fifa_data$Weight[is.na(fifa_data$Weight)] = 200

# c. Set Contract Valid Until to 2019
fifa_data$Contract.Valid.Until[is.na(fifa_data$Contract.Valid.Until)] = 2019

# d. Set Loaned From to "None"
fifa_data$Loaned.From[is.na(fifa_data$Loaned.From)] = "None"


# e. Preferred Foot to "Right"
fifa_data$Preferred.Foot[is.na(fifa_data$Preferred.Foot)] = "Right"

#2. Command for displaying different Nations participating in FIFA
unique(fifa_data$Nationality)

#3. Pseudo code for displaying Countries with Most players.
sort(table(fifa_data$Nationality), decreasing = TRUE)[1:30] #first 30 

#4. Command for drawing line plot for age vs rating 
library(ggplot2)

ggplot(data = fifa_data,
       mapping = aes(x = Age))+
geom_line(aes(y = Overall,
          colour = "Red"))+
geom_line(aes(y = Potential,
          colour = "Blue"))+
ylab("Rating")+
labs(color = "Types") +
scale_colour_discrete(labels = c('Overall', 'Potential')) +
ggtitle("Age vs Rating")

#############2############

#1. Display a single graph, Distribution of Overall Score in Different popular 
#Clubs. (box plot)

pop_club_df = as.data.frame(sort(table(fifa_data$Club), decreasing = TRUE)[1:10])
pop_club = pop_club_df$Var1
clubs = c()
scores = c()
for(each in pop_club){
  club_list = fifa_data[which(fifa_data$Club == each),10]
  score_list = fifa_data[which(fifa_data$Club == each),8]
  clubs = c(clubs, club_list)
  scores = c(scores,score_list)
}

df = data.frame(clubs,scores)
colnames(df) = c("Club", "Score")

ggplot(data = df, mapping = aes(x = Club, y = Score))+
  geom_boxplot()+
  xlab("Clubs") + ylab("Overall Score")+
  ggtitle("Boxplots of overall score in popular clubs")

# 2.With the help of visualization, display most preferred Foot of the Player 
# (right/ left)

ggplot(fifa_data, aes(x = factor(Preferred.Foot), fill = factor(Preferred.Foot))) +
  geom_bar()+
  labs(x = "", fill = "")+
  ggtitle("Preferred foot")+
  xlab("Foot")

# 3. Display list of 15 youngest Players from the FIFA 2019

player_age = data.frame(fifa_data$Name, fifa_data$Age)
player_age[order(player_age$fifa_data.Age),][1:15,]

# 4. Histogram of Players age
hist(fifa_data$Age, xlab = "Age of players", main = "Histogram of Age of Players", col = "red")

#######################

#Does weight of the player impact his rating?

weight = str_split(fifa_data$Weight, "lbs")
for(i in 1:length(weight)){
  fifa_data$Weight[i] = weight[[i]][1]
}
fifa_data$Weight = as.numeric(fifa_data$Weight)
fifa_data[which(is.na(fifa_data$Weight)==TRUE),] = mean(fifa_data$Weight, na.rm = TRUE)

cor(fifa_data$Weight,fifa_data$Overall)
cor(fifa_data$Weight, fifa_data$Potential)

#Top 10 players with the most stamina

stam = data.frame(fifa_data$Name, fifa_data$Stamina)
top_stam = stam[order(stam$fifa_data.Stamina, decreasing = TRUE),][1:10,]
colnames(top_stam) = c("Name", "Stamina")
top_stam

