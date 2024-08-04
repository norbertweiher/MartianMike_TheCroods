extends Area2D
@onready var ExitAnimSprite = $AnimatedSprite2D

signal end_of_level_reached()

func animate():
	ExitAnimSprite.play("ExitAnim")
	
func _on_body_entered(body):
	end_of_level_reached.emit()
