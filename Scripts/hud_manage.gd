extends Control 
class_name HUD    

@onready var time_couter = $time_container/time_couter as Label  # Referência ao rótulo que exibe o tempo, localizado dentro de 'time_container'.  
@onready var life_couter = $container/life_cpntainer/life_couter as Label  # Referência ao rótulo que exibe a vida do jogador, localizado dentro de 'life_cpntainer'.  
@onready var clock_timer: Timer = $clock_timer as Timer  # Referência ao temporizador que controla a contagem do tempo.  

var minutes = 0  # Variável para armazenar os minutos restantes.  
var seconds = 0  # Variável para armazenar os segundos restantes.  
@export_range(0, 10) var default_minutes := 1  # Variável exportada para definir os minutos padrão (inicialmente 1).  
@export_range(0, 59) var default_seconds := 0  # Variável exportada para definir os segundos padrão (inicialmente 0).  

signal time_is_up()  # Sinal que pode ser emitido quando o tempo acabar.  

func _ready() -> void:  # Função chamada quando o nó está pronto.  
	life_couter.text = str("%02d" % Globals.player_life)  # Atualiza o rótulo de vida com o valor atual da vida do jogador.  
	time_couter.text = str("%02d" % default_minutes) + ";" + str("%02d" % default_seconds)  # Define o texto do rótulo de tempo com os minutos e segundos padrão.  
	reset_clock_timer()  # Chama a função para reiniciar o temporizador.  

	# Conectando o sinal de morte do jogador  
	var player = get_tree().get_root().get_node("res://prefabs/player.tscn")  # Obtém a referência ao nó do jogador, atualizado para o caminho correto.  

func _process(delta: float) -> void:  # Função chamada em cada frame para atualizar o estado do HUD.  
	life_couter.text = str("%02d" % Globals.player_life)  # Atualiza o rótulo de vida em cada frame.  

	if minutes == 0 and seconds == 0:  # Verifica se o tempo acabou.  
		queue_free()  # Remove o HUD do jogo.  
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")  # Muda a cena para a tela de game over.  

func _on_clock_timer_timeout() -> void:  # Função chamada quando o temporizador atinge o tempo limite.  
	if seconds == 0:  # Verifica se os segundos chegaram a zero.  
		if minutes > 0:  # Se ainda houver minutos, reduz um minuto e reinicia os segundos.  
			minutes -= 1  
			seconds = 59  
		else:  # Se não houver mais minutos, para o temporizador e sai da função.  
			clock_timer.stop()  
			return  
	seconds -= 1  # Reduz um segundo.  

	time_couter.text = str("%02d" % minutes) + ";" + str("%02d" % seconds)  # Atualiza o rótulo de tempo com os novos valores.  

func reset_clock_timer():  # Função para reiniciar o temporizador.  
	minutes = default_minutes  # Define os minutos para o valor padrão.  
	seconds = default_seconds  # Define os segundos para o valor padrão.  
	clock_timer.start()  # Inicia o temporizador.  

# Função chamada quando o jogador morre  
func _on_player_has_died():  
	print("Game Over!")  # Imprime uma mensagem de game over no console.  
	# Aqui você pode adicionar a lógica para mostrar a tela de game over.  
	get_tree().change_scene("res://scenes/game_over.tscn")  # Muda a cena para a tela de game over.
