extends BaseEnemy

signal kill(node, color)
@export var color: Color

func _ready():
	$AnimationPlayer.play("eyeball bob")
	$Line2D.hide()

func _process(_delta):
	var collider: CollisionObject2D = null
	if $LeftCast.is_colliding():
		collider = $LeftCast.get_collider()
	elif $RightCast.is_colliding():
		collider = $RightCast.get_collider()
	
	if !collider or collider.get_name() != "Player":
		return
	
	$Line2D.set_point_position(1, to_local(collider.global_position))
	$Line2D.show()

func _on_kill_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Resizables"):
		kill.emit(self, color)
		queue_free()
