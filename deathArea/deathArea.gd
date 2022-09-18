extends StaticBody2D



func deathFromOutOfBounds(body):
	get_tree().change_scene("res://gameOver.tscn")
