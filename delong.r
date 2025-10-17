library(pROC)
library(readxl)
M_data<-read.csv('D:\\wxx\\SFYdataJPG\\Code\\imagescore5\\imagescore5\\ML240727\\0727other\\tc1_is.csv')
C_data<-read.csv('D:\\wxx\\SFYdataJPG\\Code\\imagescore5\\imagescore5\\ML240727\\tc_xgb.csv')
M_roc <- roc(M_data$label, M_data$pred_probability)
C_roc <- roc(C_data$label, C_data$pred_probability)

# 进行 DeLong 检验
delong <- roc.test(M_roc, C_roc, method='delong')
delong

