extends Area2D
@onready var ExitAnimSprite = $AnimatedSprite2D

func animate():
	ExitAnimSprite.play("ExitAnim")
