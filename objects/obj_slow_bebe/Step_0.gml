// feather disable GM2017

with (obj_colisao) {
    // Verifica se a colisão está acontecendo
    var _colidindo = place_meeting(x, y, obj_slow_bebe);
    // Se o estado de colisão mudou
    if (_colidindo && !global.in_slow) {
       global.speed_player -= 4;
       global.in_slow = true;
    } else if (!_colidindo && global.in_slow) {
        // Restaura a velocidade quando sai da colisão
        global.speed_player += 4;
        global.in_slow = false;
    }
}
