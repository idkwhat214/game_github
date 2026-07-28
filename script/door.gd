extends StaticBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var interactable_component: Interactable_Component = $InteractableComponent #see script for this varriablee

func _ready() -> void:
	interactable_component.interactable_activated.connect(on_interactable_activated)
	interactable_component.interactable_deactivated.connect(on_interactable_deactivated)
	collision_layer = 1 
	
func on_interactable_activated() -> void: #interact with door, open it
	animated_sprite_2d.play("open_door")
	collision_layer = 2 #same layer as player for player to walk through/interact
	
func on_interactable_deactivated() -> void: #interaction "deactivated", if you step awayy
	animated_sprite_2d.play("close_door")
	collision_layer = 1 #back to 1, this was a temporarily change of collision_layer
	
