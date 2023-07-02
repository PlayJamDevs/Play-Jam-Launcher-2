extends Node

func _process(delta: float) -> void:
	Music.stream_paused = owner.has_program_running()
