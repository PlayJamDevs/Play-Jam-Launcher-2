extends Control

onready var title: Label = $"%title"
onready var year: Label = $"%year"
onready var author: Label = $"%author"
onready var link: Label = $"%link"
onready var qr: TextureRect = $"%QR"
onready var cover: TextureRect = $"%cover"
onready var description: Label = $"%description"
var executable_path := ""

func display_game(info: GameData):
	title.text = info.title
	year.text = "Año: %s" % info.year
	author.text = "Autor: %s" % info.author
	link.text = "Link: %s" % info.link
	description.text = "Descripción: %s" % info.description
	
	cover.texture = info.get_cover()
	qr.texture = info.get_qr()
	
	executable_path = info.get_executable_path()
	
	
	
	pass



	

func _ready() -> void:
	var d = GameData.new()
	d.title = "jaja"
	d.year = "2023"
	d.author = "streq"
	d.link = "google.com"
	d.description = "mi juego"
	d.path_to_directory = "/home/streq/.local/share/Steam/steamapps/common/Godot Engine/games/indie/Recontra"
	d.executable_name = "Ejecutable.x86_64"
	display_game(d)
