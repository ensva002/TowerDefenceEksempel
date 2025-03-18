extends Area2D

var tower
var placable
var overlapping
var tower_id: int = 0



func _process(delta: float) -> void:
	global_position = get_global_mouse_position()
	if Input.is_action_just_pressed("LMB") && placable:
		tower = TowerManager.select_tower(tower_id)
		var new_tower = tower.duplicate()
		if Manager.adjust_funds(-new_tower.get_meta("price")):
			new_tower.global_position = global_position
			get_tree().current_scene.add_child(new_tower)

		
	overlapping = bool(get_overlapping_areas().size())
	if position.y < 192:
		placable_off()
	elif !overlapping:
		placable_on()
	else:
		placable_off()
		

func on_cancel_placement():
	queue_free()
	
func placable_on():
	placable = true
	modulate = Color(1,1,1,0.75)
	
func placable_off():
	placable = false
	modulate = Color(1,0.3,0.3,0.75)
