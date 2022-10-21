extends Node
class_name Walker

const DIRECTIONS = [Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN]

var position = Vector2.ZERO
var direction = Vector2.RIGHT
var borders = Rect2()
var step_history = []
var steps_since_turn = 0
var rooms = []
var available_rooms = []

export(float, 0.0, 1.0) var monster_room_chance: float = 0.3
var monster_rooms: Array = []

export(float, 0.5, 1.5) var box_room_chance: float = 0.15
var box_rooms: Array = []

func _init(starting_position, new_borders):
	assert(new_borders.has_point(starting_position))
	position = starting_position
	step_history.append(position)
	borders = new_borders

func walk(steps):
	place_room(position)
	for step in steps:
		if steps_since_turn >= 8:
			change_direction()
		
		if step():
			step_history.append(position)
		else:
			change_direction()
	available_rooms = rooms
	return step_history

func step():
	var target_position = position + direction
	if borders.has_point(target_position):
		steps_since_turn += 1
		position = target_position
		return true
	else:
		return false

func change_direction():
	place_room(position)
	steps_since_turn = 0
	var directions = DIRECTIONS.duplicate()
	directions.erase(direction)
	directions.shuffle()
	direction = directions.pop_front()
	while not borders.has_point(position + direction):
		direction = directions.pop_front()

func create_room(positions, size):
	return {position = positions, size = size}

func place_room(positionss):
	var size = Vector2(randi() % 3 + 2, randi() % 3 + 2)
	var top_left_corner = (positionss - size/2).ceil()
	rooms.append(create_room(positionss, size))
	for y in size.y:
		for x in size.x:
			var new_step = top_left_corner + Vector2(x, y)
			if borders.has_point(new_step):
				step_history.append(new_step)

func place_mosters():
	for room in available_rooms:
		if randf() < monster_room_chance:
			monster_rooms.append(room)
			available_rooms.erase(room)
	return monster_rooms
func place_box():
	for room in available_rooms:
		if randf() < box_room_chance:
			box_rooms.append(room)
			available_rooms.erase(room)
	return box_rooms
