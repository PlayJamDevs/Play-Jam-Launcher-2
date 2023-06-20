extends UIState

onready var n_PanelC := $HBoxContainer
onready var n_Panel1 := $HBoxContainer/Panel1
onready var n_Panel2 := $HBoxContainer/Panel2
onready var n_Panel3 := $HBoxContainer/Panel3
onready var n_LabelDescription := get_node("%LabelDescription")

onready var PanelDescription := [
	"Seleccion de juegos proximos a estrenarse. ¡Jugalos antes que nadie!",
	"Seleccion de juegos creados y publicados por desarrolladores independientes. Descubre titulos unicos y emocionantes!",
	"Coleccion de juegos creados para game jams. Ideas innovadoras, mecanicas unicas, estos juegos son un diamante en bruto. Se el primero en descubrir los exitos del futuro!"
]

onready var folders := [
	"estrenos",
	"indie",
	"jams"
]

var selected_idx := 1
var selected

func _unhandled_input(event : InputEvent):
	
	if event.is_action_pressed("ui_accept"):
		open_games_folder(folders[selected_idx])
		return
	
	var direction = (event.get_action_strength("ui_right") - event.get_action_strength("ui_left"))
	if !direction:
		return
	#do-while skip invisible nodes
	while true:
		selected_idx = wrapi(selected_idx + direction, 0, 3)
		if n_PanelC.get_child(selected_idx).is_visible():
			break
	
	update_selected()

func update_selected():
	selected = n_PanelC.get_child(selected_idx)
	for p in n_PanelC.get_children():
		if selected == p:
			p.modulate = Color.cyan
		else:
			p.modulate = Color.white
	n_LabelDescription.text = PanelDescription[selected_idx]

func _ready():
	._ready()
	update_selected()

func open_games_folder(folder_name):
	var games_list = get_games_in_folder(folder_name)
	goto_game_selection(games_list)

func get_games_in_folder(folder_name):
	#open directory
	var path = Global.GAMES_PATH.plus_file(folder_name)
	print(path)
	var dir := Directory.new()
	dir.open(path)
	dir.list_dir_begin(true, true)
	
	var games = []
	
	#iterate through the directory
	var current_file := ""
	while true:
		current_file = dir.get_next()
		if !current_file:
			break
		if !dir.current_is_dir():
			continue
		var game = load_game_info(path.plus_file(current_file))
		if !game:
			continue
		games.append(game)
	return games

func load_game_info(game_dir_path) -> GameData:
	var dir = Directory.new()
	dir.open(game_dir_path)
	
	dir.list_dir_begin(true, true)
	var current_file : String
	var game = GameData.new()
	
	var has_executable = false
	var has_cover = false
	var has_info = false
	
	var executable_name = ""
	var game_info = {}
	while true:
		current_file = dir.get_next()
		if !current_file:
			break
		
		var full_path = game_dir_path.plus_file(current_file)
		
		if !has_executable and current_file.begins_with("Ejecutable") and is_executable(full_path):
			has_executable = true
			executable_name = current_file
		elif !has_cover and current_file == "Cover.png":
			has_cover = true
		elif !has_info and current_file == "info.json":
			game_info = load_info(full_path)
			has_info = !!game_info
			
	
	if !has_executable or !has_info or !has_cover:
		return null
	
	var ret := GameData.new()
	ret.path_to_directory = game_dir_path
	ret.executable_name = executable_name
	for key in game_info.keys():
		if key in ret:
			ret[key] = game_info[key]
	return ret

func is_executable(file_path:String):
	return (
		(OS.has_feature("Windows") and file_path.ends_with(".exe")) or
		(OS.has_feature("X11") and OS.execute("test", ["-x", file_path]) == 0)
	)

func load_info(json_path) -> Dictionary:
	var file = File.new()
	file.open(json_path, file.READ)
	var text = file.get_as_text()
	var json : JSONParseResult = JSON.parse(text)
	file.close()
	if json.error:
		push_error("couldn't load json info for file " + json_path + ", error code " + json.error)
		return {}
	if typeof(json.result) != TYPE_DICTIONARY:
		push_error("couldn't load json info for file " + json_path + ", object isn't a dictionary.")
		return {}
	var missing_fields = get_missing_fields(json.result)
	if missing_fields:
		push_error("couldn't load json info for file " + json_path + ", missing fields are: " + missing_fields)
	return json.result

func get_missing_fields(json):
	var ret = []
	for key in ["year","title","author","description","link"]:
		if !(key in json):
			ret.append(key)
	return ret

func goto_game_selection(games_list):
	pass
