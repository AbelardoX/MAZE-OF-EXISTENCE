// feather disable GM2017
function salvar_recorde(_recorde_atualizado){
	ini_open("Savegame.ini");
	
	ini_write_real("Player", "Recorde", _recorde_atualizado);
	
	ini_close();
}

function ler_recorde(){
	var _recorde_salvo = 0;
	
	if(file_exists("Savegame.ini")){
		ini_open("Savegame.ini");
		
		_recorde_salvo = ini_read_real("Player", "Recorde", 0);
		
		ini_close();
		
	}
	
	return _recorde_salvo;
}