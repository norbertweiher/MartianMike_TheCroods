extends Area2D
class_name JumpPad
@onready var JumpPadSprite = $JumpPadSprite
signal JumpPadTriggered
@export var padjumpforce = 300

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body is Player:
		JumpPadSprite.play("Jump")
		emit_signal("JumpPadTriggered")
		print(padjumpforce)
		body.jump(padjumpforce)


func _on_jump_pad_sprite_animation_finished():
	pass # Replace with function body.


func _on_body_exited(body):
	if body is Player:
		JumpPadSprite.play("Idle")
