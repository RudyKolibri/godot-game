extends Node2D

const Player = preload("res://scenes/player.tscn")
export var ENEMY : PackedScene
export var BOX : PackedScene

var borders = Rect2(1, 1, 38, 21)

onready var tileMap = $LevelNavigation/TileMap
signal done
signal box
signal enemy
signal pointer2player
onready var player = $Player

func _ready():
	randomize()
	generate_level()

func generate_level():
	var walker = Walker.new(Vector2(19, 11), borders)
	var map = walker.walk(500)
	
	player.hide()
	player.position = map.front()* 67
	player.show()
	emit_signal("pointer2player")
	
	place_object_in_rooms(ENEMY, walker.place_mosters())
	place_object_in_rooms(BOX, walker.place_box())
	walker.queue_free()
	emit_signal("done")
	for location in map:
		tileMap.set_cellv(location, 6)
	tileMap.update_bitmask_region(borders.position, borders.end)

func _input(event):
	if event.is_action_pressed("ui_accept"):
		var _bla = get_tree().reload_current_scene()

func place_object_in_rooms(object_scene: PackedScene, rooms: Array):
	for room in rooms:
		if ! (room.position * 64).distance_to(player.global_position) < 240:
			var object = object_scene.instance()
			if object_scene == BOX:
				emit_signal("box", object)
				pass
			else:
				emit_signal("enemy", object)
			object.global_position = room.position * 64
