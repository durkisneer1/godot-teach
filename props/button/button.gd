extends Node3D

@onready var mesh = $Cube
@onready var anim_player: AnimationPlayer = get_parent_node_3d().get_node("AnimationPlayer")


func _on_interactable_focused(_interactor):
	pass


func _on_interactable_interacted(_interactor):
	anim_player.play("button_press")


func _on_interactable_unfocused(_interactor):
	pass
