extends CharacterBody2D
class_name Player

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var animation=$AnimatedSprite2D


func ready():
	pass

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("ui_left"):
		$AnimatedSprite2D.play("Right_run")
	elif Input.is_action_pressed("ui_right"):
		$AnimatedSprite2D.play("Left_run")
	elif  Input.is_action_pressed("ui_up"):
		$AnimatedSprite2D.play("Forward_run")
	elif Input.is_action_pressed("ui_down"):
		$AnimatedSprite2D.play("Back_run")
	else:
		$AnimatedSprite2D.play("Idle")
