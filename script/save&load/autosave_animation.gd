extends AnimatedSprite2D

func _ready() -> void:
	play() #once it appears ine scene tree, animation is played
	
func _on_animation_finished() -> void:
	queue_free() #once it's finished, it deletes itself
