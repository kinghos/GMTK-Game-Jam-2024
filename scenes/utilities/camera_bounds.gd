@tool
extends Node2D
class_name CameraBounds

@onready var sprite_2d: Sprite2D = $Sprite2D


@export var size: Vector2 = Vector2(10, 10) :
	set(new_size):
		size.x = new_size.x
		size.y = new_size.y
		#update_size(size/2)
@export var priority: int = 0

func update_size(value):
	sprite_2d.scale = value

func _ready() -> void:
	update_size(size)

func player_in_bounds() -> bool:
	var player_pos = Globals.player_pos
	print("X: %s" % (abs(player_pos.x - global_position.x) < (size.x/2))) 
	print("Y: %s" % abs(player_pos.y - global_position.y))
	if abs(player_pos.x - global_position.x) < (size.x / 2) and abs(player_pos.y - global_position.y) < (size.y / 2):
		return true
	return false
