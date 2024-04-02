extends Node3D

@onready var mesh = $MeshInstance3D


func _on_interactable_focused(interactor):
	mesh.mesh.material.albedo_color = Color(0, 255, 0)


func _on_interactable_interacted(interactor):
	print("interacted")


func _on_interactable_unfocused(interactor):
	mesh.mesh.material.albedo_color = Color(255, 0, 0)
