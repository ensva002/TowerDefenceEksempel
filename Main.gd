extends Node2D

@export var enemycount: int = 10
@export var enemyType: PackedScene
@export var enemyCoolDown: float = 1
@export var lives: int = 3
@export var startingFunds: int = 10

var ghost = preload("res://ghost.tscn")
signal cancel_placement

@onready var enemyTimer = $EnemyTimer
@onready var enemyPath = $Path2D
@onready var enemyStart = enemyPath.curve.get_point_position(0)

func _ready() -> void:
	enemyTimer.wait_time = enemyCoolDown
	Manager.lives = lives
	Manager.enemiesTotal = enemycount
	Manager.adjust_funds(startingFunds)

func _on_button_pressed() -> void:
	emit_signal("cancel_placement")
	var ghostInst = ghost.instantiate()
	cancel_placement.connect(ghostInst.on_cancel_placement)
	add_child(ghostInst)
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("RMB"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		emit_signal("cancel_placement")


func _on_enemy_timer_timeout() -> void:
	var enemyInst = enemyType.instantiate()
	enemyInst.global_position = enemyStart
	enemyPath.add_child(enemyInst)
	enemycount -= 1
	if enemycount <= 0:
		enemyTimer.stop()
