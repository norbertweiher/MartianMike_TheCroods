extends Area2D
@onready var new_start_position = $Marker2D

signal check_point_reached(checkpoint_position)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	check_point_reached.emit(new_start_position.global_position)
