extends Control
#extends UIState

onready var item_list: ItemList = $"%ItemList"


onready var title: Label = $"%title"
onready var year: Label = $"%year"
onready var author: Label = $"%author"
onready var link: Label = $"%link"
onready var qr: TextureRect = $"%QR"
onready var cover: TextureRect = $"%cover"
onready var description: Label = $"%description"
var executable_path := ""

func update_game(info: GameData):
	title.text = info.title
	year.text = "Año: %s" % info.year
	author.text = "Autor: %s" % info.author
	link.text = "Link: %s" % info.link
	description.text = "Descripción: %s" % info.description
	cover.texture = info.texture
	executable_path = info.executable_path
	qr.texture = info.qr_texture
	pass
	
