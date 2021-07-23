extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var peer = NetworkedMultiplayerENet.new()
var ip = "192.168.0.117"
var port = 8080

# Called when the node enters the scene tree for the first time.
func _ready():
	peer.create_client(ip, port)
	get_tree().network_peer = peer
	pass # Replace with function body.

remote func set_transform(data):
	$EnemyPlayer.transform = data


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rpc_unreliable("set_transform", $Player.transform)
#	pass
