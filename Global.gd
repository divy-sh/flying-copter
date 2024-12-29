extends Node

enum GameStates {
	MENU,
	IDLE,
	PLAYING,
	OVER,
	HIGHSCORE
}

enum Levels {
	forest,
}

enum Vehicles {
	copter,
}

var default_save_data = {
	"high_score" = [],
	"coins" = 0,
	"level" = Levels.forest,
	"vehicle" = Vehicles.copter,
}

var save_data = {}

var SPEED = -500
var current_score = 0
var game_state = GameStates.MENU

func save():
	save_data.coins += current_score
	var time = Time.get_datetime_dict_from_system()
	if len(save_data.high_score) < 10:
		save_data.high_score.append([current_score, 
		str(time.year) + "-" + str(time.month) + "-" + str(time.day)])
	elif save_data.high_score[-1][0] < current_score:
		save_data.high_score.pop_back()
		save_data.high_score.append([current_score, 
		str(time.year) + "-" + str(time.month) + "-" + str(time.day)])
		save_data.high_score.sort()
		save_data.high_score.reverse()
	
	var save_file = FileAccess.open("user://save.cfg", FileAccess.WRITE)
	save_file.store_var(save_data)
	save_file.close()

func load():
	if not FileAccess.file_exists("user://save.cfg"):
		save_data = default_save_data
		save()

	var file = FileAccess.open("user://save.cfg", FileAccess.READ)
	save_data = file.get_var()

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

func high_score():
	SPEED = 0
	game_state = GameStates.HIGHSCORE
