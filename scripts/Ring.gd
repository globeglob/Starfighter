extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var largeexplosion = preload("res://scenes/LargeExplosion.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	$Area.connect("body_entered", self, "_player_entered")
	pass # Replace with function body.

func _player_entered(body):
	var i = largeexplosion.instance()
	i.transform.origin = transform.origin
	i.emitting = true
	get_parent().add_child(i)
	queue_free()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
