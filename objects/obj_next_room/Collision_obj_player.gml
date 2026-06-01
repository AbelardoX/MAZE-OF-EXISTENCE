// feather disable GM2017
// feather disable once GM2016
var pos_x = 0;
// feather disable once GM2016
var pos_y = 0;
if(global.permitido == true){
    var _sala_destino = room_destino;  // Sala que você está indo

    // Se estiver saindo do tutorial para a Fase_BEBE
    if (room == Main_tutorial && _sala_destino == Fase_BEBE) {
        // Inicializa a primeira sala do mundo real
        global.current_sala = [0, 0];
        global.fase = 1;
        room_goto(Fase_BEBE);
        exit;
    }

    // Lógica para Templos (compara coordenadas)
    var _is_temple = false;
    if (is_array(_sala_destino) && variable_global_exists("templos_salas_pos") && is_array(global.templos_salas_pos) && array_length(global.templos_salas_pos) > 0) {
        if (array_equals(_sala_destino, global.templos_salas_pos[0])) {
            _is_temple = true;
        }
    }

	if (_is_temple) {
		global.current_sala = global.templos_salas_pos[0];
     // feather disable once GM1041
	    carregar_sala_templo(is_array(_sala_destino) ? _sala_destino : [0,0], room_origem, direcao);
    } else {
        // Movimentação normal entre salas procedurais
     // feather disable once GM1041
	    carregar_sala(is_array(_sala_destino) ? _sala_destino : [0,0], room_origem);
    }

    // ... (pos_x, pos_y logic) ...


if (direcao == 2) { 
	
            pos_x = 80;  // Posição à frente do prev_room
            pos_y = (global.room_height / 2);
			direcao = 0;
			direction = 0;
			}
// Veio da direita
else if (direcao == 4) {  

            pos_x = global.room_width-150;  // Posição à frente do prev_room
            pos_y = (global.room_height / 2);
			direcao = 0;
			direction = 180;
	}
// Veio de baixo
else if (direcao == 3) {  

      
            pos_x =(global.room_width / 2);
            pos_y = 80;  // Posição à frente do prev_room
			direcao = 0;
				direction = 90;
 }
// Veio de cima

else if (direcao == 1) {  
	
  
            pos_x = (global.room_width / 2);
            pos_y = global.room_height-80;  // Posição à frente do prev_room
			direcao = 0;
				direction = 270;
}
	if(global.current_sala == global.templos_salas_pos[0]){
		pos_x -=32;
	}
		obj_player.x = pos_x +32;
		obj_player.y = pos_y;
	
}
	
