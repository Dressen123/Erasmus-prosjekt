extends CharacterBody2D

var speed: float = 65
var attacking = false
var direction = "down"

func _ready():
	$weapon/sword.visible = false
	$weapon/sword/swordCollision.disabled = false

func input():
	var movement = Input.get_vector("left", "right", "up", "down")
	velocity = movement * speed
	update_animation(movement)

	if Input.is_action_just_pressed("interact"):
		$swordAnimation.play("attack" + direction)  
		attacking = true
		await $swordAnimation.animation_finished
		attacking = false

	if attacking:
		$weapon/sword.visible = true
		$weapon/sword/swordCollision.disabled = false
	else:
		$weapon/sword.visible = false
		$weapon/sword/swordCollision.disabled = true

func update_animation(movement):
	if movement.length() == 0:
		$playerAnimation.play("idle")
	else:
		if movement.x > 0:
			direction = "right"
		elif movement.x < 0:
			direction = "left"
		elif movement.y < 0:
			direction = "up"
		elif movement.y > 0:
			direction = "down"
		$playerAnimation.play("run")

func _physics_process(delta):
	input()
	move_and_slide()
