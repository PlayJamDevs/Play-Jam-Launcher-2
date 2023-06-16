extends UIState

onready var n_PanelC := $HBoxContainer
onready var n_Panel1 := $HBoxContainer/Panel1
onready var n_Panel2 := $HBoxContainer/Panel2
onready var n_Panel3 := $HBoxContainer/Panel3
onready var n_LabelDescription := get_node("%LabelDescription")

onready var PanelDescription := [
	"Seleccion de juegos proximos a estrenarse. ¡Jugalos antes que nadie!",
	"Seleccion de juegos creados y publicados por desarrolladores independientes. Descubre titulos unicos y emocionantes! ",
	"Coleccion de juegos creados para game jams. Ideas innovadoras, mecanicas unicas, estos juegos son un diamante en bruto. Se el primero en descubrir los exitos del futuro!"
]

var selected_idx := 0

func _unhandled_input(event : InputEvent):
	
	selected_idx = wrapi(selected_idx + (event.get_action_strength("ui_right") - event.get_action_strength("ui_left")), 0, 3)
	
	for p in n_PanelC.get_children():
		if n_PanelC.get_child(selected_idx) == p:
			p.modulate = Color.cyan
		else:
			p.modulate = Color.white
	
	n_LabelDescription.text = PanelDescription[selected_idx]
