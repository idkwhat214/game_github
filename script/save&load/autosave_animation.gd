extends AnimatedSprite2D

func _ready() -> void:
	pass
	

func _on_animation_finished() -> void:
	queue_free()
