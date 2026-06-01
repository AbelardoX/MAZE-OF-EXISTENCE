// feather disable GM1041
// feather disable GM1049
// feather disable GM2017
var _slow_id = obj_slow;
var _speed_slow = global.speed_sperm - 4;
var _speed_norm = global.speed_sperm;

// Para cada instância de obj_SPERM
with (obj_SPERM) {
    // Verifica se está colidindo com alguma instância de obj_slow
    if (place_meeting(x, y, _slow_id)) {
        // Reduz a velocidade
        current_speed = _speed_slow;
    } else {
        // Restaura a velocidade normal
        current_speed = _speed_norm;
    }
}
