// feather disable GM2017
function desenha_linha(_path) {
    var _path_length = array_length(_path);

    // Loop através do caminho
    for (var _i = 0; _i < _path_length - 1; _i++) {
        var _start_x = _path[_i][0] * _cell_size + _cell_size / 2;
        var _start_y = _path[_i][1] * _cell_size + _cell_size / 2;
        var _end_x = _path[_i + 1][0] * _cell_size + _cell_size / 2;
        var _end_y = _path[_i + 1][1] * _cell_size + _cell_size / 2;

        // Calcular o ângulo da linha
        var _angle = point_direction(_start_x, _start_y, _end_x, _end_y);
        
        // Criar a instância do sprite na posição do início do segmento
        var _traco_instance = instance_create_layer(_start_x, _start_y, "Layer_Linhas", obj_traco);
		with (_traco_instance) {
        // Definir o ângulo e o tamanho da instância
		image_angle = _angle;
        
        // Ajustar o comprimento do traço conforme a distância entre os pontos
        var _scale_x = point_distance(_start_x, _start_y, _end_x, _end_y) / sprite_width[spr_traco];
		image_xscale = _scale_x+0.1;

        // Centralizar a instância
		x = (_start_x + _end_x) / 2;
        y = (_start_y + _end_y) / 2 ;
		}
    }
}
function apagar_linhas() {
    // Apagar todas as instâncias de obj_traco
    with (obj_traco) {
        instance_destroy();
    }
}
