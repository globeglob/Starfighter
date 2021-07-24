extends KinematicBody

export var max_speed = 10
export var acceleration = 0.6
export var pitch_speed = 1.0
export var roll_speed = 1.1
export var yaw_speed = 1.25  # Set lower for linked roll/yaw
export var input_response = 8.0

var smallexplosion = preload("res://scenes/SmallExplosion.tscn")

var velocity = Vector3.ZERO
var forward_speed = 0
var pitch_input = 0
var roll_input = 0
var yaw_input = 0

var fire = 0
var firedelay = 0.1

var energy = 42
var health = 42
var id = 0

var start_pos = Vector3()

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	start_pos = transform.origin

remote func playerhit():
	hit()

func hit():
	var i = smallexplosion.instance()
	health -= 5
	if health <= 0:
		if Global.mode == "singleplayer":
			get_tree().change_scene("res://scenes/ScoreScreen.tscn")
		elif Global.mode == "multiplayer":
			transform.origin = start_pos
			energy = 42
			health = 42

func get_input(delta):
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()
	if Input.is_action_pressed("boost") and energy > 1:
		max_speed = 30
		acceleration = 1
		forward_speed = lerp(forward_speed, max_speed, acceleration * delta)
		energy -= 20 * delta
	else:
		max_speed = 10
		acceleration = 0.6
	if Input.is_action_pressed("ui_up"):
		forward_speed = lerp(forward_speed, max_speed, acceleration * delta)
	if Input.is_action_pressed("ui_down"):
		forward_speed = lerp(forward_speed, 0, acceleration * delta)
	if Input.is_action_pressed("fire") and fire < 0 and energy > 5:
		energy -= 5
		fire = firedelay
		$Gun1/Beam.visible = true
		$Gun2/Beam.visible = true
		if $RayCast.is_colliding():
			print("shot")
			if $RayCast.get_collider().filename == "res://scenes/EnemyBasic.tscn" or $RayCast.get_collider().filename == "res://scenes/Target.tscn" or $RayCast.get_collider().filename == "res://scenes/EnemyBoss.tscn":
				$RayCast.get_collider().hit()
		yield(get_tree().create_timer(0.1), "timeout")
		$Gun1/Beam.visible = false
		$Gun2/Beam.visible = false
		
		


	pitch_input = lerp(pitch_input,
			Input.get_action_strength("forward") - Input.get_action_strength("backward"),
			input_response * delta)
	roll_input = lerp(roll_input,
			Input.get_action_strength("ui_left") - Input.get_action_strength("ui_right"),
			input_response * delta)
	yaw_input = lerp(yaw_input,
			Input.get_action_strength("left") - Input.get_action_strength("right"),
			input_response * delta)
	# replace the line above with this for linked roll/yaw:
	#yaw_input = roll_input


func _physics_process(delta):
	if $ColorRect.visible:
		$ColorRect.visible = false
	$Label.text = str(Global.score)
	if health < 42:
		health += delta / 10
	if energy < 42:
		energy += delta * 10
	$Display/Viewport/Energy.rect_size.x = energy / 2
	$Display/Viewport/Health.rect_size.x = health / 2
	$Display/Viewport/Node2D.rotation_degrees = -(forward_speed * 3)
	Global.playerpos = transform.origin
	fire -= delta
	get_input(delta)
	if forward_speed > max_speed:
		forward_speed -= delta * 10
	transform.basis = transform.basis.rotated(transform.basis.z, roll_input * roll_speed * delta)
	transform.basis = transform.basis.rotated(transform.basis.x, pitch_input * pitch_speed * delta)
	transform.basis = transform.basis.rotated(transform.basis.y, yaw_input * yaw_speed * delta)
	transform.basis = transform.basis.orthonormalized()
	velocity = -transform.basis.z * forward_speed
	var collision = move_and_collide(velocity * delta)
	#if collision:
	#	hit()
