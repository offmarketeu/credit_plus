library(readxl)

ur<-1101453
ecu<- 'UK_CM_1'
ca<- 0.04
lgd_add<- 1.06
num_sim=2500000
setwd("C:/Users/n040485/Documents/1000_FProject/Credit")
LOSS<-vector()
LOSS<- rep(0,num_sim)
# datos credito

fd<- read.csv2("UK_retail.csv")
fd_ru<- fd[fd$RU_ID==ur,]
fd_ru<- fd_ru[fd_ru$PD_TRAMO!=64,]

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


fd_ru$pe <- fd_ru$EAD* fd_ru$PD/100 * fd_ru$LGD/100
PE <- sum(fd_ru$pe)


nrnd <- matrix(rnorm(num_sim*35,0,1), nrow= num_sim, ncol=35)

# sys + idio

mc_ <- nrnd %*% as.matrix(mc)
sys_cwi <- mc_ %*% t(ec)
idio <- sqrt(1 - sum(ec^2))* matrix((rnorm(num_sim,0,1)), nrow= num_sim, ncol=1)

# Perdidas

for (scen in 1:num_sim){
  for (buck in 1:nrow(fd_ru)) {
    PD <- as.numeric(as.character(fd_ru[buck,4]))/100
    LGD <- as.numeric(as.character(fd_ru[buck,6]))/100* lgd_add
    EAD<- as.numeric(as.character(fd_ru[buck,8]))
    PD_C <- pnorm((qnorm(PD) - sqrt(ca)* (sys_cwi[scen] + idio[scen] ))/(sqrt(1-ca)),0,1)
    LOSS_B <- PD_C * LGD * EAD
    LOSS[scen] <- LOSS[scen] + LOSS_B
    
  }
  
}

print (quantile(LOSS, 0.9995))
print(PE)
