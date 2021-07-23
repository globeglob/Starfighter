extends StaticBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var largeexplosion = preload("res://scenes/LargeExplosion.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func hit():
	get_parent().get_parent().target_shot()
	var i = largeexplosion.instance()
	i.transform.origin = transform.origin
	i.emitting = true
	get_parent().get_parent().add_child(i)
	get_parent().remove_child(self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
