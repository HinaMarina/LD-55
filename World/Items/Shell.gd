extends Node2D

@onready var area2D : Area2D = $Area2D
@onready var soundfc : AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var sprite: Sprite2D = $Sprite2D
var pegou : bool

func _on_area_2d_body_entered(body):
	if !pegou:
		if body is CharacterBody2D:
			GlobalVariables.Mushroom = true
			GlobalVariables.number_levels_passed +=1
			sprite.visible = false
			soundfc.playing = true
			pegou = true
			PauseTree.can_move = false
			GlobalVariables.level_finished()
		


func _on_audio_stream_player_2d_finished():
	PauseTree.can_move = true
	LevelManager.change_scene("shell")
	self.queue_free()
