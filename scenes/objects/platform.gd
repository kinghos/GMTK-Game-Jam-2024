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

var hovering: bool = false
var expanded: bool = false

func update_initial_scale(new_scale):
	$".".scale.x = new_scale

func update_expanded_scale(new_scale):
	$EditorSprite.scale.x = new_scale

func _ready() -> void:
	if not Engine.is_editor_hint():
		$EditorSprite.visible = false

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT and not expanded:
		resize()

func resize():
	var resize_tween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	var expanded_scale_vector = Vector2(expanded_scale, 1)
	resize_tween.tween_property($".", "scale", expanded_scale_vector, 1)
	$Sprite2D.material.set_shader_parameter("width", 0)
	expanded = true

func _on_mouse_entered() -> void:
	if not expanded:
		$Sprite2D.material.set_shader_parameter("width", 0.5)
		hovering = true

func _on_mouse_exited() -> void:
	$Sprite2D.material.set_shader_parameter("width", 0)
	hovering = false
