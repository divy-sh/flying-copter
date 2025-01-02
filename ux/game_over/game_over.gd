extends Node2D

var fade_duration = 0.1

func _ready():
	var restart_button = $restart
	restart_button.pressed.connect(_restart_pressed)
	var main_menu_button = $mainMenu
	main_menu_button.pressed.connect(_menu_button_pressed)

func _restart_pressed():
	Global.game_idle()
	get_tree().reload_current_scene()

func _menu_button_pressed():
	Global.main_menu()
	get_tree().reload_current_scene()

func _process(_delta):
	if Global.game_state == Global.GameStates.OVER:
		modulate.a = min(modulate.a + _delta / fade_duration, 1)
		visible = true
	else:
		modulate.a = max(modulate.a - _delta / fade_duration, 0)
		if modulate.a == 0:
			visible = false

	var score = $score
	score.text = "[center]score: %s[center]" % Global.current_score
