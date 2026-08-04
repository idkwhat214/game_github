extends Node
class_name Quest

signal quest_state_changed(new_state: int)
var quest_state := 0

func _ready() -> void: 
	pass 

func _process(_delta):
	pass
	
func plant_interaction() -> void: #check plant script line 19
	quest_state = 1
	quest_state_changed.emit(quest_state)
	
func hmw_interaction() -> void: #check hmw script line line 19
	if quest_state == 1: #only if quest_state is 1, meaning if plant has already been interacted with first,
		quest_state = 2 #will quest_state change to 2 for the dialogue to continue; check dialogUI line 50
		quest_state_changed.emit(quest_state)
