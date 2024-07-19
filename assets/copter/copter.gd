extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if position.y > 800 or position.y < -800:
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")

func _input(event):
	if event.is_pressed():
		self.linear_velocity = Vector2(0, -800)
