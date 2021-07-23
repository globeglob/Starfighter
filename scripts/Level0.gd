extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func target_shot():
	print($Targets.get_child_count())
	if $Targets.get_child_count() == 1:
		yield(get_tree().create_timer(2), "timeout")
		Global.level = "res://scenes/Level1.tscn"
		get_tree().change_scene(Global.level)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
