extends Area2D

@onready var interactable_label: Label = $InteractableLabel
@onready var interactable_component: Interactable_Component = $InteractableComponent
@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var panel: Panel = $CanvasLayer/Panel
@onready var label: Label = $CanvasLayer/Label
@onready var close_label: Label = $CanvasLayer/CloseLabel

func _ready() -> void:
	interactable_label.hide() #when scene loads, hide label
	canvas_layer.hide()
	interactable_component.interactable_activated.connect(on_interactable_activated)
	interactable_component.interactable_deactivated.connect(on_interactable_deactivated)
	
func on_interactable_activated() -> void:
	interactable_label.show()
	
func on_interactable_deactivated() -> void:
	interactable_label.hide()
	
func _process(_delta):
	if interactable_label.visible and Input.is_action_just_pressed("interact"):
		canvas_layer.show()
		
	if Input.is_action_just_pressed("close"):
		canvas_layer.hide()
		

	
	
