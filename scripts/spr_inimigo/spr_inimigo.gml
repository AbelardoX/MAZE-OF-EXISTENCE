// feather disable GM2017
function scr_recalculate_path() {
    // Obtém as coordenadas do jogador em termos de grid
    var _player_x = obj_player.x div global._cell_size;
    var _player_y = obj_player.y div global._cell_size;

    // Obtém as coordenadas do inimigo em termos de grid
    var _enemy_x = x div global._cell_size;
    var _enemy_y = y div global._cell_size;

    // Calcula o novo caminho usando A*
    ds_list_destroy(path); // Destrói o caminho antigo
    path = scr_astar_path(_enemy_x, _enemy_y, _player_x, _player_y);

    // Reinicia o ponto de caminho
    next_point = 0;

    // Se o caminho estiver vazio, não faz nada
    if (ds_list_size(path) > 0) {
        var _point = ds_list_find_value(path, next_point);
        target_x = _point[0] * global._cell_size;
        target_y = _point[1] * global._cell_size;
    }
}


function create_random_enemy_folow() {
    var _enemy_x, _enemy_y;

    // Buscar a instância de obj_lab
    var _lab = instance_find(obj_lab, 0);

    // Verifica se a referência ao obj_lab foi definida corretamente
    if (_lab != noone) {
        do {
            // Gera coordenadas aleatórias dentro dos limites do labirinto
            _enemy_x = irandom(_lab._maze_width - 1) + 1;
            _enemy_y = irandom(_lab._maze_height - 1) + 1;
        } until (ds_grid_get(global._maze, _enemy_x, _enemy_y) == 1); // Continua até encontrar um local de chão

        // Cria o inimigo no local encontrado
        instance_create_layer(_enemy_x * _lab._cell_size, _enemy_y * _lab._cell_size, "Top_layer", obj_enemy_folow);
    }
}


function scr_enemy_random_move() {

    // Cria uma lista de direções possíveis
    var _directions = ds_list_create();
    ds_list_add(_directions, [0, -1]); // Para cima
    ds_list_add(_directions, [0, 1]);  // Para baixo
    ds_list_add(_directions, [-1, 0]); // Para a esquerda
    ds_list_add(_directions, [1, 0]);  // Para a direita

    // Tente encontrar uma direção válida
    var _valid_direction_found = false;
    while (!_valid_direction_found && ds_list_size(_directions) > 0) {
        // Escolhe uma direção aleatória
        var _index = irandom(ds_list_size(_directions) - 1);
        directio = ds_list_find_value(_directions, _index);

        // Calcula a nova posição na grade
        var _new_x = (x div global._cell_size) + directio[0];
        var _new_y = (y div global._cell_size) + directio[1];

        // Verifica se a nova posição não é uma parede
        if (ds_grid_get(global._maze, _new_x, _new_y) == 1) { // 1 significa chão
            target_x = _new_x * global._cell_size;
            target_y = _new_y * global._cell_size;
            is_moving = true;
            _valid_direction_found = true;
        } else {
            // Remove a direção inválida
            ds_list_delete(_directions, _index);
        }
    }

    // Se nenhuma direção válida foi encontrada, para de se mover
    if (!_valid_direction_found) {
        is_moving = false;
    }

    // Destrói a lista de direções
    ds_list_destroy(_directions);
}

