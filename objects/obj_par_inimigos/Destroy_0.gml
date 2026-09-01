// feather disable GM2017
// Se este objeto era virtualizado, marca ele como morto permanentemente
if (variable_instance_exists(id, "virtual_id")) {
    global.entidades_mortas[? virtual_id] = true;
}

var _index = ds_list_find_index(global.enemy_list, id);
if (_index != -1) {
    ds_list_delete(global.enemy_list, _index);
}

if (instance_exists(obj_grupo_inimigos)) {
    var _my_grupo_id = (variable_instance_exists(id, "grupo_id") ? grupo_id : noone);
    
    with (obj_grupo_inimigos) {
        if (_my_grupo_id != noone && _my_grupo_id == grupo_id) {
            inimigos_spawnados--;
            if (inimigos_spawnados <= 0) {
                // Remove da lista
                for (var _i = 0; _i < ds_list_size(global.posicoes_estruturas); _i++) {
                    var _info = global.posicoes_estruturas[| _i];
                    if (_info[3] == obj_grupo_inimigos && _info[4] == grupo_id) {
                        ds_list_delete(global.posicoes_estruturas, _i);
                        break;
                    }
                }
                instance_destroy(); // destrói o spawn
            }
        }
    }
}
