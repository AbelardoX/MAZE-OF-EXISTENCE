// feather disable GM2017

function is_within_bounds(_nx, _ny) {
    return _nx >= 0 && _nx < maze_width && _ny >= 0 && _ny < maze_height;
}

function verifica_novo_caminho_mais_rapido(_start_x, _start_y, _end_x, _end_y, _caminho_atual) {
    // Função para encontrar o caminho mais curto usando uma busca em largura (similar ao acha_caminho)
    var _novo_caminho = acha_caminho(_start_x, _start_y, _end_x, _end_y);

    // Verificar se o novo caminho foi encontrado
    if (_novo_caminho != undefined) {
        var _comprimento_novo_caminho = array_length(_novo_caminho);
        var _comprimento_caminho_atual = array_length(_caminho_atual);

        // Comparar os comprimentos dos caminhos
        if (_comprimento_novo_caminho < _comprimento_caminho_atual) {
            return _novo_caminho;
        } else {
            return _caminho_atual;
        }
    } else {
        return _caminho_atual; // Retorna o caminho atual se nenhum novo caminho foi encontrado
    }
}

// Função para desenhar o labirinto
function draw_maze(_maze_width, _maze_height, _maze, _cell_size, _spr1_parede, _spr2_parede_cima, _spr2_chao) {
    for (var _i = 0; _i <= _maze_width + 1; _i++) {
        for (var _z = 0; _z <= _maze_height + 1; _z++) {
            if (ds_grid_get(_maze, _i, _z) == 0) {
                var _has_top = (_z > 0 && ds_grid_get(_maze, _i, _z - 1) == 0);
                var _has_bottom = (_z < _maze_height && ds_grid_get(_maze, _i, _z + 1) == 0);

                var _scale_x = _cell_size / sprite_get_width(_spr1_parede);
                var _scale_y = _cell_size / sprite_get_height(_spr1_parede);

                if (_has_bottom) {
                    draw_sprite_ext(_spr2_parede_cima, 0, _i * _cell_size, _z * _cell_size, _scale_x, _scale_y, 0, c_white, 1);
                } else if (_has_top && _has_bottom) {
                    draw_sprite_ext(_spr2_parede_cima, 0, _i * _cell_size, _z * _cell_size, _scale_x, _scale_y, 0, c_white, 1);
                } else {
                    draw_sprite_ext(_spr1_parede, 0, _i * _cell_size, _z * _cell_size, _scale_x, _scale_y, 0, c_white, 1);
                }
            } else {
                var _scale_x = _cell_size / sprite_get_width(_spr2_chao);
                var _scale_y = _cell_size / sprite_get_height(_spr2_chao);
                
                // Gera uma rotação aleatória (0, 90, 180, 270 graus)
                var _random_rotation = choose(0, 90, 180, 270);

                draw_sprite_ext(_spr2_chao, 0, _i * _cell_size+32, _z * _cell_size+32, _scale_x, _scale_y, _random_rotation, c_white, 1);
            }
        }
    }
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
        var _dx = 0, _dy = 0;
        
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


