// feather disable GM2017
function desenha_barra_vida() {
   var _scala = 3;
   var _guia = display_get_gui_height();
   var _spra = sprite_get_height(spr_barra_vida) * _scala;
   var _hud = _guia - _spra;   

    var _pos_x = 80; // Posição X da barra
    var _pos_y = 100; // Posição Y da barra
    var _largura_barra = sprite_get_width(spr_barra_vida) * _scala;
    var _altura_barra = sprite_get_height(spr_barra_vida) * _scala;
	
	var _pos_stamina = _pos_y + 48;
	
	var _vida = global.vida;
	var _max_vida = global.vida_max;
	var _stamina = global.estamina;
	var _max_estamina = global.max_estamina;
	var _xp = global.xp;
	var _max_xp = global.max_xp;
   
     // Verificar se o player está tocando a área da barra (mesmo parcialmente)
    var _alfa = 1; // Alpha normal
    if (instance_exists(obj_player)) {
        if (point_in_rectangle(obj_player.x, obj_player.y, _pos_x - _largura_barra , _pos_y - _altura_barra + 120, _pos_x + _largura_barra , _pos_y + _altura_barra - 50)) {
            // _alfa = 0.3;
        }
    }
	
	draw_set_font(fnt_status);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_set_color(c_black);
	draw_sprite_ext(spr_hud_barra_xp, 0, _pos_x , _pos_stamina + 35, (_xp / _max_xp) * 0.8, 2, 0 , c_white, _alfa);
	  
	draw_sprite_ext(spr_hud_xp, 0, _pos_x , _pos_stamina + 35, 0.8, 2, 0 , c_white, _alfa);
	draw_sprite_ext(spr_vida, 0, _pos_x , _pos_y, (_vida / _max_vida) * _scala, _scala, 0 , c_white, _alfa);
    draw_sprite_ext(spr_sanidade, 0, _pos_x - 30 , _pos_y + 39, (global.sanidade / global.max_sanidade) * _scala, _scala, 0 , c_white, _alfa);
	
   draw_sprite_ext(spr_barra_vida, 0, _pos_x , _pos_y, _scala, _scala, 0 , c_white, _alfa);
   draw_set_alpha(1);
}
