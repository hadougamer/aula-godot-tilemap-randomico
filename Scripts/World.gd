extends Node2D

# Percentual de caminho
export var path_percent=0 #desligado

# Numero de Tile Sets
const tileset_count = 8

# Index of path tile
const path_index = 3

# Nosso tilemap
onready var tm:TileMap = $Map

# Resolução da tela
const screen_size = Vector2(15, 10);

func _ready():
	# Ajuste tamanho da tela
	_setup_screen()
	_generate_tiles()

func _generate_tiles():
	for screen_x in range(0, screen_size.x):
		for screen_y in range(0, screen_size.y):
			#tm.set_cell(screen_x, screen_y, path_index)
			tm.set_cell(screen_x, screen_y, _random_tile_index())

# Indice randomico de tile	
func _random_tile_index():
	var rng = RandomNumberGenerator.new()
	rng.randomize()

	# Define o percentual de caminho
	if path_percent > 0:
		if rng.randi_range(0, 100) < path_percent:
			return path_index;
		else:
			return rng.randi_range(0, (tileset_count-1))
	else:
		return rng.randi_range(0, (tileset_count-1))

func _setup_screen():
	# Seta o tamanho da tela de acordo com a resolução e escala do ladrilho
	var screen_width = (tm.cell_size.x * tm.scale.x)  * screen_size.x
	var screen_height = (tm.cell_size.y * tm.scale.y) * screen_size.y  
	OS.set_window_size(Vector2(screen_width, screen_height))

func _on_Button_pressed():
	_generate_tiles();