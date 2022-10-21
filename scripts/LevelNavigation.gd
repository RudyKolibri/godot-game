extends Navigation2D

func _on_map_enemy(object):
	add_child(object)
	object.connect("shake", $"../Player/Camera2D/ScreenShake", "start")
