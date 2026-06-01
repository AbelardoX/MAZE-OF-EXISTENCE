// feather disable GM2017
function scr_torreta_check_player(){
	if(distance_to_object(obj_player) <= dist_aggro){
		state = scr_amoeba_perseguir;
	}
}
function scr_torreta_hit(){
		alarm[2] = 180;
	empurrar_veloc = lerp(empurrar_veloc,0,0.05);
	hveloc = lengthdir_x(empurrar_veloc,empurrar_dir);
	vveloc = lengthdir_y(empurrar_veloc,empurrar_dir);
	
	scr_amoeba_colisao();
}


function scr_torreta_colisao(){
    aplicar_movimento_com_colisao(hveloc, vveloc);
}


function atirar_torreta(){
	
    // Obtém a posição do obj_sperm
    var _alvo_x = obj_player.x;
    var _alvo_y = obj_player.y;
    
    // Direção do inimigo para o obj_sperm
    var _direcao = point_direction(x, y, _alvo_x, _alvo_y);
    
  
    image_angle = _direcao -180;  // Subtrai 90 graus para alinhar o "frente" do retângulo corretamente




if(tiro == true){
var _tiros = instance_create_layer(x,y,"instances",obj_tiro);
with(_tiros){
	direction =  _direcao ;
}
tiro = false;
}




}

function scr_torreta_parada(){
	if(alarm[2] == 0){
		state = atirar_torreta;
	}
	
}