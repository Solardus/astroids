extends KinematicBody2D
var Explosion = preload("res://Explosion.tscn")
var ExplosionSound = preload ("res://Sounds/270311__littlerobotsoundfactory__explosion-03.wav")
var Score
var minimap_icon = "mob"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const MiniAstroid = preload("res://MiniAstroid.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	Score = get_node("Control")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var player = get_tree().get_nodes_in_group("Player")[0]
	var direction = (player.position-position).normalized()*50
	move_and_collide(direction*delta)
	rotate(0.05)
	
#var CorrectSound = preload("res://chimes.wav")
#
#func _process(delta: float) -> void:
#    if !$AudioStreamPlayer2D.is_playing():
#        $AudioStreamPlayer2D.stream = CorrectSound
#        $AudioStreamPlayer2D.play()

func _on_Area2D_body_entered(body):
	if "BulletRoot" in body.name:
		queue_free()
		var explosion = Explosion.instance()
		get_tree().get_root().add_child(explosion)
		explosion.position = get_global_position()
		var Miniastroid = MiniAstroid.instance()
		get_tree().get_root().add_child(Miniastroid)
		Miniastroid.position = get_global_position()
		MyVars.addScore()
