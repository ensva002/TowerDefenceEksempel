extends Node2D

var reset
var sprite
@export var size: float = 0.46
@export var draw_on_top: bool = false
@export var timer: float = 10

func _ready() -> void:
	$Timer.wait_time = timer
	$Timer.start()
	sprite = $bloodSprite
	sprite.region_rect = Rect2(randi_range(0,6)*256,0,256,256)
	sprite.rotation = deg_to_rad(randf_range(1,365))
	sprite.scale = Vector2(size,size)
	if draw_on_top:
		z_index = 20

func _process(_delta: float) -> void:
	if reset:
		sprite.modulate = Color(0.837,0.081,0.092,$Timer.time_left/$Timer.wait_time)
		

func _on_timer_timeout() -> void:
	if !reset:
		reset = true
		$Timer.start()
	else:
		queue_free()
