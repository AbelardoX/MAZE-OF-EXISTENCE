// feather disable GM2016
// feather disable GM2017

event_inherited();

if(vida <=0){
	repeat(3)
	var _int = instance_create_layer(x,y,"instances",obj_amoeba_azul);
	_int.vida = vida/2;
	_int.escala = escala - 0.5;
	_int.dano = dano/2;
}

