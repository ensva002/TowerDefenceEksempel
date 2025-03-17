extends Node

var towerList = []
var ammoList = []


func select_tower(id: int = 0) -> Node2D:
	return towerList[id]

func create_new_ammo():
	pass

func _ready() -> void:
	create_new_tower()
	create_new_tower({
		"sprTurret": preload("res://towerParts/turrets/turretB.tres"),
		"price": 10
	})

func create_new_tower(attributes_inn: Dictionary = {})->Node2D:
		var template = preload("res://tower.tscn")
		var attributes = {
		"sprBase": preload("res://towerParts/bases/baseA.tres"),
		"sprTurret": preload("res://towerParts/turrets/turretA.tres"),
		"ammoType": 0,
		"turnSpeed": 0,
		"fireRate": 1,
		"magazineCapacity": 0,
		"reloadSpeed": 5,
		"damage": 1,  # burde være i ammotype
		"health": 1,
		"price": 5,
		"rangeMax": 500,
		"rangeMin": 0,
		"add_to_list": true
		}
		
		for key in attributes_inn:
			attributes[key] = attributes_inn[key]
		#attributes.merge(attributes_inn)
			
		#mix 'n matcher måter å gjøre ting på for å teste ut
		#touch base
		var towerOut = template.instantiate()
		
		towerOut.get_node("Base").texture = attributes["sprBase"]
		towerOut.get_node("Gun").texture = attributes["sprTurret"]
		towerOut.towerRange = attributes["rangeMax"]
		
		
		for key in attributes:
			if key != "add_to_list":
				towerOut.set_meta(key, attributes[key])
		
		if attributes["add_to_list"]:
			towerList.append(towerOut)
		print(towerList)
		return towerOut
