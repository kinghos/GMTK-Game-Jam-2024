extends Node2D

var death: PackedScene = preload("res://scenes/utilities/death.tscn")

func kill():
	var death_anim = death.instantiate()
	add_child(death_anim)
	hide()
	var anim = death_anim.get_node("AnimationPlayer")
	anim.play()
	await anim.finished
