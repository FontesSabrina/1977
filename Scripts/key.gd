class_name Key extends Node2D 

func _ready():  
	if self.name in Globals.key_fouded:  # Verifica se o nome da chave já está na lista de chaves encontradas.  
		queue_free()  # Se a chave já foi encontrada, remove o nó do jogo.  
	print(Globals.key_fouded)  # Imprime a lista de chaves encontradas no console.  

func _on_area_2d_body_entered(body): 
	Globals.key_fouded.append(self.name)  # Adiciona o nome da chave à lista de chaves encontradas.  
	queue_free()  # Remove o nó da chave do jogo após ser coletada.
