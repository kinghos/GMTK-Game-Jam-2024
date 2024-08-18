extends Area2D

@onready var sprite_2d = $Sprite2D
signal pressed(switch_id)

func _ready():
	sprite_2d.animation = "up"

func _on_body_entered(body):
	if "can_push_switch" in body:
		sprite_2d.animation = "down"
		pressed.emit(self)
