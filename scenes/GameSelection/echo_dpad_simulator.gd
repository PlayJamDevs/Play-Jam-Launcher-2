extends Node
onready var echo_startup_timer: Timer = $echo_startup_timer
onready var echo_repeat_timer: Timer = $echo_repeat_timer
signal echo(v_dir)
var v_dir := 0.0
var echo: = false

func _process(delta: float) -> void:
	var new_v_dir = get_v_dir()
	if v_dir and new_v_dir == v_dir:
		if echo_startup_timer.is_stopped():
			echo_startup_timer.start()
	else:
		echo_startup_timer.stop()
		echo = false
	v_dir = new_v_dir
	
	if echo and echo_repeat_timer.is_stopped():
		var e = InputEventAction.new()
		if v_dir > 0.0:
			e.action = "ui_down"
		elif v_dir < 0.0:
			e.action = "ui_up"
		e.pressed = true
		e.strength = 1.0
		owner._unhandled_input(e)
		echo_repeat_timer.start()

func _ready() -> void:
	echo_startup_timer.connect("timeout", self, "_on_timeout")

func _on_timeout():
	echo = true


func get_v_dir():
	var buffer = Input.get_axis("ui_up","ui_down")
	if abs(buffer)>0.5:
		return sign(buffer)
	return 0.0
