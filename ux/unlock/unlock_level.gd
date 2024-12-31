extends Node2D

var fade_duration = 0.1

func _ready():
	var back_button = $back
	back_button.pressed.connect(_back_button_pressed)
	populate_list()

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

func populate_list():
	var levels = $levels/GridContainer
	var selectable_preload = preload("res://ux/unlock/selectable.tscn")
	for l in Global.save_data.levels:
		var selectable = selectable_preload.instantiate()
		selectable.find_child("name").text = "[center]%s[/center]" % Global.save_data.levels[l].name
		if Global.save_data.levels[l].unlocked == false:
			selectable.find_child("unlock").text = str(Global.save_data.levels[l].cost)
		else:
			selectable.find_child("unlock").text = "Unlocked"
		selectable.find_child("image").texture = load("res://background/" + 
		Global.save_data.levels[l].name + "/logo.png")
		
		selectable.selectableName = l
		selectable.type = "level"
		levels.add_child(selectable)
	
	levels.queue_sort()
