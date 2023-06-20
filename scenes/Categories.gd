extends UIState

onready var n_PanelC := $HBoxContainer
onready var n_Panel1 := $HBoxContainer/Panel1
onready var n_Panel2 := $HBoxContainer/Panel2
onready var n_Panel3 := $HBoxContainer/Panel3
onready var n_LabelDescription := get_node("%LabelDescription")

onready var PanelDescription := [
	"Seleccion de juegos proximos a estrenarse. ¡Jugalos antes que nadie!",
	"Seleccion de juegos creados y publicados por desarrolladores independientes. Descubre titulos unicos y emocionantes!",
	"Coleccion de juegos creados para game jams. Ideas innovadoras, mecanicas unicas, estos juegos son un diamante en bruto. Se el primero en descubrir los exitos del futuro!"
]

onready var folders := [
	"estrenos",
	"indie",
	"jams"
]

var selected_idx := 1
var selected

func _unhandled_input(event : InputEvent):
	
	if event.is_action_pressed("ui_accept"):
		open_games_folder(folders[selected_idx])
		return
	
	var direction = (event.get_action_strength("ui_right") - event.get_action_strength("ui_left"))
	if !direction:
		return
	#do-while skip invisible nodes
	while true:
		selected_idx = wrapi(selected_idx + direction, 0, 3)
		if n_PanelC.get_child(selected_idx).is_visible():
			break
	
	update_selected()

func update_selected():
	selected = n_PanelC.get_child(selected_idx)
	for p in n_PanelC.get_children():
		if selected == p:
			p.modulate = Color.cyan
		else:
			p.modulate = Color.white
	n_LabelDescription.text = PanelDescription[selected_idx]

func _ready():
	._ready()
	update_selected()

func open_games_folder(folder_name):
	goto_game_selection(folder_name)

onready var game_selection: Control = owner.get_node("%GameSelection")

func goto_game_selection(folder_name):
	game_selection.setup(folder_name)
	n_AnimTree["parameters/Categories/conditions/exit"] = true
	
func _enter_state():
	n_AnimTree["parameters/Categories/conditions/exit"] = false
