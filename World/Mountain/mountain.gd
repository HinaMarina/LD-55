extends Node2D

@export var limit_left:Node2D
@export var limit_right:Node2D
@export var limit_top:Node2D
@onready var player:Player
# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalVariables.can_fly = true
	for child in get_children():
		if child is Player:
			player = child
	player.camera.limit_left = limit_left.global_position.x
	player.camera.limit_right = limit_right.global_position.x
	player.camera.limit_top = limit_top.global_position.y
	player.visible = false
	PauseTree.can_move = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_animated_sprite_2d_animation_finished():
	player.visible = true
	PauseTree.can_move = true
