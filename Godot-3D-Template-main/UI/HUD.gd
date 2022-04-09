extends Control

func _ready():
	Global.update_score(0)

func update_score():
	$Score.text = str(Global.score)

