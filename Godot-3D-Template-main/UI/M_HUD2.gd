extends Control

onready var player2 = get_node("/root/Multiplayer/Player2")
onready var instructions = $Instructions

var player_health = 100

func _ready():
	$P2Health.text = str(player_health)

func update_health(d):
	player_health -= d
	$P2Health.text = str(player_health)



func _on_Instructions_Timer_timeout():
	instructions.hide()
