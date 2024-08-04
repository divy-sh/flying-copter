extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.load()
	Global.save_data.current_score = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if position.y > 1000 or position.y < -800:
		game_over()
	
	var sprite = self.find_child("sprite")
	var target_rotation = self.linear_velocity.y / 1000
	sprite.rotation = lerp_angle(sprite.rotation, target_rotation, 0.1)

func _input(event):
	if event.is_pressed():
		self.linear_velocity = Vector2(0, -1000)

func _integrate_forces(state):
	pass
	for i in range(state.get_contact_count()):
		var contact_collider = state.get_contact_collider_object(i)
		if contact_collider:
			print("Colliding with: ", contact_collider.name)
			game_over()

func game_over():
	Global.save()
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")
