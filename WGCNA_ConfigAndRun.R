#
#'''
#Author: Yuan Shang
#Script to render RNA analytic reports
#Input:sampleInfo.xlsx has 'Sample','Group','Color'(optional) as columns
#Specify:dataDir,species,sampleInfo, and projectName in proparams
#Output: RNASeq Analytic report
#'''

rm(list=ls())
if (rstudioapi::isAvailable()) {
  if (require('rstudioapi') != TRUE) {
    install.packages('rstudioapi')
  }else{
    library(rstudioapi) # load it
  }
  wdir <- dirname(getActiveDocumentContext()$path)
}else{
  wdir <- getwd()
}

#Set wdir to upper directory
wdir <- gsub('[^/]*$','',wdir)
wdir <- substr(wdir, 1, nchar(wdir)-1)
setwd(wdir)
wdir

### Choose groups and groupNames
#c("NCI.F.APOE33","NCI.F.APOE23","NCI.M.APOE33", "NCI.M.APOE34","NCI.M.APOE23","NCI.F.APOE34") #NCI
#c("MCI.F.APOE33","MCI.F.APOE23","MCI.M.APOE33", "MCI.M.APOE34","MCI.M.APOE23","MCI.F.APOE34") #MCI
#c("AD.F.APOE33","AD.F.APOE23","AD.M.APOE33", "AD.M.APOE34","AD.M.APOE23","AD.F.APOE34") #AD

current_groupname <- "NCI"
current_groups <- c("NCI.F.APOE33","NCI.F.APOE23","NCI.M.APOE33", "NCI.M.APOE34","NCI.M.APOE23","NCI.F.APOE34") 

current_groupname <- "AD"
current_groups <- c("AD.F.APOE33","AD.F.APOE23","AD.M.APOE33", "AD.M.APOE34","AD.M.APOE23","AD.F.APOE34")  

current_groupname <- "MCI"
current_groups <- c("MCI.F.APOE33","MCI.F.APOE23","MCI.M.APOE33", "MCI.M.APOE34","MCI.M.APOE23","MCI.F.APOE34") 


current_groupname <- "F_APOE33"
current_groups <- c("NCI.F.APOE33","AD.F.APOE33") 

current_groupname <- "F_APOE34"
current_groups <- c("NCI.F.APOE34","AD.F.APOE34") 

projectName=paste0("WGCNA_ROSMAP_",current_groupname)

### Data Dir where lcpm_WithoutFactors_ROSMAP.Rdata and x_normalized_ROSMAP.Rdata are located
dataDir="~/Dropbox/human/ROSMAP/RNASeq"


### Other parameters that controls WGCNA network constructions
powerEstimate <- 0
thresholdZ.k <- -3
MEDissThres <- 0.4
maptype <- "signed"

### outPut Dir
outDir <- file.path(wdir,current_groupname)
if(!dir.exists(outDir)){
  dir.create(outDir)
}

#sampleMeta=paste0("sample",".xlsx")
proparams <- list(projectName = projectName,
                  date = Sys.Date(),
                  #sampleInfo=sampleMeta,#"sampleInfo_SexAPOE18m.xlsx"
                  dataDir=dataDir,
                  outputDir=outDir,
                  groupName=current_groupname,
                  groups=current_groups,
                  powerEstimate=powerEstimate,
                  thresholdZ=thresholdZ.k,
                  MEDissThres=MEDissThres,
                  maptype=maptype
)


rmarkdown::render("WGCNA_ROSMAP/WGCNA_ROSMAP.Rmd", 
                  params = proparams,
                  output_dir=proparams$outputDir,
                  #knit_root_dir=proparams$wdir,
                  output_file=paste0(proparams$projectName,".html"))




