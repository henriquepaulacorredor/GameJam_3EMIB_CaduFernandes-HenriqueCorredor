extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -900.0
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var hud: CanvasLayer = $"../HUD"
@onready var posicao_inicial: Marker2D = $"../PosicaoInicial"

func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("left", "right")
	
	# Inverte o sprite
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true
	
	# Altera a animação
	if is_on_floor():
		if direction == 0:
			animated_sprite_2d.play("idle")
		else:
			animated_sprite_2d.play("walk")
	else:
		animated_sprite_2d.play("jump")
	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func die():
	tomar_dano(1)
# função que recebe a quantidade de dano via parâmetro e aplica à vidas
func tomar_dano(dano:int) -> void:
	GameManager.vidas -= dano
	if GameManager.vidas <= 0:
		# ao invés de printar "Game Over" no Output,
		# levaremos para a cena de Game Over
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")
	else:
		respawn()
	hud.atualizar_vidas()
	
func respawn() -> void:
	position = posicao_inicial.position
