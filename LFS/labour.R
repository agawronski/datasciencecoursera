setwd("C:/Users/aidan/data_science/datasciencecoursera/LFS")
august <- read.csv("lfs-71M0001XCB-E-2014-August_F1.csv", header=TRUE)
august <- august[,c("LFSSTAT","PROV","AGE_12","SEX","EDUC90","MJH","NAICS_18","NOCS_01_47","UHRSMAIN","FIRMSIZE","HRLYEARN","UNION","TENURE","COWMAIN")]
lfs <- august[complete.cases(august),]

#create employment subsetors
#LFS will contain all employed (we already have only the employed due to "complete.cases")
employed <- lfs[lfs$LFSSTAT==1 | lfs$LFSSTAT==2,]
# unemployed <- lfs[lfs$LFSSTAT==3 | lfs$LFSSTAT==4 | lfs$LFSSTAT==5,]
# not_in <- lfs[lfs$LFSSTAT==6,]

# log wage variable
wage <- employed$HRLYEARN
lwage <- log(wage)

#education dummies comparsion group is 0-8 years of education
somehigh <- ifelse(employed$EDUC90==1, 1, 0)
high <- ifelse(employed$EDUC90==2, 1, 0)
somepost <- ifelse(employed$EDUC90==3, 1, 0)
diploma<- ifelse(employed$EDUC90==4, 1, 0)
bachelors <- ifelse(employed$EDUC90==5, 1, 0)
graduate <- ifelse(employed$EDUC90==6, 1, 0)

data <- as.data.frame(cbind(lwage,somehigh,high,somepost,diploma,bachelors,graduate))

#independent variables
# age <- AGE_12 groups of five years
union <- ifelse(employed$UNION==1, 1, 0)
age <- employed$AGE_12
age <- replace(age, age==1, 17)
age <- replace(age, age==2, 22)
age <- replace(age, age==3, 27)
age <- replace(age, age==4, 32)
age <- replace(age, age==5, 37)
age <- replace(age, age==6, 42)
age <- replace(age, age==7, 47)
age <- replace(age, age==8, 52)
age <- replace(age, age==9, 57)
age <- replace(age, age==10, 62)
age <- replace(age, age==11, 67)
age <- replace(age, age==12, 72)
tenure <- employed$TENURE
male <- ifelse(employed$SEX==1, 1, 0)
multi <- ifelse(employed$MJH==2, 1, 0)
public <- ifelse(employed$COWMAIN==1, 1, 0)

#add to data
data <- cbind(data,union,age,tenure,male,multi,public)
           
#Province
NF <- ifelse(employed$PROV==10, 1, 0)
PEI <- ifelse(employed$PROV==11, 1, 0)
NS <- ifelse(employed$PROV==12, 1, 0)
NB <- ifelse(employed$PROV==13, 1, 0)
QC <- ifelse(employed$PROV==24, 1, 0)
ON <- ifelse(employed$PROV==35, 1, 0)
MB <- ifelse(employed$PROV==46, 1, 0)
SK <- ifelse(employed$PROV==47, 1, 0)
AB <- ifelse(employed$PROV==48, 1, 0)
BC <- ifelse(employed$PROV==59, 1, 0)

#add to data
data <- cbind(data,NF,PEI,NS,NB,QC,ON,MB,SK,AB,BC)

#industry dummies NAICS_18
agri <- ifelse(employed$NAICS_18==1, 1, 0)
for_fish <- ifelse(employed$NAICS_18==2, 1, 0)
utilities <- ifelse(employed$NAICS_18==3, 1, 0)
construction <- ifelse(employed$NAICS_18==4, 1, 0)
man_durables <- ifelse(employed$NAICS_18==5, 1, 0)
man_non <- ifelse(employed$NAICS_18==6, 1, 0)
wholesale <- ifelse(employed$NAICS_18==7, 1, 0)
retail <- ifelse(employed$NAICS_18==8, 1, 0)
trans_ware <- ifelse(employed$NAICS_18==9, 1, 0)
fin_insur <- ifelse(employed$NAICS_18==10, 1, 0)
profess <- ifelse(employed$NAICS_18==11, 1, 0)
management <- ifelse(employed$NAICS_18==12, 1, 0)
education <- ifelse(employed$NAICS_18==13, 1, 0)
health <- ifelse(employed$NAICS_18==14, 1, 0)
rec <- ifelse(employed$NAICS_18==15, 1, 0)
accom_food <- ifelse(employed$NAICS_18==16, 1, 0)
other <- ifelse(employed$NAICS_18==17, 1, 0)
public_admin <- ifelse(employed$NAICS_18==18, 1, 0)

#
data <- cbind(data,
              agri,for_fish,utilities,construction,man_durables,man_non,wholesale,retail,trans_ware,
              fin_insur,profess,management,education,health, rec,accom_food,other,public_admin)


# Create experience variable
experience <- as.vector(rep(NA, length(age)))
data <- cbind(data, experience)
#seventeen year olds
data[data$age==17 & data$somehigh==1, "experience"] <- 1
data[data$age==17 & data$high==1, "experience"] <- 0
data[data$age==17 & data$somepost==1, "experience"] <- 0
data[data$age==17 & data$diploma==1, "experience"] <- 0
data[data$age==17 & data$bachelors==1, "experience"] <- 0
data[data$age==17 & data$graduate==1, "experience"] <- 0

#twenty two year olds
data[data$age==22 & data$somehigh==1, "experience"] <- 6
data[data$age==22 & data$high==1, "experience"] <- 5
data[data$age==22 & data$somepost==1, "experience"] <- 4
data[data$age==22 & data$diploma==1, "experience"] <- 3
data[data$age==22 & data$bachelors==1, "experience"] <- 0
data[data$age==22 & data$graduate==1, "experience"] <- 0

#twenty seven year olds
data[data$age==27 & data$somehigh==1, "experience"] <- 11
data[data$age==27 & data$high==1, "experience"] <- 10
data[data$age==27 & data$somepost==1, "experience"] <- 9
data[data$age==27 & data$diploma==1, "experience"] <- 8
data[data$age==27 & data$bachelors==1, "experience"] <- 5
data[data$age==27 & data$graduate==1, "experience"] <- 3

#thirty two year olds
data[data$age==32 & data$somehigh==1, "experience"] <- 16
data[data$age==32 & data$high==1, "experience"] <- 15
data[data$age==32 & data$somepost==1, "experience"] <- 14
data[data$age==32 & data$diploma==1, "experience"] <- 13
data[data$age==32 & data$bachelors==1, "experience"] <- 10
data[data$age==32 & data$graduate==1, "experience"] <- 8

#thirty seven year olds
data[data$age==37 & data$somehigh==1, "experience"] <- 21
data[data$age==37 & data$high==1, "experience"] <- 20
data[data$age==37 & data$somepost==1, "experience"] <- 19
data[data$age==37 & data$diploma==1, "experience"] <- 18
data[data$age==37 & data$bachelors==1, "experience"] <- 15
data[data$age==37 & data$graduate==1, "experience"] <- 13

#fourty two year olds
data[data$age==42 & data$somehigh==1, "experience"] <- 26
data[data$age==42 & data$high==1, "experience"] <- 25
data[data$age==42 & data$somepost==1, "experience"] <- 24
data[data$age==42 & data$diploma==1, "experience"] <- 23
data[data$age==42 & data$bachelors==1, "experience"] <- 20
data[data$age==42 & data$graduate==1, "experience"] <- 17

#fourty seven year olds
data[data$age==47 & data$somehigh==1, "experience"] <- 31
data[data$age==47 & data$high==1, "experience"] <- 30
data[data$age==47 & data$somepost==1, "experience"] <- 29
data[data$age==47 & data$diploma==1, "experience"] <- 28
data[data$age==47 & data$bachelors==1, "experience"] <- 25
data[data$age==47 & data$graduate==1, "experience"] <- 13

#fifty two year olds
data[data$age==52 & data$somehigh==1, "experience"] <- 36
data[data$age==52 & data$high==1, "experience"] <- 35
data[data$age==52 & data$somepost==1, "experience"] <- 34
data[data$age==52 & data$diploma==1, "experience"] <- 33
data[data$age==52 & data$bachelors==1, "experience"] <- 30
data[data$age==52 & data$graduate==1, "experience"] <- 28

#fifty seven year olds
data[data$age==57 & data$somehigh==1, "experience"] <- 41
data[data$age==57 & data$high==1, "experience"] <- 40
data[data$age==57 & data$somepost==1, "experience"] <- 39
data[data$age==57 & data$diploma==1, "experience"] <- 38
data[data$age==57 & data$bachelors==1, "experience"] <- 35
data[data$age==57 & data$graduate==1, "experience"] <- 33

#sixty two year olds
data[data$age==62 & data$somehigh==1, "experience"] <- 46
data[data$age==62 & data$high==1, "experience"] <- 45
data[data$age==62 & data$somepost==1, "experience"] <- 44
data[data$age==62 & data$diploma==1, "experience"] <- 43
data[data$age==62 & data$bachelors==1, "experience"] <- 40
data[data$age==62 & data$graduate==1, "experience"] <- 38

#sixty seven year olds
data[data$age==67 & data$somehigh==1, "experience"] <- 51
data[data$age==67 & data$high==1, "experience"] <- 50
data[data$age==67 & data$somepost==1, "experience"] <- 49
data[data$age==67 & data$diploma==1, "experience"] <- 48
data[data$age==67 & data$bachelors==1, "experience"] <- 45
data[data$age==67 & data$graduate==1, "experience"] <- 42

#seventy two year olds
data[data$age==72 & data$somehigh==1, "experience"] <- 56
data[data$age==72 & data$high==1, "experience"] <- 55
data[data$age==72 & data$somepost==1, "experience"] <- 54
data[data$age==72 & data$diploma==1, "experience"] <- 53
data[data$age==72 & data$bachelors==1, "experience"] <- 50
data[data$age==72 & data$graduate==1, "experience"] <- 48

#Everyone with no education
data[is.na(data$experience), "experience"] <- data[is.na(data$experience),"age"]-14
#generate experience squared variable
data$experience2 <- data$experience^2

#Create occupation variables with NOCS_01_47
data$sr_manage_occupation <- ifelse(employed$NOCS_01_47==1, 1, 0)
data$spec_manage <- ifelse(employed$NOCS_01_47==2, 1, 0)
data$retail_manage <- ifelse(employed$NOCS_01_47==3, 1, 0)
data$other_manage_NEC <- ifelse(employed$NOCS_01_47==4, 1, 0)
data$business_finance <- ifelse(employed$NOCS_01_47==5, 1, 0)
data$insurance_admin <- ifelse(employed$NOCS_01_47==6, 1, 0)
data$secretary <- ifelse(employed$NOCS_01_47==7, 1, 0)
data$admin_regulatory <- ifelse(employed$NOCS_01_47==8, 1, 0)
data$clerical_supervisor <- ifelse(employed$NOCS_01_47==9, 1, 0)
data$clerical_occupation <- ifelse(employed$NOCS_01_47==10, 1, 0)

data$natural_science_professional <- ifelse(employed$NOCS_01_47==11, 1, 0)
data$natural_science_techincal <- ifelse(employed$NOCS_01_47==12, 1, 0)
data$health_professional <- ifelse(employed$NOCS_01_47==13, 1, 0)
data$nurse_supervisors <- ifelse(employed$NOCS_01_47==14, 1, 0)
data$health_technician <- ifelse(employed$NOCS_01_47==15, 1, 0)
data$support_health_services <- ifelse(employed$NOCS_01_47==16, 1, 0)
data$judges_lawyers_psych <- ifelse(employed$NOCS_01_47==17, 1, 0)
data$teachers_professors <- ifelse(employed$NOCS_01_47==18, 1, 0)
data$paralegal <- ifelse(employed$NOCS_01_47==19, 1, 0)
data$art_culture_professional <- ifelse(employed$NOCS_01_47==20, 1, 0)

data$art_culture_technical <- ifelse(employed$NOCS_01_47==21, 1, 0)
data$sales_service_supervisor <- ifelse(employed$NOCS_01_47==22, 1, 0)
data$insurance <- ifelse(employed$NOCS_01_47==23, 1, 0)
data$retail_sales_clerk <- ifelse(employed$NOCS_01_47==24, 1, 0)
data$cashiers <- ifelse(employed$NOCS_01_47==25, 1, 0)
data$chef_cook <- ifelse(employed$NOCS_01_47==26, 1, 0)
data$food_beverage_service <- ifelse(employed$NOCS_01_47==27, 1, 0)
data$protective_services <- ifelse(employed$NOCS_01_47==28, 1, 0)
data$travel_accomodation <- ifelse(employed$NOCS_01_47==29, 1, 0)
data$childcare <- ifelse(employed$NOCS_01_47==30, 1, 0)

data$sales_service_occupation <- ifelse(employed$NOCS_01_47==31, 1, 0)
data$trades_transport <- ifelse(employed$NOCS_01_47==32, 1, 0)
data$construction_trades <- ifelse(employed$NOCS_01_47==33, 1, 0)
data$power_station <- ifelse(employed$NOCS_01_47==34, 1, 0)
data$machinists <- ifelse(employed$NOCS_01_47==35, 1, 0)
data$mechanics <- ifelse(employed$NOCS_01_47==36, 1, 0)
data$other_trades_NEC <- ifelse(employed$NOCS_01_47==37, 1, 0)
data$heavy_equip_crane <- ifelse(employed$NOCS_01_47==38, 1, 0)
data$transport_operator <- ifelse(employed$NOCS_01_47==39, 1, 0)
data$construction <- ifelse(employed$NOCS_01_47==40, 1, 0)

data$agriculture <- ifelse(employed$NOCS_01_47==41, 1, 0)
data$foresty_mine_oil_gas <- ifelse(employed$NOCS_01_47==42, 1, 0)
data$product_labourers <- ifelse(employed$NOCS_01_47==43, 1, 0)
data$mfr_supervisor <- ifelse(employed$NOCS_01_47==44, 1, 0)
data$machine_operator <- ifelse(employed$NOCS_01_47==45, 1, 0)
data$assemblers_in_mfr <- ifelse(employed$NOCS_01_47==46, 1, 0)
data$labourer_manufacturing <- ifelse(employed$NOCS_01_47==47, 1, 0)


#basic model
basic <- lm(lwage ~ somehigh+high+somepost+diploma+bachelors+graduate+union+tenure++male+multi+public+experience+experience2, data=data)

# basic plus industry plus industry dummies (accom_food as comparison)
ind <- lm(lwage ~ somehigh+high+somepost+diploma+bachelors+graduate+union+tenure++male+multi+public+experience+experience2+
            agri +for_fish +utilities +construction +man_durables +man_non +wholesale +retail +trans_ware +fin_insur+
            profess +management +education +health +rec +other +public_admin
          , data=data)

# basic plus industry plus industry dummies (accom_food as comparison)
# plus province (PEI as comparison)
ind_prov <- lm(lwage ~ somehigh+high+somepost+diploma+bachelors+graduate+union+tenure++male+multi+public+experience+experience2+
            agri +for_fish +utilities +construction +man_durables +man_non +wholesale +retail +trans_ware +fin_insur+
            profess +management +education +health +rec +other +public_admin+
            NF+NS+NB+QC+ON+MB+SK+AB+BC
            , data=data)

# basic plus industry plus industry dummies (accom_food as comparison)
# plus province (PEI as comparison)
# plus occupation (cashier as comparison)
ind_prov_occ <- lm(lwage ~ somehigh+high+somepost+diploma+bachelors+graduate+union+tenure++male+multi+public+experience+experience2+
                     agri +for_fish +utilities +construction +man_durables +man_non +wholesale +retail +trans_ware +fin_insur+
                     profess +management +education +health +rec +other +public_admin+
                     NF+NS+NB+QC+ON+MB+SK+AB+BC+
                   sr_manage_occupation+spec_manage+retail_manage+other_manage_NEC+business_finance+insurance_admin+secretary+
                   admin_regulatory+clerical_supervisor+clerical_occupation+natural_science_professional+natural_science_techincal+
                   health_professional+nurse_supervisors+health_technician+support_health_services+judges_lawyers_psych+teachers_professors+ 
                   paralegal+art_culture_professional+art_culture_technical+sales_service_supervisor+insurance+retail_sales_clerk+
                   chef_cook+food_beverage_service+protective_services+travel_accomodation+childcare+sales_service_occupation+ 
                   trades_transport+construction_trades+power_station+machinists+mechanics+other_trades_NEC+heavy_equip_crane+
                   transport_operator+construction+agriculture+foresty_mine_oil_gas+product_labourers+mfr_supervisor+machine_operator+
                   assemblers_in_mfr+labourer_manufacturing
                   , data=data)

coefficients <- ind_prov_occ$coef

write.csv(coefficients, "betas.csv")

h <- read.csv("betas.csv")
h <- h[,3]
head(h)

multiply <- coefficients*h
h_lwage <- sum(multiply)
