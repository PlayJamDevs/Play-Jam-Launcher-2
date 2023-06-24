extends UIState
onready var game_info_display: Control = $"%game_info_display"
onready var item_list: ItemList = $"%ItemList"

var game_list := []
var selected_item = -1
func _enter_state():
	n_AnimTree["parameters/GameSelection/conditions/exit"] = false

func setup(folder):
	_display_game_list(_get_games_in_folder(folder))
	focus()

func focus():
	if item_list.get_item_count():
		select(0)
	else:
		game_info_display.clear()

func _ready() -> void:
	item_list.connect("item_selected", self, "_on_item_selected")
	item_list.connect("item_activated", self, "_on_item_activated")

func _on_item_selected(index: int):
	game_info_display.display_game(game_list[index])
	selected_item = index
	

func _unhandled_input(event: InputEvent) -> void:
	if !OS.is_window_focused():
		return
	if event.is_action_pressed("ui_cancel"):
		n_AnimTree["parameters/GameSelection/conditions/exit"] = true
	if item_list.items.empty():
		return
	if event.is_action_pressed("ui_accept"):
		activate()
	if event.is_action_pressed("ui_down", true):
		select(selected_item + 1)
	if event.is_action_pressed("ui_up", true):
		select(selected_item - 1)

func select(idx):
	var items = item_list.get_item_count()
	idx = posmod(idx, items)
	item_list.select(idx)
	_on_item_selected(idx)
	#scroll to selected item
	item_list.ensure_current_is_visible()

func activate():
	for idx in item_list.get_selected_items():
		_on_item_activated(idx)

func _on_item_activated(index: int):
	var info: GameData = game_list[index]
	_execute(info.get_executable_path())

func _execute(path):
	OS.execute(path, PoolStringArray(), false)
	pass


func _display_game_list(list: Array):
	game_list = list
	item_list.clear()
	for element in game_list:
		var game : GameData = element
		item_list.add_item(game.title if game.title else "???")
		pass

func _get_games_in_folder(folder_name) -> Array:
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
		var game = _load_game_info(path.plus_file(current_file))
		if !game:
			continue
		games.append(game)
	return games

func _load_game_info(game_dir_path) -> GameData:
	var dir = Directory.new()
	dir.open(game_dir_path)
	
	dir.list_dir_begin(true, true)
	var current_file : String
	var game = GameData.new()
	
	var has_executable = false
	var has_cover = false
	var has_info = false
	
	var executable_name = ""
	var cover_name = ""
	var game_info = {}
	while true:
		current_file = dir.get_next()
		if !current_file:
			break
		
		var full_path = game_dir_path.plus_file(current_file)
		
		if !has_executable and _is_executable(full_path):
			has_executable = true
			executable_name = current_file
		elif !has_cover and "cover.png".nocasecmp_to(current_file) == 0:
			has_cover = true
			cover_name = current_file
		elif !has_info and "info.json".nocasecmp_to(current_file) == 0:
			game_info = _load_info(full_path)
			has_info = !!game_info
			
	
	
	if !has_executable:
		push_error("couldn't load game for folder " + game_dir_path + ", missing executable.")
		return null
	if !has_info or !has_cover:
		var missing = []
		if !has_info:
			missing.append("info.json")
		if !has_cover:
			missing.append("cover.png")
		var suffix = missing[0]
		if missing.size()>1:
			for i in range(1, missing.size()-1):
				suffix += ", "
				suffix += missing[i]
			suffix += " and " + missing[-1]
		
		push_warning("couldn't fully load info for folder " + game_dir_path + ", missing " + suffix + ".")
	
	var ret := GameData.new()
	ret.path_to_directory = game_dir_path
	ret.executable_name = executable_name
	ret.cover_name = cover_name
	for key in game_info.keys():
		if key in ret:
			ret[key] = game_info[key]
	ret.initialize()
	return ret

func _is_executable(file_path:String):
	return (
		(OS.has_feature("Windows") and file_path.ends_with(".exe")) or
		(OS.has_feature("X11") and OS.execute("test", ["-x", file_path]) == 0)
	)

func _load_info(json_path) -> Dictionary:
	var file = File.new()
	file.open(json_path, file.READ)
	var text = file.get_as_text()
	var json : JSONParseResult = JSON.parse(text)
	file.close()
	if json.error:
		push_warning("couldn't load json info for file " + json_path + ", error code " + json.error)
		return {}
	if typeof(json.result) != TYPE_DICTIONARY:
		push_warning("couldn't load json info for file " + json_path + ", object isn't a dictionary.")
		return {}
	var missing_fields = _get_missing_fields(json.result)
	if missing_fields:
		push_warning("couldn't fully load json info for file " + json_path + ", missing fields are: " + missing_fields)
	return json.result

func _get_missing_fields(json):
	var ret = []
	for key in ["year","title","author","description","link"]:
		if !(key in json):
			ret.append(key)
	return ret

