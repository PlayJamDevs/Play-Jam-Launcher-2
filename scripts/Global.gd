class_name Globals extends Node

# Clase que contiene todas las configuraciones y valores que todos los nodos deben compartir.

enum UIState {
	INTRO,
	CATEGORY_SELECTION,
	GAME_SELECTION,
	EXECUTE_GAME,
	EXIT
}

var qr_text: String = "text"
var error_correction_level: int = 0

var PATH :String = OS.get_executable_path().get_base_dir()
var GAMES_PATH :String = PATH.plus_file("games")
