extends Node2D

var MAIN_MENU = load("res://assets/audio/Main Menu.mp3")
var MANSION = load("res://assets/audio/Mansion.mp3")

@onready var asp: AudioStreamPlayer = $AudioStreamPlayer

func _play_music(music: AudioStream, volume = 0.0):
	if asp.stream == music:
		return
	asp.stream = music
	asp.volume_db = volume
	asp.play()

func _play_music_level(song, volume=0.0):
	_play_music(song, volume)
