extends CharacterBody2D
class_name Player

const SPEED = 300.0
var last_direction: Vector2 = Vector2.UP #for idle animation

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D #script has been turned into a variable

var is_dialogue_active: bool = true #for blocking player movement in dialog_ui script

func _physics_process(_delta: float) -> void: #main function
	if is_dialogue_active:
		return
	process_movement()
	process_animation()
	move_and_slide()

func process_movement() -> void:
	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_vector("left","right","up","down") #be able to move in all directions, even diagonally 
	
	if direction != Vector2.ZERO:
		velocity = direction * SPEED
		last_direction = direction
	else:
		velocity = Vector2.ZERO
	
	
func process_animation() -> void:
	if velocity != Vector2.ZERO:
		play_animation("walk", last_direction)
	else:
		play_animation("idle", last_direction)
		
func play_animation(prefix: String, dir: Vector2) -> void:
	if dir.x != 0: #face left or right
		animated_sprite_2d.flip_h = dir.x < 0  #make it face left
		animated_sprite_2d.play(prefix + "_right")
	elif dir.y < 0:
		animated_sprite_2d.play(prefix + "_up")
	elif dir.y > 0:
		animated_sprite_2d.play(prefix + "_down")
		
func _ready() -> void:
	add_to_group("player")
	
