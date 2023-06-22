extends Reference
class_name GameData
var path_to_directory := ""
var executable_name := ""
var cover_name := ""
var title := ""
var year := ""
var author := ""
var link := ""
var description := ""

var cover : Texture setget,get_cover

const NOT_FOUND_TEXTURE = preload("res://assets/NOT_FOUND.png")

func get_cover() -> Texture:
	if !cover:
		var loaded_cover = load_img(get_cover_path())
		if !loaded_cover:
			loaded_cover = NOT_FOUND_TEXTURE
		cover = loaded_cover
		
	return cover

var qr : Texture setget,get_qr
func get_qr() -> Texture:
	if !qr:
		qr = generate_qr()
	return qr

func initialize():
#	get_cover()
#	get_qr()
	pass
	
func get_cover_path():
	return path_to_directory.plus_file(cover_name)
func get_executable_path():
	return path_to_directory.plus_file(executable_name)


func load_img(path) -> Texture:
	var img := Image.new()
	var code :int = img.load(path)
	if code:
		push_warning("attempt to load img at " + path + " returns with error_code " + str(code))
		return null
	var tex := ImageTexture.new()
	tex.create_from_image(img, 0)
	return tex



func generate_qr() -> Texture:
	var qr_code: QrCode = QrCode.new()
	qr_code.error_correct_level = QrCode.ERROR_CORRECT_LEVEL.LOW
	var texture: ImageTexture = qr_code.get_texture(link)
	return texture
