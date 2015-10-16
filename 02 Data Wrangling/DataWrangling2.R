require("jsonlite")
require("RCurl")
require("dplyr")
require("ggplot2")

# Change the USER and PASS below to be your UTEid
edu <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from EDUCATION"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_pjo293', PASS='orcl_pjo293', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))

emp <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from UNEMPLOYMENT"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_pjo293', PASS='orcl_pjo293', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))


# plots boxplot showing median salary for each county for each urban influence code 
dplyr::full_join(edu, emp, by="FIPS_CODE") %>% group_by(URBAN_INFLUENCE_CODE2013) %>% filter(URBAN_INFLUENCE_CODE2013 %in% c("1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12")) %>% ggplot(aes(x= URBAN_INFLUENCE_CODE2013 , y=as.numeric(as.character(MEDIAN_INCOME_2013)), color=URBAN_INFLUENCE_CODE2013)) + geom_boxplot()
