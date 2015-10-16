require("jsonlite")
require("RCurl")
require("dplyr")
require("ggplot2")

# Change the USER and PASS below to be your UTEid
edu <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from EDUCATION"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_pjo293', PASS='orcl_pjo293', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))

emp <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from UNEMPLOYMENT"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_pjo293', PASS='orcl_pjo293', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))

summary(edu)
summary(emp)

head(edu)
head(emp)


# plots number of people who have a college degree vs. number of people who are employed by state.
# the states are the top 6 median income states and the bottom 6 median income states
dplyr::inner_join(emp, edu, by="AREA_NAME") %>% group_by(STATE.x) %>% filter(STATE.x==STATE.y & STATE.x %in% c("MS", "AR", "WV", "KY", "NM", "TN", "PR", "MD", "NJ", "AK", "HI", "CT")) %>% ggplot(aes(x = as.numeric(as.character(EMPLOYED_2009)), y = as.numeric(as.character(BACHELORS2009_13)), color = STATE.x)) + labs(x="Number of People Who Hold Bachelor Degrees", y=paste("Number of People Who Are Employed")) + geom_point()
