extends Node

const MUSIC = preload("res://assets/audio/Ending Cutscene.mp3")

func _ready() -> void:
	Music._play_music_level(MUSIC)

func _on_tail_entered(body: Node2D) -> void:
	print("gained tail!")
