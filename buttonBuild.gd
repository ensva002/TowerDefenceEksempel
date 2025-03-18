extends Button

@export var tower_type: int = 0
signal btn_build(id)

func _on_pressed() -> void:
	emit_signal("btn_build",tower_type)
