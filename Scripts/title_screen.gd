class_name Title  extends Control  

#botão de iniciar  
func _on_start_btn_pressed() -> void:  
	 
	get_tree().change_scene_to_file("res://prefabs/level1.tscn")  

#  botão de créditos  
func _on_credits_btn_pressed() -> void:  
	get_tree().change_scene_to_file("res://scenes/credits.tscn")  

# botão de controles  
func _on_controles_btn_pressed() -> void:  
	get_tree().change_scene_to_file("res://scenes/controles.tscn")  

#  botão de sair  
func _on_sair_btn_pressed() -> void:  
	get_tree().quit()



func _on_audio_stream_player_finished():
	$".".play()
	pass # Replace with function body.
