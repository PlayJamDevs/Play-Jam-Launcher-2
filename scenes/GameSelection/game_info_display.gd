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
	
	var cover_path = info.get_cover_path()
	cover.texture = load_img(cover_path)
	qr.texture = generate_qr(info.link)
	
	executable_path = info.get_executable_path()
	
	
	
	pass

func generate_qr(text) -> Texture:
	var qr_code: QrCode = QrCode.new()
	qr_code.error_correct_level = QrCode.ERROR_CORRECT_LEVEL.LOW
	var texture: ImageTexture = qr_code.get_texture(text)
	return texture

func load_img(path) -> Texture:
	var img := Image.new()
	var code = img.load(path)
	if code:
		print("attempt to load img at ", path, " returns in error_code ", code)
	var tex := ImageTexture.new()
	tex.create_from_image(img, 0)
	return tex
	

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
