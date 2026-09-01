damage = 0;
veloc = 0;
push_force = 2;

setup = function(_data) {
    damage = _data.damage;
    veloc = _data.speed;
    direction = _data.direction;
    sprite_index = _data.sprite;
    image_xscale = _data.size;
    image_yscale = _data.size;
    speed = veloc;
}
