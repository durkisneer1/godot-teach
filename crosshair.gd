extends Node2D


# Called when the node enters the scene tree for the first time.
func _draw():
	draw_circle(get_viewport_rect().get_center(), 3, Color(255, 255, 255))
