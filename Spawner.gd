extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const Astroid = preload ("res://Astroid.tscn")
var timer
var rng = RandomNumberGenerator.new()



# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = 0.5
	timer.one_shot = false
	timer.connect("timeout",self,"onTimeout")
	timer.start()

func onTimeout():
	spawn()

func spawn():
	var playerPos = get_tree().get_nodes_in_group("Player")[0].get_global_position()
	var screenSize = get_viewport().get_visible_rect().size
	var pmx = 1
	var pmy = 1
	if rng.randf_range(0, 1)<0.5:
		pmx = -1
	if rng.randf_range(0, 1)<0.5:
		pmy = -1
	var my_random_numberx = rng.randf_range(200, 300)*pmx
	var my_random_numbery = rng.randf_range(200, 300)*pmy
	var astroid = Astroid.instance()
	astroid.position = (Vector2(playerPos.x+my_random_numberx +  (pmx*screenSize.x/2),playerPos.y+my_random_numbery+ (pmy*screenSize.y/2)));
	get_tree().root.add_child(astroid)
