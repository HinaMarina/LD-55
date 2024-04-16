extends Node2D

@export var seed_tip:TextureRect
@export var canvas : CanvasLayer
@export var animated_sprite : AnimatedSprite2D
@onready var area2d : Area2D = $Area2D
var inside_area:bool
var climb_here:bool
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if inside_area && !GlobalVariables.can_climb:
		if Input.is_action_just_pressed("Placing_seeds") && GlobalVariables.Seed_number>=3:
			var tween = create_tween()
			tween.tween_property(seed_tip,"modulate",Color(1,1,1,0),0.3)
			GlobalVariables.Seed_number -= 3
			animated_sprite.play("default")
			climb_here = true
			_on_area_2d_body_entered(CharacterBody2D)
func _on_area_2d_body_entered(body):
	if climb_here:
		GlobalVariables.can_climb = true
	else:
		if body is CharacterBody2D:
			var tween = create_tween()
			tween.tween_property(seed_tip,"modulate",Color(1,1,1,1),0.3)
			inside_area = true
		if climb_here:
			GlobalVariables.can_climb = true

func _on_area_2d_body_exited(body):
	if climb_here:
		GlobalVariables.can_climb = false
	else:
		if body is CharacterBody2D:
			var tween = create_tween()
			tween.tween_property(seed_tip,"modulate",Color(1,1,1,0),0.3)
			inside_area = false
