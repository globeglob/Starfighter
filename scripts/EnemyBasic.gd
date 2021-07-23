extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text
var hp = 3
var smallexplosion = preload("res://scenes/SmallExplosion.tscn")
var largeexplosion = preload("res://scenes/LargeExplosion.tscn")
var projectile = preload("res://scenes/Projectile1.tscn")
var velocity = Vector3()
var forward_speed = 5
var fire = 0
var firedelay = 0.5


# Called when the node enters the scene tree for the first time.
func _ready():
	forward_speed = rand_range(-20, 20)
	pass # Replace with function body.

func die():
	var i = largeexplosion.instance()
	i.transform.origin = transform.origin
	i.emitting = true
	get_parent().add_child(i)
	Global.points += 1
	Global.score += 1
	queue_free()
func hit():
	var i = smallexplosion.instance()
	hp -= 1
	if hp == 0:
		die()
	else:
		i.transform.origin = transform.origin
		i.emitting = true
		get_parent().add_child(i)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if fire < 0:
		fire = firedelay
		var i = projectile.instance()
		i.transform.origin = transform.origin
		i.rotation = rotation
		get_parent().add_child(i)
	else:
		fire -= delta
	look_at(Global.playerpos, Vector3.UP)
	velocity = -transform.basis.x * forward_speed
	move_and_collide(velocity * delta)
#	pass
