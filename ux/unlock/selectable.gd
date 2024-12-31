extends Node

@export var type: String
@export var selectableName: String

func _on_unlock_pressed():
	if type == "level":
		unlock_level()
	elif type == "vehicle":
		unlock_vehicle()

func unlock_level():
	var level = Global.Levels[selectableName]
	if Global.save_data.levels[selectableName]["unlocked"] == true:
		Global.save_data.level = level
		Global.save()
		get_tree().reload_current_scene()
	elif level.cost <= Global.save_data.coins:
		Global.save_data.coins -= level.cost
		Global.save_data.level = level
		Global.save_data.levels[selectableName]["unlocked"] = true
		Global.save()
		get_tree().reload_current_scene()

func unlock_vehicle():
	var vehicle = Global.Vehicles[selectableName]
	if Global.save_data.vehicles[selectableName]["unlocked"] == true:
		Global.save_data.vehicle = vehicle
		Global.save()
		get_tree().reload_current_scene()
	elif vehicle.cost <= Global.save_data.coins:
		Global.save_data.coins -= vehicle.cost
		Global.save_data.vehicle = vehicle
		Global.save_data.vehicles[selectableName]["unlocked"] = true
		Global.save()
		get_tree().reload_current_scene()
