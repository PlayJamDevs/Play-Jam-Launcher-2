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
