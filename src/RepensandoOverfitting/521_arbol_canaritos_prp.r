#limpio la memoria
rm( list=ls() )
gc()

library("data.table")
library("rpart")
library("rpart.plot")

#setwd( "D:\\gdrive\\ITBA2022A\\" )  #establezco la carpeta donde voy a trabajar
setwd( "C:\\Users\\Administrador\\Desktop\\UTNFRP\\AplicacionesaEconomiayFinanzas\\Laboratorio\\" )  #establezco la carpeta donde voy a trabajar
#cargo el dataset
dataset  <- fread( "./datasets/paquete_premium_202011.csv")


#uso esta semilla para los canaritos
#set.seed(102191)
set.seed(999233)
#-0.5994048	1730	669	7
#agrego una variable canarito, random distribucion uniforme en el intervalo [0,1]
dataset[ ,  canarito1 :=  runif( nrow(dataset) ) ]

#agrego los siguientes canaritos
#for( i in 1:30 ) dataset[ , paste0("canarito", i ) :=  runif( nrow(dataset)) ]
for( i in 1:100 ) dataset[ , paste0("canarito", i ) :=  runif( nrow(dataset)) ]


#Primero  veo como quedan mis arboles
modelo  <- rpart(formula= "clase_ternaria ~ . ",
                 data= dataset[,],
                 model= TRUE,
                 xval= 0,
                 cp= -0.599, 
                 minsplit= 1730, 
                 minbucket=669,
                 maxdepth= 7)

#creo la carepta donde guardo el resultado
dir.create( "./labo/exp/",  showWarnings = FALSE ) 
dir.create( "./labo/exp/ST5210/", showWarnings = FALSE )
setwd("C:\\Users\\Administrador\\Desktop\\UTNFRP\\AplicacionesaEconomiayFinanzas\\Laboratorio\\labo\\exp\\ST5210\\")   #Establezco el Working Directory DEL EXPERIMENTO

#genero la imagen del arbol
pdf( file= "arbol_canaritos100.pdf", width=20, height=4)
prp(modelo, extra=101, digits=5, branch=1, type=4, varlen=0, faclen=0)
dev.off()
