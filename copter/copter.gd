extends RigidBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.load()
	Global.current_score = 0
	self.freeze = true

func _process(_delta):
	if Global.game_state == Global.GameStates.PLAYING:
		self.freeze = false
	if position.y > 1000 or position.y < -800:
		game_over()
	
	var sprite = $sprite
	var target_rotation = self.linear_velocity.y / 2600
	sprite.rotation = lerp_angle(sprite.rotation, target_rotation, 0.1)

func _input(event):
	if event.is_pressed() and (Global.game_state == Global.GameStates.IDLE or 
		Global.game_state == Global.GameStates.PLAYING):
		Global.game_playing()
		self.linear_velocity = Vector2(0, -1300)

func _integrate_forces(state):
	if not Global.game_state == Global.GameStates.PLAYING:
		return
	for i in range(state.get_contact_count()):
		var contact_collider = state.get_contact_collider_object(i)
		if contact_collider:
			game_over()
			break

func show_explosion():
	self.linear_velocity = Vector2.ZERO
	self.gravity_scale = 0
	var sprite = $sprite
	sprite.visible = false
	var explosion = $Explosion
	explosion.visible = true
	explosion.play("explosion")
	if not explosion.is_connected("animation_finished", queue_free):
		explosion.connect("animation_finished", queue_free)

func game_over():
	show_explosion()
	Global.save()
	Global.game_over()
