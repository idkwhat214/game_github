extends Control

@onready var color_rect: ColorRect = $ColorRect
@onready var timer: Timer = $Timer
@onready var time_label: Label = $time_label
@onready var success_label: Label = $success_label

@export var duration: float = 5.0 #time limit in seconds
var required_presses: int = 10
var current_presses: int = 0
var active: bool = false #-----copilot suggestion

func _ready() -> void:
	success_label.hide()
	process_mode = Node.PROCESS_MODE_ALWAYS #-----copilot suggestion
	timer.process_mode = Node.PROCESS_MODE_ALWAYS #-----copilot suggestion
	hide()
	
func start_qte() -> void:
	show()
	timer.wait_time = duration #.wait_time means in how many seconds the timer will stop
	timer.one_shot = true #.one_shot means that the timer will stop after reaching the end instead of restarting
	current_presses = 0
	timer.start()
	get_tree().paused = true #pause the game until player finishes this qte
	active = true #-----copilot suggestion
	time_label.text = "%.2f" % duration #-----copilot suggestion
	
func _input(_event: InputEvent) -> void:
	if active and Input.is_action_just_pressed("interact"): 
		current_presses += 1
		if timer.time_left > 0.0 and current_presses >= required_presses:
			_success()
			
func _update_time_label() -> void:
	var remaining_time = snapped(timer.time_left, 0.01) #round the time_left to two decimals 3.1415 -> 3.14
	time_label.text = "%.2f" % remaining_time #show the remaining time

func _process(_delta: float) -> void:
	if active: #-----copilot suggestion
		_update_time_label()

func _on_timer_timeout() -> void:
	if active and current_presses < required_presses:
		_fail()

func _success() -> void:
	active = false #-----copilot suggestion
	timer.stop()
	success_label.show()
	success_label.text = "SUCCESS"
	await get_tree().create_timer(2.5).timeout #wait 2.5 seconds
	get_tree().paused = false #continue game
	QuestManager.qte_done()
	hide()
	
func _fail() -> void:
	active = false #-----copilot suggestion
	success_label.show()
	success_label.text = "FAIL"
	await get_tree().create_timer(2.5).timeout 
	get_tree().paused = false 
	hide()
