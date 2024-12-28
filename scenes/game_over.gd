extends Node

func _ready():
	pass

func _process(_delta):
	if Global.game_state == 2:
		self.visible = true
	else:
		self.visible = false
