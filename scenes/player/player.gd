extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

@export var MAGIC_RADIUS = 300
@export var push_force = 500

var scale_presets: Array = [Vector2(0.1, 0.1), Vector2(0.2, 0.2), Vector2(0.5, 0.5), Vector2(1.0, 1.0), Vector2(1.5, 1.5), Vector2(2.0, 2.0)]

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var cross_cursor: Resource = load("res://assets/graphics/cursors/cross.png")
var wand_cursor: Resource = load("res://assets/graphics/cursors/wandcursor.png")
@onready var animated_sprite = $AnimatedSprite2D
@onready var ray_cast_2d: RayCast2D = $RayCast2D

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("Left", "Right")
	
	# Flip sprite
	if direction > 0:
		animated_sprite.flip_h = false
		$Line2D.set_point_position(0, Vector2(7, 0))
	elif direction < 0:
		animated_sprite.flip_h = true
		$Line2D.set_point_position(0, Vector2(-7, 0))
	else:
		animated_sprite.stop()
	
	# Play animations
	if is_on_floor():
		if direction == 0:
			#animated_sprite.play("idle")	
			pass
		else:
			animated_sprite.play("walk")
	else:
		#animated_sprite.play("jump")
		pass
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	push_object()

func _process(_delta: float) -> void:
	var mouse_pos = to_local(get_viewport().get_mouse_position())
	
	# Find difference of vectors and see if its less than the max radius
	var vector_diff = mouse_pos - to_local(position)
	if vector_diff.length() < MAGIC_RADIUS:
		$Line2D.show()
		$Line2D.set_point_position(1, mouse_pos)
		Input.set_custom_mouse_cursor(wand_cursor)
		$RayCast2D.target_position = mouse_pos
	else:
		$Line2D.hide()
		Input.set_custom_mouse_cursor(cross_cursor)
		ray_cast_2d.target_position = Vector2(7, 0)
		
	if ray_cast_2d.is_colliding():
		var collider = ray_cast_2d.get_collider()
		
		if collider.is_in_group("Resizables"):
			var current_scale: Vector2 = collider.get_child(0).scale
			var new_scale: Vector2 = current_scale
			
			if Input.is_action_pressed("Primary"):
				new_scale = get_adjacent_scale(current_scale, 1)
			elif Input.is_action_pressed("Secondary"):
				new_scale = get_adjacent_scale(current_scale, -1)
			
			if new_scale != current_scale:
				collider.resize(new_scale)
				

func get_adjacent_scale(current_scale: Vector2, direction: int):
	var index = scale_presets.find(current_scale)
	index += direction
	
	if index >= 0 and index < scale_presets.size():
		return scale_presets[index]
	else:
		return current_scale

func push_object():
	for i in get_slide_collision_count():
		var col = get_slide_collision(i)
		if col.get_collider() is RigidBody2D:
			col.get_collider().apply_central_force(col.get_normal() * -push_force)
