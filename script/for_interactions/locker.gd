extends Area2D

@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var keypad_ui: Control = $CanvasLayer/keypad/VBoxContainer
@onready var interactable_label: Label = $InteractableLabel
@onready var interactable_component: Interactable_Component = $InteractableComponent


func _ready():
	keypad_ui.hide()
	interactable_label.hide()
	interactable_component.interactable_activated.connect(on_interactable_activated)
	interactable_component.interactable_deactivated.connect(on_interactable_deactivated)
	
func on_interactable_activated() -> void:
	interactable_label.show()
	
func _process(_delta):
	if interactable_label.visible and Input.is_action_just_pressed("interact"): #if E is pressed in the interactable area
		keypad_ui.show()
	
func on_interactable_deactivated() -> void:
	interactable_label.hide() 
	keypad_ui.hide()
	 
	
	
	
