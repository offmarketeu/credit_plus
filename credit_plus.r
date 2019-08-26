
ur=1101401

# Parametros

ec <- read.csv2("file_ec")
mc <- read.csv2("file_mc")
ca <- read.csv2("file_ca")
lgd_add<- read.csv2("file_lgd")

num_sim=1000000

nrnd <- matrix(rnorm(0,1), nrow= num_sim, ncol=15)
inrnd <- matrix(qnorm(rnorm(0,1)), nrow= num_sim, ncol=15)

# Lectura de fichero de texto

de<- read.csv2("file_csv", sep=";")

# Extrae ru de analisis

