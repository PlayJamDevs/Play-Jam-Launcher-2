extends RichTextLabel

var url = ""
var just_pressed := false

func _ready() -> void:
	connect("meta_clicked", self, "_pressed")

func _pressed(what:String):
	Global.open_url(url)
