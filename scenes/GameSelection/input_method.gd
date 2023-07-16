extends Node
class_name InputMethod

static func get_texture(input_method: String):
	return _texture[_resolve(input_method)]

static func get_text(input_method: String):
	return "Se juega con " + _text[_resolve(input_method)]

enum {
	JOYSTICK = 1,
	MOUSE,
	KEYBOARD,
	MOUSE_KEYBOARD,
	SIZE
}

const _texture = {
		JOYSTICK: preload("res://assets/textures/input_method/joystick.png"),
		MOUSE: preload("res://assets/textures/input_method/mouse.png"),
		KEYBOARD: preload("res://assets/textures/input_method/keyboard.png"),
		MOUSE_KEYBOARD: preload("res://assets/textures/input_method/mouse_keyboard.png"),
}

const _text = {
		JOYSTICK: "Joystick",
		MOUSE: "Mouse",
		KEYBOARD: "Teclado",
		MOUSE_KEYBOARD: "Mouse y Teclado",
}

static func _resolve(input_method:String):
	var parsed_int = int(input_method)
	if parsed_int > 0 and parsed_int < SIZE:
		return parsed_int

	if input_method.findn("JOYSTICK") != -1:
		return JOYSTICK

	var has_mouse = input_method.findn("MOUSE") != -1
	var has_keyboard = input_method.findn("KEYBOARD") != -1 or input_method.findn("TECLADO") != -1

	if has_mouse and has_keyboard:
		return MOUSE_KEYBOARD
	if has_mouse:
		return MOUSE
	if has_keyboard:
		return KEYBOARD

	return JOYSTICK
