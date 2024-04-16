extends Node3D


func _on_interactable_focused(_interactor):
	print("focused")


func _on_interactable_interacted(_interactor):
	print("interacted")


func _on_interactable_unfocused(_interactor):
	print("interactor")
