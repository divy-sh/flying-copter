extends Node2D

const OBSTACLE_COUNT = 2
var SPEED = -300
var SPAWN_OFFSET = 1080
var OBSTACLE_SWAY = 400

var obstacles = []
var first
var second

func _ready():
	for i in range(OBSTACLE_COUNT):
		var obstacle_path = "res://assets/level/trainyard/obstacles/obs_%d.tscn" % (i + 1)
		obstacles.append(load(obstacle_path))
	spawn_obstacles()
	
func _process(delta):
	process_obstacle_physics(delta)

func spawn_obstacles():
	first = obstacles[randi() % OBSTACLE_COUNT].instantiate()
	first.position = Vector2(SPAWN_OFFSET, obstacle_sway())
	second = obstacles[randi() % OBSTACLE_COUNT].instantiate()
	second.position = Vector2(SPAWN_OFFSET * 2, obstacle_sway())
	add_child(first)
	add_child(second)

func process_obstacle_physics(delta):
	if first and first is Node2D:
		first.position += Vector2(SPEED, 0) * delta
	if second and second is Node2D:
		second.position += Vector2(SPEED, 0) * delta
	
	if first.position.x < -SPAWN_OFFSET:
		first = reset_obstacle(first)
	if second.position.x < -SPAWN_OFFSET:
		second = reset_obstacle(second)

func reset_obstacle(obs):
	remove_child(obs)
	obs.queue_free()
	var new_obs = obstacles[randi() % OBSTACLE_COUNT].instantiate()
	new_obs.position = Vector2(SPAWN_OFFSET, obstacle_sway())
	add_child(new_obs)
	return new_obs

func obstacle_sway():
	if randi() % 2 == 0:
		return randi() % OBSTACLE_SWAY
	else:
		return -1 * randi() % OBSTACLE_SWAY
