extends CanvasLayer

var frames = [
	preload("res://assets/graphics/cutscenes/opening_1.png"),
	preload("res://assets/graphics/cutscenes/opening_2.png"),
	preload("res://assets/graphics/cutscenes/opening_3.png"),
	preload("res://assets/graphics/cutscenes/opening_4.png"),
	preload("res://assets/graphics/cutscenes/opening_5.png")
]
const CUTSCENE = preload("res://assets/audio/Cutscene.mp3")
var current_frame: int = 0
var tween: Tween
var transitioning: bool = false

func _ready() -> void:
	Music._play_music_level(CUTSCENE)
	update_current_frame()

func update_current_frame():
	tween = get_tree().create_tween()
	tween.tween_property($Frame, "modulate", Color.WHITE, 1)
	$Frame.texture = frames[current_frame]
	
	if current_frame == 0:
		$BackArrow.visible = false
	else:
		$BackArrow.visible = true
	if current_frame == frames.size() - 1:
		$SkipButton.visible = false
		$NextArrow.visible = false
		$PlayButton.visible = true
	else:
		$SkipButton.visible = true
		$NextArrow.visible = true
		$PlayButton.visible = false
	
	await tween.finished
	transitioning = false

func fade_to_black() -> void:
	tween = get_tree().create_tween()
	tween.tween_property($Frame, "modulate", Color.BLACK, 1)

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

func _go_to_level_1() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn")
