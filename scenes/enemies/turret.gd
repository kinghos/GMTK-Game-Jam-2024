extends BaseEnemy

signal kill(node, color)
@export var skull_color: Color = Color("726def")

var player_dying: bool = false

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
	
	if not player_dying:
		kill.emit(collider, collider.skull_color)
	player_dying = true
	await get_tree().create_timer(1.4).timeout
	get_tree().reload_current_scene()

func _on_kill_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Resizables"):
		kill.emit(self, skull_color)
		queue_free()
