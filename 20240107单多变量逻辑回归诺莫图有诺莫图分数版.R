rm(list = ls())
library(rms)

train_df <- read.csv("E:\\SFYdataJPG\\Code\\imagescore5\\imagescore5\\vae\\vae0326\\train_vaelabeled0326-2.csv")
#test_df <- read.csv("E:\\SFYdataJPG\\Code\\data0103\\11test-clinial.csv")
train_df
# 合并数据
#df <- rbind(train_df, test_df)
dd=datadist(train_df)
options(datadist="dd")
train_df <- as.data.frame(train_df)
print(train_df)
selected_columns <- c('age','pregnant_week', 'LA_diameter','RA_diameter', 'LV_diameter', 'RV_diameter', 'LA_area',
                      'LV_area', 'RA_area','RV_area', 'LA_RA_area_ratio', 'LV_RV_area_ratio', 'left_ventricle_right_ventricle',
                     'LV_ellipticity','RV_ellipticity','Image_Score')
#selected_columns <- c('age','fetal_clinical_gestational_age','fetal_ultrasound_gestational_age', 'LA_diameter', 'LV_diameter', 'LA_area',
 #                     'LV_area', 'RA_area','RV_area', 'LA_RA_area_ratio', 'LV_RV_area_ratio', 
 #                     'LV_ellipticity')
train_df[, selected_columns] <- scale(train_df[, selected_columns])
write.csv(train_df, 'E:\\SFYdataJPG\\Code\\data240111\\20240119\\clinialdata\\test_nomolization.csv', row.names = FALSE)
print(train_df)

#单变量逻辑回归
f_clinial <- lrm(label ~LV_ellipticity, data = train_df,x = TRUE, y = TRUE , maxit = 1000)
print(f_clinial)
#exp(coef(f_clinial)) #OR值/95%置信区间
df <- data.frame(variable  = colnames(f_clinial$var),
                 OR        = exp(f_clinial$coefficients),
                 OR_lower  = exp(f_clinial$coefficients + qnorm(0.025) * sqrt(diag(f_clinial$var))),
                 OR_upper  = exp(f_clinial$coefficients + qnorm(0.975) * sqrt(diag(f_clinial$var))),
                 row.names = NULL)

df
summary(f_clinial, Image_Score=c(0,1)) #odds ratio 的第四个数字是OR,最后一列的最后两个是95%置信区间的值

#age+fetal_clinical_gestational_age+fetal_ultrasound_gestational_age+LA_diameter+
#  LV_diameter+LA_area+LV_area+RA_area+RV_area+LA_RA_area_ratio+LV_RV_area_ratio+LV_ellipticity

#多变量逻辑回归
f_clinial <- lrm(label~LV_diameter+LV_area+LA_RA_area_ratio+LV_RV_area_ratio+Image_Score, data = train_df,x = TRUE, y = TRUE , maxit = 1000)
print(f_clinial)
summary(f_clinial, LA_diameter=c(0,1),LA_area=c(0,1), LV_diameter=c(0,1),RV_area=c(0,1))

dd <- datadist(train_df)
options(datadist="dd")


#par(mgp=c(1.6,0.6,0),mar=c(5,5,3,1)) 
nom <- nomogram(f_clinial,fun=plogis,
                fun.at = c(0.01,0.1,0.5,0.9,0.99), 
                funlabel = "risk",    ##风险轴刻度
                conf.int = F,  #每个得分的置信度区间
                lp=F,
                abbrev = F)
print(nom)
plot(nom,xfrac=0.4,label.every=1)
#诺莫图分数
library(nomogramFormula)
dir.create('E:\\SFYdataJPG\\Code\\data240111\\20240119\\imagescore5\\nom_score0204')



results <- formula_rd(nomogram = nom)

nom_score <- points_cal(formula = results$formula, rd = train_df)
# boxplot(nom_score[PC$label == 0],nom_score[PC$label == 1],names = c("0","1"),col = colors()[10:11])
df <- data.frame(name=train_df$nname,pred = points_cal(formula = results$formula, rd = train_df), label = train_df$label)
write.csv(df, 'E:\\SFYdataJPG\\Code\\data240111\\20240119\\imagescore5\\nom_score0204\\tc_name不归一化.csv',row.names = FALSE)
summary(f_lrm, Age=c(0,1), tuber=c(0,1), EBreast_long=c(0,1),EBreast_short=c(0,1),rad_score=c(0,1),deep_score=c(0,1))
