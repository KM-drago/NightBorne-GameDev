extends KinematicBody2D

var playerHealth : = 100
var blueOrbs : = 0

var animation_SM
var speed : int = 300
var gravity : = 600
var jumpForce : = 500

var direction = Vector2.RIGHT

var prePY : int = 0


var vel : = Vector2()


onready var playerSprite : = get_node("playerSprite")

func _ready():
	Globals.prevScene = get_tree().current_scene.filename
	animation_SM = $AnimationTree.get("parameters/playback")
	get_node("attack2D/leftColision").disabled = true
	get_node("attack2D/rightColision").disabled = true

func _physics_process(delta: float) -> void:
	var currAnimation = animation_SM.get_current_node()
	vel.x = 0
	
	if !$bgs.playing:
		$bgs.play()
	
	if playerHealth <= 0:
		die()
		return
		
	if get_tree().current_scene.filename == "res://bossArena.tscn":
		if !get_node("/root/bossArena/bossMusic").playing:
			get_node("/root/bossArena/bossMusic").play()
	
	if Input.is_action_just_pressed("attack"):
		attack()
		return
		
	if Input.is_action_pressed("move_left"):
		vel.x -= speed
		playerSprite.flip_h = true
		direction = Vector2.LEFT
#		get_node("attack2D/CollisionShape2D").position.x *= -1
	
	if Input.is_action_pressed("move_right"):
		vel.x += speed
		playerSprite.flip_h = false
		direction = Vector2.RIGHT
#		get_node("attack2D/CollisionShape2D").position.x *= 1
	
	if is_on_floor():
		if vel.x != 0:
			animation_SM.travel("walk")
		else:
			animation_SM.travel("idle")
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
#		animation_SM.travel("idle")		
		vel.y = -jumpForce
		animation_SM.travel("jump")
	
	vel.y += gravity * delta
	if vel.y > 600:
		vel.y = 600	
	
	move_and_slide(vel,Vector2.UP)
	prePY = position.y	
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.is_in_group("envTiles") and prePY == int(position.y):
			vel.y = 50

func takeDamage(dmg):
	$hurt.play()
	playerHealth = playerHealth - dmg
	animation_SM.travel("takeDamage")
	return

func die():
	get_node("playerCollision").disabled = true
	animation_SM.travel("death")
	if !$death.playing:
		$death.play()
#	set_physics_process(false)
	var t = Timer.new()
	t.set_wait_time(2.5)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	#show game over page
	get_tree().change_scene("res://gameOver.tscn")
	t.queue_free()
	
	
func attack():
	if direction == Vector2.LEFT:
		get_node("attack2D/leftColision").disabled = false
	else:
		get_node("attack2D/rightColision").disabled = false
	animation_SM.travel("attack")
	if !$sword.playing:
		$sword.play()
	var t = Timer.new()
	t.set_wait_time(0.1)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	if direction == Vector2.LEFT:
		get_node("attack2D/leftColision").disabled = true
	else:
		get_node("attack2D/rightColision").disabled = true
	t.queue_free()		


func damageEnemy(body):
	body.takeDamage()
