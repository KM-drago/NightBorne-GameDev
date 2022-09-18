extends StaticBody2D


var attackFlag = 0
var attackConstraint = 0

onready var player = null


func _physics_process(delta) -> void:
	if attackFlag == 1 and attackConstraint <= 0:
			player.takeDamage(10)
			attackConstraint = 60
			return
	attackConstraint = attackConstraint - 1

func attackPlayerFlagSet(body):
	attackFlag = 1
	player = body
	
func attackPlayerFlagRemove(body):
	attackFlag = 0
	player = null	
