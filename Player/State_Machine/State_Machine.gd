class_name State_Machine extends Node2D

######### States ############
@export var idle_state : State
@export var run_state : State
@export var flying_state : State
@export var climbing_state : State

######## Some Important Nodes #######
@export var player_body : CharacterBody2D
@export var camera : Camera2D

######## State Machine Variables ######
var states_array : Array[State] = []
var input_vector : Vector2
var current_state : State
var is_on_floor : bool = true
var flying : bool = false
var can_move : bool = true
var climbing : bool = false
var state_wanna_exit : bool
var gliding:bool

@export var gravity = 5

func _ready():
	set_state(idle_state)
	for child in get_children():
		if child is State:
			states_array.append(child)
			child.visible = true
			
func _process(delta):
	is_on_floor = player_body.is_on_floor()
	can_move = PauseTree.can_move
	if current_state == flying_state:
		gliding = flying_state.is_complete
		flying = !flying_state.is_complete
	else:
		gliding = is_on_floor
		
	if current_state == climbing_state:
		climbing = !climbing_state.is_complete

	for state in states_array:
		state.is_on_floor = is_on_floor
	########### do the current state
	if current_state != null:
		if current_state.is_complete == false:
			current_state.do()
			update_states_animator_tree()
			
	######################################
	#Setting State responding through the input#
	if is_on_floor:
		if can_move:
			if !climbing:
				if abs(Input.get_axis("ui_left","ui_right"))>0 && identify_directional_input() && !flying:
					input_vector.x = Input.get_axis("ui_left","ui_right")
					input_vector.y = 0.0
					set_state(run_state)
					update_states_variables()
					update_states_animator_tree()
					update_sprites_visibility()

				elif !flying:
					player_body.velocity = player_body.velocity.move_toward(Vector2.ZERO,120)
					player_body.move_and_slide()
					if player_body.velocity == Vector2.ZERO:
						set_state(idle_state)
						update_sprites_visibility()
						update_states_variables()
						if Input.is_action_just_pressed("ui_accept") && GlobalVariables.flower_number>=1:
							set_state(flying_state)
							flying = true
							update_sprites_visibility()
		
			if Input.is_action_just_pressed("climb"):
				set_state(climbing_state)
				update_sprites_visibility()
		
func _physics_process(delta):
	########### physics_do the current state
	if current_state != null:
		if current_state.is_complete == false:
			current_state.physics_do()
			update_states_animator_tree()
			
	########### apply_gravity ##########
	if !is_on_floor && !flying && !climbing:
		if current_state == run_state:
			player_body.velocity = player_body.velocity.move_toward(Vector2.ZERO,120)
			player_body.move_and_slide()
			if player_body.velocity == Vector2.ZERO:
				set_state(idle_state)
				update_sprites_visibility()
		if !gliding:
			player_body.velocity.x = Input.get_axis("ui_left","ui_right")*run_state.max_speed
			player_body.velocity.y += gravity*2
			player_body.move_and_slide()
			set_state(idle_state)
			update_sprites_visibility()
		if gliding:
			player_body.velocity.x = Input.get_axis("ui_left","ui_right")*run_state.max_speed
			player_body.velocity.y += gravity*0.1
			player_body.move_and_slide()
	
func update_sprites_visibility():
	for state in states_array:
		if state.sprite != null:
			if state != current_state:
				state.sprite.visible = false
				if state.audio_player != null:
					state.audio_player.volume_db = -100
				if state.animator_tree != null:
					state.animator_tree.active = false
			else:
				state.sprite.visible = true
				if state.audio_player != null:
					state.audio_player.volume_db = 0
					state.animator_tree.active = true

func set_state(new_state:State):
	if new_state != null && new_state != current_state:
		current_state = new_state
		current_state.enter()
	
func identify_directional_input():
	if Input.is_action_pressed("ui_left") || Input.is_action_pressed("ui_right"):
		return true
	else:
		return false

func update_states_variables():
	for state in states_array:
		state.is_on_floor = is_on_floor
		state.input_vector = input_vector

func update_states_animator_tree():
	for state in states_array:
		if state.has_method("set_tree_blend_position"):
			state.set_tree_blend_position()

