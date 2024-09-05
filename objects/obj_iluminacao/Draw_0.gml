/// @description Insert description here
if(global.encontrou_sala_escura) {
 if(surface_exists(sombra_surface)){
surface_set_target(sombra_surface);
	draw_set_color(c_black);
	draw_set_alpha(0.9);
	draw_rectangle(0, 0, room_width, room_height, false);
	draw_set_color(c_white);
	draw_set_alpha(1);

	
	if instance_exists(obj_vela){
		var _num = instance_number(obj_vela);
		
		for( var i = 0; i < _num; i++){
			var _vela = instance_find(obj_vela, i);
			
		draw_set_alpha(0.7);
		draw_circle(_vela.x, _vela.y, raio_visao+30+irandom(2),false);
		
		draw_set_alpha(0.8);
		draw_circle(_vela.x, _vela.y, raio_visao+60+irandom(2),false);
		}
		
	}
  // Definir o raio da visão ao redor do jogador
    var raio_visao = global.raio_lanterna;

    // Pegar as coordenadas do jogador na tela (ajustar de acordo com a câmera)
    var x_jogador_gui = global.current_player.x - camera_get_view_x(view_camera[0]);
    var y_jogador_gui = global.current_player.y - camera_get_view_y(view_camera[0]);

    // Desenhar o círculo de visão, removendo a escuridão ao redor do jogador
	gpu_set_blendmode(bm_subtract);
	draw_circle(x_jogador_gui, y_jogador_gui, raio_visao +irandom(2),false);
	
	draw_set_alpha(0.8);
	draw_circle(x_jogador_gui, y_jogador_gui, raio_visao+30+irandom(2),false);
	
	draw_set_alpha(0.7);
	draw_circle(x_jogador_gui, y_jogador_gui, raio_visao+60+irandom(2),false);
	
	draw_set_alpha(0.6);
	draw_circle(x_jogador_gui, y_jogador_gui, raio_visao+90+irandom(2),false);
	draw_set_alpha(1);
    gpu_set_blendmode(bm_normal);
	


surface_reset_target();
}else{
	sombra_surface = surface_create(room_width,room_height);


}


draw_surface(sombra_surface,0,0);




}










