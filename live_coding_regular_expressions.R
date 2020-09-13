# [EN] Download the dataset
# [ES] Descarga el dataset
library(readr)
nombres_2015 <- read_csv("https://infra.datos.gob.ar/catalog/otros/dataset/2/distribution/2.21/download/nombres-2015.csv")

# create a vector of names
names <- nombres_2015 %>% 
  select(nombre) %>% 
  as.vector() 

# How many names we have ?
# ¿Cuántos nombres hay?

nrow(names)

# Como es un dataset grande y puede demorar procesarse, 
# seleccionamos al azar unas 1000 muestras.
set.seed(100)
nombres <- sample_n(names, 1000) 

# 1) str_starts 

# Nombres que empiezan con A
str_view(nombres$nombre,"^A")
str_view(names$nombre,"^A", match = TRUE)

# Nombres que empiezan con X
str_view(names$nombre,"^X", match = TRUE) # <- completa 

# Puedes usar str_starts to filter 
names %>%
  filter(str_starts(nombre,"X")) %>%
  View()

# O puedes usar str_detect con la expresión regular
names %>%
  filter(str_detect(nombre,"^X")) %>%
  View()

# 2) str_ends

# Nombres que terminen en "en"
str_view(names$nombre,"en$", match = TRUE)

names %>%
  filter(str_ends(nombre,"en")) %>%
  View()

names %>%
  filter(str_detect(nombre,"en$")) %>% # <-- add the regular expression
  View()

# Agrega la expresión regular para visualizar nombres que terminan en "ias"
str_view(names$nombre,"ias$", match = TRUE)

# Completa el siguiente código para visualizar cuántos nombres
# terminan en "ias"

names %>%
  filter(str_ends(nombre,"ias")) %>%
  count()

# Cuántos nombres terminan en la letra z ?

names %>%
  filter(str_ends(nombre,"z")) %>% # completa
  count()

# TIP extra
# Podemos usar el operador OR que es | para buscar "ias" e "ías"
str_view(names$nombre,"ias$|ías$", match = TRUE)

names %>%
  filter(str_detect(nombre,"ias$|ías$")) %>%
  count()

# 3) str_detect para buscar una cadena

# Nombres "Lionel" por Messi lovers

str_view(names$nombre,"Lionel", match = TRUE)

# Cuántas veces aparece Lionel, o cuántos Lionel hay 

names %>%
  filter(str_detect(nombre,"Lionel")) %>% # <- complete
  count()

# ¿Cuántos Juan hay?
names %>%
  filter(str_detect(nombre,"Juan")) %>% # <- complete
  count()


# ¿Cuántas Maria o María hay ?
names %>%
  filter(str_detect(nombre,"Maria|María")) %>% # <- complete
  count()

#4) Mezclemos patrones!!! 
# Let's mix some patterns 

# Diferencia entre :letter: :alpha: :space:
str_view(names$nombre[1:100], "[:space:]", match = TRUE)

# Me indica la primer letra que encuentra, sea minúscula o mayúscula
str_view(names$nombre[1:100], "[:letter:]", match = TRUE)

# Mayúsculas
str_view(names$nombre[1:100], "[:upper:]", match = TRUE)
str_view(names$nombre[1:100], "[A-Z]", match = TRUE)

# Minúsculas
str_view(names$nombre[1:100], "[:lower:]", match = TRUE)
str_view(names$nombre[1:100], "[a-z]", match = TRUE)

# Que empiece en mayúsculas, y luego cualquier letra
str_view(names$nombre[1:100], "[:upper:][:letter:]", match = TRUE)

# REPETICION REPETITION PATTERN
str_view(names$nombre[1:100], "[:upper:][:letter:]*")

# ¿Cuál es la diferencia entre estas tres expresiones?
str_view(names$nombre[1:100], "[:upper:][:letter:]*")
str_view(names$nombre[1:100], "[:upper:][:letter:]*$")
str_view(names$nombre[1:100], "^[:upper:][:letter:]*$")

# Let's mix some patterns 

# Personas cuyo nombre completo tenga un sólo nombre
str_view(names$nombre[1:100], "^[:letter:]*$")
str_view(names$nombre[1:100], "^[:upper:][:letter:]*$")

# Nombres que empiecen con "L" y terminen con "a"
str_view(names$nombre,"^L[:alpha:]*a$",match = TRUE)

# Nombres que empiecen con "M" y terminen con "s"
str_view(names$nombre,"^_[:alpha:]*_$",match = TRUE) # <- completa el _

# Nombres que empiecen con J y terminen con n
str_view(names$nombre,"^_[:alpha:]*_$",match = TRUE) # <- completa el _

# Nombres con 5 caracteres

str_view(names$nombre,"^[:alpha:]{5}$",match = TRUE)

# Nombres entre 1 y 5 caracteres

str_view(names$nombre,"^[:letter:]{1,5}$",match=TRUE)

# Nombres entre 3 y 6 caracteres
str_view(names$nombre,"^[:letter:]{_,_}$",match=TRUE) # <-- complete

# Personas con dos nombres

str_view(nombres$nombre,"^[:letter:]+[:space:][:letter:]+$",match=TRUE)

# Personas con dos nombres cuyo segundo nombre termine en o
str_view(nombres$nombre,___,match=TRUE)

# Personas con dos nombres cuyo primer y segundo nombre terminen en o

str_view(nombres$nombre,____,match=TRUE)

# EJERCICIOS

# Completa la expresión regular en str_view para encontrar
# los siguientes patrones

# a ) Personas con un sólo nombre en su nombre completo, 
# que contenga la letra "ñ"

str_view(nombres$nombre,____,match=TRUE)

# b ) Personas con un sólo nombre en su nombre completo, 
# que empiece con N y termine con a

str_view(nombres$nombre,____,match=TRUE)

# c) Algún nombre en los nombres completos cuya longitud sea 6 caracteres

# d) Algún nombre en los nombres completos cuya longitud sea entre 5 y 10 caracteres



# Integremos contenidos de unidades anteriores (dplyr y purrr)

# Crea una función para filtrar y luego usa purrr para crear el dataset

# ¿ Cuántos nombres completos con dos nombres hay en el dataset ?

names %>%
  filter(str_detect(nombre,_____)) %>% 
  count()

# Crea un tibble con el siguiente formato
# 
# _CuantosNombres | cantidad |
# ----------------------------
#    1            |          |
#    2            |          |
#    3            |          |

cuantos_nombres <- c(1,2,3)
patron <- c("^[:letter:]*$", ____, ____)

# Crea un tibble con el siguiente formato
# 
# Empieza_con | Termina_con | Cantidad
# ----------------------------
#    A        |             |
#    B        |             |
#    Z        |            |
#
#


filter_names <- function(start_char,end_char)
{
  names %>%
    filter(str_starts(nombre,start_char) & str_ends(nombre,end_char)) %>% 
    count()
  
}

filter_names("G","o")
