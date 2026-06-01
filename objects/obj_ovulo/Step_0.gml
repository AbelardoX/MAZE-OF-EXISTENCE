// feather disable GM2017
// Step Event do obj_ovulo (inimigo)

// Definir velocidade do inimigo (óvulo)
var _move_speed = 8; // Ajuste a velocidade conforme necessário
var _detection_radius = 100; // Distância em que o inimigo percebe o jogador

// Verificar a distância até o jogador
var _player = instance_find(obj_sperm, 0);
if (_player != noone) {
    var _distance_to_player = point_distance(x, y, _player.x, _player.y);

    // Se o jogador estiver dentro do raio de detecção
    if (_distance_to_player < _detection_radius) {
        // Mover na direção oposta ao jogador
        var _direction_away = point_direction(x, y, _player.x, _player.y) + 180;
        
        // Calcular a nova posição baseada na direção oposta
        var _new_x = x + lengthdir_x(_move_speed, _direction_away);
        var _new_y = y + lengthdir_y(_move_speed, _direction_away);
        
        // Verificar se a nova posição resultaria em colisão com uma parede
        if (!place_meeting(_new_x, _new_y, obj_wall_carne)) {
            // Se não houver colisão, mover na direção oposta ao jogador
            direction = _direction_away;
            speed = _move_speed;
        } else {
            // Caso contrário, tenta uma direção levemente ajustada (+/- 45 graus)
            _direction_away += choose(45, -45);
            _new_x = x + lengthdir_x(_move_speed, _direction_away);
            _new_y = y + lengthdir_y(_move_speed, _direction_away);
            
            if (!place_meeting(_new_x, _new_y, obj_wall_carne)) {
                direction = _direction_away;
                speed = _move_speed;
            }
        }
    }
}

// Movimento aleatório se a velocidade for zero (óvulo parado)
if (speed == 0) {
    var _random_direction = irandom_range(0, 360); // Direção aleatória
    direction = _random_direction; // Definir a direção aleatória
    speed = _move_speed; // Definir a velocidade
}

// Verificar se a nova posição colidirá com uma parede
if (place_meeting(x + lengthdir_x(speed, direction), y + lengthdir_y(speed, direction), obj_wall_carne)) {
    // Se colidir com uma parede, ricochetear
    move_bounce_solid(false);
}
// Verificar se a nova posição colidirá com uma parede
if (place_meeting(x + lengthdir_x(speed, direction), y + lengthdir_y(speed, direction), obj_wall_carne_circular)) {
    // Se colidir com uma parede, ricochetear
    move_bounce_solid(false);
}



