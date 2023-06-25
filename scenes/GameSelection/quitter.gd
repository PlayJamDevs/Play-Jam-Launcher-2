extends Node

onready var quit_timer: Timer = $"%quit_timer"
var running_program

func _quit_focused_window():
	if running_program == -1:
		return
	OS.kill(running_program)
	running_program = -1
	pass
func _on_running_program(pid):
	running_program = pid

func _process(delta: float) -> void:
	if (
		!OS.is_window_focused() and 
		Input.is_action_pressed("quitA") and 
		Input.is_action_pressed("quitB")
	):
		if quit_timer.is_stopped():
			quit_timer.start()
	else:
		quit_timer.stop()

func _ready() -> void:
	quit_timer.connect("timeout", self, "_quit_focused_window")
	owner.connect("running_program",self,"_on_running_program")
