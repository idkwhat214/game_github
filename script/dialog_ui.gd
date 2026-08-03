extends Control

@onready var example_balloon: DialogueManagerExampleBalloon = $ExampleBalloon
@onready var balloon: Control = $ExampleBalloon/Balloon
@onready var responses_menu: DialogueResponsesMenu = $ExampleBalloon/Balloon/ResponsesMenu

var player: CharacterBody2D

func _ready() -> void: #the function Godot uses when node enters scene tree, initialization
	balloon.visible = false #start scene balloon hidden; makes dialogue box only appear when dialogue begins
	
	player = get_tree().get_first_node_in_group("player")
	if not is_instance_valid(player):
		player = get_tree().current_scene.find_child("player", true, false)
	
	var dm = Engine.get_singleton("DialogueManager") #in project settings (autoload), DialogueManager is present
	if dm: #checks whether dm exists
		dm.dialogue_started.connect(Callable(self, "_on_dialogue_started")) #connects the signal dialogue_started from dm to a function
		dm.dialogue_ended.connect(Callable(self, "_on_dialogue_ended"))
		responses_menu.response_selected.connect(Callable(self, "_on_response_selected"))
	
	var res = load("res://dialogue/main.dialogue") #load the file with the dialogue
	if res:
		dm.show_dialogue_balloon(res)
	
func _on_response_selected(response: DialogueResponse) -> void: 
	pass #placeholder, does nothing for now
	
func _on_dialogue_started(resource: DialogueResource) -> void:
	if is_instance_valid(player):
		player.is_dialogue_active = true
	
func _on_dialogue_ended(resource: DialogueResource) -> void:
	if is_instance_valid(player):
		player.is_dialogue_active = false
		
		
