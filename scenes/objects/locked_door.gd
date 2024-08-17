extends StaticBody2D

@onready var sprite_2d = $Sprite2D
@onready var collision_shape_2d = $CollisionShape2D
@onready var lock_colour = $LockColour
@export var trigger_switch: Node
@export var colour: Color = Color("#bd314b")

func _ready():
	sprite_2d.animation = "locked"
	trigger_switch.pressed.connect(_on_switch_pressed)
	#lock_colour.set_self_modulate(colour)
	#lock_colour.show()

func _on_switch_pressed(switch_id):
	print(switch_id, trigger_switch)
	if switch_id == trigger_switch:
		sprite_2d.animation = "unlocked"
		collision_shape_2d.set_deferred("disabled", true)
		#lock_colour.hide()
