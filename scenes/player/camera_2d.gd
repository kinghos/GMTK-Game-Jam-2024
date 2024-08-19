extends Camera2D

func get_closest_bounds() -> CameraBounds:
	var candidates = []
	for b in get_tree().get_nodes_in_group("CameraBounds"):
		if b.player_in_bounds():
			candidates.append(b)
	if len(candidates) == 0:
		return null
	
	var biggest_priority = -10000.0
	var closest
	for c in candidates:
		var prio = c.priority
		if prio > biggest_priority:
			closest = c
			biggest_priority = prio
	
			
	return closest
	
func _process(delta: float) -> void:
	set_limit_to_bounds()
	
func set_limit_to_bounds():
	var curr_bounds = get_closest_bounds()
	if curr_bounds:
		limit_bottom = curr_bounds.global_position.y + (curr_bounds.size.y / 2)
		limit_top = curr_bounds.global_position.y - (curr_bounds.size.y / 2)
		limit_left = curr_bounds.global_position.x - (curr_bounds.size.x / 2)
		limit_right = curr_bounds.global_position.x + (curr_bounds.size.x / 2)
