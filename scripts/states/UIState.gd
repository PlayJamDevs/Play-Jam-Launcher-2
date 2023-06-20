class_name UIState extends Control

export(Globals.UIState) var state := Globals.UIState.INTRO

onready var n_AnimTree : AnimationTree = get_tree().get_nodes_in_group("AnimTree")[0]

func enter_state() -> void:
	set_process_unhandled_input(true)

func exit_state() -> void:
	set_process_unhandled_input(false)

func _ready() -> void:
	exit_state()
