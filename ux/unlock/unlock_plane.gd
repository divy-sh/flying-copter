extends Node2D

var fade_duration = 0.1

func _ready():
	var back_button = $back
	back_button.pressed.connect(_back_button_pressed)
	populate_list()

func _process(_delta):
	if Global.game_state == Global.GameStates.UNLOCK_PLANES:
		modulate.a = min(modulate.a + _delta / fade_duration, 1)
		visible = true
	else:
		modulate.a = max(modulate.a - _delta / fade_duration, 0)
		if modulate.a == 0:
			visible = false

func _back_button_pressed():
	Global.unlocks()

func populate_list():
	var vehicles = $vehicles/GridContainer
	var selectable_preload = preload("res://ux/unlock/selectable.tscn")
	for p in Global.save_data.vehicles:
		var selectable = selectable_preload.instantiate()
		selectable.find_child("name").text = "[center]%s[/center]" % Global.save_data.vehicles[p].title
		if Global.save_data.vehicles[p].unlocked == false:
			selectable.find_child("unlock").text = str(Global.save_data.vehicles[p].cost)
		else:
			selectable.find_child("unlock").text = "Unlocked"
		selectable.find_child("image").texture = load("res://plane/planes/" + 
		Global.save_data.vehicles[p].name + ".png")
		
		selectable.selectableName = p
		selectable.type = "vehicle"
		vehicles.add_child(selectable)
	
	vehicles.queue_sort()
