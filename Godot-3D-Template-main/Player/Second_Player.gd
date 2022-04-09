extends KinematicBody

onready var Camera = $Pivot/Camera					# the camera attached to the player (in a "pivot" node so we rotate the entire player left and right but only move its "head" up and down)

var gravity = -30									# downward (-y) acceleration applied on every frame
var max_speed = 6									# velocity multiplier applied to every movement
var mouse_sensitivity = 0.002						# translating the mouse XY coordinates into angular (radian) movement
var mouse_range = 1.2								# Clamp to about a 140 degree range of motion
var velocity = Vector3()
var rotation_speed = 0.05

var health = 100
var damage = 10
var max_health = 100

onready var rc = $Pivot/RayCast
onready var flash = $Pivot/blasterG/Flash
onready var Decal = preload("res://Weapons/Decal.tscn")
onready var anim_play = $Pivot/Camera/AnimationPlayer
onready var health_hud = get_node("/root/Multiplayer/Container/V2/HUD")

func _ready():
	$Pivot/Camera.current = true

func get_input():
	var input_dir = Vector3()						# Collect all the inputs into a single vector
	if Input.is_action_pressed("forward_2"):			# all the inputs are directions relative to where the camera is currently facing
		input_dir += -Camera.global_transform.basis.z
		anim_play.play("Headbob")
	if Input.is_action_pressed("back_2"):
		input_dir += Camera.global_transform.basis.z
		anim_play.play("Headbob")
	if Input.is_action_pressed("left_2"):				# strafe left and right
		rotate_y(rotation_speed)
		#input_dir += -Camera.global_transform.basis.x
		anim_play.play("Headbob")
	if Input.is_action_pressed("right_2"):
		rotate_y(-rotation_speed)
		#input_dir += Camera.global_transform.basis.x
		anim_play.play("Headbob")
	input_dir = input_dir.normalized()				# just get the unit vector (length of 1), which essentially just returns the direction
	return input_dir
	
func _unhandled_input(event):
	pass
	"""
	if event is InputEventMouseMotion:											# if the mouse has moved
		$Pivot.rotate_x(-event.relative.y * mouse_sensitivity)					# up-down motion, applied to the $Pivot
		$Pivot.rotation.x = clamp($Pivot.rotation.x, -mouse_range, mouse_range)	# make sure we can't look inside ourselves :)
		rotate_y(-event.relative.x * mouse_sensitivity)							# left-right motion, applied to the Player
"""

func _physics_process(delta):
	velocity.y += gravity * delta					# apply gravity
	if is_on_floor():
		velocity.y = 0
	var desired_velocity = get_input() * max_speed
	
	velocity.x = desired_velocity.x					# just get the XZ components of the velocity (the y is handled purely by gravity)
	velocity.z = desired_velocity.z
	velocity = move_and_slide(velocity, Vector3.UP, true)
	
	if Input.is_action_just_pressed("shoot_2") and !flash.visible:
		flash.shoot()
		$Gunshot.play()
		var target = ""
		if rc.is_colliding():
			var c = rc.get_collider()
			var decal = Decal.instance()
			rc.get_collider().add_child(decal)
			decal.global_transform.origin = rc.get_collision_point()
			decal.look_at(rc.get_collision_point() + rc.get_collision_normal(), Vector3.UP)
			if c.is_in_group("Enemy"):
				c.queue_free()
				Global.update_score(50)
			if c.has_method("damaged"):
				target = c.get_path()
				c.damaged(damage)
	
func damaged(d):
	health -= d
	$HealthBar.update(health, max_health) 
	health_hud.update_health(10)
	if health <= 0:
		var _scene = get_tree().change_scene("res://UI/FPWin.tscn")
		get_node("/root/Multiplayer").hide()
