@tool
extends Node2D
class_name CameraBounds

@onready var sprite_2d: Sprite2D = $Sprite2D
@export var size: Vector2 = Vector2(10, 10):
	set(new_size):
		size.x = new_size.x
		size.y = new_size.y
		if Engine.is_editor_hint():
			update_editor_size(size/4)
@export var priority: int = 0

func update_editor_size(value):
	sprite_2d.scale = value


func player_in_bounds() -> bool:
	var player_pos = Globals.player_pos
	if abs(player_pos.x - global_position.x) < (size.x / 2) and abs(player_pos.y - global_position.y) < (size.y / 2):
		return true
	return false
