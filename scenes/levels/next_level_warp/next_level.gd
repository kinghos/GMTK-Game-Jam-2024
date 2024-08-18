extends Area2D

@export var next_level_path: String

var level_1_texture = preload("res://assets/graphics/doors/castle_entrance.png")

func _ready():
	if $".".get_parent().name == "Level1":
		$Sprite2D.texture = level_1_texture
		$Sprite2D.scale = Vector2(4, 4)
	else:
		$AnimationPlayer.play("hovering")

func _on_body_entered(body):
	if body.get_name() == "Player":
		get_tree().change_scene_to_file.call_deferred(next_level_path)
