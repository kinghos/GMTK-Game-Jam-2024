@tool
extends StaticBody2D

@onready var sprite_2d = $Sprite2D
@onready var collision_shape_2d = $CollisionShape2D
@onready var lock_colour = $LockColour
@export var trigger_switch: Node
@export var colour: Color = Color("#bd314b") :
	set(value):
		colour = value
		update_colour()

func update_colour():
	if not lock_colour:
		await self.ready
	lock_colour.set_self_modulate(colour)
	lock_colour.show()

func _ready():
	update_colour()
	sprite_2d.animation = "locked"
	# "x" in y is a way to check properties in a file.
	if "pressure_plate" in trigger_switch:
		trigger_switch.pressed.connect(_on_pressure_plate_pressed)
	elif "button" in trigger_switch: 
		trigger_switch.pressed.connect(_on_button_pressed)

func open_door():
	sprite_2d.animation = "unlocked"
	collision_shape_2d.set_deferred("disabled", true)
	if $"../..".name == "Level5" or $"../..".name == "Level6":
		queue_free()
	lock_colour.hide()

func _on_button_pressed(switch_id):
	if switch_id == trigger_switch:
		open_door()
		
func _on_pressure_plate_pressed(pressed):
	if pressed:
		open_door()
	else:
		sprite_2d.animation = "locked"
		collision_shape_2d.set_deferred("disabled", false)
		lock_colour.show()
		
