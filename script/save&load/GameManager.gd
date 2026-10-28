extends Node

const SAVE_LOCATION = "user://saved_game.json"

@export var autosave_scene : PackedScene #never mind, not used
var game_data: Dictionary

func update_data(): 
	var player = get_tree().get_first_node_in_group("player")
	if not player:
		push_error("not saved: player not found")
		return false
		
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

func save() -> bool:
	if  not update_data():
		return false
		
	var file = FileAccess.open(SAVE_LOCATION, FileAccess.WRITE)
	if not file:
		push_error("save failed: could not open save file")
		return false
		
	file.store_string(JSON.stringify(game_data)) #store dictionary as JSON
	file.close() #finished, so file is closed
	return true
	
func load() -> bool:
	if not FileAccess.file_exists(SAVE_LOCATION):
		print("load failed: save file doesn't exist")
		return false
		
	var file = FileAccess.open(SAVE_LOCATION, FileAccess.READ)
	if not file:
		push_error("load failed: could not open save file.")
		return false
		
	var parsed_data = JSON.parse_string(file.get_as_text())
	file.close()
	
	if not parsed_data is Dictionary:
		push_error("load failed: save data is invalid.")
		return false
		
	game_data = parsed_data
	
	var player = get_tree().get_first_node_in_group("player")
	if player and game_data.has("player_position"):
		var position: Dictionary = game_data["player_position"]
		player.global_position = Vector2(position.get("x", player.global_position.x),position.get("y", player.global_position.y))

	if game_data.has("quest_state"):
		QuestManager.quest_state = int(game_data["quest_state"])

	var saved_game_state: Dictionary = game_data.get("game_state", {})
	GameState.math_skill = int(saved_game_state.get("math_skill", GameState.math_skill))
	GameState.silence = int(saved_game_state.get("silence", GameState.silence))
	GameState.useless_phone = int(saved_game_state.get("useless_phone", GameState.useless_phone))
	GameState.pacifist = int(saved_game_state.get("pacifist", GameState.pacifist))

	return true
		
		
	
		
		
