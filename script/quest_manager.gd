extends Node
class_name Quest

signal quest_state_changed(new_state: int)
var quest_state := 0
	
func plant_interaction() -> void: #check plant script line 19
	quest_state = 1
	quest_state_changed.emit(quest_state)
	
func hmw_interaction() -> void: #check hmw script line line 19
	if quest_state == 1: #only if quest_state is 1, meaning if plant has already been interacted with first,
		quest_state = 2 #will quest_state change to 2 for the dialogue to continue; check dialogUI line 50
		quest_state_changed.emit(quest_state)

func neighbor_int1():
	if quest_state == 2:
		quest_state = 3
		quest_state_changed.emit(quest_state)
		
func neighbor_int2(): 
	if quest_state == 3:
		quest_state = 3-1 #sink interaction done
		quest_state_changed.emit(quest_state)

func neighbor_branch_ready(): #check line 91 in dialogue file
	if quest_state == 3:
		quest_state = 3-2

func news_int(): 
	if quest_state == 3-1 or quest_state == 3-2: #only if you've done the sink interaction from option 1 line 54 or chosen option 2 line 90
		quest_state = 4
		quest_state_changed.emit(quest_state)
