// feather disable GM2017
// Obter a instância do player e sua posição
var _player = instance_find(obj_player, 0);
var _player_x = 0, _player_y = 0;
if (_player != noone) {
    _player_x = _player.x div global._cell_size;
    _player_y = _player.y div global._cell_size;
}
// Obter a posição do inimigo
var _enemy_x = x div global._cell_size;
var _enemy_y = y div global._cell_size;

if (path != undefined && ds_list_size(path) > 0) {
    var _next_step = ds_list_find_value(path, 0); // Obtenha o próximo passo
    var _next_x = _next_step[0] * global._cell_size + global._cell_size / 2;
    var _next_y = _next_step[1] * global._cell_size + global._cell_size / 2;

    // Mover o inimigo para o próximo passo
    var _move_speed = 4; // Ajuste a velocidade conforme necessário
    move_towards_point(_next_x, _next_y, _move_speed);

    // Se o inimigo chegou ao próximo passo, remova esse passo do caminho
    if (point_distance(x, y, _next_x, _next_y) < _move_speed) {
        ds_list_delete(path, 0);
    }
} else {
    // Se o caminho estiver vazio ou não existir, recalcular o caminho
    // feather ignore GM2043
    var _caminho_array = acha_caminho(_enemy_x, _enemy_y, _player_x, _player_y);
    if (_caminho_array != undefined) {
        path = ds_list_create();
        for (var _i = 0; _i < array_length(_caminho_array); _i++) {
            ds_list_add(path, _caminho_array[_i]);
        }
    }
}
