extends Node

enum GameStates {
	MENU,
	IDLE,
	PLAYING,
	OVER,
	OVER_SAVE,
	HIGHSCORE,
	UNLOCK,
	UNLOCK_PLANES,
	UNLOCK_LEVELS,
}

var Levels = {
	forest = {
		name = "forest",
		unlocked = true,
		cost = 0,
		layerCount = 7
	},
	desert = {
		name = "desert",
		unlocked = false,
		cost = 500,
		layerCount = 6
	},
	skies = {
		name = "skies",
		unlocked = false,
		cost = 1000,
		layerCount = 9
	},
	moon = {
		name = "moon",
		unlocked = false,
		cost = 5000,
		layerCount = 6
	},
}

var Vehicles = {
	plane_1_blue = {
		name = "plane_1_blue",
		title = "Dingo Blue",
		unlocked = true,
		cost = 0
	},
	plane_1_pink = {
		name = "plane_1_pink",
		title = "Dingo Pink",
		unlocked = false,
		cost = 100
	},
	plane_1_red = {
		name = "plane_1_red",
		title = "Dingo Red",
		unlocked = false,
		cost = 200
	},
	plane_1_yellow = {
		name = "plane_1_yellow",
		title = "Dingo Yellow",
		unlocked = false,
		cost = 500
	},
	plane_2_blue = {
		name = "plane_2_blue",
		title = "Audit Blue",
		unlocked = false,
		cost = 800
	},
	plane_2_green = {
		name = "plane_2_green",
		title = "Audit Green",
		unlocked = false,
		cost = 1000
	},
	plane_2_red = {
		name = "plane_2_red",
		title = "Audit Red",
		unlocked = false,
		cost = 1500
	},
	plane_2_yellow = {
		name = "plane_2_yellow",
		title = "Audit yellow",
		unlocked = false,
		cost = 2000
	},
	plane_3_blue = {
		name = "plane_3_blue",
		title = "Calibri Blue",
		unlocked = false,
		cost = 2500
	},
	plane_3_green = {
		name = "plane_3_green",
		title = "Calibri Green",
		unlocked = false,
		cost = 3000
	},
	plane_3_red = {
		name = "plane_3_red",
		title = "Calibri Red",
		unlocked = false,
		cost = 4000
	},
	plane_3_yellow = {
		name = "plane_3_yellow",
		title = "Calibri Yellow",
		unlocked = false,
		cost = 8000
	},
}

var default_save_data = {
	"high_score" = [],
	"coins" = 0,
	"level" = Levels.forest,
	"vehicle" = Vehicles.plane_1_blue,
	"levels" = Levels,
	"vehicles" = Vehicles,
}

var playerName = ""

var save_data = {}

var SPEED = -500
var current_score = 0
var game_state = GameStates.MENU

func save():
	save_data.coins += current_score
	if is_high_score():
		save_data.high_score.append([current_score, playerName])
		save_data.high_score.sort()
		save_data.high_score.reverse()
	if len(save_data.high_score) > 10:
		save_data.high_score.pop_back()

	var save_file = FileAccess.open("user://save.cfg", FileAccess.WRITE)
	save_file.store_var(save_data)
	save_file.close()

func is_high_score():
	return (
		current_score > 0 and 
		(
			len(save_data.high_score) == 0 or 
			current_score > save_data.high_score[-1][0]
		)
	)

func load():
	if not FileAccess.file_exists("user://save.cfg"):
		save_data = default_save_data
		save()

	var file = FileAccess.open("user://save.cfg", FileAccess.READ)
	save_data = file.get_var()

func game_over():
	SPEED = 0
	game_state = GameStates.OVER

func game_over_save():
	SPEED = 0
	game_state = GameStates.OVER_SAVE

func game_idle():
	SPEED = -500
	game_state = GameStates.IDLE

func main_menu():
	SPEED = -500
	game_state = GameStates.MENU

func high_score():
	SPEED = 0
	game_state = GameStates.HIGHSCORE

func unlocks():
	SPEED = 0
	game_state = GameStates.UNLOCK

func unlock_planes():
	SPEED = 0
	game_state = GameStates.UNLOCK_PLANES

func unlock_levels():
	SPEED = 0
	game_state = GameStates.UNLOCK_LEVELS


func game_playing():
	game_state = GameStates.PLAYING
