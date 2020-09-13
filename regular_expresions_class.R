library(stringr)
library(dplyr)

#' Dataset 
frutas <- c("banana","anana","manzana","naranja","mandarina","frutilla")

#' 1) Al comienzo de la cadena // At the beggining of the string
#' 
#' 
#' 1.a ) visualizo como funciona mi patrón o expresión regular
#' Frutas que empiezan con "a"
str_view(frutas,"^a")
# Frutas que empiezan con "f"
str_view(frutas,"^f")

# 1.b) puedo usar str_detect para filtrar luego
str_detect(frutas,"^a")

# 1.b.1 ) Caso usando R base
frutas[str_detect(frutas,"^a")]

# 1.b.2) Caso usando dplyr
tabla <- tibble(nombres = c("banana","anana","manzana","naranja","mandarina","frutilla"))

tabla %>% 
  filter(str_detect(nombres,"^a")) # str_detect(Column_name,Pattern)

# 1.c) funcion str_stars

str_view(frutas,"^a")

str_starts(frutas,"a")

tabla %>% 
  filter(str_starts(nombres,"a")) # str_starts(Column_name,Pattern)

# Filtre frutas cuyo nombre empiece con "f"
tabla %>% 
  filter(str_starts(nombres,"___"))

# 2 ) al final de la cadena / at the end of the string

# 2.1) str_ends

str_view(frutas,"na$")

str_ends(frutas,"na")

# Frutas que terminen con "ana"

str_ends(frutas,"ana")
str_view(frutas,"ana$")


# 2.2) str_detect

str_detect(frutas,"na$")

# Quiero las que NO terminan en "na"

str_detect(frutas,"na$",negate = TRUE)

str_view(frutas,"na$",match = TRUE)

# 3) Contiene una cadena

# 3.1 

str_view(frutas,"na")

str_detect(frutas,"na")

# Frutas cuyo nombre contiene "z"
str_view(_____,"z")

# 4) Combinar elementos

# 4.1) * Cualquier caracter

# Los [ ] representan un caracter o grupo

# Ejemplo 
str_view(frutas,"[:letter:]")

str_view(frutas,"[:letter:]*") # * means 0 or more

# Combinamos expresiones

# Que empiece con m y luego cualquier cantidad de letras

str_view(frutas,"^m[:letter:]*") # * means 0 or more

# Que empiece con m y luego cuatro (4 four) letras

str_view(frutas,"^m[:letter:]{4}") 

# Muestra manzana y mandarina
str_view(frutas,"^m[:letter:]{2,6}") # rango entre 2 y 6

# Shows only mandarina
str_view(frutas,"^m[:letter:]{2,6}$") # rango entre 2 y 6

## dataset nombres 


library(readr)
nombres_2015 <- read_csv("https://infra.datos.gob.ar/catalog/otros/dataset/2/distribution/2.21/download/nombres-2015.csv")

names <- nombres_2015 %>% 
  select(nombre) %>% 
  as.vector() 

head(nombres_2015)
# Como es un dataset grande y puede demorar procesarse, 
# seleccionamos al azar unas 1000 muestras.

set.seed(100)
nombres <- sample_n(names, 1000)

## Sintaxis expresiones

# space character, espacios
str_view(nombres$nombre,"[:space:]") # espacios

# letras del alfabeto
str_view(nombres$nombre,"[:letter:]") 
str_view(nombres$nombre,"[:letter:]*")

# mayusculas
str_view(nombres$nombre,"[A-Z]") 
str_view(nombres$nombre,"[:upper:]") 

# minusculas
str_view(nombres$nombre,"[a-z]") 
str_view(nombres$nombre,"[:lower:]")
str_view(nombres$nombre,"[a-z]+") 
 


## EJERCICIOS 

# Nombres que terminen con "z"

str_view(nombres$nombre,"z$",match = TRUE)

# Nombres que empiecen con la letra "X"

str_view(nombres$nombre,"^X",match = TRUE)

# Nombres que contengan las silabas "ana"
str_view(nombres$nombre,"ana",match = TRUE)

# Nombres "Lionel" ( Messi lovers :-D)
str_view(nombres$nombre,"Lionel",match = TRUE)

# Nombres que empiecen con "A" y terminen con "a"

str_view(nombres$nombre,"^A[:alpha:]*a$",match = TRUE)

# Nombres que empiecen con "L" y terminen con "a"
str_view(nombres$nombre,"^L[:alpha:]*a$",match = TRUE)

# Nombres con 5 caracteres

str_view(nombres$nombre,"^[:alpha:]{5}$",match = TRUE)

# Nombres entre 1 y 5 caracteres

str_view(nombres$nombre,"^[:letter:]{1,5}$",match=TRUE)

# Personas con dos nombres

str_view(nombres$nombre,"^[:letter:]+[:space:][:letter:]+$")

# Personas con tres nombres

str_view(nombres$nombre,"^[:letter:]+[:space:][:letter:]+[:space:][:letter:]+$")

# evitando repetir :-) don't repeat, use {}

str_view(nombres$nombre,"^[:letter:]+([:space:][:letter:]+){2}$",match = TRUE)

