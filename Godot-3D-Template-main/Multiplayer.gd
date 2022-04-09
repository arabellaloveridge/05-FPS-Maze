extends Spatial

onready var player1pos = $Player1Pos
onready var player2pos = $Player2Pos

var menu = null

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	
	var player1 = preload("res://Player/First_Player.tscn").instance()
	player1.name = "Player1"
	player1.global_transform = player1pos.global_transform
	$Container/V1/V1.add_child(player1)
	
	var player2 = preload("res://Player/Second_Player.tscn").instance()
	player2.name = "Player2"
	player2.global_transform = player2pos.global_transform
	$Container/V2/V2.add_child(player2)
	
func _unhandled_input(_event):
	if Input.is_action_pressed("menu"):
		if menu == null:
			menu = get_node_or_null("/root/Multiplayer/Menu")
		if menu != null:
			if not menu.visible:
				get_tree().paused = true
				menu.show()
			else:
				get_tree().paused = false
				menu.hide()
