class_name Enemy extends CharacterBody2D  

const SPEED = 30  # Define uma constante para a velocidade do inimigo.  
var direction: int = 1  # Inicializa a direção do movimento; 1 significa que o inimigo se move para a direita e -1 para a esquerda.  
@onready var wall_detector := $wall_detector as RayCast2D  # Cria uma referência ao nó 'wall_detector', que é do tipo 'RayCast2D'.  

func _ready() -> void:  # Função chamada quando o nó está pronto.  
	wall_detector.enabled = true  # Ativa o RayCast, permitindo que ele detecte colisões.  

func _process(delta: float) -> void:  # Função chamada em cada frame para atualizar o estado do inimigo.  
	# Mantém o movimento  
	var motion = Vector2.RIGHT * direction * SPEED  # Calcula o vetor de movimento baseado na direção e na velocidade.  
	position += motion * delta  # Atualiza a posição do inimigo.  

	# Atualiza o RayCast e verifica a colisão  
	wall_detector.force_raycast_update()  # Força uma atualização do RayCast para verificar se há uma colisão.  
	if wall_detector.is_colliding():  # Checa se o RayCast está colidindo com alguma coisa.  
		direction *= -1  # Inverte a direção do movimento se houve uma colisão com uma parede.  

func _on_area_2d_body_entered(body: Node) -> void:  # Função chamada quando um corpo entra na área 2D do inimigo.  
	if body.is_in_group("player"):  # Verifica se o corpo que entrou é um jogador.  
		body.take_damage()  # Se for um jogador, aplica dano ao jogador.  

func _on_area_2d_body_exited(body: Node) -> void:  # Função chamada quando um corpo sai da área 2D do inimigo.  
	print("exit")  # Imprime uma mensagem no console quando um corpo sai.  
	# player = null  # Esta linha está comentada, mas poderia ser usada para limpar a referência ao jogador.
