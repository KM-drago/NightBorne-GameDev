extends CanvasLayer



var heartArr
var player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().current_scene.get_node("Player")
	heartArr = [$h1,$h2,$h3,$h4,$h5,$h6,$h7,$h8,$h9,$h10]

func _physics_process(delta: float) -> void:
	if (!weakref(player).get_ref()):
		 return
	else:
		for i in range(0,10):
			heartArr[i].hide()
		for i in range(0,player.playerHealth/10):
			heartArr[i].show()
		$blueOrbCount.clear()
		$blueOrbCount.add_text(String(Globals.blueOrbs))
