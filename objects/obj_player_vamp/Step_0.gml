// feather disable GM2017
if(hit){
	state = scr_personagem_hit_vamp;
}
if(global.level_up == true){
	alarm[0]++;
	alarm[2]++;
	alarm[3]++;
	alarm[6]++;
	alarm[11]++;
	image_speed = 0;
	exit;		
}else{
	image_speed = 1;
script_execute(state);

if(global.estamina <= global.max_estamina && !andar){
global.estamina += 0.5;
}

if(global.vida <= 0){
	game_end();
}


if (global.estamina <= 0 && !andar){
andar = true;
global.estamina = 0;
alarm[0] = 50;
}



// Itera sobre a lista de scripts ativos e os executa
for (var _i = 0; _i < ds_list_size(global.active_upgrades); _i++) {
    var _script = global.active_upgrades[| _i];
    script_execute(_script); // Executa o script
}
}


