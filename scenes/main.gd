extends Node2D

func _ready():
	var level = load("res://assets/level/trainyard/trainyard.tscn")
	var level_inst = level.instantiate()
	level_inst.position = Vector2(0, 0)
	add_child(level_inst)

func _process(delta):
	pass
