extends Area2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var interactable_label: Label = $InteractableLabel
@onready var interactable_component: Interactable_Component = $InteractableComponent


func _ready() -> void:
	interactable_label.hide() #when scene loads, hide label
	interactable_component.interactable_activated.connect(on_interactable_activated)
	interactable_component.interactable_deactivated.connect(on_interactable_deactivated)
	
func on_interactable_activated() -> void:
	interactable_label.show()  #when the collision shape from interactable component is entered,the label becomes visible

func _process(_delta):
	if interactable_label.visible and Input.is_action_just_pressed("interact"): #if E is pressed in the interactable area
		animated_sprite_2d.play("water") #this animation plays
	
func on_interactable_deactivated() -> void:
	interactable_label.hide()
	animated_sprite_2d.play("default")
