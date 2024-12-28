extends Node2D

const OBSTACLE_COUNT = 6
var SPAWN_OFFSET = 1080
var OBSTACLE_SWAY = 400

var obstacle
var first
var second

var score_ui

func _ready():
	var obstacle_path = "res://assets/level/obstacle/obs_1.tscn"
	obstacle = load(obstacle_path)
	spawn_obstacle()
	spawn_ui()
	
func _process(delta):
	process_obstacle_physics(delta)

func spawn_obstacle():
	first = obstacle.instantiate()
	first.position = Vector2(SPAWN_OFFSET, obstacle_sway())
	second = obstacle.instantiate()
	second.position = Vector2(SPAWN_OFFSET * 2, obstacle_sway())
	add_child(first)
	add_child(second)

func spawn_ui():
	var score_path = load("res://assets/level/score.tscn")
	score_ui = score_path.instantiate()
	score_ui.text = str(Global.save_data.current_score)
	add_child(score_ui)

func process_obstacle_physics(delta):
	if first and first is Node2D:
		first.position += Vector2(Global.SPEED, 0) * delta
	if second and second is Node2D:
		second.position += Vector2(Global.SPEED, 0) * delta
	
	if first.position.x < -SPAWN_OFFSET:
		first = reset_obstacle(first)
	if second.position.x < -SPAWN_OFFSET:
		second = reset_obstacle(second)

func reset_obstacle(obs):
	Global.save_data.current_score += 1
	if Global.save_data.current_score >= 20:
		Global.SPEED = -700
	score_ui.text = str(Global.save_data.current_score)
	remove_child(obs)
	obs.queue_free()
	var new_obs = obstacle.instantiate()
	new_obs.position = Vector2(SPAWN_OFFSET, obstacle_sway())
	add_child(new_obs)
	return new_obs

func obstacle_sway():
	if randi() % 2 == 0:
		return randi() % OBSTACLE_SWAY
	else:
		return -1 * randi() % OBSTACLE_SWAY
