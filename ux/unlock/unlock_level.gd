extends Node2D

var fade_duration = 0.1

var level_list = []

func _ready():
	var back_button = $back
	back_button.pressed.connect(_back_button_pressed)
	var levels = $levels/VBoxContainer
	var selectable = preload("res://ux/unlock/selectable.tscn")
	var i = 0
	for l in Global.save_data.levels:
		var level = selectable.instantiate()
		level.position = Vector2(0 , 0 + 350 * i)
		level.find_child("name").text = Global.save_data.levels[l].name
		level.find_child("cost").text = str(Global.save_data.levels[l].cost)
		i += 1
		print(level.position)
		levels.add_child(level)
		level_list.append(level)

func _process(_delta):
	if Global.game_state == Global.GameStates.UNLOCK_LEVELS:
		modulate.a = min(modulate.a + _delta / fade_duration, 1)
		visible = true
	else:
		modulate.a = max(modulate.a - _delta / fade_duration, 0)
		if modulate.a == 0:
			visible = false

func _back_button_pressed():
	Global.unlocks()
