extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var spawn = 0
var spawndelay = 10
var startdelay = 5

var enemybasic = preload("res://scenes/EnemyBasic.tscn")
var enemyboss = preload("res://scenes/EnemyBoss.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.points >= 10:
		Global.points = 0
		var i = enemyboss.instance()
		i.transform.origin.x = rand_range(-100,100)
		i.transform.origin.y = rand_range(-20,20)
		i.transform.origin.z = rand_range(-100, 100)
		$Sun/Enemies.add_child(i)
		
	if startdelay > 0:
		startdelay -= delta
	else:
		if spawn > 0:
			spawn -= delta
		else:
			spawn = spawndelay
			var i = enemybasic.instance()
			i.transform.origin.x = rand_range(-100,100)
			i.transform.origin.y = rand_range(-20,20)
			i.transform.origin.z = rand_range(-100, 100)
			$Sun/Enemies.add_child(i)
#	pass
