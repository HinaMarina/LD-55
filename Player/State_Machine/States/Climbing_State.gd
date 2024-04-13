extends State

@export var climbing_vel: float = 75
@export var climbing_accel : float = 50
var frame_index:int

func climb():
	if abs(Input.get_axis("ui_down","ui_up"))>0:
		input_vector.y = Input.get_axis("ui_up","ui_down")
		player_body.velocity.y = move_toward(0,climbing_vel*input_vector.y,climbing_accel)
		player_body.velocity.x = 0
		player_body.move_and_slide()
	if Input.is_action_just_released("ui_accept"):
		complete()
		exit()
		
func sets_animation():
	if abs(player_body.velocity.y) > 0:
		if Input.is_action_pressed("ui_up"):
			animator.play("climbing")

		if Input.is_action_pressed("ui_down"):
			animator.play_backwards("climbing")
	else:
		animator.stop(true)
func exit():
	super()
	pass
	
func update_frame(direction:bool):
	if direction == true:
		if frame_index <3:
			sprite.frame = frame_index
			frame_index += 1
		else:
			frame_index = 0
	if direction == false:
		if frame_index >0:
			sprite.frame = frame_index
			frame_index -= 1
		else:
			frame_index = 3

func physics_do():
	climb()
	super()
	
func do():
	super()
	sets_animation()
