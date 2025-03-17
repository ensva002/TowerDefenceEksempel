extends Area2D

var tower
var placable
var overlapping

func _ready() -> void:
	tower = TowerManager.select_tower(1)
	print(tower)

func _process(delta: float) -> void:
	global_position = get_global_mouse_position()
	if Input.is_action_just_pressed("LMB") && placable && Manager.adjust_funds(-tower.get_meta("price")):
		var new_tower = tower.duplicate()
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
