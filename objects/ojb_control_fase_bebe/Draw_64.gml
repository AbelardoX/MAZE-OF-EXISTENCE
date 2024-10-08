

if (global.map == true) {
    var mini_map_width = 220;
    var mini_map_height = 200;
    var _cell_size = 25; // Tamanho de cada célula no minimapa

    draw_set_alpha(0.7);

    // Posição do canto inferior direito da tela
    var mini_map_x = display_get_width() - mini_map_width - 40;
    var mini_map_y = display_get_height() - mini_map_height - 40;

    // Desenhar fundo do minimapa
    draw_set_color(c_black);
    draw_rectangle(mini_map_x, mini_map_y, mini_map_x + mini_map_width, mini_map_y + mini_map_height, false);

    // Calcular os limites para o centro do minimapa (a sala atual do jogador)
    var center_x = mini_map_x + mini_map_width / 2;
    var center_y = mini_map_y + mini_map_height / 2;

    // Limites do minimapa para o número de células que podem ser mostradas
    var max_cells_x = mini_map_width div _cell_size; // Quantidade máxima de células visíveis no eixo X
    var max_cells_y = mini_map_height div _cell_size; // Quantidade máxima de células visíveis no eixo Y

    // Desenhar cada sala no minimapa
    for (var i = 0; i < array_length_1d(global.salas_geradas); i++) {
        var sala = global.salas_geradas[i];
        if (is_array(sala)) {
            var sala_x = sala[0];
            var sala_y = sala[1];

            // Posição da sala relativa à sala atual
            var delta_x = sala_x - global.current_sala[0];
            var delta_y = sala_y - global.current_sala[1];

            // Calcula a posição no minimapa com base na distância da sala atual
            var mini_x = center_x + (delta_x * _cell_size);
            var mini_y = center_y - (delta_y * _cell_size);

            // Verificar se a sala está dentro dos limites do minimapa
            if (abs(delta_x) <= max_cells_x / 2 && abs(delta_y) <= max_cells_y / 2) {
                // Sala comum (branca por padrão)
                draw_set_color(c_white);

                // Verificar se o jogador está na sala do templo
                var esta_no_templo = false;
				var Esta_escura_pos = false;
                if (global.templos_salas_pos != undefined) {
                    for (var j = 0; j < array_length_1d(global.templos_salas_pos); j++) {
                        var templo_pos = global.templos_salas_pos[0];
                        if (global.current_sala[0] == templo_pos[0] && global.current_sala[1] == templo_pos[1]) {
                            draw_set_color(c_red); // Se o jogador está na sala do templo, desenha vermelho
                            esta_no_templo = true;
                            break;
                        }
                    }
                }

            
                // Verificar se essa sala contém um dos templos (quando o jogador não está nela)
                if (!esta_no_templo && global.templos_salas_pos != undefined) {
                    for (var j = 0; j < array_length_1d(global.templos_salas_pos); j++) {
                        var templo_pos = global.templos_salas_pos[j];
                        if (templo_pos[0] == sala_x && templo_pos[1] == sala_y) {
                            draw_set_color(c_yellow); // Sala com templo
                            break;
                        }
                    }
                }
				if (!Esta_escura_pos && global.salas_escuras != undefined) {
                    for (var j = 0; j < array_length_1d(global.salas_escuras); j++) {
                        var escura_pos = global.salas_escuras[j];
                        if (escura_pos[0] == sala_x && escura_pos[1] == sala_y) {
                            draw_set_color(c_black); // Sala com templo
                            break;
                        }
                    }
                }
				 if (global.salas_escuras != undefined) {
                    for (var j = 0; j < array_length_1d(global.salas_escuras); j++) {
                        var escura_pos = global.salas_escuras[j];
                        if (global.current_sala[0] == escura_pos[0] && global.current_sala[1] == escura_pos[1]) {
                            draw_set_color(c_black); // Se o jogador está na sala do templo, desenha vermelho
                            Esta_escura_pos = true;
                            break;
                        }
                    }
                }

                // Desenhar a sala como um quadrado
                draw_rectangle(mini_x, mini_y, mini_x + _cell_size, mini_y + _cell_size, false);

                // Se for a sala atual, desenhar de uma cor diferente
                if (global.current_sala[0] == sala_x && global.current_sala[1] == sala_y) {
                    draw_set_color(c_red); // Sempre vermelha para a sala atual
                    draw_rectangle(mini_x, mini_y, mini_x + _cell_size, mini_y + _cell_size, false);
                    draw_set_color(c_white); // Voltar à cor padrão
                }
            }
        }
    }
}

draw_set_alpha(1);

draw_set_color(c_white);
draw_set_font(fnt_menu_op);


desenha_barra_vida();