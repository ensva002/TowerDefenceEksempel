@tool
extends Area2D

@onready var gun = $Gun
@onready var tip = $Gun/Tip
@onready var shootingRange = $Range
@onready var fireTimer = $FireTimer
@onready var audio = $AudioStreamPlayer

var towerRange
var damage
var rateOfFire

var target
var drawTracer

func _ready() -> void:
	$Range/RangeShape.shape.radius = towerRange
	fireTimer.wait_time = rateOfFire

func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		$Range/RangeShape.shape.radius = towerRange
		queue_redraw()
		
	if !target && shootingRange.get_overlapping_areas().size() > 0:
		var threat = 0
		var finalTarget
		for potentialTarget in shootingRange.get_overlapping_areas():
			if potentialTarget.get_parent().progress > threat:
				finalTarget = potentialTarget
				threat = potentialTarget.get_parent().progress
		target = finalTarget.get_parent()
		
	
	if target:
		gun.look_at(target.position)
		gun.rotate(deg_to_rad(90))

func _draw() -> void:
	draw_circle(Vector2.ZERO,towerRange,Color(0,0,1,0.1))
	if drawTracer:
		draw_line(to_local(tip.global_position),to_local(target.global_position),"white",1,true)
	

func _on_range_area_exited(area: Area2D) -> void:
	if area.get_parent() == target:
		target = null


func _on_fire_timer_timeout() -> void:
	if target:
		target.health -= 1
		audio.pitch_scale = 1
		audio.pitch_scale += randf_range(-0.1,0.1)
		audio.play()
		drawTracer = true
		queue_redraw()
		await get_tree().create_timer(0.05).timeout
		drawTracer = false
		queue_redraw()
	
