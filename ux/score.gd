extends Node2D

var fade_duration = 0.1

func _process(_delta):
	var score_text = $Score
	score_text.text = "[center] "+ str(Global.save_data.current_score) +" [/center]"
	if Global.game_state == Global.GameStates.PLAYING or Global.game_state == Global.GameStates.IDLE:
		modulate.a = min(modulate.a + _delta / fade_duration, 1)
		visible = true
	else:
		modulate.a = max(modulate.a - _delta / fade_duration, 0)
		if modulate.a == 0:
			visible = false
