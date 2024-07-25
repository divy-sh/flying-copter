extends Node2D

const OBSTACLE_COUNT = 8
var obstacles = []
var obs_instance

func _ready():
	for i in range(OBSTACLE_COUNT):
		var obstacle_path = "res://assets/level/trainyard/obstacles/obs_%d.tscn" % (i + 1)
		obstacles.append(load(obstacle_path))
	spawn_obstacle()

func _process(delta):
	if obs_instance:
		obs_instance.position = $Bg.position

func randomize_obstacles():
	if obs_instance:
		obs_instance.queue_free()
	spawn_obstacle()

func spawn_obstacle():
	var random_number = randi() % OBSTACLE_COUNT
	obs_instance = obstacles[random_number].instantiate()
	add_child(obs_instance)
