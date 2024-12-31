extends Node2D

var fade_duration = 0.1

func _ready():
	var back_button = $mainMenu
	back_button.pressed.connect(_back_button_pressed)

	var levelsImage = $levels/GridContainer/levels/image
	levelsImage.texture = load("res://background/" + 
		Global.save_data.level.name + "/logo.png")
	var vehicleImage = $levels/GridContainer/vehicles/image
	vehicleImage.texture = load("res://plane/planes/" + 
		Global.save_data.vehicle.name + ".png")

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

func _on_level_unlock_pressed():
	Global.unlock_levels()

func _on_vehicle_unlock_pressed():
	Global.unlock_planes()
