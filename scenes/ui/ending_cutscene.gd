extends Node

const MUSIC = preload("res://assets/audio/Ending Cutscene.mp3")

var frames = [
	preload("res://assets/graphics/cutscenes/ending_1.png"),
	preload("res://assets/graphics/cutscenes/ending_2.png")
]

var current_frame: int = 0
var tween: Tween
var gained_tail: bool = false
var transitioning: bool = false

func _ready() -> void:
	Music._play_music_level(MUSIC)

func _on_tail_entered(body: Node2D) -> void:
	if not gained_tail:
		$SkeletonBackground.visible = false
		$CutsceneLayer.visible = true
		$Tilemaps/TileMapLayer.visible = false
		update_current_frame()

func update_current_frame():
	tween = get_tree().create_tween()
	tween.tween_property($CutsceneLayer/Frame, "modulate", Color.WHITE, 1)
	$CutsceneLayer/Frame.texture = frames[current_frame]
	
	if current_frame == 0:
		$CutsceneLayer/BackArrow.visible = false
		$CutsceneLayer/NextArrow.visible = true
		$CutsceneLayer/MenuButton.visible = false
	elif current_frame == 1:
		$CutsceneLayer/BackArrow.visible = true
		$CutsceneLayer/NextArrow.visible = false
		$CutsceneLayer/MenuButton.visible = true
	
	await tween.finished
	transitioning = false

func fade_to_black() -> void:
	tween = get_tree().create_tween()
	tween.tween_property($CutsceneLayer/Frame, "modulate", Color.BLACK, 1)

func _on_next_arrow_pressed() -> void:
	if not transitioning:
		transitioning = true
		
		if current_frame < frames.size() - 1:
			current_frame += 1
		
		fade_to_black()
		await tween.finished
		update_current_frame()

func _on_back_arrow_pressed() -> void:
	if not transitioning:
		transitioning = true
		
		if current_frame >= 1:
			current_frame -= 1
		
		fade_to_black()
		await tween.finished
		update_current_frame()

func _go_to_main_menu() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/title_screen.tscn")
