extends Node2D

@onready var line_v: Line2D = $LineV
@onready var line_h: Line2D = $LineH

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var screen_size: Vector2 = get_viewport_rect().size
	
	line_v.add_point(Vector2(screen_size.x/2, 0))
	line_v.add_point(Vector2(screen_size.x/2, screen_size.y))
	
	line_h.add_point(Vector2(0, screen_size.y/2))
	line_h.add_point(Vector2(screen_size.x, screen_size.y/2))

