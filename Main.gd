extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(PackedScene) var enemy_scene
var score

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	new_game()



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func game_over():
	print("Game Over!")
	$EnemyTimer.stop()

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()


func _on_StartTimer_timeout():
	$EnemyTimer.start()


func _on_EnemyTimer_timeout():
	# Create a new instance of the Mob scene.
	var enemy = enemy_scene.instance()

	# Choose a random location on Path2D.
	var enemy_spawn_location = get_node("EnemyPath/EnemySpawnLocation")
	enemy_spawn_location.offset = randi()

	# Set the enemy's direction perpendicular to the path direction.
	var direction = enemy_spawn_location.rotation + PI / 2

	# Set the enemy's position to a random location.
	enemy.position = enemy_spawn_location.position

	# Add some randomness to the direction.
	direction += rand_range(-PI / 4, PI / 4)
	enemy.rotation = direction

	# Choose the velocity for the enemy.
	var velocity = Vector2(rand_range(150.0, 250.0), 0.0)
	enemy.linear_velocity = velocity.rotated(direction)

	# Spawn the enemy by adding it to the Main scene.
	add_child(enemy)
