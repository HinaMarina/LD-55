extends State

@export var max_speed = 130
@export var acceleration = 200
@export var friction = 150
var old_blend

func move():
	var max_speed_vector:Vector2
	max_speed_vector.x = max_speed*input_vector.x
	max_speed_vector.y = 0
	player_body.velocity = player_body.velocity.move_toward(max_speed_vector*2,acceleration)
	player_body.move_and_slide()
	
func physics_do():
	super()
	move()
	
func do():
	super()
	set_tree_blend_position()

func set_tree_blend_position():
		animator_tree.set("parameters/blend_position",input_vector.x)

func step_sound_play():
	audio_player.pitch_scale = 1.0 + randf_range(-0.1, 0.1)
	audio_player.play()
	pass
	
