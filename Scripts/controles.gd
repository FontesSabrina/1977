class_name Controle  extends Control





func _on_voltar_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/title_screen.tscn")


func _on_audio_stream_player_finished():
	$".".play()
	pass 
