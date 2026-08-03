extends Node
class_name Quest

var quest_state := 0

func _ready() -> void: 
	pass 

func _process(_delta):
	pass
	
func plant_interaction() -> void:
	quest_state = 1
