extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.score > Global.highscore:
		Global.highscore = Global.score
	$Label2.text = str(Global.score)
	$Label4.text = str(Global.highscore)
	Global.score = 0
	Global.save_score()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("fire"):
		get_tree().change_scene("res://scenes/Level1.tscn")
	elif Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
#	pass
