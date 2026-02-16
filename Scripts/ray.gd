class_name RayTrap extends Area2D




func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.take_damage()


func _on_start_time_timeout() -> void:
	$anim.play("off")
	$rayColl.set_deferred("disabled",false)


func _on_stop_timer_timeout() -> void:
	$anim.play("on")
	$rayColl.set_deferred("disabled",true)
