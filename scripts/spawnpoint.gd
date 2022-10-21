extends Node2D

export var bulletScene : PackedScene
var direction = null
func _on_Spawner_shootgun2(pos, global):
	pos.y -= 15
	pos.x -= 15
	direction = (pos - global).normalized()
	var bullet = bulletScene.instance() as Node2D
	get_parent().add_child(bullet)
	bullet.global_position = self.global_position
	bullet.direction = - direction
	bullet.rotation = bullet.direction.angle()
