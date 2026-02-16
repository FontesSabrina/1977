class_name Door extends StaticBody2D  

func _ready():  
	if self.name in Globals.opened_doors:  # Verifica se o nome da porta já está na lista de portas abertas.  
		queue_free()  # Se a porta já estiver aberta, o nó será removido do jogo.  

func _on_area_2d_body_entered(body: Node2D) -> void:  # Função chamada quando um corpo entra na área 2D da porta.  
	if self.name in Globals.key_fouded:  # Verifica se o nome da porta está na lista de chaves encontradas.  
		$anim.play("Open")  # Executa a animação de abrir a porta.  
		await $anim.animation_finished  # Espera a animação terminar antes de continuar.  
		Globals.opened_doors.append(self.name)  # Adiciona o nome da porta à lista de portas abertas.  
		queue_free()  # Remove a porta do jogo após ser aberta.  
	else:  # Este bloco é executado se o nome da porta não estiver na lista de chaves encontradas.  
		$anim.play("Closed")  # Executa a animação de fechar a porta.
