// feather disable GM2017
// Step do obj_explosion

if (follow_player && instance_exists(obj_player)) {
    x = obj_player.x;
    y = obj_player.y;
}

// Se for baseado em animação (Recomendado):
if (image_index >= image_number - 1) {
    instance_destroy();
}