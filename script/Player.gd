extends KinematicBody2D

export (int) var speed = 400
export (int) var jump_speed = -600
export (int) var dash_speed = 800  # Kecepatan dash
export (float) var dash_duration = 0.2  # Durasi dash dalam detik
export (int) var GRAVITY = 1200
export (int) var max_jumps = 2

const UP = Vector2(0, -1)

var velocity = Vector2()
var jumps = 0
var is_dashing = false
var dash_timer = 0

func get_input():
	velocity.x = 0
	if is_on_floor() and Input.is_action_just_pressed('up'):
		jumps = 0
		velocity.y = jump_speed
		jumps += 1
	if not is_on_floor() and jumps < max_jumps and Input.is_action_just_pressed('up'):
		velocity.y = jump_speed
		jumps += 1
	if Input.is_action_just_pressed("ui_select") and not is_dashing:
		is_dashing = true
		dash_timer = dash_duration
	if is_dashing:
		velocity.x = -dash_speed if Input.is_action_pressed('left') else dash_speed
		dash_timer -= get_process_delta_time()
		if dash_timer <= 0:
			is_dashing = false
	if not is_dashing and Input.is_action_pressed('right'):
		velocity.x += speed
	if not is_dashing and Input.is_action_pressed('left'):
		velocity.x -= speed

func _physics_process(delta):
	velocity.y += delta * GRAVITY
	get_input()
	velocity = move_and_slide(velocity, UP)
