extends Node

var enemiesTotal = 1
var kills = 0
var lives = 1
var funds = 0
signal lives_lost(amount)
signal new_funds(amount)

func enemy_killed(amount: int)-> void:
	kills += amount
	if kills >= enemiesTotal:
		print("You win")

func reduce_lives(amount: int)-> void:
	lives -= amount
	emit_signal("lives_lost",amount)
	if lives <= 0:
		print("You lose")

func adjust_funds(amount:  int, force: bool = false)-> bool:
	var sum = funds + amount
	if sum < 0:
		if force && funds > 0:
			sum = 0
		else:
			return false
	funds = sum
	emit_signal("new_funds",funds)
	return true
