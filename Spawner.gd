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
	var my_random_numberx = rng.randf_range(-200, 1000)
	var my_random_numbery = rng.randf_range(-200, 1000)
	var astroid = Astroid.instance()
	astroid.position = Vector2(my_random_numberx,my_random_numbery)
	get_tree().root.add_child(astroid)
