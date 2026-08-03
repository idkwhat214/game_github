class_name Interactable_Component 
extends Area2D #script is attached to an Area 2D node

signal interactable_activated
signal interactable_deactivated

func _on_body_entered(_body: Node2D) -> void: #when something enters the area
	interactable_activated.emit() #this signal is sended out

func _on_body_exited(_body: Node2D) -> void: 
	interactable_deactivated.emit()
