extends Node2D

var fade_duration = 0.1

func _process(_delta):
	if Global.game_state == 0:
		modulate.a = min(modulate.a + _delta / fade_duration, 1)
		visible = true
	else:
		modulate.a = max(modulate.a - _delta / fade_duration, 0)
		if modulate.a == 0:
			visible = false
