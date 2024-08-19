extends BaseEnemy

signal kill(node, color)
@export var skull_color: Color = Color("726def")
@export var initial_light_color: Color = Color("6862da")
@export var alert_light_color: Color = Color("c00000")

var player_dying: bool = false

func _ready():
	$AnimationPlayer.play("eyeball bob")

func _process(_delta):
	var collider: CollisionObject2D = null
	
	if $LeftCast.is_colliding():
		var left_collider = $LeftCast.get_collider()
		if left_collider and left_collider.get_name() == "Player":
			collider = left_collider
			
	if $RightCast.is_colliding():
		var right_collider = $RightCast.get_collider()
		if right_collider and right_collider.get_name() == "Player":
			collider = right_collider
	
	if collider:
		if not player_dying:
			kill.emit(collider, collider.skull_color)
		player_dying = true
		$PointLight2D.color = alert_light_color


func _on_kill_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Resizables"):
		kill.emit(self, skull_color)
