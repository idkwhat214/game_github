extends Node

@export var autosave_scene : PackedScene

const SAVE_LOCATION = "user://saved_game.tres"

func save():
	var file = FileAccess.open (SAVE_LOCATION, FileAccess.WRITE)
	var update_data = {
			"position" : GameState.position
		}
	
	var json_ver = JSON.stringify(update_data)
	file.store_string(json_ver)
	file.close()
		
func load():
	if FileAccess.file_exists(SAVE_LOCATION):
		var file = FileAccess.open (SAVE_LOCATION, FileAccess.READ)
		var data = JSON.parse_string(file.get_as_text())
		file.close()

func autosave():
	var autosaveobject : AnimatedSprite2D = autosave_scene.instantiate()
	autosaveobject.global_position = Vector2(900, 500)
	add_child(autosaveobject)
	save()
	
	
	
