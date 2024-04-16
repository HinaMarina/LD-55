extends Node2D

@export var Player:Player
@onready var arrow = $Door/ArrowAnim
@onready var pointer = $Door/Pointer
@onready var zone_tip = $ZoneTip
@export var bgm_players : Array[AudioStreamPlayer2D]
@export var ingredients_label_number : TextureRect
@export var ingredientes_number : Label

var zone_tip_calls_counter : int =0
var entrou:bool
# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalVariables.modulate_object(ingredients_label_number,false,3)
	PauseTree.can_move = false
	for audio in bgm_players:
		audio.playing = true
	GlobalVariables.can_fly = false
	Player.camera.enabled = false
	zone_tip.modulate.a = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
			GlobalVariables.modulate_object(ingredients_label_number,true,0.2)
			PauseTree.can_move = true
	ingredientes_number.text = str(3 - GlobalVariables.number_levels_passed)
	ingredientes_number.modulate.a = ingredients_label_number.modulate.a
	if entrou:
		if Input.is_action_just_pressed("ui_up"):
			if arrow.frame+2 < 6:
				arrow.frame += 1
				await get_tree().create_timer(0.1).timeout
				arrow.frame += 1
			else:
				arrow.frame += 1
				await get_tree().create_timer(0.1).timeout
				arrow.frame = 0
			if arrow.frame == 0:
				pointer.frame = 0
			elif arrow.frame == 2:
				pointer.frame = 2
			elif arrow.frame == 4:
				pointer.frame = 1


func _on_area_2d_body_entered(body):
	if body is CharacterBody2D:
		entrou = true
		if zone_tip_calls_counter == 0:
			zone_tip.zone_tip(true)
			zone_tip_calls_counter += 1


func _on_area_2d_body_exited(body):
	if body is CharacterBody2D:
		entrou = false
		zone_tip.zone_tip(false)
		zone_tip_calls_counter = 0
