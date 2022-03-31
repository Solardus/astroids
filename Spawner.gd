extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const Astroid = preload ("res://Astroid.tscn")
var timer
# Called when the node enters the scene tree for the first time.
func _ready():
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = 0.5
	timer.one_shot = false
	timer.connect("timeout",self,"onTimeout")
	timer.start()

func onTimeout():
	spawn()

func spawn():
	var astroid = Astroid.instance()
	astroid.position = Vector2(0,0)
	get_tree().root.add_child(astroid)
