extends Reference
class_name GameData
var path_to_directory := ""
var executable_name := ""
var title := ""
var year := ""
var author := ""
var link := ""
var description := ""


func get_cover_path():
	return path_to_directory.plus_file("Cover.png")
func get_executable_path():
	return path_to_directory.plus_file(executable_name)
