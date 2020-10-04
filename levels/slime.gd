extends KinematicBody2D

const ROCKET = preload("res://levels/rocket.tscn")

var motion = Vector2()
const UP = Vector2(0, -1)
const GRAVITY = 8.5
const MAX_SPEED = 30
var SPEED_ACCEL = 0
const FRICTION = 5
const AIR_DRAG = 3

var MAX_Y = 100
var vx = 0
var vy = 0
var start_y = 0

var jump_period

func _ready():
	vx = 0


func handle_gravity(delta):
	if Input.is_action_pressed("jump"):
		motion.y += GRAVITY
	else:
		motion.y += GRAVITY * 2


func handle_movement():
	var dvx
	
	vx += SPEED_ACCEL
	
	if is_on_floor():
		dvx = FRICTION
	else:
		dvx = AIR_DRAG
	if vx > 0:
		vx = max(vx - dvx, 0)
	elif vx < 0:
		vx = min(vx + dvx, 0)
				
	motion.x = vx


func _physics_process(delta):
			
	handle_gravity(delta)
	handle_movement()
	
	if (motion.y > MAX_Y):
		motion.y = MAX_Y
	if (vx > MAX_SPEED):
		vx = MAX_SPEED
	if (vx < -MAX_SPEED):
		vx = -MAX_SPEED
		
	motion = move_and_slide(motion, UP)
	
	if SPEED_ACCEL > 0:
		if position.x > 320:
			position.x -= 320
			position.y = start_y
	else:
		if position.x < 0:
			position.x += 320
			position.y = start_y


func kill():
	queue_free()

