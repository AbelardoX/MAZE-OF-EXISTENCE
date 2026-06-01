// feather disable GM2017
var _moving = false;
// Variável para controlar a velocidade do player
var _current_speed = global.speed_player;
var _current_image_speed = 1; // Velocidade padrão da animação

// Se a tecla Shift estiver pressionada, reduz a velocidade
if (keyboard_check(vk_shift)) {
    _current_speed = global.speed_player * 0.5; // Reduz a velocidade do player
    _current_image_speed = 0.3; // Reduz a velocidade da animação (ajuste conforme necessário)
} else {
    _current_image_speed = 1; // Volta à velocidade normal da animação
}

// Controle de movimento
var _h_move = 0;
var _v_move = 0;

if (keyboard_check(vk_left) || keyboard_check(ord("A"))) {
    _h_move = -_current_speed;
	sprite_index = spr_player_esquerda;
        _moving = true;
} else if (keyboard_check(vk_right) || keyboard_check(ord("D"))) {
    _h_move = _current_speed;
	sprite_index = spr_player_direita;
        _moving = true;
}

if (keyboard_check(vk_up) || keyboard_check(ord("W"))) {
    _v_move = -_current_speed;
	 sprite_index = spr_player_cima;
        _moving = true;
} else if (keyboard_check(vk_down) || keyboard_check(ord("S"))) {
    _v_move = _current_speed;
	sprite_index = spr_player_baixo;
        _moving = true;
}

// Atualiza a posição do player
x += _h_move;
y += _v_move;

// Atualiza a animação do player se ele estiver se movendo
if (_moving) {
	
	image_speed = _current_image_speed; // Define a velocidade da animação baseada na velocidade atual
	show_debug_message(image_speed);
} else {
    image_speed = 0; // Para a animação do player
    image_index = 0; // Opcional: redefine para o primeiro quadro da animação
}





if (keyboard_check_pressed(vk_space) && bombs > 0) {
    bombs -= 1;

    var _player_x = floor(x / global._cell_size);
    var _player_y = floor(y / global._cell_size);

    var _directions = [[0, -1], [0, 1], [-1, 0], [1, 0]]; // Direções de cima, baixo, esquerda e direita

    for (var _i = 0; _i < array_length(_directions); _i++) {
        var _dx = _directions[_i][0];
        var _dy = _directions[_i][1];
        var _nx = _player_x + _dx;
        var _ny = _player_y + _dy;
  
        if (_nx > 0 && _nx < global.maze_width && _ny > 0 && _ny < global.maze_height) {
            var _grid_value = ds_grid_get(global.maze, _nx, _ny);
            show_debug_message("Grid Value at NX: " + string(_nx) + ", NY: " + string(_ny) + " is " + string(_grid_value));

            if (_grid_value == 0) {
                show_debug_message("Wall detected at NX: " + string(_nx) + ", NY: " + string(_ny) + ". Attempting to destroy.");
                ds_grid_set(global.maze, _nx, _ny, 1);

                var _wall_instance = instance_position(_nx * global._cell_size + global._cell_size / 2, _ny * global._cell_size + global._cell_size / 2, obj_wall);
                
                if (_wall_instance != noone) {
                    show_debug_message("Wall destroyed at NX: " + string(_nx) + ", NY: " + string(_ny));
                    
                    with (_wall_instance) {
                        instance_destroy();
                    }

                    instance_create_layer(_nx * global._cell_size, _ny * global._cell_size, "Instances", obj_floor);
                    instance_create_layer(_nx * global._cell_size + global._cell_size / 2, _ny * global._cell_size + global._cell_size / 2, "Layer_Player", obj_explosion);

                    // Verifica as paredes ao redor da parede destruída
                    var _adj_directions = [[0, -1], [0, 1], [-1, 0], [1, 0]]; // Cima, baixo, esquerda, direita
                    
                    for (var _j = 0; _j < array_length(_adj_directions); _j++) {
                        var _adj_dx = _adj_directions[_j][0];
                        var _adj_dy = _adj_directions[_j][1];
                        var _adj_nx = _nx + _adj_dx;
                        var _adj_ny = _ny + _adj_dy;

                        // Verifica se a parede adjacente está dentro dos limites
                        if (_adj_nx > 0 && _adj_nx < global.maze_width && _adj_ny > 0 && _adj_ny < global.maze_height) {
                            var _adj_wall_instance = instance_position(_adj_nx * global._cell_size + global._cell_size / 2, _adj_ny * global._cell_size + global._cell_size / 2, obj_wall);
                            if (_adj_wall_instance != noone) {
                                
                                // Verificar se não há paredes coladas embaixo (verifica a posição imediatamente abaixo)
                                var _below_adj_ny = _adj_ny + 1; // Verificar a parede imediatamente abaixo
                                if (_below_adj_ny < global.maze_height) {
                                    var _below_adj_wall_instance = instance_position(_adj_nx * global._cell_size + global._cell_size / 2, _below_adj_ny * global._cell_size + global._cell_size / 2, obj_wall);

                                    // Se não houver parede embaixo, troca a sprite para spr_parede_cima
                                    if (_below_adj_wall_instance == noone) {
                                        with (_adj_wall_instance) {
                                            sprite_index = spr_parede;
                                        }
                                        show_debug_message("Adjacent wall at NX: " + string(_adj_nx) + ", NY: " + string(_adj_ny) + " has been changed to spr_parede_cima.");
                                    }
                                }
                            }
                        }
                    }
                } else {
                    show_debug_message("Wall instance not found at NX: " + string(_nx) + ", NY: " + string(_ny));
                }
            } else {
                show_debug_message("No wall to destroy at NX: " + string(_nx) + ", NY: " + string(_ny));
            }
        } else {
            show_debug_message("Position out of bounds - NX: " + string(_nx) + ", NY: " + string(_ny));
        }
    }
}
