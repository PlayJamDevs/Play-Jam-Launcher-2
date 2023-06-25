extends Control

onready var title: Label = $"%title"
onready var year: Label = $"%year"
onready var author: Label = $"%author"
onready var link: Label = $"%link"
onready var qr: TextureRect = $"%QR"
onready var cover: TextureRect = $"%cover"
onready var description: Label = $"%description"
var executable_path := ""

const MAX_QR_SIZE = 240

func display_game(info: GameData):
	title.text = "Título: %s" % info.title
	year.text = "Año: %s" % info.year
	author.text = "Autor: %s" % info.author
	link.text = "Link: %s" % info.link
	description.text = "Descripción: %s" % info.description
	
	cover.texture = info.cover
	qr.texture = info.qr
	
	executable_path = info.get_executable_path()

func _ready() -> void:
	clear()

func clear() -> void:
	var d = GameData.new()
	
	title.text = "No hay juegos"
	year.text = "Este directorio de juegos está vacío"
	author.text = ""
	link.text = ""
	description.text = ""
	cover.texture = null
	qr.texture = null
	executable_path = ""

