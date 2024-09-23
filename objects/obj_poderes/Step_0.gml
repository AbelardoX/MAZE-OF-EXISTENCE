if(poder_correr){
	 obj_player.current_speed += 5;
	poder_correr = !poder_correr;
}

if(poder_dash){
global.dash_habilitado = true;
global.speed_dash = 20;  // Velocidade do dash
global.frames = 20;

if (global.dash_habilitado && !global.dash_em_recarga) {
    if (keyboard_check_pressed(mb_right)) {
		global.in_dash =true;
        // Inicia o dash
        global.speed_player= global.speed_dash;
        global.dash_em_recarga = true;  // Ativa a recarga do dash
        alarm[0] = global.frames;  // Define a duração do dash
	
    } else {
        // Volta à velocidade normal
		global.in_dash = false;
        global.speed_player = global.speed_player_base;
        obj_player.current_image_speed = 0.6;
    }
}


if (alarm[0] <= 0 && global.dash_em_recarga) {
    global.dash_em_recarga = false;  // Reseta o estado de recarga
}

}
if(poder_lanterna){
	global.raio_lanterna = 260;
	
}

if(poder_mapa){
	global.map = true;
}







