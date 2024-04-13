extends State

@export var max_speed = 90
@export var acceleration = 100
@export var friction = 150
var old_blend

func move():
	var max_speed_vector:Vector2
	max_speed_vector.x = max_speed*input_vector.x
	max_speed_vector.y = 0
	player_body.velocity = player_body.velocity.move_toward(max_speed_vector,acceleration)
	player_body.move_and_slide()
	
func physics_do():
	super()
	move()
	
func do():
	super()
	set_tree_blend_position()

func set_tree_blend_position():
		animator_tree.set("parameters/blend_position",input_vector.x)
