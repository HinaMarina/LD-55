class_name State extends Node2D

############# State Assets #####################
@export var player_body:CharacterBody2D
@onready var sprite:Sprite2D
@onready var animator:AnimationPlayer
@onready var animator_tree:AnimationTree

############## State Data ######################
@onready var input_vector:Vector2
@onready var time:float
var is_complete:bool
var is_on_floor:bool
var can_move:bool

func _ready():
	for child in get_children():
		if child is Sprite2D:
			sprite = child
		elif child is AnimationPlayer:
			animator = child
		elif child is AnimationTree:
			animator_tree = child
			

func do():
	pass
	
func physics_do():
	pass
	
func enter():
	time = Time.get_ticks_msec()
	is_complete = false
	
func exit():
	pass
	
func complete():
	is_complete = true
	
func elapsed_time():
	return (Time.get_ticks_msec() - time)/1000
	
func change_movement():
	can_move = !can_move
