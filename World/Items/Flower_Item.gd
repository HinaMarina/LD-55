extends Node2D

@export var sound_fx : AudioStreamPlayer2D

func _on_area_2d_body_entered(body):
	if body is CharacterBody2D:
		GlobalVariables.flower_number += 1
		sound_fx.play()
		$Icon.visible=false


func _on_audio_stream_player_2d_finished():
		self.queue_free()
