extends Node

onready var quit_timer: Timer = $"%quit_timer"

func _quit_focused_window():
	if owner.running_program_pid == owner.NO_PROGRAM:
		return
	if OS.is_process_running(owner.running_program_pid):
		OS.kill(owner.running_program_pid)

	owner.running_program_pid = owner.NO_PROGRAM
	pass

func _process(delta: float) -> void:
	if Input.is_action_pressed("quitA") and Input.is_action_pressed("quitB"):
		if quit_timer.is_stopped():
			quit_timer.start()
	else:
		quit_timer.stop()

func _ready() -> void:
	quit_timer.connect("timeout", self, "_quit_focused_window")
