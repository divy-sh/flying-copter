extends Area2D

func _on_body_entered(_body):
	$collect_sound.play()
	
	Global.current_score += 1
	if Global.current_score >= 20:
		Global.SPEED = -700

	$Coin.queue_free()
	$collision.queue_free()

	await $collect_sound.finished
	queue_free()
