extends Node

var SPEED = -500

var save_data = {
	"current_score": 0,
	"high_score": 0
}

func save():
	save_data.high_score = max(save_data.current_score, save_data.high_score)
	var save_file = FileAccess.open("user://save.cfg", FileAccess.WRITE)
	save_file.store_var(save_data.best_score)
	save_file.close()

func load():
	if not FileAccess.file_exists("user://save.cfg"):
		save()
	var file = FileAccess.open("user://save.cfg", FileAccess.READ)
	save_data.best_score = file.get_var()
	
