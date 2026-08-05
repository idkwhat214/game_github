extends CharacterBody2D

@onready var interactable_component: Interactable_Component = $InteractableComponent
@onready var interactable_label: Label = $InteractableComponent/InteractableLabel
@onready var collision_shape_2d: CollisionShape2D = $InteractableComponent/CollisionShape2D

func _ready() -> void:
	add_to_group("npcs")
	interactable_label.hide() #when scene loads, hide label
	interactable_component.interactable_activated.connect(on_interactable_activated)
	interactable_component.interactable_deactivated.connect(on_interactable_deactivated)

func on_interactable_activated() -> void:
	interactable_label.show()
	
func on_interactable_deactivated() -> void:
	interactable_label.hide()
	
func _process(_delta):
	if interactable_label.visible and Input.is_action_just_pressed("interact"): #if E is pressed in the interactable area
		QuestManager.neighbor_int1()
	


	
