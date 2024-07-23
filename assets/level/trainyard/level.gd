extends Node

var obstacle
var obs_instance
# Called when the node enters the scene tree for the first time.
func _ready():
	obstacle = preload("res://assets/level/trainyard/obstacles/obs_1.tscn")
	obs_instance = obstacle.instantiate()
	add_child(obs_instance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func randomize_obstacles():
	pass
