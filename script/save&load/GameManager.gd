extends Node

const SAVE_LOCATION = "user://saved_game.json"

@export var autosave_scene : PackedScene
var game_data: Dictionary

func update_data(): 
	var player = get_tree().get_first_node_in_group("player")
	if not player:
		push_error("not saved: player not found")
		return
		
	game_data = {
	"player_position" : {
		"x": player.global_position.x,
		"y": player.global_position.y
	},
	"quest_state": QuestManager.quest_state,
	"game_state": {
		"math_skill": GameState.math_skill,
		"silence": GameState.silence,
		"useless_phone": GameState.useless_phone,
		"pacifist": GameState.pacifist
	}
}

func save():
	update_data()
	var file = FileAccess.open(SAVE_LOCATION, FileAccess.WRITE)
	file.store_string(JSON.stringify(game_data)) #store dictionary as JSON
	file.close() #finished, so file is closed
	
func load() -> bool:
	if FileAccess.file_exists(SAVE_LOCATION):
		var file = FileAccess.open(SAVE_LOCATION, FileAccess.READ)
		game_data = JSON.parse_string(file.get_as_text())
		file.close()
		return true
	else:
		print("load failed.")
		return false
		
		
	
		
		
