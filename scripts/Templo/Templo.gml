// feather disable GM2017
// Defina isso em um script de inicialização ou no topo do arquivo (Macros)
#macro DIR_BAIXO 1
#macro DIR_ESQUERDA 2
#macro DIR_CIMA 3
#macro DIR_DIREITA 4
#macro CELL_VAZIO 0
#macro CELL_CHAO 1

// --- FUNÇÃO PRINCIPAL ---
function carregar_templo(_direcao) {
    // 1. Resetar e criar estrutura base
    criar_chao_room_inteira(real(global._maze_width), real(global._maze_height), global._maze);
    
    var _dist = variable_global_exists("distancia_parede_templo") ? real(global.distancia_parede_templo) : 4;
    criar_templo_poder(real(global._maze_width), real(global._maze_height), global._maze, _dist, _dist);

    // 2. Abrir a entrada baseada na direção (Lógica extraída)
    temple_open_entrance(_direcao);

    // 3. Criar as instâncias físicas das paredes
    criar_paredes_intances(real(global._maze_width), real(global._maze_height), global._maze, real(global._cell_size));    

    // 4. Spawnar o poder (Lógica extraída)
    temple_spawn_powerup();
}

// --- HELPER: ABRIR ENTRADA ---
function temple_open_entrance(_dir) {
    var _grid = global._maze;
    var _tunnel_length = 5; // O quanto o tunel avança para fora (loop do 'i')
    var _xx = 0;
    var _yy = 0;

    switch (_dir) {
        case DIR_ESQUERDA:
            _xx = global.x_meio_esquerda;
            _yy = global.y_meio_esquerda;
            
            // Abre o chão (altura de 3 blocos: y-1 a y+1)
            ds_grid_set_region(_grid, _xx, _yy - 1, _xx, _yy + 1, CELL_CHAO);
            
            // Cria paredes do túnel
            for (var _i = 1; _i < _tunnel_length; _i++) {
                ds_grid_set(_grid, _xx - _i, _yy - 2, CELL_VAZIO);
                ds_grid_set(_grid, _xx - _i, _yy + 2, CELL_VAZIO);
            }
            break;

        case DIR_DIREITA:
            _xx = global.x_meio_direita;
            _yy = global.y_meio_direita;

            // Abre o chão
            ds_grid_set_region(_grid, _xx, _yy - 1, _xx, _yy + 1, CELL_CHAO);

            // Cria paredes do túnel
            for (var _i = 1; _i < _tunnel_length; _i++) {
                ds_grid_set(_grid, _xx + _i, _yy - 2, CELL_VAZIO);
                ds_grid_set(_grid, _xx + _i, _yy + 2, CELL_VAZIO);
            }
            break;

        case DIR_CIMA:
            _xx = global.x_meio_superior;
            _yy = global.y_meio_superior;

            // Abre o chão (Largura de 4 blocos: x-2 a x+1, mantendo sua lógica original)
            ds_grid_set_region(_grid, _xx - 2, _yy, _xx + 1, _yy, CELL_CHAO);

            // Cria paredes do túnel
            for (var _i = 1; _i < _tunnel_length; _i++) {
                ds_grid_set(_grid, _xx - 2, _yy - _i, CELL_VAZIO);
                ds_grid_set(_grid, _xx + 2, _yy - _i, CELL_VAZIO);
            }
            break;

        case DIR_BAIXO:
            _xx = global.x_meio_inferior;
            _yy = global.y_meio_inferior;

            // Abre o chão
            ds_grid_set_region(_grid, _xx - 2, _yy, _xx + 1, _yy, CELL_CHAO);

            // Cria paredes do túnel
            for (var _i = 1; _i < _tunnel_length; _i++) {
                ds_grid_set(_grid, _xx - 2, _yy + _i, CELL_VAZIO);
                ds_grid_set(_grid, _xx + 2, _yy + _i, CELL_VAZIO);
            }
            break;
    }
}

// --- HELPER: SPAWNAR PODER ---
function temple_spawn_powerup() {
    global.poder_escolhido = irandom(ds_list_size(global.lista_poderes_basicos) - 1);
    global.objeto_escolhido = procurar_poder(global.poder_escolhido);
    
    if (!global.objeto_escolhido.coletado) {
        instance_create_layer(global.room_width / 2, global.room_height / 2, "instances", global.objeto_escolhido.objeto);
    }
}