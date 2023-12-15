extends Area2D
const bulletPath = preload('res://Bullet.tscn')


# Declare member variables here. Examples:
var alive = true
export var speed = 200 # How fast the player will move (pixels/sec).
export var velocity = Vector2.ZERO # The player's movement vector.
var bulletVelocity = Vector2.ZERO
var screen_size # Size of the game window.
signal hit


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	alive = true
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		bulletVelocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		bulletVelocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		bulletVelocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		bulletVelocity.y -= 1
	bulletVelocity = bulletVelocity.normalized()
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
		rotation = velocity.angle()
	else:
		$AnimatedSprite.stop()
		
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	if Input.is_action_just_pressed("ui_accept"):
		if alive:
			shoot()
	#$Node2D.look_at(get_global_mouse_position())


func _on_Player_body_entered(body):
	hide() # Player disappears after being hit.
	emit_signal("hit")
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)
	alive = false
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	
func shoot():
	var bullet = bulletPath.instance()
	get_parent().add_child(bullet)
	bullet.position = $Node2D/Position2D.global_position
	bullet.velocity = bulletVelocity
