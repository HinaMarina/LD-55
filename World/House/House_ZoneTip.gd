extends Sprite2D

func zone_tip(value:bool):
	if value:
		var tween = create_tween()
		tween.tween_property(self,"modulate",Color(1,1,1,1),0.2)
	if !value:
		var tween = create_tween()
		tween.tween_property(self,"modulate",Color(1,1,1,0),0.3)
