extends Node
class_name InputMethod

enum {
	JOYSTICK = 1,
	MOUSE,
	KEYBOARD,
	MOUSE_KEYBOARD,
	SIZE
}

static func as_int(input_method:String):
	var parsed_int = int(input_method)
	if parsed_int > 0 and parsed_int < InputMethod.SIZE:
		return parsed_int
	
	if input_method.findn("JOYSTICK") != -1:
		return InputMethod.JOYSTICK
	
	var has_mouse = input_method.findn("MOUSE") != -1
	var has_keyboard = input_method.findn("KEYBOARD") != -1 or input_method.findn("TECLADO") != -1
	
	if has_mouse and has_keyboard:
		return InputMethod.MOUSE_KEYBOARD
	if has_mouse:
		return InputMethod.MOUSE
	if has_keyboard:
		return InputMethod.KEYBOARD

	return InputMethod.MOUSE_KEYBOARD
