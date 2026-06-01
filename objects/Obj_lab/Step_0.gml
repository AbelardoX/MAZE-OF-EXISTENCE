// feather disable GM2017
show_debug_message(global.dificuldade);
if(global.dificuldade == 20 || global.dificuldade == 10){
var _extra_space =  global._cell_size; // Dois blocos extras em cada direção

// Defina a posição da viewport para seguir o jogador, com extra_space em todas as direções
view_xview[0] = clamp(obj_player.x - view_wview[0] / 2 - _extra_space, 0, room_width - view_wview[0] - _extra_space * 2);
view_yview[0] = clamp(obj_player.y - view_hview[0] / 2 - _extra_space, 0, room_height - view_hview[0] - _extra_space * 2);

// Obter as coordenadas e dimensões da viewport 0
var _view_x = view_xview[0] - _extra_space;
var _view_y = view_yview[0] - _extra_space;
var _view_w = view_wview[0] + _extra_space * 3;
var _view_h = view_hview[0] + _extra_space * 2;

// Loop através de todas as instâncias do jogo
with (all) {
    // Verificar se a instância está dentro da viewport expandida
    if (bbox_right > _view_x && bbox_left < _view_x + _view_w &&
        bbox_bottom > _view_y && bbox_top < _view_y + _view_h) {
        visible = true;  // Tornar a instância visível
    } else {
        visible = false; // Tornar a instância invisível
    }
}
}

if (keyboard_check_pressed(ord("R"))) {
    game_restart();
}
