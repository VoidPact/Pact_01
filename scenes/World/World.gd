extends Node2D

# NETWORKING
var my_id
var my_info = {name = "dingus"} 
var peer_infos = {}

func _ready():
	get_tree().connect("network_peer_connected", self, "_peer_connected") 
	get_tree().connect("network_peer_disconnected", self, "_peer_disconnected")
	get_tree().connect("connected_to_server", self, "_my_connected")

func _my_connected():
	rpc("register_peer", my_id, my_info)
	rpc("new_player", my_id, my_info)
	new_player(my_id, my_info)

func _peer_connected(id):
	rpc_id(id,"register_peer", my_id, my_info)
	rpc_id(id,"new_player", my_id, my_info)
	

func _peer_disconnected(id):
	peer_infos.erase(id)
	remove_child(id) # MEMORY LEAK

remote func register_peer(id, info):
	peer_infos[id] = info
	

# INSTANTIATE WORLD
remote func new_player(id, info):
	var player = predload("res://scenes/Player/Player.tscn").instance()
	player.init(id,info)
	add_child(player)
	