extends Area2D

@onready var interactable_label: Label = $InteractableLabel
@onready var interactable_component: Interactable_Component = $InteractableComponent
@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var panel: Panel = $CanvasLayer/Panel
@onready var page_1: Label = $CanvasLayer/Page1
@onready var page_2: Label = $CanvasLayer/Page2
@onready var continue_label: Label = $CanvasLayer/ContinueLabel
@onready var close_label: Label = $CanvasLayer/CloseLabel

func _ready() -> void:
	interactable_label.hide() #when scene loads, hide label
	canvas_layer.hide() #and canvas
	interactable_component.interactable_activated.connect(on_interactable_activated)
	interactable_component.interactable_deactivated.connect(on_interactable_deactivated)
	
func on_interactable_activated() -> void:
	interactable_label.show()
	
func on_interactable_deactivated() -> void:
	interactable_label.hide()
	
func _process(_delta):
	if interactable_label.visible and Input.is_action_just_pressed("interact"):
		reset()
		
	if interactable_label.visible and Input.is_action_just_pressed("continue"): #show 2nd page
		canvas_layer.show()
		continue_label.hide()
		page_1.hide()
		page_2.show()
		
	if Input.is_action_just_pressed("close"):
		canvas_layer.hide()

func reset() -> void: #reset function, so that diary can be read again and again
	canvas_layer.show() #everything will be shown except for page 2
	continue_label.show()
	page_1.show()
	page_2.hide()
