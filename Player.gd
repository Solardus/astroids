extends KinematicBody2D



# Declare member variables here. Examples:
var Explosion = preload("res://Explosion.tscn")
var ExplosionSound = preload ("res://Sounds/270311__littlerobotsoundfactory__explosion-03.wav")
var rot_speed = 2.5
var thrust = 500
var max_vel = 400
var friction = 0.65

var rot = 0
var pos = Vector2()
var vel = Vector2()
var acc = Vector2()

var Bullet = preload("res://Bullet.tscn")
var canfire = true
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():#start function
	var screen_size = get_viewport_rect().size
	position = screen_size / 3
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):#update function
	
	if Input.is_action_pressed("Move_Right"):
		rot += rot_speed * delta
	if Input.is_action_pressed("Move_Left"):
		rot -= rot_speed * delta
	if Input.is_action_pressed("Move_Up"):
		acc = Vector2(thrust, 0).rotated(rot)
	else:
		acc = Vector2(0,0)
		
	acc += vel* -friction
	vel += acc* delta
	pos += vel * delta
	
	position = pos;
	rotation = rot
	
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
#	var direction = Vector2()
#	if Input.is_action_pressed("Move_Up"):
#		direction+=Vector2(0,-1)
#	if Input.is_action_pressed("Move_Down"):
#		direction+=Vector2(0,1)
#	if Input.is_action_pressed("Move_Left"):
#		direction+=Vector2(-1,0)
#	if Input.is_action_pressed("Move_Right"):
#		direction+=Vector2(1,0)
#	move_and_slide(direction*100)
		pass


func _on_Area2D_body_entered(body):
	if body.get_filename() == "res://Astroid.tscn" || body.get_filename() == "res://MiniAstroid.tscn":
		#GlobalControl.gameOver()
		get_node("/root/MainRoot/CanvasLayer/Control").gameOver()
		var explosion = Explosion.instance()
		get_tree().get_root().add_child(explosion)
		explosion.position = get_global_position()
		queue_free()
	

