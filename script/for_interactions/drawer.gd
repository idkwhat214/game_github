extends Area2D

@onready var interactable_label: Label = $InteractableLabel
@onready var interactable_component: Interactable_Component = $InteractableComponent
@onready var collision_shape_2d: CollisionShape2D = $InteractableComponent/CollisionShape2D


func _ready() -> void:
	interactable_label.hide() #when scene loads, hide label
	interactable_component.interactable_activated.connect(on_interactable_activated)
	interactable_component.interactable_deactivated.connect(on_interactable_deactivated)
	
func on_interactable_activated() -> void:
	interactable_label.show()
	
func on_interactable_deactivated() -> void:
	interactable_label.hide()
