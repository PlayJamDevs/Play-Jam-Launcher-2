extends Node2D

onready var menus := {}

var config := ConfigFile.new()

func _ready():
	randomize()
	
	# Asigna el UIState al nodo correspondiente
	for m in $UI.get_children():
		menus[m.state] = m
		
	get_tree().get_nodes_in_group("AnimTree")[0].active = true
