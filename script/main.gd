extends Node2D

@onready var qte_smash_key = $QTECanvasLayer/QTE_smash_key
@onready var light: CanvasLayer = $light

func _ready() -> void:
	QuestManager.qte_state_changed.connect(_on_qte_state_changed) #-----copilot suggestion
	if QuestManager.qte_state == 1:
		_start_qte()
		
func _on_qte_state_changed(new_state: int) -> void: #-----copilot suggestion
	if new_state == 1:
		_start_qte() #line 14 here

func _start_qte() -> void: #-----copilot suggestion
	qte_smash_key.start_qte() #check qtesk script

#func light():
	#light.hide()
