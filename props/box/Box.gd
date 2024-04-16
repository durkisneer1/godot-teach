extends Node3D

@onready var mesh = $Root/MeshInstance3D
@onready var anim_player = $AnimationPlayer


func _on_interactable_focused(_interactor):
	mesh.mesh.material.albedo_color = Color("#37522f")


func _on_interactable_interacted(_interactor):
	anim_player.play("bounce")


func _on_interactable_unfocused(_interactor):
	mesh.mesh.material.albedo_color = Color("#541511")
