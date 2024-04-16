class_name Player extends Node2D

@export var player_body:CharacterBody2D
@export var state_machine: State_Machine
@export var camera : Camera2D
@export var canvas_layer : CanvasLayer
@export var bag_icon: TextureRect
@export var inventory_panel : TextureRect
@export var inventory_bg: ColorRect
@export var seed_number_label:Label
@export var flower_number_label:Label
@export var level_finished_panel:TextureRect

var menu_opened : bool = false

func _ready():
	inventory_panel.modulate.a = 0
	inventory_bg.visible = false
	level_finished_panel.modulate.a = 0
func _physics_process(delta):
	if Input.is_action_just_pressed("Menu"):
		open_inventory()
	if GlobalVariables.level_just_finished == true:
		finishing_level()
	seed_number_label.text = str(GlobalVariables.Seed_number)
	flower_number_label.text = str(GlobalVariables.flower_number)

func open_inventory():
	if !menu_opened:
		var tween = create_tween()
		tween.tween_property(inventory_panel,"modulate",Color(1,1,1,1),0.3)
		menu_opened = true
		inventory_bg.visible = true
		PauseTree.pause()
	elif menu_opened:
		var tween = create_tween()
		tween.tween_property(inventory_panel,"modulate",Color(1,1,1,0),0.3)
		menu_opened = false
		inventory_bg.visible = false
		PauseTree.pause()
		
func finishing_level():
	player_body.velocity = Vector2.ZERO
	player_body.move_and_slide()
	state_machine.set_state(state_machine.idle_state)
	state_machine.update_sprites_visibility()
	GlobalVariables.modulate_object(level_finished_panel,false,0.3)
	GlobalVariables.level_just_finished = false
	
