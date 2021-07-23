extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Label2.text = str(Global.highscore)

func _process(delta):
	if Input.is_action_pressed("fire"):
		get_tree().change_scene("res://scenes/Level0.tscn")
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
