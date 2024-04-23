extends CanvasLayer

@onready var start_button = $StartButton


func _process(_delta):
	if start_button.button_pressed:
		get_tree().change_scene_to_file("res://main.tscn")
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
