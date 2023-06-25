extends Node

const NO_PROGRAM = -1

onready var quit_timer: Timer = $"%quit_timer"
var running_program_pid = NO_PROGRAM

func _quit_focused_window():
	if running_program_pid == NO_PROGRAM:
		return
	if OS.is_process_running(running_program_pid):
		OS.kill(running_program_pid)
	running_program_pid = NO_PROGRAM
	pass
func _on_running_program(pid):
	running_program_pid = pid

func _process(delta: float) -> void:
	if Input.is_action_pressed("quitA") and Input.is_action_pressed("quitB"):
		if quit_timer.is_stopped():
			quit_timer.start()
	else:
		quit_timer.stop()

func _ready() -> void:
	quit_timer.connect("timeout", self, "_quit_focused_window")
	owner.connect("running_program",self,"_on_running_program")
