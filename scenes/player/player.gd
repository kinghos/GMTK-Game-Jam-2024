extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

@export var skull_color: Color = "#6abe30"
@export var MAGIC_RADIUS = 300
@export var push_force = 500
@export var dead: bool = false

var can_push_switch

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var cross_cursor: Resource = load("res://assets/graphics/cursors/cross.png")
var wand_cursor: Resource = load("res://assets/graphics/cursors/wandcursor.png")
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_2d: RayCast2D = $RayCast2D

func _physics_process(delta):
	if dead:
		return
		
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and (is_on_floor() or $CoyoteTimer.time_left > 0):
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("Left", "Right")
	
	# Flip sprite
	if direction > 0:
		animated_sprite.flip_h = false
		$Line2D.set_point_position(0, Vector2(7, 0))
		$RayCast2D.position = Vector2(8, 0)
	elif direction < 0:
		animated_sprite.flip_h = true
		$Line2D.set_point_position(0, Vector2(-7, 0))
		$RayCast2D.position = Vector2(-8, 0)
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	var was_on_floor = is_on_floor()
	move_and_slide()
	push_objects()
	
	if was_on_floor and !is_on_floor():
		$CoyoteTimer.start()

func _process(_delta: float) -> void:
	if dead:
		return
	
	# Play animations
	if is_on_floor():
		if velocity == Vector2.ZERO:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("walk")
			
	var mouse_pos = to_local($Camera2D.get_global_mouse_position())
	
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

			if Input.is_action_pressed("Primary"):
				collider.resize(current_scale, 1)
			elif Input.is_action_pressed("Secondary"):
				collider.resize(current_scale, -1)
		elif collider.name == "Platform":
			collider.resize()
			

func push_objects():
	for i in get_slide_collision_count():
		var col = get_slide_collision(i)
		if col.get_collider() is RigidBody2D:
			col.get_collider().apply_central_force(col.get_normal() * -push_force)

func _on_camera_area_entered(area: Area2D) -> void:
	var collision_shape = area.get_node("CollisionShape2D")
	var size = collision_shape.shape.size
	
	var view_size = get_viewport_rect().size
	if size.y < view_size.y:
		size.y = view_size.y
	
	if size.x < view_size.x:
		size.x = view_size.x
	
	var cam = $Camera2D
	cam.limit_top = collision_shape.global_position.y - size.y/2
	cam.limit_left = collision_shape.global_position.x - size.x/2
	
	$Camera2D.limit_bottom = cam.limit_top + size.y
	$Camera2D.limit_right = cam.limit_left + size.x
