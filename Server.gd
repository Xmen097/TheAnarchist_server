extends Node

var network = NetworkedMultiplayerENet.new()
var port = 1909
var max_players = 10

func _ready():
	startServer()
	
func startServer():
	network.create_server(port, max_players)
	get_tree().set_network_peer(network)
	print("Server started")
	
	network.connect("peer_connected", self, "_peer_connected")
	network.connect("peer_disconnected", self, "_peer_disconnected")
	
func _peer_connected(player_id):
	print("User" + str(player_id) + " Connected")
	
func _peer_disconnected(player_id):
	print("User" +str(player_id) + " Disconnected")


remote func fetch_data(data_name, requestor):
	var player_id = get_tree().get_rpc_sender_id()
	var data = ServerData.data[data_name]
	rpc_id(player_id, "return_data", data, requestor)
	print("sending " + str(data) + "to player " + str(player_id))
	
remote func move_player(position):
	# Get the id of the RPC sender.
	var id = get_tree().get_rpc_sender_id()
