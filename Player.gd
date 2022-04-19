extends KinematicBody2D



# Declare member variables here. Examples:
var Bullet = preload("res://Bullet.tscn")
var canfire = true
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():#start function
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):#update function
	look_at(get_global_mouse_position())
	if Input.is_action_pressed("Fire") && canfire:
		var bulletinstance = Bullet.instance()
		bulletinstance.position = get_node("FirePoint").global_position
		bulletinstance.rotation_degrees = rotation_degrees
		bulletinstance.apply_impulse(Vector2(),Vector2(1000,0).rotated(rotation))
		get_tree().root.add_child(bulletinstance)
		canfire = false
		yield(get_tree().create_timer(0.2),"timeout")
		canfire = true 

func _physics_process(delta):
	var direction = Vector2()
	if Input.is_action_pressed("Move_Up"):
		direction+=Vector2(0,-1)
	if Input.is_action_pressed("Move_Down"):
		direction+=Vector2(0,1)
	if Input.is_action_pressed("Move_Left"):
		direction+=Vector2(-1,0)
	if Input.is_action_pressed("Move_Right"):
		direction+=Vector2(1,0)
	
	
	move_and_slide(direction*100)


func _on_Area2D_body_entered(body):
	print(body.get_filename())
#	get_tree().paused = true

