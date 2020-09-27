extends Node

var data

func _ready():
	var data_file = File.new()
	data_file.open("res://Data/data.json", File.READ)
	var data_json = JSON.parse(data_file.get_as_text())
	data_file.close()
	data = data_json.result
