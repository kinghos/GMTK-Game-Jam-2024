extends Node2D
class_name CameraBounds

@export var size: Vector2 = Vector2(10, 10)
@export var priority: int = 0

func player_in_bounds() -> bool:
	var player_pos = Globals.player_pos
	if abs(player_pos.x - global_position.x) < (size.x / 2) and abs(player_pos.y - global_position.y) < (size.y / 2):
		return true
	return false
