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
const LOADING_QR_TEXTURE = preload("res://assets/QR_LOADING.png")


func get_cover() -> Texture:
	if !cover:
		var loaded_cover = load_img(get_cover_path())
		if !loaded_cover:
			loaded_cover = NOT_FOUND_TEXTURE
		cover = loaded_cover
		
	return cover

var qr : Texture setget,get_qr
var _qr_tex : ImageTexture = ImageTexture.new()
var _generating_qr := false
func get_qr() -> Texture:
	if !link:
		return null
	if !qr and !_generating_qr:
		_qr_tex.create_from_image(LOADING_QR_TEXTURE.get_data(), ImageTexture.FLAG_CONVERT_TO_LINEAR)
		_generate_qr_async()
	elif _thread.is_active() and !_thread.is_alive():
		_thread.wait_to_finish()
	return _qr_tex

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

func _generate_qr() -> void:
	_generating_qr = true
	var qr_code: QrCode = QrCode.new()
	qr_code.error_correct_level = QrCode.ERROR_CORRECT_LEVEL.LOW
	qr = qr_code.get_texture(link)
	_qr_tex.create_from_image(qr.get_data(), ImageTexture.FLAG_CONVERT_TO_LINEAR)
	_generating_qr = false

var _thread : Thread

func _generate_qr_async():
	_thread = Thread.new()
	_thread.start(self, "_generate_qr")
