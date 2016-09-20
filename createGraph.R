##### createGraph.R - Max Stoaks 09/18/2016
#####
## Start with this file
## Sourcing this should read the CSV, clean the data and then create the graph in Neo4j
## This assumes you have the csv version of the products spreadsheet in your working directory and that neo4J is running on its standard port
## NOTE - THIS WILL DELETE ALL NODES/RELS in your neo4j db
#####
#####

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

#clean up the data including Category, Technology, SME
unique(GSBProds$Category)
GSBProds[GSBProds$Product=="Admissions Application",]$Category <- "Application / Review"
GSBProds[50,]$Category <- "Application / Review"
unique(GSBProds$DS.SME)
GSBProds[GSBProds$DS.SME=="Max Stocks",]$DS.SME <-"Max Stoaks"
GSBProds[123,]$Technology <- "Salesforce"
GSBProds[25,]$Technology <- "Salesforce/Tableau"


#load neo library
library("RNeo4j", lib.loc="/Library/Frameworks/R.framework/Versions/3.3/Resources/library")

#connect to neo
graph = startGraph("http://localhost:7474/db/data")

createProductGraph(graph, GSBProds)