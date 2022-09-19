extends KinematicBody2D

var animation_ene_SM
var speed : int = 200
var gravity : = 600

export var dmg_output : = 10

export var enemyHealth : = 20

var chaseFlag : = 0
var attackFlag : = 0

var attackConstraint : = 90

var randLookContraint = 120

var vel : = Vector2()

var player = null

var blueOrb_pck = preload("res://blueOrb/blueOrb.tscn")

onready var normalEnemySprite : = get_node("normalEnemySprite")

func _ready():
	animation_ene_SM = $AnimationTree.get("parameters/playback")

func _physics_process(delta: float) -> void:
	var randIntForLook = range(1,101)[randi()%range(1,101).size()]
	var currAnimation = animation_ene_SM.get_current_node()
	vel.x = 0
#	vel.y = 600

	if enemyHealth <= 0:
		die()
		return
	
	if chaseFlag == 1:
		var target = player.position
		vel = (target - position).normalized() * speed
	vel.y = 600
	
	if attackFlag == 1 and attackConstraint <= 0:
			animation_ene_SM.travel("attack")
			$dagger.play()
			attackPlayer(player)
			attackConstraint = 90
			return

	if vel.x == 0:
		if randIntForLook % 2 == 0 and randLookContraint <= 0:
			if normalEnemySprite.flip_h == true:
				normalEnemySprite.flip_h = false
			else:
				normalEnemySprite.flip_h = true
			randLookContraint = 120
	
	if vel.x < 0:
		normalEnemySprite.flip_h = true
	elif vel.x > 0:
		normalEnemySprite.flip_h = false
	

	randLookContraint = randLookContraint - 1
	attackConstraint = attackConstraint - 1
	if is_on_floor():
		if vel.x != 0:
			animation_ene_SM.travel("run")
		else:
			animation_ene_SM.travel("idle")
	
	move_and_slide(vel,Vector2.UP)


func takeDamage():
	enemyHealth = enemyHealth - 10
	animation_ene_SM.travel("takeDamage")
	return

func die():
	animation_ene_SM.travel("death")
	set_physics_process(false)
	get_node("neCollision").disabled = true
	normalEnemyDestroyTimer(1)
	var blueOrb = blueOrb_pck.instance()
	blueOrb.position = position
	get_parent().add_child(blueOrb, true)
	
func attackPlayerFlagSet(body):
	attackFlag = 1
	player = body
	
func attackPlayerFlagRemove(body):
	attackFlag = 0

func attackPlayer(player):
	player.takeDamage(dmg_output)
	
func chasePlayer(body):
	chaseFlag = 1
	player = body

func stopChasingPlayer(body):
	chaseFlag = 0
	player = null

func normalEnemyDestroyTimer(s):	
	var t = Timer.new()
	t.set_wait_time(s)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()
	queue_free()
