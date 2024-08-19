@tool
extends StaticBody2D

@export var initial_scale: float = 1 :
	set(value):
		initial_scale = value
		update_initial_scale(value)
@export var expanded_scale: float = 2 :
	set(value):
		expanded_scale = value
		update_expanded_scale(value)

var hovering = false
var resize_tween: Tween = null

func update_initial_scale(new_scale):
	$".".scale.x = new_scale

func update_expanded_scale(new_scale):
	$EditorSprite.scale.x = new_scale

func _ready() -> void:
	if not Engine.is_editor_hint():
		$EditorSprite.visible = false

#func resize(current_scale: Vector2, direction: int):
	#resize_tween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC).set_parallel()
	#resize_tween.tween_property($CollisionShape2D, "scale", sizes[0], 1)
	#resize_tween.tween_property($".", "_mass", sizes[1], 1)
	#$".".physics_material_override.set_friction(sizes[2])

func _on_mouse_enter(_shape_idx: int):
	$CollisionShape2D/Sprite2D.material.set_shader_parameter("width", 0.5)
	hovering = true

func _on_mouse_exit(_shape_idx: int):
	$CollisionShape2D/Sprite2D.material.set_shader_parameter("width", 0)
	hovering = false
