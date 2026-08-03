extends Control

@onready var example_balloon: DialogueManagerExampleBalloon = $ExampleBalloon
@onready var balloon: Control = $ExampleBalloon/Balloon
@onready var responses_menu: DialogueResponsesMenu = $ExampleBalloon/Balloon/ResponsesMenu

var player: CharacterBody2D

func _ready() -> void: #the function Godot uses when node enters scene tree, initialization
	balloon.visible = false #start scene with balloon hidden; makes dialogue box only appear when dialogue begins
	
	#get the player
	player = get_tree().get_first_node_in_group("player") #look for node named player
	if not is_instance_valid(player): #check whether player was found successfully
		player = get_tree().current_scene.find_child("player", true, false)
	
	var dm = Engine.get_singleton("DialogueManager") #in project settings (autoload), DialogueManager is present
	if dm: #checks whether dm exists
		dm.dialogue_started.connect(Callable(self, "_on_dialogue_started")) #connects the signal dialogue_started from dm script to a function
		dm.dialogue_ended.connect(Callable(self, "_on_dialogue_ended"))
		responses_menu.response_selected.connect(Callable(self, "_on_response_selected"))
	
	var res = load("res://dialogue/main.dialogue") #load the file with the dialogue
	if res:
		dm.show_dialogue_balloon(res) #show balloon with dialogue
	
func _on_response_selected(response: DialogueResponse) -> void: #when a response is selected
	pass #placeholder, does nothing for now
	
func _on_dialogue_started(resource: DialogueResource) -> void:
	if is_instance_valid(player): #checks whether player reference is still valid
		player.is_dialogue_active = true #dialogue is running, block player movement
	
func _on_dialogue_ended(resource: DialogueResource) -> void:
	if is_instance_valid(player): 
		player.is_dialogue_active = false
		
		
