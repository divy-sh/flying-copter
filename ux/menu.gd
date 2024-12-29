extends Node2D

var fade_duration = 0.1

func _ready():
	var play_button = $play
	play_button.pressed.connect(_play_pressed)
	var high_scores = $highScores
	high_scores.pressed.connect(_high_score_pressed)

func _process(_delta):
	if Global.game_state == Global.GameStates.MENU:
		modulate.a = min(modulate.a + _delta / fade_duration, 1)
		visible = true
	else:
		modulate.a = max(modulate.a - _delta / fade_duration, 0)
		if modulate.a == 0:
			visible = false

func _play_pressed():
	Global.game_idle()

func _high_score_pressed():
	Global.high_score()
