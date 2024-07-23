extends Node2D

var level
var first
var second
var speed = -400

func _ready():
	level = preload("res://assets/level/trainyard/level.tscn")
	first = level.instantiate()
	second = level.instantiate()
	first.position = Vector2(0, 0)
	second.position = Vector2(1220, 0)

	add_child(first)
	add_child(second)

func _process(delta):
	if first and first is Node2D:
		first.position += Vector2(speed, 0) * delta
	if second and second is Node2D:
		second.position += Vector2(speed, 0) * delta
	if first.position.x < -1220:
		first.position.x = 1220
		first.randomize_obstacles()
	if second.position.x < -1220:
		second.position.x = 1220
		second.randomize_obstacles()
		
