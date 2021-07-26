#####Clustering the iris data according to petal length and petal width######

data("iris")
v1 = iris$Petal.Length[1:15]
v2 = iris$Petal.Width[1:15]
df = data.frame(v1, v2)
library("stringr")


###################### Defining the functions ######################

#Function for finding Jcust Value 
jclust_value = function(zc1, zc2){
  #ZC1: Reference points for cluster 1
  #ZC2: Reference points for cluster 2
   jclust_elements = c()
  for (i in c(1:length(zc1))) {
    jclust_elements = c(jclust_elements, min(zc1[i],zc2[i]))
  }
  jclust = sum(jclust_elements)/length(jclust_elements)
  jclust = round(jclust, 4)
  return(jclust)
}

#Function for sorting the clusters

clusters_function <- function(vector_e1, vector_e2, zc1_e1, zc1_e2, zc2_e1, zc2_e2){
  
  #vector_e1 = Element 1 of vector under consideration
  #vector_e2 =  Element 2 of vector under consideration
  #zc1_e1 = Element 1 of Zc1
  #zc1_e2 = Element 2 of Zc1
  #zc2_e1 = Element 1 of Zc2
  #zc2_e2 = Element 2 of Zc2
  
  zc1 = sqrt((vector_e1 - zc1_e1)^2 + (vector_e2 - zc1_e2)^2)
  zc2 = sqrt((vector_e1 - zc2_e1)^2 + (vector_e2 - zc2_e2)^2)
  i = 1
  clusters = c()
  
  while (i <= length(zc1)) {
    if (zc1[i] < zc2[i]){
      cluster = "C1"
    } else {
      cluster = "C2"
    }
    clusters = c(clusters,cluster)
    
    i = i + 1
  }
  print(str_c("Jclust value= ", jclust_value(zc1,zc2)))
  return(clusters)
  
}


#Function for finding new referance points

new_reference_points <- function(dfvectors, old_cluster){
  
  old_cluster_c1 = dfvectors[which(old_cluster == "C1"), ]
  old_cluster_c2 = dfvectors[which(old_cluster == "C2"), ]
  zc1new_e1 = mean(old_cluster_c1$v1) #Element 1 of new reference point in Zc1
  zc1new_e2 = mean(old_cluster_c1$v2) #Element 2 of new reference point in Zc1
  zc2new_e1 = mean(old_cluster_c2$v1) #Element 1 of new reference point in Zc2
  zc2new_e2 = mean(old_cluster_c2$v2) #Element 2 of new reference point in Zc2
  
  return(c(zc1new_e1, zc1new_e2, zc2new_e1, zc2new_e2))
}

#Function for comparing two clusters to check if they are same

comparing_clusters = function(old_cluster, new_cluster){
  j = 1
  while(j <= length(old_cluster)){
    if(old_cluster[j] != new_cluster[j]){
      return("The clusters are not equal. Move on to the next iteration.")
      break
    }
    j = j + 1
  }
  return("The clusters are equal!")
}

######################## Solving the problem ###############################

#Let's consider ZC1 = c(1.1, 0.1) and  ZC2 = c(1.7,0.4)

#First iteration
cluster_1 <- clusters_function(v1, v2, 1.1, 0.1, 1.7, 0.4)
plot(v1,v2,xlab = "Petal Length", ylab = "Petal Width", main = "Clustering: First Iteration", 
     pch = 20, col = "red")
points(df$v1[which(cluster_1 == "C1")], df$v2[which(cluster_1 == "C1")], pch = 20,
       col = "blue")

#Second iteration
x <- new_reference_points(df,cluster_1) #new reference points
cluster_2 <- clusters_function(v1, v2, x[1], x[2], x[3], x[4])
plot(v1,v2,xlab = "Petal Length", ylab = "Petal Width", main = "Clustering: Second Iteration", 
     pch = 20, col = "red")
points(df$v1[which(cluster_2 == "C1")], df$v2[which(cluster_2 == "C1")], pch = 20,
       col = "blue")
comparing_clusters(cluster_1, cluster_2)

#Third iteration
y <- new_reference_points(df,cluster_2)
cluster_3 = clusters_function(v1, v2, y[1], y[2], y[3], y[4])
plot(v1,v2,xlab = "Petal Length", ylab = "Petal Width", main = "Clustering: Third Iteration", 
     pch = 20, col = "red")
points(df$v1[which(cluster_3 == "C1")], df$v2[which(cluster_3 == "C1")], pch = 20,
       col = "blue")
comparing_clusters(cluster_2, cluster_3)

#Second and Third clusters are equal

#Fourth iteration to check if the jclust value remains constant
z <- new_reference_points(df, cluster_3)
cluster_4 = clusters_function(v1, v2, z[1], z[2], z[3], z[4])

#Since they are same, we put the clusters in the data frame
petal.clusters = cluster_3

#Final clusters
df_clusters = cbind(df, petal.clusters); df_clusters
