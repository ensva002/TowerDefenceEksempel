extends Node2D


func _ready() -> void:
	var tween = get_tree().create_tween()

	tween.tween_property(self, "position", Vector2(global_position.x,global_position.y-50), 0.3)
	tween.parallel().tween_property($Sprite, "modulate", Color(1,1,1,0), 0.15).set_delay(0.15)
	tween.tween_callback(self.queue_free)
