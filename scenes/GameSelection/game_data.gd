extends Reference
class_name GameData
var path_to_directory := ""
var executable_name := ""
var title := ""
var year := ""
var author := ""
var link := ""
var description := ""

func initialize():
#	get_cover()
#	get_qr()
	pass
	
func get_cover_path():
	return path_to_directory.plus_file("Cover.png")
func get_executable_path():
	return path_to_directory.plus_file(executable_name)


func load_img(path) -> Texture:
	var img := Image.new()
	var code = img.load(path)
	if code:
		print("attempt to load img at ", path, " returns in error_code ", code)
	var tex := ImageTexture.new()
	tex.create_from_image(img, 0)
	return tex


var cover : Texture
func get_cover() -> Texture:
	if !cover:
		cover = load_img(get_cover_path())
	return cover

var qr : Texture
func get_qr() -> Texture:
	if !qr:
		qr = generate_qr()
	return qr

func generate_qr() -> Texture:
	var qr_code: QrCode = QrCode.new()
	qr_code.error_correct_level = QrCode.ERROR_CORRECT_LEVEL.LOW
	var texture: ImageTexture = qr_code.get_texture(link)
	return texture
