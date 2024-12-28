extends RigidBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.load()
	Global.save_data.current_score = 0
	self.freeze = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Global.game_state == Global.GameStates.PLAYING:
		self.freeze = false
	if position.y > 1000 or position.y < -800:
		game_over()
	
	var sprite = self.find_child("sprite")
	var target_rotation = self.linear_velocity.y / 1300
	sprite.rotation = lerp_angle(sprite.rotation, target_rotation, 0.1)

func _input(event):
	if event.is_pressed() and Global.game_state != Global.GameStates.OVER:
		Global.game_playing()
		self.linear_velocity = Vector2(0, -1300)

func _integrate_forces(state):
	pass
	for i in range(state.get_contact_count()):
		var contact_collider = state.get_contact_collider_object(i)
		if contact_collider:
			game_over()

func game_over():
	Global.save()
	Global.game_over()
	
