extends Node2D

var MAIN_MENU = preload("res://assets/audio/Main Menu.mp3")
var MANSION = preload("res://assets/audio/Mansion.mp3")

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	if not get_tree().get_nodes_in_group("Levels"):
		audio_stream_player.stream = MAIN_MENU
		audio_stream_player.play()
	else:
		print("HAI")
		audio_stream_player.stream = MANSION
		audio_stream_player.stream.play()
