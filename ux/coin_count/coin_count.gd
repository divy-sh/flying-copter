extends Node2D

var fade_duration = 0.1

func _process(_delta):
	var count_text = $coin_count_text
	count_text.text = str(Global.save_data.coins)
