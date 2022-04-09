extends Area

#onready var anim = $AnimationPlayer

#func _ready():
	#anim.play("Spin")

func _on_key_body_entered(body):
	if body.name == "Player":
		$Pickup.play()
		var exit = get_node_or_null("/root/Game/Maze/Exit")
		if exit != null:
			exit.unlock()
			queue_free()
