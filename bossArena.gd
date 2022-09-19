extends Node2D


func _physics_process(delta) -> void:
	if !$normalEnemy:
		var t = Timer.new()
		t.set_wait_time(1)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		get_tree().change_scene("res://won.tscn")
		t.queue_free()
