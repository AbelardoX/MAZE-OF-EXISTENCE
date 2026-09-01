if (follow_player && instance_exists(obj_player)) {
    x = obj_player.x;
    y = obj_player.y;
}

if (duration > 0) {
    duration--;
} else {
    instance_destroy();
}
