// feather disable GM2017
escala = 1;
script_execute(state);
depth = -y;


if (vida <= 0) {
    // Definir uma base de XP e um multiplicador baseado na vida máxima do inimigo
    var _base_xp = 10; // Valor fixo de XP
    var _xp_multiplicador = 0.1; // Multiplicador para balancear o ganho de XP (ajustável conforme desejado)

    // Ganhar XP com base na vida do inimigo derrotado
    var _xp_ganho = _base_xp + (max_vida * _xp_multiplicador);
    
    ganhar_xp(_xp_ganho);

    // Destroi o inimigo
    instance_destroy();
}


if(alarm[3] == 0){
	state = atirar_torreta;
}







