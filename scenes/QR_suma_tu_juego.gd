extends TextureRect
export var link:="https://www.canva.com/design/DAFnuAJKd-c/2dZlVfpmrwOug-GOSVianA/view"
func _ready() -> void:
	var qr_code: QrCode = QrCode.new()
	qr_code.error_correct_level = QrCode.ERROR_CORRECT_LEVEL.LOW
	var qr = qr_code.get_texture(link)
	var _qr_tex = ImageTexture.new()
	_qr_tex.create_from_image(qr.get_data(), ImageTexture.FLAG_CONVERT_TO_LINEAR)
	texture = _qr_tex
func _gui_input(event: InputEvent) -> void:
	if Global.is_left_click(event):
		OS.shell_open(link)
