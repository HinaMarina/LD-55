extends Node2D
@onready var animation : AnimatedSprite2D=$AnimatedSprite2D
@onready var audiofx :AudioStreamPlayer2D=$AudioStreamPlayer2D
@onready var feather_area : Area2D = $Feather

func _ready():
	feather_area.monitoring = false

func _on_bird_activation_body_entered(body):
	animation.play("default")
	feather_area.monitoring = true

func _on_feather_body_entered(body):
	self.queue_free()
