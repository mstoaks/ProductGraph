createProductGraph <- function(graph, df) {
    clear(graph, input = FALSE)
    #create the personas admit, student, faculty, staff, alumni, it, public with name and desc
    createNode(graph, .label="Persona", name="Admit")
    createNode(graph, .label="Persona", name="Student")
    createNode(graph, .label="Persona", name="Faculty")
    createNode(graph, .label="Persona", name="Staff")
    createNode(graph, .label="Persona", name="Alumni")
    createNode(graph, .label="Persona", name="IT")
    createNode(graph, .label="Persona", name="Public")
    addIndex(graph, "Persona", "name")
    
    #create the technologies
    for (tech in unique(df$Technology)) {
        createNode(graph, .label="Technology", name=tech)
    }
    
    #create the platforms
    for (plat in unique(df$Platform)){
        if(plat != "") {
            createNode(graph, .label="Platform", name=plat)    
        }
        
    }
    addIndex(graph, "Platform", "name")
    
    #create the products with name, description, ds.sme and the relationship to the platforms, technologies and personas
    query = "
    MERGE (product:Product {name:{prodName}, description:{desc}, category:{cat}, sme:{dssme}})
    MERGE (technology:Technology {name:{techName}})
    MERGE (platform:Platform {name:{platName}})
    CREATE (product)-[:PLATFORM]->(platform)
    CREATE (product)-[:TECHNOLOGY]->(technology)
    "
    
    t = newTransaction(graph)
    for (i in 1:nrow(GSBProds)) {
        row <-GSBProds[i,]
        prodName = row$Product
        desc = row$Description
        catName = row$Category
        dssmeName = row$DS.SME
        techName = row$Technology
        #persName = row$Persona
        if (row$Platform != "") {platName = row$Platform}
        
        #get the personas
        if(row$Admit=="X")  {print("Admit")} #FILL ME IN
        appendCypher(t,
                     query,
                     prodName = prodName,
                     desc=desc,
                     cat=catName,
                     dssme=dssmeName,
                     techName=techName,
                     platName=platName
                     #personaName=persName
        )
        #createNode(graph, .label="Product", name=row$Product, description=row$Description, category=row$Category, dssme=row$DS.SME)
    }
    commit(t)
    
}    