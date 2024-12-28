extends Area2D

func _on_body_entered(_body):
	Global.save_data.current_score += 1
	if Global.save_data.current_score >= 20:
		Global.SPEED = -700
	
	scale = Vector2(1.2, 1.2)
	modulate = Color(1, 1, 1, 0.7)
	await get_tree().create_timer(0.05).timeout

	scale = Vector2(0.1, 0.1)
	modulate = Color(1, 1, 1, 1)
	await get_tree().create_timer(0.05).timeout

	queue_free()
