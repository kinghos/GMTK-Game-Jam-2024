extends Area2D

@export var next_level_path: String
@export var flip_horizontal: bool = false

var level_1_texture = preload("res://assets/graphics/doors/castle_entrance.png")

func _ready():
	if $".".get_parent().name == "Level1":
		$Sprite2D.texture = level_1_texture
		$Sprite2D.scale = Vector2(0.5, 0.5)
	if flip_horizontal:
		$Sprite2D.flip_h = !$Sprite2D.flip_h

func _on_body_entered(body):
	if body.get_name() == "Player":
		get_tree().change_scene_to_file.call_deferred(next_level_path)
