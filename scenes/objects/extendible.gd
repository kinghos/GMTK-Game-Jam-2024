@tool
extends Node

@export var initial_scale: float = 1 :
	set(value):
		initial_scale = value
		update_initial_scale(value)
@export var expanded_scale: float = 2 :
	set(value):
		expanded_scale = value
		update_expanded_scale(value)
@export var tween_duration: float = 1

var expanded: bool = false

func update_initial_scale(new_scale):
	$Sprite2D.scale.x = new_scale

func update_expanded_scale(new_scale):
	if has_node("EditorSprite"):
		$EditorSprite.scale.x = new_scale

func _ready() -> void:
	if not Engine.is_editor_hint() and has_node("EditorSprite"):
		$EditorSprite.visible = false
	else:
		update_initial_scale(initial_scale)
		update_expanded_scale(expanded_scale)

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed() and not expanded:
		if initial_scale < expanded_scale and event.button_index == MOUSE_BUTTON_LEFT:
			resize()
		if initial_scale > expanded_scale and event.button_index == MOUSE_BUTTON_RIGHT:
			resize(true)

func resize(remove_collision: bool = false):
	var resize_tween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	var expanded_scale_vector = Vector2(expanded_scale, 1)
	resize_tween.tween_property($".", "scale", expanded_scale_vector, tween_duration)
	$Sprite2D.material.set_shader_parameter("width", 0)
	expanded = true
	if remove_collision:
		await resize_tween.finished
		queue_free()

func _on_mouse_entered() -> void:
	if not expanded:
		$Sprite2D.material.set_shader_parameter("width", 2)

func _on_mouse_exited() -> void:
	if not expanded:
		$Sprite2D.material.set_shader_parameter("width", 1)
