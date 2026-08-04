extends Node

var math_skill := 0

func _ready() -> void:
	pass

func teleport_player(target_position: Vector2) -> void:
	var player = get_tree().get_first_node_in_group("player") #get player
	
	if player: #if player exists
		player.global_position = target_position #change position, target position can be defined in dialogue file

func _process(_delta: float) -> void:
	pass
