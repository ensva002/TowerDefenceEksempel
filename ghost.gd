extends Area2D

var tower = preload("res://tower.tscn")
var placable
var overlapping
var price = 5

func _process(delta: float) -> void:
	global_position = get_global_mouse_position()
	if Input.is_action_just_pressed("LMB") && placable && Manager.adjust_funds(-price):
		var towerInst = tower.instantiate()
		towerInst.global_position = global_position
		get_tree().current_scene.add_child(towerInst)
		
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
