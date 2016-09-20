#Read in the CSV
GSBProducts <- read.csv("./GSBProducts.csv", stringsAsFactors=FALSE)

GSBProducts$ROADMAP <- NULL


#import dplyr
library("dplyr", lib.loc="/Library/Frameworks/R.framework/Versions/3.2/Resources/library")


#clean up column names
names(GSBProducts)[names(GSBProducts) == "Product.Service"] <- "Product"
names(GSBProducts)[names(GSBProducts) == "Principal.Technology"] <- "Technology"
names(GSBProducts)[names(GSBProducts) == "Staff..Admin"] <- "Staff"
names(GSBProducts)[names(GSBProducts) == "Infra..IT"] <- "IT"

GSBProds <- dplyr::select(GSBProducts, Product, Description, Category, Platform, Technology, DS.SME, Admit, Student, Faculty, Staff, Alumni, IT, Public)


#clean up the data Category
unique(GSBProds$Category)
GSBProds[GSBProds$Product=="Admissions Application",]$Category <- "Application / Review"
GSBProds[50,]$Category <- "Application / Review"
unique(GSBProds$DS.SME)
GSBProds[GSBProds$DS.SME=="Max Stocks",]$DS.SME <-"Max Stoaks"

GSBProds[123,]$Technology <- "Salesforce"
GSBProds[25,]$Technology <- "Salesforce / Tableau"

createProductGraph(graph, GSBProds)