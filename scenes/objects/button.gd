extends Area2D

@onready var sprite_2d = $Sprite2D
@export var color: Color
signal pressed(switch_id)

func _ready():
	sprite_2d.animation = "up"
	$ButtonMask.animation = "up"
	$ButtonMask.set_self_modulate(color)

func _on_body_entered(body):
	if "can_push_switch" in body:
		sprite_2d.animation = "down"
		$ButtonMask.animation = "down"
		pressed.emit(self)
