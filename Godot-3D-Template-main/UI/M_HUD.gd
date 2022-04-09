extends Control

onready var player1 = get_node("/root/Multiplayer/Player1")
onready var instructions = $Instructions

var player_health = 100

func _ready():
	$P1Health.text = str(player_health)

func update_health(d):
	player_health -= d
	$P1Health.text = str(player_health)



func _on_Instructions_Timer_timeout():
	instructions.hide()
