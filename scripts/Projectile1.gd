extends Area


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 50
var time = 10


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self, "_body_entered")
	pass # Replace with function body.

func _body_entered(body):
	if body.filename == "res://scenes/Player.tscn":
		body.hit()
	elif not body.filename == "res://scenes/EnemyBasic.tscn":
		queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	transform.origin += -transform.basis.z * delta * speed
	if time > 0:
		time -= delta
	else:
		queue_free()
#	pass
