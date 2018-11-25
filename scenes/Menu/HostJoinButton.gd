extends Button

const PORT = 4242
const MAX_PLAYERS = 8

var peer

func _pressed():
	# TODO: close server / client first
	var input = $"../IPTextEdit".get_line(0)
	if input == "":
		host()
	else:
		join(input)
	# TODO: change scene if success
	# test change
	get_tree().change_scene("res://scenes/World/World.tscn")

func host():
	peer = NetworkedMultiplayerENet.new()
	peer.create_server(PORT, MAX_PLAYERS)
	get_tree().set_network_peer(peer)

func join(input):
	peer = NetworkedMultiplayerENet.new()
	peer.create_client(input, PORT)
	get_tree().set_network_peer(peer)