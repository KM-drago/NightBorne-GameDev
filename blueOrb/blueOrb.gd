extends StaticBody2D



func pickUp(body):
	$AnimatedSprite.play("pickup")
	var t = Timer.new()
	t.set_wait_time(1)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()
	queue_free()
	body.blueOrbs = body.blueOrbs + 1 
