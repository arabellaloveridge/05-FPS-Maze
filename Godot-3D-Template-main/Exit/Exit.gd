extends Area

var locked = true

func _ready():
	$Light.light_color = Color(1,0,0,1)
	
func unlock():
	locked = false
	$Light.light_color = Color(0,1,0,1)

func _on_Exit_body_entered(body):
	if body.name == "Player" and not locked:
		Global.level += 1
		if Global.level == 2:
			get_tree().change_scene("res://Game2.tscn")
		#get_tree().change_scene("res://UI/Win.tscn")
