extends Area2D
signal picked_up_coin()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	picked_up_coin.emit()
	queue_free() # Replace with function body.
