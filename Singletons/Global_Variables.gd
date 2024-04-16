extends Node

@onready var flower_number:int
@onready var Seed_number:int
@onready var number_levels_passed:int = 0
@onready var can_climb:bool = false
@onready var Feather:bool
@onready var Mushroom:bool
@onready var Rainbow_Shell:bool
var level_just_finished : bool
var can_fly:bool

func modulate_object(node,value:bool,time:float):
	if value == true:
		var tween = create_tween()
		tween.tween_property(node,"modulate",Color(0,0,0,0),time)
	elif value == false:
		var tween = create_tween()
		tween.tween_property(node,"modulate",Color(1,1,1,1),time)

func level_finished():
	level_just_finished = true
