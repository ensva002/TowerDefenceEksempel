extends HBoxContainer

var lifegui = preload("res://lifeGui.tscn")
var lifeGuiInst
var lifeContainer
var fundsLabel

func _ready() -> void:
	Manager.connect("lives_lost", Callable(self, "on_lives_lost"))
	Manager.connect("new_funds", Callable(self, "on_new_funds"))
	lifeContainer = $VBoxContainer/LifeContainer
	fundsLabel = $VBoxContainer/FundsContainer/Funds
	for life in get_tree().current_scene.lives:
		var lifeGuiInst = lifegui.instantiate()
		lifeContainer.add_child(lifeGuiInst)

func on_lives_lost(amount):
	var allHearts = lifeContainer.get_children()
	while amount > 0:
		amount -= 1
		if allHearts.size() > 0:
			allHearts[0].queue_free()
	
func on_new_funds(amount):
	fundsLabel.text = str(amount)
	
