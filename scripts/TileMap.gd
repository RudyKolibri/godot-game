extends TileMap

func _on_map_done():
	for child in get_children():
		if child is GridBox:
			child.initialize(self)


func _on_map_box(object):
	add_child(object)
