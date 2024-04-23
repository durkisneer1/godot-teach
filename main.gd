extends Node3D


func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://menu.tscn")
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
