require("jsonlite")
require("RCurl")
require("dplyr")
require("ggplot2")

# Change the USER and PASS below to be your UTEid
edu <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from EDUCATION"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_pjo293', PASS='orcl_pjo293', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))

emp <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from UNEMPLOYMENT"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_pjo293', PASS='orcl_pjo293', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))

dplyr::left_join(emp, edu, by = "FIPS_CODE") %>% group_by(URBAN_INFLUENCE_CODE2013, UNEMPLOYMENT_RATE_2013) %>% filter(URBAN_INFLUENCE_CODE2013 %in% c("1","2","3","4","5","6","7","8","9","10","11","12")) %>% ggplot(aes(x = as.numeric(as.character(UNEMPLOYMENT_RATE_2013)), y = as.numeric(as.character(HS_DIPLOMA_ONLY2009_13))), color = URBAN_INFLUENCE_CODE2013) + labs(x="Unemployment Rate", y=paste("Number of People Who Have High School Diplomas Only"))+ geom_point()

