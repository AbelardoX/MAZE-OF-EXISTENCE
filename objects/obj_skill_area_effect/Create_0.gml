damage = 0;
radius = 0;
duration = 0;
follow_player = true;
sprite_index = -1;

setup = function(_data) {
    damage = _data.damage;
    radius = _data.radius;
    duration = _data.duration;
    follow_player = _data.follow_player;
    sprite_index = _data.sprite;
    
    // Ajusta o tamanho da hitbox baseado no raio
    if (sprite_exists(sprite_index)) {
        var _sw = sprite_get_width(sprite_index);
        image_xscale = (radius * 2) / _sw;
        image_yscale = (radius * 2) / _sw;
    }
}
