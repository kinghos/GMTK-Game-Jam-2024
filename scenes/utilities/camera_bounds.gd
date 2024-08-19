@tool
extends Node2D
class_name CameraBounds

@export var size: Vector2 = Vector2(10, 10) :
	set(new_size):
		size.x = new_size.x
		size.y = new_size.y
		update_size(size)
@export var priority: int = 0

func update_size(value):
	$Sprite2D.scale = value

func _ready() -> void:
	update_size(size)

func player_in_bounds() -> bool:
	var player_pos = Globals.player_pos
	if abs(player_pos.x - global_position.x) < (size.x / 2) and abs(player_pos.y - global_position.y) < (size.y / 2):
		return true
	return false
