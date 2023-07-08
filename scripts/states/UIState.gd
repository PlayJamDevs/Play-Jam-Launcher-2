class_name UIState extends Control

export(Globals.UIState) var state := Globals.UIState.INTRO

onready var n_AnimTree : AnimationTree = get_tree().get_nodes_in_group("AnimTree")[0] if get_tree().has_group("AnimTree") else null

func enter_state() -> void:
	set_process_unhandled_input(true)
	set_process_input(true)
	_enter_state()

func exit_state() -> void:
	set_process_unhandled_input(false)
	set_process_input(false)
	_exit_state()

func _ready() -> void:
	exit_state()

#override these
func _enter_state() -> void:
	pass

func _exit_state() -> void:
	pass
