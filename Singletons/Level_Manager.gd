extends Node

@onready var House_Scene : NodePath = "res://World/House/House.tscn"
@onready var Forest_Scene : NodePath = "res://Scenes/Parallax_forest_test.tscn"
@onready var Beach_Scene : NodePath
@onready var Mountain_Scene: NodePath

func change_scene(leaving_level:String):
	
	if leaving_level == "mushroom":
		get_tree().change_scene_to_file(House_Scene)
	if leaving_level == "shell":
		get_tree().change_scene_to_file(House_Scene)
