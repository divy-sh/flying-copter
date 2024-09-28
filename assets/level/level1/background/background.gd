extends Node

var first
var second
var background = load("res://assets/level/level1/background/background.tscn")
var SPAWN_OFFSET = 1080

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_bg()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	process_obstacle_physics(delta)

func spawn_bg():
	first = background.instantiate()
	first.position = Vector2(SPAWN_OFFSET, 0)
	second = background.instantiate()
	second.position = Vector2(SPAWN_OFFSET * 2, 0)
	add_child(first)
	add_child(second)

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
	remove_child(obs)
	obs.queue_free()
	var new_obs = background.instantiate()
	new_obs.position = Vector2(SPAWN_OFFSET, 0)
	add_child(new_obs)
	return new_obs
