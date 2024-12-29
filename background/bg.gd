extends Node

var SPAWN_OFFSET = 3030
var bgs = []
var first = []
var second = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(Global.save_data.level.layerCount):
		var level = "res://background/%s/level_%s.tscn" % [Global.save_data.level.name, i]
		bgs.append(load(level))
		spawn_bg(bgs[i], i)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for i in range(Global.save_data.level.layerCount):
		process_bg_physics(delta, bgs[i], i)

func spawn_bg(bg, i):
	first.append(bg.instantiate())
	first[i].position = Vector2(0, 0)
	second.append(bg.instantiate())
	second[i].position = Vector2(SPAWN_OFFSET, 0)
	add_child(first[i])
	add_child(second[i])

func process_bg_physics(delta, bg, i):
	if first[i] and first[i] is Node2D:
		first[i].position += Vector2(Global.SPEED * (0.8 - 0.1 * i), 0) * delta
	if second[i] and second[i] is Node2D:
		second[i].position += Vector2(Global.SPEED * (0.8 - 0.1 * i), 0) * delta
	
	if first[i].position.x < -SPAWN_OFFSET:
		first[i] = reset_bg(first[i], bg)
	if second[i].position.x < -SPAWN_OFFSET:
		second[i] = reset_bg(second[i], bg)

func reset_bg(obs, bg):
	remove_child(obs)
	obs.queue_free()
	var new_bg = bg.instantiate()
	new_bg.position = Vector2(SPAWN_OFFSET, 0)
	add_child(new_bg)
	return new_bg
