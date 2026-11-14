extends Control

@onready var color_rect: ColorRect = $ColorRect
@onready var key_label: Label = $ColorRect/pressbutton
@onready var timer: Timer = $Timer
@onready var time_label: Label = $time_label
@onready var success_label: Label = $success_label
var required_presses: int = 10
var current_presses: int = 0

signal finished (success: bool)

func _ready() -> void:
	get_tree().paused = true #
	success_label.hide()

func _process(delta: float) -> void:
	var remaining_time = snapped(timer.time_left, 0.01) #from the time_left, 0.01 keeps getting subtracted 
	time_label.text = str(remaining_time)

#func _input(event: InputEvent) -> void:
	#if Input.is_action_just_pressed("interact"):

func _on_timer_timeout() -> void:
	var success = timer.time_left #if there's time left, congrats
	_update_success_level(success) #success text will appear
	get_tree().paused = false # 
	finished.emit(success)
	timer.stop()
	
func _update_success_level(success: bool) -> void:
	success_label.show()
	if success:
		success_label.text = "SUCCESS"
	else:
		success_label.text = "FAIL"
