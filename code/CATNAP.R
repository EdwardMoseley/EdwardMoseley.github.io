# https://www.hiv.lanl.gov/components/sequence/HIV/neutralization/download_db.comp


# CATNAP
# Assay    last update: Sat Jul 1 00:00:03 2023
# Antibodies    last update: Sat Jul 1 00:00:07 2023
# Antibody germlines    last update: Sat Jul 1 00:00:07 2023
# Antibody heavy chain na sequences    last update: Sat Jul 1 00:00:07 2023
# Antibody heavy chain aa sequences    last update: Sat Jul 1 00:00:07 2023
# Antibody light chain na sequences    last update: Sat Jul 1 00:00:07 2023
# Antibody light chain aa sequences    last update: Sat Jul 1 00:00:07 2023
# Viruses    last update: Sat Jul 1 00:00:12 2023
# Virus na alignment    last update: Sat Jul 1 00:00:13 2023
# Virus aa alignment    last update: Sat Jul 1 00:00:14 2023
# Virus aa alignment (Potential N-linked glycosylation sites are marked with an "O")    last update: Sat Jul 1 00:00:14 2023

# Env Feature - Neutralizing Antibody Contacts & Features
# Env feature    last update: Thu Jun 1 00:05:01 2023




list.files("~/Downloads")

# Antibody IC50 titer database
assay <- read.csv("~/Downloads/assay.txt", sep = '\t', header = T, stringsAsFactors = F)
# Colnames
# "Antibody"  "Virus"     "Reference" "Pubmed.ID" "IC50"      "IC80"      "ID50"     

# Unique antibodies dataset
abs <- read.csv("~/Downloads/abs.txt", sep = '\t', header = T, stringsAsFactors = F)
#[1] "Name"                          "Binding.Type"                  "Structure"                    
#[4] "Ab.patient"                    "Clonal.lineage"                "Isolation.paper.Pubmed.ID."   
#[7] "Neutralizing.antibody.feature" "Light.chain.type"              "X..of.viruses.tested"         
#[10] "ADCC"                          "Mean.panel.IC50"               "SD.panel.IC50"                
#[13] "Alias"                         "LANL.comments"  

virus <- read.csv("~/Downloads/viruses.txt", sep = '\t', header = T, stringsAsFactors = F)


#[1] "Virus.name"               "Subtype"                  "Country"                 
#[4] "Year"                     "Patient.health"           "Days.post.infection"     
#[7] "Days.from.seroconversion" "Fiebig"                   "Risk.factor"             
#[10] "Accession"                "Tier"                     "Infection.stage"         
#[13] "Patient.code.ID."         "Virus.type"               "Co.receptor"             
#[16] "Alias"                    "HIV.DB.name"              "Seq.data"                
#[19] "LANL.comments"            "X..of.Abs.tested"  


tmp <- abs[which(abs$Ab.patient %in% virus$Patient.code.ID.),]

tmp <- virus[which(virus$Patient.code.ID. %in% abs$Ab.patient),]

## ##
## CoV Database
## ##

list.files("~/Downloads/COV CATNAP 11Jul23")

abs <- read.csv("~/Downloads/COV CATNAP 11Jul23/abs.txt", sep = '\t', header = T, stringsAsFactors = F)
assay <- read.csv("~/Downloads/COV CATNAP 11Jul23/assay.txt", sep = '\t', header = T, stringsAsFactors = F)
virus <- read.csv("~/Downloads/COV CATNAP 11Jul23/viruses.txt", sep = '\t', header = T, stringsAsFactors = F)
# Structural feature
sfeat <- read.csv("~/Downloads/COV CATNAP 11Jul23/sfeature.txt", sep = '\t', header = T, stringsAsFactors = F)

# Build data set


# Harmonize names
colnames(virus)[which(colnames(virus) ==  "Virus.name")] <- "Virus"
# Left join assay and virus tables on virus name
tmp <- merge(assay, virus, by = "Virus", all.x = TRUE)
# Left join assay and virus data to antibody data on antibody name
dat <- merge(tmp, abs, by = c("Antibody", "Alias"), all.x = TRUE)

# Remove duplicates
tmp <- dat[!duplicated(dat),]

# Subset ic50 titers
dat <- tmp[tmp$Type == "ic50",]







































