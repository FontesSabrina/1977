class_name Player extends CharacterBody2D     

var knockback_vetor := Vector2.ZERO  # Variável para armazenar a força de recuo aplicada ao jogador, inicialmente zero.  
@export var SPEED = 100.0  # Variável exportada que define a velocidade do jogador, podendo ser ajustada no editor.  
@onready var animation := $anim as AnimatedSprite2D  # Referência ao nó 'anim', que controla as animações do jogador.  
@onready var remote_trasfom := $remote as RemoteTransform2D  # Referência ao nó 'remote', que permite o controle remoto da posição do jogador pela câmera.  
signal player_has_died()  # Sinal que pode ser emitido quando o jogador morre.  

func _process(delta: float) -> void:  # Função chamada em cada frame para atualizar o estado do jogador.  
	velocity = Vector2.ZERO  # Inicializa a velocidade como zero a cada frame.  

	# Verifica se as teclas de movimento estão pressionadas e ajusta a velocidade de acordo.  
	if Input.is_action_pressed("ui_right"):  
		velocity.x += 1  # Aumenta a velocidade no eixo X para a direita.  
	if Input.is_action_pressed("ui_left"):  
		velocity.x -= 1  # Diminui a velocidade no eixo X para a esquerda.  
	if Input.is_action_pressed("ui_down"):  
		velocity.y += 1  # Aumenta a velocidade no eixo Y para baixo.  
	if Input.is_action_pressed("ui_up"):  
		velocity.y -= 1  # Diminui a velocidade no eixo Y para cima.  

	if velocity.length() > 0:  # Checa se a velocidade é diferente de zero (ou seja, se o jogador está se movendo).  
		velocity = velocity.normalized() * SPEED  # Normaliza o vetor de velocidade e multiplica pela velocidade padrão.  

		# Define a animação de acordo com a direção de movimento.  
		if velocity.x < 0:  
			$anim.play("left")  # Toca a animação para a esquerda.  
		elif velocity.x > 0:  
			$anim.play("right")  # Toca a animação para a direita.  
		elif velocity.y < 0:  
			$anim.play("back")  # Toca a animação para cima.  
		elif velocity.y > 0:  
			$anim.play("front")  # Toca a animação para baixo.  
	else:  
		$anim.play("stopped")  # Se não estiver se movendo, toca a animação de parado.  

	if knockback_vetor != Vector2.ZERO:  # Verifica se existe uma força de recuo.  
		velocity = knockback_vetor  # Se houver, a velocidade é definida como o vetor de recuo.  

	move_and_slide()  # Move o jogador de acordo com a velocidade e lida com a física do jogo.  

func _on_hurtbox_body_entered(body: Node2D) -> void:  # Função chamada quando um corpo entra na "hurtbox" do jogador.  
	take_damage(Vector2.ZERO)  # Aplica dano ao jogador.  
	if $ray_right.is_colliding():  # Verifica colisão à direita.  
		take_damage(Vector2(-50, -50))  # Aplica dano com um vetor de recuo à direita.  
	elif $ray_left.is_colliding():  # Verifica colisão à esquerda.  
		take_damage(Vector2(50, -50))  # Aplica dano com um vetor de recuo à esquerda.  

func take_damage(knockback_force := Vector2.ZERO, duration := 0.25):  # Função para aplicar dano ao jogador.  
	if Globals.player_life > 0:  
		Globals.player_life -= 1  # Reduz a vida do jogador.  
	else:  
		queue_free()  # Se a vida do jogador chegou a zero, remove o jogador do jogo.  
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")  # Muda para a cena de game over.  
	  
	if knockback_force != Vector2.ZERO:  # Checa se há uma força de recuo a ser aplicada.  
		knockback_vetor = knockback_force  # Define o vetor de recuo.  

		var knockback_tween = get_tree().create_tween()  # Cria um tween para animar o recuo.  
		knockback_tween.parallel().tween_property(self, "knockback_vector", Vector2.ZERO, duration)  # Anima a volta do vetor de recuo para zero.  
		animation.modulate = Color(1, 0, 0, 1)  # Muda a cor da animação para vermelho (efeito de dano).  
		knockback_tween.parallel().tween_property(animation, "modulate", Color(1, 1, 1, 1), duration)  # Restaura a cor da animação para normal após o dano.  

func follow_camera(camera):  # Função para acompanhar a câmera.  
	var camera_path = camera.get_path()  # Obtém o caminho da câmera.  
	remote_trasfom.remote_path = camera_path  # Define o caminho remoto para o transform da câmera.
