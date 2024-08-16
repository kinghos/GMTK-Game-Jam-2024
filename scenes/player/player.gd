extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0
const MAGIC_RADIUS = 300

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var cross_cursor: Resource = load("res://assets/graphics/cursors/cross.png")
var wand_cursor: Resource = load("res://assets/graphics/cursors/wandcursor.png")
@onready var animated_sprite = $AnimatedSprite2D


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("Left", "Right")
	
	# Flip sprite
	if direction > 0:
		animated_sprite.flip_h = false
		$Line2D.set_point_position(0, Vector2(7, 0))
	elif direction < 0:
		animated_sprite.flip_h = true
		$Line2D.set_point_position(0, Vector2(-7, 0))
	
	# Play animations
	#if is_on_floor():
		#if direction == 0:
			#animated_sprite.play("idle")
		#else:
			#animated_sprite.play("run")
	#else:
		#animated_sprite.play("jump")	
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _process(delta: float) -> void:
	var mouse_pos = $Camera2D.get_local_mouse_position()
	
	
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
		$RayCast2D.target_position = Vector2(7, 0)
