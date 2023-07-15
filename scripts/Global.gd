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

var PATH: String = OS.get_executable_path().get_base_dir()
var GAMES_PATH: String = PATH.plus_file("games")
var CONFIG_PATH: String = PATH.plus_file("config.json")

var config = {
	can_click_links = true,
	can_quit = true,
	start_on_fullscreen = false,
	can_toggle_fullscreen = true,
	mute = false,
}

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("fullscreen") and config.can_toggle_fullscreen:
		OS.window_fullscreen = !OS.window_fullscreen

func is_left_click(event: InputEvent) -> bool:
	return is_click(event, BUTTON_LEFT)
func is_right_click(event: InputEvent) -> bool:
	return is_click(event, BUTTON_RIGHT)
func is_click(event:InputEvent, button:int)->bool:
	return (
		event is InputEventMouseButton and 
		event.is_pressed() and 
		(event as InputEventMouseButton).button_index == button
	)


static func load_json_file(json_path):
	var file = File.new()
	file.open(json_path, file.READ)
	var text = file.get_as_text()
	var json : JSONParseResult = JSON.parse(text)
	file.close()
	if json.error:
		push_warning("couldn't load json file at" + json_path + ", error code " + str(json.error))
		return null
	return json.result

func _ready() -> void:
	if _load_config() == -1:
		print("configuration file not found, creating one with default values")
		_create_config_file()
	_refresh_config()

func _load_config():
	var new_config = load_json_file(CONFIG_PATH)
	if new_config == null:
		return -1
	if typeof(new_config) == TYPE_DICTIONARY:
		for key in config.keys():
			if new_config.has(key):
				config[key] = new_config[key]
	return 0
	
func _create_config_file():
	var file = File.new()
	file.open(CONFIG_PATH, File.WRITE)
	file.store_string(JSON.print(config,"\t"))
	file.close()

func _refresh_config():
	OS.window_fullscreen = config.start_on_fullscreen
	AudioServer.set_bus_mute(0, config.mute)
	get_tree().set_auto_accept_quit(config.can_quit)
	
func open_url(url):
	if config.can_click_links:
		OS.shell_open(url)
