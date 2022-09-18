extends StaticBody2D

export(String) var next_lvl

func torchTouch(body):
	get_tree().change_scene(next_lvl)
