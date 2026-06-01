// feather disable GM2017
/// @description Insert description here
// You can write your code in this editor

    draw_paths = !draw_paths; // Alternar entre desenhar ou não os caminhos


// Verificar se devemos desenhar o caminho
if (draw_paths) {
    // Inicialmente, calcular o caminho atual
    var _caminho_atual = acha_caminho(start_x, start_y, end_x - 1, end_y - 1);

    // Verificar se o caminho atual foi encontrado
    if (_caminho_atual != undefined && array_length(_caminho_atual) > 0) {
        // Desenhar o caminho atual
        desenha_linha(_caminho_atual);
        
        // Verificar se há um novo caminho mais rápido
        var _caminho_mais_rapido = verifica_novo_caminho_mais_rapido(start_x, start_y, end_x - 1, end_y - 1, _caminho_atual);
        
        // Se o novo caminho for mais rápido, desenhe o novo caminho
        if (_caminho_mais_rapido != _caminho_atual) {
            desenha_linha(_caminho_mais_rapido);
            show_debug_message("Novo caminho mais rápido desenhado.");
        }
    } else {
        show_debug_message("Nenhum caminho encontrado.");
    }
}else{
	apagar_linhas();
}











