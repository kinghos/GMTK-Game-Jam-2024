extends Node2D

func _ready() -> void:
	print($AnimationPlayer.get_animation("death").find_track("Skull:modulate", 0))
	print($AnimationPlayer.get_animation("death").track_find_key(3, 1.2))
