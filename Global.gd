extends Node

var SPEED = -500

enum GameStates {
	MENU,
	IDLE,
	PLAYING,
	OVER
}

var game_state = GameStates.MENU

var save_data = {
	"current_score": 0,
	"high_score": 0,
}

func save():
	save_data.high_score = max(save_data.current_score, save_data.high_score)
	var save_file = FileAccess.open("user://save.cfg", FileAccess.WRITE)
	save_file.store_var(save_data.high_score)
	save_file.close()

func load():
	if not FileAccess.file_exists("user://save.cfg"):
		save()
	var file = FileAccess.open("user://save.cfg", FileAccess.READ)
	save_data.best_score = file.get_var()
	
func game_over():
	SPEED = 0
	game_state = GameStates.OVER
	
func game_idle():
	SPEED = -500
	game_state = GameStates.IDLE
	
func game_playing():
	game_state = GameStates.PLAYING

func main_menu():
	SPEED = -500
	game_state = GameStates.MENU
