class_name World extends Node2D  

@onready var player := $player as CharacterBody2D  
@onready var control: Control = $HUD/control  
@onready var camera := $Camera2D as Camera2D  

func _ready() -> void:  
	player.follow_camera(camera)  
	Globals.player.player_has_died.connect(game_over)  
	control.timer_is.up.connect(game_over)  

func _process(delta: float) -> void:  
	pass  

# Função para recarregar o jogo  
func reload_game() -> void:  
	await get_tree().create_timer(1.0).timeout  
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")

# Função chamada quando o jogo termina  
func game_over() -> void:  
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")
