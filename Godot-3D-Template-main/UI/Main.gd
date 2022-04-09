extends Control

func _ready():
	pass

func _on_SP_pressed():
	get_tree().change_scene("res://Game.tscn")

func _on_Quit_pressed():
	get_tree().quit()


func _on_MP_pressed():
	get_tree().change_scene("res://Multiplayer.tscn")
