library(readxl)

ur<-1101453
ecu<- 'UK_CM_1'
ca<- 0.145
lgd_add<- 1.46

# datos credito

fd<- read.csv2("E:/APP_OFFMARKET/credit_plus/UK_retail.csv")
fd_ru<- fd[fd$RU_ID==ur,]

# ecuaciones minoristas
ec <- read_excel("E:/APP_OFFMARKET/credit_plus/sensi_mayov16.xls", skip=3)
ec <- ec[ec$Modelo==ecu,]

# matriz correlaciones
mc <- read_excel("E:/APP_OFFMARKET/credit_plus/corr_oficiales.xls", skip=4)
mc<- mc[,-c(1)]

#ca <- read.csv2("file_ca")
#lgd_add<- read.csv2("file_lgd")

num_sim=1000000

nrnd <- matrix(rnorm(0,1), nrow= num_sim, ncol=15)
inrnd <- matrix(qnorm(rnorm(0,1)), nrow= num_sim, ncol=15)


