extends StaticBody2D



func pickUp(body):
	$AnimatedSprite.play("pickup")
	get_node("pickupH/CollisionShape2D").disabled = true
	body.playerHealth = 100
	var t = Timer.new()
	t.set_wait_time(1)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()
	queue_free()
