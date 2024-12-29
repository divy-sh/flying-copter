extends Node2D

var fade_duration = 0.1

func _ready():
	var back_button = $mainMenu
	back_button.pressed.connect(_back_button_pressed)

func _process(_delta):
	if Global.game_state == Global.GameStates.UNLOCK:
		modulate.a = min(modulate.a + _delta / fade_duration, 1)
		visible = true
	else:
		modulate.a = max(modulate.a - _delta / fade_duration, 0)
		if modulate.a == 0:
			visible = false

func _back_button_pressed():
	Global.main_menu()

func _on_planes_input_event(_viewport, event, _shape_idx):
	if event.is_pressed():
		Global.unlock_planes()


func _on_levels_input_event(_viewport, event, _shape_idx):
	if event.is_pressed():
		Global.unlock_levels()
