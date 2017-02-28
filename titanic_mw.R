# Data Wrangling Exercise #2 - Missing Data -Ming Waters
library(dplyr)
library(tidyr)

# Load the original titanic file, rename to t_new

t_new <- read.csv("titanic_original.csv")

# Locate missing values and replace with "S"

t_new$embarked =  gsub("^$", "S", t_new$embarked)

# Find missing values in age column and replace with the mean value of age

t_new <- mutate(t_new, age = ifelse(is.na(t_new$age), 
                                   mean(t_new$age, na.rm = TRUE), age))

# Fill missing values in boat column with "None"

t_new$boat <-  gsub("^$", "None", t_new$boat)

#Inspect the cabin column - Why are the missing cabin numbers, what does
# the missing numbers mean?
View(t_new)

# Determine if there is a coorelation between survival 0 = died and lack of 
# cabin number 

# After view table, I did not see a coorelation between any other 
# variable missing a field and the cabin missing so guessing missing cabin
# number indicatdes a crewmember

# Create a new column 
# that has_cabin_number which has 1 if there is a cabin number, 
# and 0 otherwise.
t_new <- mutate(t_new, cabin_number = ifelse(grepl("^$", cabin), 0, 1))

# rename clean file to titanic_clean.csv
write.csv(t_new, "titanic_clean.csv")
