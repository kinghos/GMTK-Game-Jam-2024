extends Node2D

var MAIN_MENU = load("res://assets/audio/Main Menu.mp3")
var MANSION = load("res://assets/audio/Mansion.mp3")

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	for i in get_tree().get_nodes_in_group("RootNodes"):
		print(i)
		if "song" in i and not i.is_in_group("Levels"):
			audio_stream_player.stream = i.song
			audio_stream_player.play()
	
