extends Node
class_name Quest

signal quest_state_changed(new_state: int)
var quest_state := 0
signal locker_unlocked(new_state: int)
var locker := 0
signal qte_state_changed(new_state: int)
var qte_state := 0
signal qte_success_state(new_state: int)
var qte_success := 0
signal qte_finished(result: int) #-----copilot suggestion
	
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
		quest_state = 31 #sink interaction done
		quest_state_changed.emit(quest_state)

func neighbor_branch_ready(): #check line 94 in dialogue file
	if quest_state == 3:
		quest_state = 32
		quest_state_changed.emit(quest_state)

func news_int(): 
	if quest_state == 31 or quest_state == 32: #only if you've done the sink interaction from option 1 line 54 or chosen option 2 line 930
		quest_state = 4 #if you interact with the tv before that, dialogue will not pop up, see dialog ui line 56
		quest_state_changed.emit(quest_state)
		
func keypad():
	locker = 1
	locker_unlocked.emit(locker)
	
func qte_activation():
	qte_success = 0
	qte_state = 1
	qte_state_changed.emit(qte_state)

	var result: int = await qte_finished #-----copilot suggestion
	qte_success = result #-----copilot suggestion
	qte_state = 0 #-----copilot suggestion
	qte_state_changed.emit(qte_state) #-----copilot suggestion
	return result #-----copilot suggestion

func qte_done():
	qte_success = 1
	qte_success_state.emit(qte_success)
	qte_finished.emit(qte_success) #-----copilot suggestion

func qte_failed(): #-----copilot suggestion
	qte_success = 0
	qte_success_state.emit(qte_success)
	qte_finished.emit(qte_success) 
