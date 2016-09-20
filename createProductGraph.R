createProductGraph <- function(graph, df) {
    clear(graph, input = FALSE)
    #create the personas admit, student, faculty, staff, alumni, it, public with name and desc
    admitPersonaNode = createNode(graph, .label="Persona", name="Admit")
    studentPersonaNode = createNode(graph, .label="Persona", name="Student")
    facultyPersonaNode = createNode(graph, .label="Persona", name="Faculty")
    staffPersonaNode = createNode(graph, .label="Persona", name="Staff")
    alumniPersonaNode = createNode(graph, .label="Persona", name="Alumni")
    itPersonaNode = createNode(graph, .label="Persona", name="IT")
    publicPersonaNode = createNode(graph, .label="Persona", name="Public")
    addIndex(graph, "Persona", "name")
    
    #create the technologies
    for (tech in unique(df$Technology)) {
        if(tech != ""){
        techNode = createNode(graph, .label="Technology", name=tech)
        }
    }
    addConstraint(graph, "Technology", "name")
    
    #create the platforms
    for (plat in unique(df$Platform)){
        if(plat != "") {
            createNode(graph, .label="Platform", name=plat)    
        }
    }
    addConstraint(graph, "Platform", "name")
    
    #create the products with name, desc, category, ds.dsm
    for (k in 1:nrow(GSBProds)){
        row <- GSBProds[k,]
        prodNode = createNode(graph, .label="Product", name=row$Product, description=row$Description, category=row$Category, sme=row$DS.SME)
        if(toupper(row$Admit) == "X") {createRel(prodNode, "USED_BY", admitPersonaNode)}
        if(toupper(row$Student) == "X") {createRel(prodNode, "USED_BY", studentPersonaNode)}
        if(toupper(row$Faculty) == "X") {createRel(prodNode, "USED_BY", facultyPersonaNode)}
        if(toupper(row$Staff) == "X") {createRel(prodNode, "USED_BY", staffPersonaNode)}
        if(toupper(row$Alumni) == "X") {createRel(prodNode, "USED_BY", alumniPersonaNode)}
        if(toupper(row$IT) == "X") {createRel(prodNode, "USED_BY", itPersonaNode)}
        if(toupper(row$Public) == "X") {createRel(prodNode, "USED_BY", publicPersonaNode)}
        
        #add tech relationship
        techName <- row$Technology
        if(techName != "") {
            techNode <- getOrCreateNode(graph, "Technology", name=row$Technology)
            createRel(prodNode, "USES_TECH", techNode)
        }
        #browser()
        
        platName <- row$Platform
        if(platName != ""){
            platNode <- getOrCreateNode(graph, "Platform", name=row$Platform)
            createRel(prodNode, "USES_PLATFORM", platNode)
        }
    }

}    