extends State

@export var going_up :State
@export var max_reach :State
@export var vertical_speed = -200
@export var vertical_accel = 100
@export var flying_time:float = 1

var running_state:State
var substates_array : Array [State] = []
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var reach_max_vel:bool = false

func _ready():
	running_state = going_up
	update_running_state_assets()
	for child in get_children():
		if child is State:
			substates_array.append(child)
	for substate in substates_array:
		substate.sprite.visible = false
	
	
func update_running_state_assets():
	if running_state != null:
		for child in running_state.get_children():
			if child is Sprite2D:
				sprite = child
			if child is AnimationPlayer:
				animator = child
	for substate in substates_array:
		if substate != running_state:
			substate.sprite.visible = false
		else:
			substate.sprite.visible = true
			
func push_up():
	if elapsed_time() < flying_time:
		player_body.velocity.x = Input.get_axis("ui_left","ui_right")*30
		player_body.velocity.y = vertical_speed
		player_body.move_and_slide()
	if elapsed_time() > flying_time:
		player_body.velocity.x = Input.get_axis("ui_left","ui_right")*30
		var tween = create_tween()
		tween.tween_property(player_body,"velocity",Vector2.ZERO,0.25)
		player_body.move_and_slide()
		var vector:Vector2
		vector.x = 0
		vector.y = -0
		#weirdly, when velocity is subjected to a tweening, it never reaches zero
		#probably something about floating point representation
		if abs(player_body.velocity.y) < 0.5:
			player_body.velocity.y = 0
			complete()
			exit()
	
func do():
	super()
	if is_on_floor:
		running_state = going_up
	sets_animation()
	update_running_state_assets()
		
func physics_do():
	if running_state == max_reach:
		push_up()
	
		
func sets_animation():
	var animation_list = animator.get_animation_list()
	animator.play(animation_list[0])


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "Going_Up_Animation":
		running_state = max_reach
		sets_animation()
		
func exit():
	super()
	running_state = going_up

func complete():
	super()
	GlobalVariables.flower_number -= 1
