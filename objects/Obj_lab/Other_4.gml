// feather disable GM2017
// Inicializar variáveis
randomize();
window_set_fullscreen(true);

// Obtém o índice da room atual
var _current_room = room;
var _room_name = room_get_name(room);

if(global.dificuldade >= 7){
global.dificuldade = 1;	
global.tamanho_lab = 128 / global.dificuldade;
}
_cell_size = global._cell_size;
tamanho_lab = global.tamanho_lab;
room_width = 1920;
room_height = 1088;


// Verifica se a largura e a altura são múltiplos de _cell_size
switch (global.dificuldade) {
    case 1:
        room_width = (room_width div tamanho_lab) * _cell_size;
        room_height = (room_height div tamanho_lab - 1) * _cell_size;
        break;
    case 2:
        room_width = (room_width div tamanho_lab - 1) * _cell_size;
        room_height = (room_height div tamanho_lab ) * _cell_size;
        break;
    case 3:
        room_width = (room_width div tamanho_lab) * _cell_size;
        room_height = (room_height div tamanho_lab) * _cell_size;
        break;
    case 4:
        room_width = (room_width div tamanho_lab - 1) * _cell_size;
        room_height = (room_height div tamanho_lab - 1) * _cell_size;
        break;
    case 5:
        room_width = (room_width div tamanho_lab - 1) * _cell_size;
        room_height = (room_height div tamanho_lab) * _cell_size;
        break;
	case 6:
        room_width = (room_width div tamanho_lab ) * _cell_size;
        room_height = (room_height div tamanho_lab) * _cell_size;
        break;
	case 10:
        room_width = (room_width div tamanho_lab - 1) * _cell_size;
        room_height = (room_height div tamanho_lab-1) * _cell_size;
        break;
	case 20:
        room_width = (room_width div tamanho_lab - 1) * _cell_size;
        room_height = (room_height div tamanho_lab) * _cell_size;
        break;
}


global.maze_width = (room_width div _cell_size) -1;
global.maze_height = (room_height div _cell_size) -1;
maze_width = global.maze_width;
maze_height = global.maze_height;
global.maze = ds_grid_create(maze_width + 2, maze_height + 2);
visited = ds_grid_create(maze_width + 2, maze_height + 2);
frontier = ds_list_create();
paths = ds_stack_create();
start_x = 1;
start_y = 1;
end_x = maze_width;
end_y = maze_height;
draw_paths = false; // Variável para controlar se devemos desenhar os caminhos
path_points = ds_list_create(); // Lista para armazenar os pontos do caminho

difficulty = 1000; // Exemplo: nível de dificuldade 5
instance_create_layer(start_x * _cell_size + 32, start_y * _cell_size + 32, "Layer_Player", obj_player);


// Inicializar o labirinto com paredes
for (var _i = 0; _i <= maze_width + 1; _i++) {
    for (var _z = 0; _z <= maze_height + 1; _z++) {
        ds_grid_set(global.maze, _i, _z, 0); // Inicializa como paredes
    }
}

// Função para verificar se as coordenadas estão dentro dos limites
function is_within_bounds(_nx, _ny) {
    return _nx >= 0 && _nx < maze_width && _ny >= 0 && _ny < maze_height;
}


// Função Algoritmo de Prim para gerar o labirinto
// Função Algoritmo de Prim para gerar o labirinto
function prim_algorithm() {
    ds_grid_set(global.maze, start_x, start_y, 1);
    ds_stack_push(paths, start_x);
    ds_stack_push(paths, start_y);
    ds_list_add(path_points, [start_x, start_y]);

    var _directions = [[1, 0], [0, 1], [-1, 0], [0, -1]];

    for (var _i = 0; _i < 4; _i++) {
        var _dx = _directions[_i][0];
        var _dy = _directions[_i][1];
        var _nx = start_x + _dx;
        var _ny = start_y + _dy;
        if (is_within_bounds(_nx, _ny)) {
            if (ds_grid_get(global.maze, _nx, _ny) == 0) {
                ds_list_add(frontier, [_nx, _ny, start_x, start_y]);
            }
        }
    }

    while (ds_list_size(frontier) > 0) {
        var _wall_index = irandom(ds_list_size(frontier) - 1);
        var _wall = ds_list_find_value(frontier, _wall_index);
        ds_list_delete(frontier, _wall_index);

        var _wx = _wall[0];
        var _wy = _wall[1];
        var _px = _wall[2];
        var _py = _wall[3];

        var _opposite_x = _wx + (_wx - _px);
        var _opposite_y = _wy + (_wy - _py);

        if (is_within_bounds(_opposite_x, _opposite_y)) {
            if (ds_grid_get(global.maze, _opposite_x, _opposite_y) == 0) {
                ds_grid_set(global.maze, _wx, _wy, 1);
                ds_grid_set(global.maze, _opposite_x, _opposite_y, 1);

                for (var _j = 0; _j < 4; _j++) {
                    var _dx = _directions[_j][0];
                    var _dy = _directions[_j][1];
                    var _nx = _opposite_x + _dx;
                    var _ny = _opposite_y + _dy;
                    if (is_within_bounds(_nx, _ny)) {
                        if (ds_grid_get(global.maze, _nx, _ny) == 0) {
                            ds_list_add(frontier, [_nx, _ny, _opposite_x, _opposite_y]);
                        }
                    }
                }

                ds_stack_push(paths, _opposite_x);
                ds_stack_push(paths, _opposite_y);
                ds_list_add(path_points, [_opposite_x, _opposite_y]);
            }
        }
    }
}

// Adicionar Conexões Aleatórias

function verifica_novo_caminho_mais_rapido(_start_x, _start_y, _end_x, _end_y, _caminho_atual) {
    // Função para encontrar o caminho mais curto usando uma busca em largura (similar ao acha_caminho)
    var _novo_caminho = acha_caminho(_start_x, _start_y, _end_x, _end_y);

    // Verificar se o novo caminho foi encontrado
    if (_novo_caminho != undefined) {
        var _comprimento_novo_caminho = array_length(_novo_caminho);
        var _comprimento_caminho_atual = array_length(_caminho_atual);

        // Comparar os comprimentos dos caminhos
        if (_comprimento_novo_caminho < _comprimento_caminho_atual) {
            show_debug_message("Novo caminho mais curto encontrado!");
            return _novo_caminho;
        } else {
            show_debug_message("Nenhum caminho mais curto encontrado. Mantendo o caminho atual.");
            return _caminho_atual;
        }
    } else {
        show_debug_message("Nenhum novo caminho encontrado.");
        return _caminho_atual; // Retorna o caminho atual se nenhum novo caminho foi encontrado
    }
}

// Função para desenhar o labirinto
function draw_maze_obj_lab() {
    for (var _i = 0; _i <= maze_width + 1; _i++) {
        for (var _z = 0; _z <= maze_height + 1; _z++) {
            if (ds_grid_get(global.maze, _i, _z) == 0) {
                var _has_top = (_z > 0 && ds_grid_get(global.maze, _i, _z - 1) == 0);
                var _has_bottom = (_z < maze_height && ds_grid_get(global.maze, _i, _z + 1) == 0);

                var _scale_x = _cell_size / sprite_get_width(spr_parede);
                var _scale_y = _cell_size / sprite_get_height(spr_parede);

                if (_has_bottom) {
                    draw_sprite_ext(spr_parede_cima, 0, _i * _cell_size, _z * _cell_size, _scale_x, _scale_y, 0, c_white, 1);
                } else if (_has_top && _has_bottom) {
                    draw_sprite_ext(spr_parede_cima, 0, _i * _cell_size, _z * _cell_size, _scale_x, _scale_y, 0, c_white, 1);
                } else {
                    draw_sprite_ext(spr_parede, 0, _i * _cell_size, _z * _cell_size, _scale_x, _scale_y, 0, c_white, 1);
                }
            } else {
                var _scale_x = _cell_size / sprite_get_width(spr_chao);
                var _scale_y = _cell_size / sprite_get_height(spr_chao);
                draw_sprite_ext(spr_chao, 0, _i * _cell_size, _z * _cell_size, _scale_x, _scale_y, 0, c_white, 1);
            }
        }
    }
    var _scale_x = _cell_size / sprite_get_width(spr_start);
    var _scale_y = _cell_size / sprite_get_height(spr_start);
    draw_sprite_ext(spr_start, 0, start_x * _cell_size, start_y * _cell_size, _scale_x, _scale_y, 0, c_white, 1);

    _scale_x = _cell_size / sprite_get_width(spr_end);
    _scale_y = _cell_size / sprite_get_height(spr_end);
    draw_sprite_ext(spr_end, 0, end_x * _cell_size -64 , end_y * _cell_size -64  , _scale_x, _scale_y, 0, c_white, 1);
}

// Função para criar bombas em locais aleatórios de chão


// Função para criar instâncias de parede
function create_wall_instances() {
    for (var _i = 0; _i <= maze_width + 1; _i++) {
        for (var _z = 0; _z <= maze_height + 1; _z++) {
            if (ds_grid_get(global.maze, _i, _z) == 0) {
                var _has_top = (_z > 0 && ds_grid_get(global.maze, _i, _z - 1) == 0);
                var _has_bottom = (_z < maze_height && ds_grid_get(global.maze, _i, _z + 1) == 0);

               
				 if (_has_bottom) {
                    var _wall_instance = instance_create_layer(_i * _cell_size, _z * _cell_size, "instances", obj_wall);
                    _wall_instance.sprite_index = spr_parede_cima;
                } else if (_has_top && _has_bottom) {
                   var _wall_instance = instance_create_layer(_i * _cell_size, _z * _cell_size, "instances", obj_wall);
                    _wall_instance.sprite_index = spr_parede_cima;
                }else {
                    instance_create_layer(_i * _cell_size, _z * _cell_size, "instances", obj_wall);
                }
            } else {
               instance_create_layer(_i * _cell_size, _z * _cell_size, "instances", obj_floor);
            }
        }
    }

    instance_create_layer(start_x * _cell_size, start_y * _cell_size, "Top_Layer", obj_start);
    instance_create_layer(end_x * _cell_size -64  , end_y * _cell_size  -64 , "Top_Layer", obj_end);
}



// Função para desenhar o caminho

function remove_dead_ends(_difficulty) {
    var _directions = [[1, 0], [0, 1], [-1, 0], [0, -1]];
    var _dead_ends = [];

    // Identificar todos os becos sem saída
    for (var _i = 1; _i < maze_width - 1; _i++) {
        for (var _j = 1; _j < maze_height - 1; _j++) {
            if (ds_grid_get(global.maze, _i, _j) == 1) {
                var _open_sides = 0;

                for (var _d = 0; _d < 4; _d++) {
                    var _nx = _i + _directions[_d][0];
                    var _ny = _j + _directions[_d][1];
                    if (is_within_bounds(_nx, _ny) && ds_grid_get(global.maze, _nx, _ny) == 1) {
                        _open_sides++;
                    }
                }

                // Se há apenas uma abertura, é um beco sem saída
                if (_open_sides == 1) {
                    array_push(_dead_ends, [_i, _j]);
                }
            }
        }
    }

    // Quebrar as paredes dos becos sem saída de acordo com a dificuldade
    for (var _k = 0; _k < array_length(_dead_ends); _k++) {
        if (_k >= _difficulty) {
            break;  // Limitar a quantidade de becos sem saída com base na dificuldade
        }

        var _dead_end = _dead_ends[_k];
        var _dx = 0;
        var _dy = 0;
        
        // Tentar encontrar uma parede adjacente para quebrar
        for (var _d = 0; _d < 4; _d++) {
            _dx = _dead_end[0] + _directions[_d][0];
            _dy = _dead_end[1] + _directions[_d][1];

            if (is_within_bounds(_dx, _dy) && ds_grid_get(global.maze, _dx, _dy) == 0) {
                ds_grid_set(global.maze, _dx, _dy, 1);  // Quebra a parede
                break;
            }
        }
    }
}


// Chamar o algoritmo de Prim
prim_algorithm();

remove_dead_ends(difficulty);
create_wall_instances();
for (var _i = 0; _i < global.dificuldade+1; _i++) {
    create_random_enemy();
}
if(global.dificuldade == 2){
create_random_enemy_folow();
}

// Criar bombas aleatórias
for (var _i = 0; _i < 10; _i++) {
    create_random_bomb();
}
