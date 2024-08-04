extends Node

func _ready():
	self.find_child("score").text += str(Global.save_data.current_score)
	self.find_child("high_score").text += str(Global.save_data.high_score)
