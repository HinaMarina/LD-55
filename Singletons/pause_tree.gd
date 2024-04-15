extends Node
@onready var can_move: bool = true
func pause():
	can_move = !can_move
