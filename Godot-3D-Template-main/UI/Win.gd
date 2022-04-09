extends Control

func _ready():
	final_score()
	
func _on_Play_pressed():
	get_tree().change_scene("res://UI/Main.tscn")


func _on_Quit_pressed():
	get_tree().quit()
	
func final_score():
	$Final_Score.text = "Final score: " + str(Global.score)
