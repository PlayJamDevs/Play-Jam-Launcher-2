extends UIState

func enter_state() -> void:
	.enter_state()

func exit_state() -> void:
	.exit_state()

func _unhandled_input(event : InputEvent):
	
	if (
		event is InputEventKey or
		event is InputEventJoypadButton or Global.is_click(event)
	) and event.pressed:
		exit()
func _gui_input(event: InputEvent) -> void:
	if Global.is_click(event):
		exit()

func exit():
	n_AnimTree["parameters/Intro/conditions/exit"] = true
