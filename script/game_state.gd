extends Node

var math_skill := 0
var silence := 0
var useless_phone := 0
var pacifist:= 0

func teleport_player(position: Vector2) -> void:
	var player = get_tree().get_first_node_in_group("player") #get player
	if player: #if player exists
		player.global_position = position #change position in dialogue file

func teleport_neighbor(position: Vector2) -> void:
	if not get_tree().get_first_node_in_group("npcs"): #the scene was not loaded like in the previous function
		var neighbor_scene = preload("res://scenes/characters/neighbor.tscn")
		var neighbor = neighbor_scene.instantiate()
		get_tree().root.add_child(neighbor)
		neighbor.global_position = position
	else:
		var neighbor = get_tree().get_first_node_in_group("npcs") #find the first node in the "npcs" group
		neighbor.global_position = position
		
func die():
	var player = get_tree().get_first_node_in_group("player")
	if player: 
		var animated_sprite = player.get_node("AnimatedSprite2D")
		if animated_sprite: 
			animated_sprite.play("dead")
