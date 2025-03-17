extends PathFollow2D

@export var max_health: int = 10 
@export var speed: float = 100
@export var reward: int = 1
var prev_health
var health
var color
var blood = preload("res://blood.tscn")


func _ready() -> void:
	max_health += randi_range(0,max_health/2) #random bare for variasjon under testing, fjern senere
	health = max_health
	prev_health = health
	

func _process(delta: float) -> void:
	progress += speed*delta
	if progress_ratio == 1.0:
		Manager.reduce_lives(1)
		progress_ratio = 0.0
	color = float(health)/float(max_health)
	modulate = Color.from_hsv(0,1-color,1)
	if health<prev_health:
		var bloodInst = blood.instantiate()
		bloodInst.global_position = global_position
		if health <= 0:
			get_tree().current_scene.add_child(bloodInst)
			Manager.enemy_killed(1)
			Manager.adjust_funds(reward)
			queue_free()
		else:
			prev_health = health
			bloodInst.size = 0.2
			bloodInst.draw_on_top = true
			bloodInst.timer = 0.2
			get_tree().current_scene.add_child(bloodInst)
	
