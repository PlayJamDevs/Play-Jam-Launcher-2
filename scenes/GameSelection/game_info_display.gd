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

static func entry_text(entry, value):
	return "%s: %s" % [entry, value if value else "???"]

# non breaking space (igual desgraciadamente no se detecta como espacio)
# y se ve todo junto
static func entry_text_no_break_space(entry, value):
	return "%s: %s" % [entry, value if value else "???"]

func display_game(info: GameData):
	title.text = entry_text("Título", info.title)
	year.text = entry_text("Año", info.year)
	author.text = entry_text("Autor", info.author)
	link.text = entry_text_no_break_space("Link", info.link)
	description.text = entry_text("Descripción", info.description)
	
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

