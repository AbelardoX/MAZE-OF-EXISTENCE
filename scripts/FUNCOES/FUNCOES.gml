// feather disable GM2017
function fim_animation(){
	var _sprite = sprite_index;
	var _image = image_index;
	if(argument_count > 0) _sprite = argument[0];
	if(argument_count > 1) _image = argument[1];
	var _type = sprite_get_speed_type(sprite_index);
	var _spd = sprite_get_speed(sprite_index)*image_speed;
	if(_type == spritespeed_framespersecond)
	    _spd = _spd / game_get_speed(gamespeed_fps);
	if(argument_count > 2) _spd = argument[2];
	return _image + _spd >= sprite_get_number(_sprite);
}

/// @desc Captura os inputs do jogador de forma padronizada
function obter_inputs_jogador() {
    return {
        esquerda: keyboard_check(ord("A")) || keyboard_check(vk_left),
        direita:  keyboard_check(ord("D")) || keyboard_check(vk_right),
        cima:     keyboard_check(ord("W")) || keyboard_check(vk_up),
        baixo:    keyboard_check(ord("S")) || keyboard_check(vk_down),
        shift:    keyboard_check(vk_shift),
        mouse_esq_press: mouse_check_button_pressed(mb_left),
        mouse_esq_rel:   mouse_check_button_released(mb_left),
        mouse_dir_press: mouse_check_button_pressed(mb_right),
        interagir: keyboard_check_pressed(ord("F"))
    };
}

/// @desc Executa movimentação com colisão pixel-perfect
/// @param _hveloc Velocidade horizontal desejada
/// @param _vveloc Velocidade vertical desejada
/// @param _col_obj Objeto ou instância de colisão (padrão: global.sala.parede)
function aplicar_movimento_com_colisao(_hveloc, _vveloc, _col_obj = undefined) {
    var _obj = _col_obj;
    
    // Se nenhum objeto foi passado, tenta pegar a parede da sala atual ou o padrão
    if (_obj == undefined) {
        if (variable_global_exists("sala") && variable_struct_exists(global.sala, "parede")) {
            _obj = global.sala.parede;
        } else {
            _obj = obj_wall;
        }
    }

    // Colisão Horizontal
    if (place_meeting(x + _hveloc, y, _obj)) {
        while (!place_meeting(x + sign(_hveloc), y, _obj)) {
            x += sign(_hveloc);
        }
        _hveloc = 0;
    }
    x += _hveloc;

    // Colisão Vertical
    if (place_meeting(x, y + _vveloc, _obj)) {
        while (!place_meeting(x, y + sign(_vveloc), _obj)) {
            y += sign(_vveloc);
        }
        _vveloc = 0;
    }
    y += _vveloc;
}
