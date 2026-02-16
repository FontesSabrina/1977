class_name FireTrap extends Area2D  

func _on_body_entered(body: Node2D) -> void:  #  quando um corpo entra na área da armadilha.  
	if body.is_in_group("player"):  # Verifica se o corpo que entrou é um jogador.  
		body.take_damage()  # Se for um jogador, aplica dano ao jogador.  

func _on_start_time_timeout() -> void:  #  quando um temporizador (timer) atinge o tempo limite para iniciar a armadilha.  
	$anim.play("on")  # Executa a animação de ativação da armadilha (fogo ligado).  
	$fireColl.set_deferred("disabled", false)  # Ativa a colisão do fogo, permitindo que cause dano aos corpos que entrarem.  

func _on_stop_timer_timeout() -> void:  #  quando um temporizador (timer) atinge o tempo limite para parar a armadilha.  
	$anim.play("off")  # Executa a animação de desativação da armadilha (fogo desligado).  
	$fireColl.set_deferred("disabled", true)  # Desativa a colisão do fogo, impedindo que cause dano aos corpos que entrarem.
