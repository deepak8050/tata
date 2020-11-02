#question 1 
# Importing all the data sets 
getwd()
setwd("C:\\Users\\Anish\\Documents\\R Case Studies (All 3 case studies)\\R case study 1 (Retail)")

cust <- read.csv("Customer.csv")
prod <- read.csv("prod_cat_info.csv")
trans <- read.csv("Transactions.csv")

View(cust)
View(prod)
View(trans)

library(dplyr)
prod <- rename(prod,prod_subcat_code = prod_sub_cat_code) 
cust <- rename(cust,cust_id = customer_Id)


# USING THE MERGE FUNCTION  
tp <- merge(x = trans,y = prod,by.x = "prod_subcat_code",by.y = "prod_cat_code",all.y = T)
View(tp)

#using the dplyr code 

x<- inner_join(trans,prod,"prod_subcat_code"="prod_subcat_code")

Customer_Final <- inner_join(cust,x,"cust_id"="cust_id")
View(Customer_Final)


#---------------------------------------------------

# question 2
# column names and their corresponding datatypes
str(Customer_Final)

#Top/Bottom 10 observations
head(Customer_Final,10)
tail(Customer_Final,10)

# Five number summary 
summary(Customer_Final)


# Question 2.d and Question 3 
# frequency tables & Bar Charts for all categorical variables


require(ggplot2)

# Gender
w<- table(Customer_Final$Gender)
w <- as.data.frame(w)
names(w)[1] <- "Gender"
w

# Gender freq bar 

freq_bar_Gender<- ggplot(Customer_Final,aes(x = Gender))+
  theme(axis.text.x=element_text(angle = -90, hjust = 0,vjust = .5)) +
  geom_bar(fill = "steelblue") +
  labs(x = "Gender Ratio ",
       title = "Gender Count")

freq_bar_Gender



# prod_cat_code 
pc<- table(Customer_Final$prod_cat_code)
pc <- as.data.frame(pc)
names(pc)[1] <- "prod_cat_code"
pc

# prod_cat_code Freq Bar

freq_bar_Prod_cat_code<- ggplot(Customer_Final,aes(x = prod_cat_code))+
  theme(axis.text.x=element_text(angle = -90, hjust = 0,vjust = .5)) +
  geom_bar(fill = "steelblue") +
  labs(x = "Product cat COde ",
       title = "Product Cat Code")
freq_bar_Prod_cat_code



#city_code
cc<- table(Customer_Final$city_code)
cc <- as.data.frame(cc)
names(cc)[1] <- "city_code"
cc
sum(cc$Freq)

#city_code freq bar 


freq_bar_City_code<- ggplot(Customer_Final,aes(x = city_code))+
                      theme(axis.text.x=element_text(angle = -90, hjust = 0,vjust = .5)) +
                      geom_bar(fill = "steelblue") +
                      labs(x = "City Codes ",
                           title = "Distribution of city codes")
freq_bar_City_code



# prod_subcat_code
psc<- table(Customer_Final$prod_subcat_code)
psc <- as.data.frame(psc)
names(psc)[1] <- "prod_subcat_code"
psc
sum(psc$Freq)

freq_bar_prod_subcat_code<- ggplot(Customer_Final,aes(x = prod_subcat_code))+
                            theme(axis.text.x=element_text(angle = -90, hjust = 0,vjust = .5)) +
                            geom_bar(fill = "steelblue") +
                            labs(x = "Customer Product subcat Codes ",
                                 title = "Distribution of Customer Product subcat Codes")
freq_bar_prod_subcat_code

#Store_type
st<- table(Customer_Final$Store_type)
st <- as.data.frame(st)
names(st)[1] <- "Store_type"
st
sum(st$Freq)


freq_bar_prod_Store_type<- ggplot(Customer_Final,aes(x = Store_type))+
                            theme(axis.text.x=element_text(angle = -90, hjust = 0,vjust = .5)) +
                            geom_bar(fill = "steelblue") +
                            labs(x = "Customer Product Store_type ",
                                 title = "Distribution of Customer Product Store Type")
freq_bar_prod_Store_type


#prod_cat
prc<- table(Customer_Final$prod_cat)
prc <- as.data.frame(prc)
names(prc)[1] <- "prod_cat"
prc
sum(prc$Freq)

freq_bar_prod_cat<- ggplot(Customer_Final,aes(x = prod_cat))+
                            theme(axis.text.x=element_text(angle = -90, hjust = 0,vjust = .5)) +
                            geom_bar(fill = "steelblue") +
                            labs(x = "Customer Product Cat ",
                                 title = "Distribution of Customer Product Cat")
freq_bar_prod_cat


#prod_sub_cat_code
pscc<- table(Customer_Final$prod_subcat_code)
pscc <- as.data.frame(pscc)
names(pscc)[1] <- "prod_subcat_code"
pscc
sum(pscc$Freq)

freq_bar_prod_sub_cat_code<- ggplot(Customer_Final,aes(x = prod_subcat_code))+
                    theme(axis.text.x=element_text(angle = -90, hjust = 0,vjust = .5)) +
                    geom_bar(fill = "steelblue") +
                    labs(x = "Customer Product Cat ",
                         title = "Distribution of Customer Product Cat")
freq_bar_prod_sub_cat_code

#prod_subcat
psb<- table(Customer_Final$prod_subcat)
psb <- as.data.frame(psb)
names(psb)[1] <- "prod_subcat"
psb
sum(psb$Freq)

freq_bar_prod_subcat<- ggplot(Customer_Final,aes(x = prod_subcat))+
                        theme(axis.text.x=element_text(angle = -90, hjust = 0,vjust = .5)) +
                        geom_bar(fill = "steelblue") +
                        labs(x = "Customer Product SubCat ",
                             title = "Distribution of Customer Product SubCat")
freq_bar_prod_subcat




# Question 3
#Generating Histograms for all the Continous Variables and frequency bars for 
# all the categorical variables 

#Question 4 

#Time period of available transaction data
library(lubridate)
Customer_Final$tran_date <- dmy(Customer_Final$tran_date)
View(Customer_Final)

#COunt of transaction where the total amount of transaction was negative 

Nt <- length(Customer_Final$total_amt[Customer_Final$total_amt<0])
Nt


#Question 5

# analyze which product categories are more popular among females vs male customers 

tab<-table(Customer_Final$Gender,Customer_Final$prod_cat)
tab
rownames(tab)[2:3] <- c("Female","Male")

# this shows Footwear is more popular among females vs Male customers


#Question 6

#which city code has the maximum customer and what was the percentage of customer from that city


cc<- table(Customer_Final$city_code)
cc <- as.data.frame(cc)
names(cc)[1] <- "city_code"
cc
max(cc$Freq)
cc <- arrange(cc,desc(cc$Freq))

cc2 <- round(prop.table(table(Customer_Final$city_code))*100,2)
cc2 <- as.data.frame(cc2)
names(cc2)[1:2] <- c("city_code","percent")
cc2
cc2 <- arrange(cc2,desc(cc2$percent))
cc <- mutate(cc,cc2$percent)

cc

# city code 4 has the maximum customer database
# percentage of customer from city code 4 - 10.51%


# Question no 7

# Which store type sells the  maximum product by value and quantity 
#--------------using the tapply function ------------------------------

maximum_value <- with(Customer_Final,tapply(total_amt,Store_type,sum))
tot_qty <- with(Customer_Final,tapply(Qty,Store_type,sum))
tot_qty <- as.data.frame(qty)
maximum_value <- as.data.frame(maximum_value)
maximum_value


top_store_type <- cbind(maximum_value,tot_qty)
top_store_type

total <- colSums(top_store_type)
total <- rbind(top_store_type,total)
rownames(total)[5] <- "Total"
total

#-----------------------------------using the groupby and summarise function -----------

library(dplyr)
require(dplyr)
max_value <- group_by(Customer_Final,Store_type)
max_value <-summarise(max_value,m_val = sum(total_amt,na.rm= T),qty = sum(Qty,na.rm=T), freq = n())
max_value <- arrange(max_value , desc(m_val))
max_value 


# e-shop exceeds everyother store_type in the value and quantity 


# question no 8 
# what was the total amount earned from the "Electronics" and "clothing" 
# categories from flagship stores

# -------------using the groupby and summarize function ----------

earnings <- group_by(Customer_Final,Store_type,prod_cat)
earnings <- summarise(earnings, earned_val = sum(total_amt,na.rm=T))
earnings <- as.data.frame(earnings)
class(earnings)

earnings <- earnings[c(9,10),]
earnings
as.data.frame(earnings)

# the total earned values from the
#                                  Clothing    1194423
#                Flagship store Electronics    2215136 

# ----------------using the tapply function ---------
e1 <- with(Customer_Final,tapply(total_amt,Customer_Final[c(13,14)],sum))
e1 <- as.data.frame(e1)
e1 <- e1[2,c(3,4)]
e1




# question 9 
# what was the toal amount earned from Male customer under the Electronics category 

# -------------using the groupby and summarize function ----------

Mearnings <- group_by(Customer_Final,prod_cat,Gender)
Mearnings <- summarise(Mearnings, mearned_val = sum(total_amt,na.rm=T))
Mearnings <- as.data.frame(Mearnings)
class(Mearnings)

Mearnings <- Mearnings[10,]
as.data.frame(Mearnings)
Mearnings

# ----------------using the tapply function ---------
names(Customer_Final)

Me1 <- with(Customer_Final,tapply(total_amt,Customer_Final[c(3,14)],sum))
Me1 <- as.data.frame(Me1)
rownames(Me1) <- c(" ","Female","Male")
Me1 <- Me1[3,c(3,4)]
Me1  


library(dplyr)

# Question no 10 ,
# how many customers have more than 10 unique transaction ,after removing all transaction 
# which have any negative amounts 

# removing all the negative transactions 

pt <- Customer_Final[!Customer_Final$total_amt < 0 ,]

# Customers having more than 10 unique transaction 
pt <- pt[!duplicated(pt$transaction_id),]
View(pt)

pt <- with(Customer_Final,group_by(Customer_Final,cust_id))
pt <- summarise(pt,Premium_cust = n())           
pt <- arrange(pt,desc(pt$Premium_cust))
pt <- pt[pt$Premium_cust > 10,]
pt
# there are 36 customer having transaction more than 10 unique transaction 


# Question 11
#For all customer age between 25-35 find out 
#11a - what was the total amount spent for "Electronics" and Books product category 
#11b-  what was the total amount spent by these customer between 1 jan 2014 to 1 march 2014

library(lubridate)
Q11 <- Customer_Final

Q11$DOB <- dmy(Q11$DOB)
Q11$age <- time_length(difftime(today(),Q11$DOB),"years")
View(Q11)
class(Q11$DOB)
min(Q11$age)
max(Q11$age)

Q11$age_group <- with(Q11,case_when(
                        age >= 25 & age <= 35 ~ "Age Group 25 - 35",
                        age > 35 &  age <= 45 ~ "Age Group 36 - 45",
                        age > 45 &  age <= 55 ~ "Age Group 46 - 55",
                        TRUE ~ as.character(age)))

Q11$qtrly_data <- quarter(Q11$tran_date,with_year = T)
View(Q11)

# total amount spent by the age group through tapply function 
Q11a <- with(Q11,tapply(total_amt,Q11[c(14,17)], sum))

Amount_spent <- Q11a[c(2,4),]
Amount_spent

# part 2 

Q11$tran_date <- ymd(Q11$tran_date)
class(Q11$tran_date)
View(Q11)


DR <- filter(Q11,age_group == "Age Group 25 - 35" & tran_date>="2014-01-01" & tran_date<"2014-03-01" )
DR <- summarise(DR,TotalAmount = sum(total_amt) )
DR
