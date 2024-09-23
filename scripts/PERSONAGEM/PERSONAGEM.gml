// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_andando(){
	
if (global.estamina > 0 ){
	

	

if(verificar_sala_escura(global.current_sala)){
	global.encontrou_sala_escura = true;
	}else{
		global.encontrou_sala_escura = false;
	}
if(global.vida == 0){
	game_restart();
}

if(global.tamanho_player >3){
global.tamanho_player = 3;
}

var moving = false;
var current_image_speed = 1; // Velocidade padrão da animação
var diagonal_angle = 0;

esquerda = keyboard_check(ord("A"));
direita = keyboard_check(ord("D"));
cima = keyboard_check(ord("W"));
baixo = keyboard_check(ord("S"));

if (esquerda) {
	sprite_index = spr_player_esquerda;
     moving = true;
	
} else if (direita) {
	sprite_index = spr_player_direita;
        moving = true;
}

else if (cima) { 
	 sprite_index = spr_player_cima;
      moving = true;
	  
} else if (baixo) { 
	sprite_index = spr_player_baixo;
        moving = true;
		
}


vveloc = (baixo - cima) ;
hveloc = (direita - esquerda);

veloc_dir = point_direction(x, y, x + hveloc, y + vveloc);

if(hveloc != 0 or vveloc != 0){
	current_speed = global.speed_player;
}else{
	current_speed = 0;
}

hveloc = lengthdir_x(current_speed, veloc_dir);
vveloc = lengthdir_y(current_speed, veloc_dir);

if(keyboard_check(vk_shift) && global.estamina > 0){
		show_debug_message("FDSAFA")
		hveloc = lengthdir_x(current_speed+10, veloc_dir);
		vveloc = lengthdir_y(current_speed+10, veloc_dir);
		global.estamina-=2;
	}else if(keyboard_check(vk_shift) && global.estamina == 0){
		hveloc = 0;
		vveloc = 0;
		
	}
	

if(place_meeting(x + hveloc, y, global.sala.parede)){
	while !place_meeting(x + sign(hveloc),y,global.sala.parede){
		x += sign(hveloc);
	}
	hveloc = 0;
}
x += hveloc;

if(place_meeting(x , y + vveloc, global.sala.parede)){
	while !place_meeting(x ,y + sign(vveloc),global.sala.parede){
		y += sign(vveloc);
	}
	vveloc = 0;
}
// Atualiza a posição do player

y += vveloc;

dir = floor((point_direction(x,y,mouse_x,mouse_y)+ 45)/90);

if(hveloc == 0 and vveloc == 0){
 switch dir{
	 default:
	 sprite_index = spr_player_direita_parado
	 break;
	 case 1:
	 sprite_index = spr_player_cima_parado
	 break;
	 case 2:
	 sprite_index = spr_player_esquerda_parado
	 break;
	 case 3:
	 sprite_index = spr_player_baixo_parado
	 break;
 }	
}

if(global.in_dash == true){
	var rastro = instance_create_layer(x,y,"instances",obj_rastro_player);
		with(rastro){
		if (obj_player.esquerda) {
    sprite_index = spr_player_esquerda;
		} else if (obj_player.direita) {
    sprite_index = spr_player_direita;
		} else if (obj_player.cima) {
    sprite_index = spr_player_cima;
		} else if (obj_player.baixo) {
     sprite_index = spr_player_baixo;
}
		
		}
}




if(instance_exists(obj_item)and obj_invetario.inventario = false and !global.inventario_cheio){
	var _inst = instance_nearest(x,y,obj_item);
	if(distance_to_point(_inst.x,_inst.y)<= 100){
		if(keyboard_check_pressed(ord("F"))){
			adicionar_item_invent(_inst.image_index,_inst.quantidade,_inst.sprite_index,_inst.nome,_inst.descricao,0,0,0,0,_inst.dano,_inst.armadura,_inst.velocidade,_inst.cura,_inst.tipo,_inst.ind);
			coletar_item(_inst.x,_inst.y,global.current_sala);
			instance_destroy(_inst);
		}
	}
}

// Manter o bloco de colisão na posição correta
if (instance_exists(global.bloco_colisao)) {
    global.bloco_colisao.x = x;
    global.bloco_colisao.y = y +30; // Ajuste 50 conforme necessário
}
}
if(mouse_check_button(mb_left)){
	image_index = 0;
	switch dir{
	 default:
	 sprite_index = spr_player_direita_parado_atacando;
	 break;
	 case 1:
	 sprite_index = spr_player_cima_parado_atacando;
	 break;
	 case 2:
	 sprite_index = spr_player_esquerda_parado_atacando;
	 break;
	 case 3:
	 sprite_index = spr_player_baixo_parado_atacando;
	 break;
 }	
 
 state = scr_ataque_player;
	
}


}

function scr_ataque_player(){
	if(image_index >= 1){
	if(atacando = false){
	switch dir{
	 default:
	  instance_create_layer( x + 10, y - 20, "instances", obj_hibox_ataque);
	 break;
	 case 1:
	  instance_create_layer( x - 40 , y -70, "instances", obj_hibox_ataque);
	 break;
	 case 2:
	  instance_create_layer( x - 70, y -20 , "instances", obj_hibox_ataque);
	 break;
	 case 3:
	  instance_create_layer( x - 40 , y + 20, "instances", obj_hibox_ataque);
	 break;
 }	
 atacando = true;
		}
	}
	if fim_animation(){
		state = scr_andando;
		atacando = false;
	}
	
}