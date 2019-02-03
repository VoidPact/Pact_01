extends Control

const PORT = 4242
const MAX_PLAYERS = 8

var peer

func _on_HostButton_pressed():
	# TODO: close old server / client first?
	peer = NetworkedMultiplayerENet.new()
	peer.create_server(PORT, MAX_PLAYERS)
	get_tree().set_network_peer(peer)
	# TODO: test sucessfulhost
	get_tree().change_scene("res://scenes/World/World.tscn")

func _on_JoinButton_pressed():
	# TODO: close old server / client first?
	var input = $"../IPEdit".get_line(0)
	peer = NetworkedMultiplayerENet.new()
	peer.create_client(input, PORT)
	get_tree().set_network_peer(peer)
	# TODO: test sucessful join
	get_tree().change_scene("res://scenes/World/World.tscn")

func _on_NameEdit_text_changed():
	global.player_name = $"NameEdit".text