library(readxl)

ur<-1101453
ecu<- 'UK_CM_1'
ca<- 0.145
lgd_add<- 1.46
setwd("C:/Users/n040485/Documents/1000_FProject/Credit")

# datos credito

fd<- read.csv2("UK_retail.csv")
fd_ru<- fd[fd$RU_ID==ur,]

# ecuaciones minoristas
ec <- read_excel("sensi_mayov16.xls", skip=3)
ec <- ec[ec$Modelo==ecu,]
ec<- ec[,-c(1:3)]

# matriz correlaciones
mc <- read_excel("corr_oficiales.xls", skip=4)
mc<- mc[,-c(1)]
mc[is.na(mc)]<-0

#ca <- read.csv2("file_ca")
#lgd_add<- read.csv2("file_lgd")

num_sim=1000000
nrnd <- matrix(rnorm(num_sim*35,0,1), nrow= num_sim, ncol=35)


# sys + idio

mc_ <- nrnd %*% as.matrix(mc)
sys_cwi <- mc_ %*% t(ec)
idio <- sqrt(1 - sum(ec^2))* matrix((rnorm(num_sim,0,1)), nrow= num_sim, ncol=1)

# Perdidas