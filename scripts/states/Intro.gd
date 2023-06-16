extends UIState

onready var n_Anim := $AnimIntro

func enter_state() -> void:
	.enter_state()

func exit_state() -> void:
	.exit_state()

func _unhandled_input(event : InputEvent):
	
	if event.is_action_released("ui_accept"):
		n_AnimTree["parameters/Intro/conditions/exit"] = true
