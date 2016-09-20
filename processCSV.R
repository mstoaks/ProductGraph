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

GSBProds <- dplyr::select(GSBProducts, Product, Description, Category, Platform, Technology, DS.SME, Admit, Student, Faculty, Staff, Alumni, IT, Public)


#data cleanup utils
# filter(GSBProds, grepl("Max+", DS.SME)  )

#Now build the individual CSV files
#First the products
write.csv(select(GSBProds, Product, Description, DS.SME), file="Products.csv")

#Now the Platforms


#Technology


# Personas
# create (n:Persona {name: "Admit"})
# create (n:Persona {name: "Student"})
# create (n:Persona {name: "Faculty"})
# create (n:Persona {name: "Staff"})
# create (n:Persona {name: "Alumni"})
# create (n:Persona {name: "IT"})
# create (n:Persona {name: "Public"})

#Get admit prods
AdmitProds <- filter(GSBProds, Admit=="X")
write.csv(select(AdmitProds, Product), file="AdmitProducts.csv")

#Get student prods
StudentProds <- filter(GSBProds, Student=="X")
write.csv(select(StudentProds, Product), file="StudentProducts.csv")

#Get Faculty prods
FacultyProds <- filter(GSBProds, Faculty=="X")
write.csv(select(FacultyProds, Product), file="FacultyProducts.csv")

#Get Staff prods
StaffProds <- filter(GSBProds, Staff=="X")
write.csv(select(StaffProds, Product), file="StaffProducts.csv")

#Get Alumni prods
AlumniProds <- filter(GSBProds, Alumni=="X")
write.csv(select(AlumniProds, Product), file="AlumniProducts.csv")

#Get IT prods
ITProds <- filter(GSBProds, IT=="X")
write.csv(select(ITProds, Product), file="ITProducts.csv")

#Get Public prods
PublicProds <- filter(GSBProds, Public=="X")
write.csv(select(PublicProds, Product), file="PublicProducts.csv")



# Need to create an "import" directory under the database root i.e. under max.graphdb


#NEXT STEPS: Add Technology




