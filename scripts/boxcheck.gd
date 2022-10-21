extends Box
class_name GridBox

onready var tween : Tween = $Tween

export var sliding_time : = 0.3

var tile_map : TileMap
var sliding : = false
var hp = 3
func initialize(_tile_map: TileMap) -> void:
	tile_map = _tile_map
	position = calculate_destination(Vector2())


func push(velocity: Vector2) -> void:
	if sliding:
		return
	var move_to : = calculate_destination(velocity.normalized())
	if can_move(move_to):
		var _bla = tween.interpolate_property(self, 
			"global_position",
			global_position,
			move_to,
			sliding_time,
			Tween.TRANS_CUBIC,
			Tween.EASE_OUT)
		var _bla2 = tween.start()
		sliding = true
		yield(tween, "tween_completed")
		sliding = false


func calculate_destination(direction: Vector2) -> Vector2:
	if tile_map != null:
		# Returns the global position from our position towards direction, snapped to the grid
		var tile_map_position = tile_map.world_to_map(global_position) + direction
		return tile_map.map_to_world(tile_map_position)
	else:
		return Vector2.ZERO

func can_move(move_to: Vector2) -> bool:
	# Returns if the box can be moved to `move_to` without causing a collision
	var future_transform : = Transform2D(transform)
	future_transform.origin = move_to
	return not test_move(future_transform, Vector2())


func _on_selfkill_body_entered(body):
	if body.is_in_group("bodies") and body != self:
		queue_free()
		
func _on_hurtbox_body_entered(body):
	
	if body.is_in_group("bullet") or body.is_in_group("bulletenemy"):
		body.hit()
		hp -= 1
		$Sprite.frame += 1
		if hp <= 1:
			self.remove_child($Tween)
			self.remove_child($selfkill)
			#self.remove_child($hurtbox)
			self.remove_child($CollisionShape2D)
			self.remove_from_group("bodies")
			queue_free()
		
