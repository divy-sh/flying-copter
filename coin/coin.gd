extends Area2D

func _on_body_entered(_body):
	Global.current_score += 1
	if Global.current_score >= 20:
		Global.SPEED = -700

	queue_free()
