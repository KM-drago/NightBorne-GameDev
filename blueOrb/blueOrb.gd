extends StaticBody2D



func pickUp(body):
	$AnimatedSprite.play("pickup")
	get_node("pickUpBO/CollisionShape2D").disabled = true
	$energyPickUp.play()
	var t = Timer.new()
	t.set_wait_time(1)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	Globals.blueOrbs = Globals.blueOrbs + 1
	t.queue_free()
	queue_free() 
