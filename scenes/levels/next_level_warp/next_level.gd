@tool
extends Area2D

@export var texture: CompressedTexture2D = preload("res://assets/graphics/misc/level_warp.png") :
	set(value):
		texture = value
		update_texture()
@export var texture_scale: float = 2.25 :
	set(value):
		texture_scale = value
		update_texture()
@export var next_level_path: String

func update_texture():
	$Sprite2D.texture = texture
	$Sprite2D.scale = Vector2(texture_scale, texture_scale)

func _ready():
	update_texture()

func _on_body_entered(body):
	if body.get_name() == "Player":
		get_tree().change_scene_to_file.call_deferred(next_level_path)
