extends Control

onready var startBtn : = get_node("startBtn")

onready var quitBtn : = get_node("quitBtn")


func _ready():
	startBtn.connect("pressed", self, "_on_btn_pressed", [Globals.prevScene])
	quitBtn.connect("pressed", self, "_on_quitBtn_btn_pressed")
	
func _physics_process(delta: float) -> void:
	if !$menuBgs.playing:
		$menuBgs.play()

func _on_btn_pressed(scene_to_load):
	Globals.blueOrbs = 0
	$btnClick.play()
	yield($btnClick, "finished")
	get_tree().change_scene(scene_to_load)
	
func _on_quitBtn_btn_pressed():
	$btnClick.play()
	yield($btnClick, "finished")
	get_tree().quit()
