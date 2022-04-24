extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$GameOverLabel.visible = false
	var playerScore = $playerScore
	playerScore.text = str(MyVars.getScore())
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$playerScore.text = str(MyVars.getScore())

func gameOver():
	$GameOverLabel.visible = true
