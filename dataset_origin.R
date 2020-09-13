# Dataset download

nombres_2015 <- read_csv("https://infra.datos.gob.ar/catalog/otros/dataset/2/distribution/2.21/download/nombres-2015.csv")

# write csv
write_csv(nombres_2015,path = "dataset_nombres.csv")

#nombres_2015 <- read_csv("dataset_nombres.csv")
