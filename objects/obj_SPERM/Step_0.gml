// feather disable GM2017
show_debug_message(global.destino_templo);
show_debug_message(global.current_sala);
if(global.vida_sperm == 0){
	game_restart();
}

if(global.tamanho_player >3){
global.tamanho_player = 3;
}
image_xscale = global.tamanho_player;
image_yscale = global.tamanho_player;
var _moving = false;
// Variável para controlar a velocidade do player

var _current_image_speed = 1; // Velocidade padrão da animação




// Controle de movimento
var _h_move = 0;
var _v_move = 0;

// Verificar teclas de movimento
var _moving_left = keyboard_check(vk_left) || keyboard_check(ord("A"));
var _moving_right = keyboard_check(vk_right) || keyboard_check(ord("D"));
var _moving_up = keyboard_check(vk_up) || keyboard_check(ord("W"));
var _moving_down = keyboard_check(vk_down) || keyboard_check(ord("S"));

// Movimento horizontal
if (_moving_left) {
    _h_move = -current_speed;
} else if (_moving_right) {
    _h_move = current_speed;
}

// Movimento vertical
if (_moving_up) {
    _v_move = -current_speed;
} else if (_moving_down) {
    _v_move = current_speed;
}

// Definir o ângulo com base na direção do movimento
if (_moving_left && _moving_up) {
    image_angle = 225; // Esquerda e cima (diagonal)
} else if (_moving_left && _moving_down) {
    image_angle = 315; // Esquerda e baixo (diagonal)
} else if (_moving_right && _moving_up) {
    image_angle = 135; // Direita e cima (diagonal)
} else if (_moving_right && _moving_down) {
    image_angle = 45; // Direita e baixo (diagonal)
} else if (_moving_left) {
    image_angle = 270; // Esquerda
} else if (_moving_right) {
    image_angle = 90; // Direita
} else if (_moving_up) {
    image_angle = 180; // Cima
} else if (_moving_down) {
    image_angle = 0; // Baixo
}

// Atualiza a posição do player
x += _h_move;
y += _v_move;

// Atualiza a animação do player se ele estiver se movendo
if (_h_move != 0 || _v_move != 0) {
    _moving = true;
}

if (_moving) {
    image_speed = _current_image_speed; // Define a velocidade da animação com base na velocidade atual
} else {
    image_speed = 0; // Para a animação do player
    image_index = 0; // Opcional: redefine para o primeiro quadro da animação
}
// Verifica se o dash está habilitado e se não está em recarga
if (global.dash_habilitado && !global.dash_em_recarga) {
    if (keyboard_check_pressed(vk_shift)) {
		global.in_dash =true;
        // Inicia o dash
        current_speed = global.speed_dash;
        global.dash_em_recarga = true;  // Ativa a recarga do dash
        alarm[0] = global.frames;  // Define a duração do dash
    } else {
        // Volta à velocidade normal
		global.in_dash = false;
        current_speed = global.speed_sperm;
        _current_image_speed = 0.6;
    }
}

if(global.in_dash == true){
	var _rastro = instance_create_layer(obj_SPERM.x,obj_SPERM.y,"instances",obj_rastro);
		with(_rastro){
			if (_moving_left && _moving_up) {
    image_angle = 225; // Esquerda e cima (diagonal)
		} else if (_moving_left && _moving_down) {
    image_angle = 315; // Esquerda e baixo (diagonal)
		} else if (_moving_right && _moving_up) {
    image_angle = 135; // Direita e cima (diagonal)
		} else if (_moving_right && _moving_down) {
    image_angle = 45; // Direita e baixo (diagonal)
		} else if (_moving_left) {
    image_angle = 270; // Esquerda
		} else if (_moving_right) {
    image_angle = 90; // Direita
		} else if (_moving_up) {
    image_angle = 180; // Cima
		} else if (_moving_down) {
    image_angle = 0; // Baixo
}
		
		}
}


// Verificar quando o dash termina
if (alarm[0] <= 0 && global.dash_em_recarga) {
    global.dash_em_recarga = false;  // Reseta o estado de recarga
}