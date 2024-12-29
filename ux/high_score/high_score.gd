extends Node2D

var fade_duration = 0.1

func _ready():
	var main_menu_button = $mainMenu
	main_menu_button.pressed.connect(_main_menu_button_pressed)
	var text = ""
	for i in Global.save_data.high_score:
		text += str(i[0]) + "\t\t" + i[1] + "\n"
	var scores_text = $scores
	scores_text.text = text

func _process(_delta):
	if Global.game_state == Global.GameStates.HIGHSCORE:
		modulate.a = min(modulate.a + _delta / fade_duration, 1)
		visible = true
	else:
		modulate.a = max(modulate.a - _delta / fade_duration, 0)
		if modulate.a == 0:
			visible = false

func _main_menu_button_pressed():
	Global.main_menu()
