extends Control
#extends UIState
onready var game_info_display: Control = $"%game_info_display"
onready var item_list: ItemList = $"%ItemList"

var game_list := []

func _ready() -> void:
	item_list.connect("item_selected",self,"_on_item_selected")
	item_list.connect("item_activated",self,"_on_item_activated")

func _on_item_selected(index: int):
	game_info_display.display_game(game_list[index])

func _on_item_activated(index: int):
	var info: GameData = game_list[index]
	execute(info.get_executable_path())

func execute(path):
	pass

func load_list(list: Array):
	game_list = list
	item_list.clear()
	for element in game_list:
		var game : GameData = element
		item_list.add_item(game.title)
		pass
