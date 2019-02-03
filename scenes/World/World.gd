extends Node2D

# Move all this networking stuff to a network controller node?
# NETWORKING
var my_id
var my_info = {} 
var peer_infos = {my_id = my_info}

func _ready():
	get_tree().connect("network_peer_connected", self, "_peer_connected") 
	get_tree().connect("network_peer_disconnected", self, "_peer_disconnected")
	
	my_id = get_tree().get_network_unique_id() # Keep as int, only convert for node names
	my_info[name] = global.player_name
	new_player(my_id, my_info)

func _peer_connected(id):
	rpc_id(id,"register_peer", my_id, my_info)
	
	# hehe
	$Label.text = peer_infos[id][name] + " has joined"

func _peer_disconnected(id):
	peer_infos.erase(id)
	remove_child(get_node(str(id))) # Memory leak, make delete_player(id)?
	
	# hehe
	$Label.text = peer_infos[id][name] + " has left"

remote func register_peer(id, info):
	peer_infos[id] = info
	new_player(id, info)

func new_player(id, info):
	var player = preload("res://scenes/Player/Player.tscn").instance()
	player.init(id, info)
	add_child(player)

# Move to some sort of player controller?
func _physics_process(delta):
	get_node(str(my_id)).handle_movement()
	