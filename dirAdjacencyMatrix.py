#Directed Adjacency Matrix

def directed_adjacency_matrix(num_vertices,num_edges):
	option = input("Which of the following do you want to find?\n1. Weighted Adjacency Matrix of Directed Graph\n2. Unweighted Adjacency Matrix of Directed Graph\n3. EXIT\n")
	mat = [[0 for i in range(num_vertices)] for j in range(num_vertices)]
	

	#Weighted

	if option == '1':
		for i in range(num_edges):

			#Entering the vertices
			start, end = input("Enter i,j - each separated by ',': ").split(",") 

			#Constraint on possible values of i and j
			if (int(start) not in range(1, num_vertices+1)) | (int(end) not in range(1, num_vertices+1)): 
				print("The value of i and j should be postive and less than the number of vertices. Try again.\n")
				return directed_adjacency_matrix(num_vertices,num_edges)

			edge_weight = float(input("Edge weight: "))
			mat[int(start)-1][int(end)-1] = round(float(mat[int(start)-1][int(end)-1] + edge_weight),2)
		return mat	

	#Unweighted

	elif option == '2':
		for i in range(num_edges):
			start, end = input("Enter i,j - each separated by ',': ").split(",")

			#Constraint on possible value of i and j
			if (int(start) not in range(1,num_vertices+1)) | (int(end) not in range(1,num_vertices+1)): 
				print("The value of i and j should be postive and less than the number of vertices. Try again.\n")
				return directed_adjacency_matrix(num_vertices,num_edges)
			mat[int(start)-1][int(end)-1] = mat[int(start)-1][int(end)-1] + 1
		return mat

	elif option == '3':
		return 0

	else:
		print("INVALID OPTION! Choose 1 or 2.\n")
		return directed_adjacency_matrix(num_vertices,num_edges)

#Function to print matrix
def print_matrix(matrix):
	for row in matrix:
		print(row)

#Take from user - the number of vertices and the number of edges
vertices = int(input("Number of vertices: "))
edges = int(input("Enter number of edges: "))

mymat = directed_adjacency_matrix(vertices, edges)
if mymat != 0:
	print("\nAdjacency matrix for {} vertices is as follows: ".format(vertices))
	print_matrix(mymat)

	

