extends StaticBody2D
@onready var SpawnPosition = $CollisionShape2D/SpawnPosition 
func get_spawn_pos():
	var spawn_position: Vector2
	spawn_position = SpawnPosition.global_position
	return spawn_position
	
func _ready():
	print(get_spawn_pos())
	
