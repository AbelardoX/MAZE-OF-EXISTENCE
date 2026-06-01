// feather disable GM2017
// feather disable once GM2016
var pos_x = 0;
// feather disable once GM2016
var pos_y = 0;

if(keyboard_check_pressed(ord("E"))){

if(global.entrou && alarm[0] <= 0){
	global.entrou = !global.entrou;
 // feather disable once GM1041
	carregar_sala(is_array(global.passada) ? global.passada : [0,0], is_array(sala_ida) ? sala_ida : [0,0]);
	var _escada_in = instance_find(obj_escada_porao,false);
		global.current_player.x = _escada_in.x;
		global.current_player.y = _escada_in.y;

}else{
	alarm[0] =60*3;
	global.entrou = !global.entrou;
	global.passada = global.current_sala;
	carregar_sala(sala_ida,global.sala_entrada);
	if (direcao == 2) { 
	
            pos_x = 70; 
            pos_y = (global.room_height / 2);
			direcao = 0;
			angulo = 90;

			
			
			}

else if (direcao == 1) {  

            pos_x = global.room_width-70;  
            pos_y = (global.room_height / 2);
			direcao = 0;
			angulo = 0;
	}
// Veio de baixo
else if (direcao == 3) {  

			
            pos_x =(global.room_width / 2);
            pos_y = 105;  
			direcao = 0;
			angulo = 180;
 }
// Veio de cima

else if (direcao == 4) {  
	
  
            pos_x = (global.room_width / 2);
            pos_y = global.room_height-100;  
			direcao = 0;
			angulo =0;
}
		var _escada = instance_create_layer(pos_x, pos_y, "instances", obj_escada_porao);
		
		
		global.current_player.x = pos_x;
		global.current_player.y = pos_y;


	

}

}
















