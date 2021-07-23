extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var playerpos = Vector3()

var mode = "singleplayer"
var multiplayerpositions = [Vector3(), Vector3()]
var level = "res://scenes/Level0.tscn"

var points = 0
var score = 0

var highscore = 0

var savefile = "user://highscore.save"


# Called when the node enters the scene tree for the first time.
func _ready():
	load_score()
	pass # Replace with function body.

func save_score():
	var file = File.new()
	file.open(savefile, File.WRITE)
	file.store_var(highscore)
	file.close()

func load_score():
	var file = File.new()
	if file.file_exists(savefile):
		file.open(savefile, File.READ)
		highscore = file.get_var()
		file.close()
	else:
		highscore = 0
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
