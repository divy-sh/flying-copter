extends Node2D

var fade_duration = 0.1

func _ready():
	var restart_button = $save
	restart_button.pressed.connect(_save_pressed)

func _save_pressed():
	if len($name.text) <= 0:
		return
	Global.playerName = $name.text
	Global.save()
	Global.game_over()

func _process(_delta):
	if Global.game_state == Global.GameStates.OVER_SAVE:
		modulate.a = min(modulate.a + _delta / fade_duration, 1)
		visible = true
	else:
		modulate.a = max(modulate.a - _delta / fade_duration, 0)
		if modulate.a == 0:
			visible = false

	var score = $score
	score.text = "[center]High Score: %s[center]" % Global.current_score
