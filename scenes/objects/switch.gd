extends Area2D

@onready var sprite_2d = $Sprite2D
signal pressed(switch_id)


#func _ready():
	#sprite_2d.animation = "inactive"

func _on_body_entered(body):
	if "canPushSwitch" in body:
		sprite_2d.animation = "active"
		pressed.emit(self)
