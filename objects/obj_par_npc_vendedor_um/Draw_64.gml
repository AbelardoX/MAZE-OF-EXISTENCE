// feather disable GM2017
if (venda_aberta) {
    var _escala = 3;
    var _mx = device_mouse_x_to_gui(0);
    var _my = device_mouse_y_to_gui(0);

    // Tamanho da tela
    var _tela_w = 1920;
    var _tela_h = 1088;

    // Tamanho do fundo original
    var _fundo_w = sprite_get_width(spr_loja_fundo_vendedor);
    var _fundo_h = sprite_get_height(spr_loja_fundo_vendedor);

    // Posição do fundo
    var _fundo_x = (_tela_w - _fundo_w * _escala) / 2;
    var _fundo_y = (_tela_h - _fundo_h * _escala) / 2;

    // Fundo escurecido
    draw_set_alpha(0.7);
    draw_set_color(c_black);
    draw_rectangle(0, 0, _tela_w, _tela_h, false);
    draw_set_alpha(1);

    // Fundo da loja
    draw_sprite_ext(spr_loja_fundo_vendedor, 0, _fundo_x, _fundo_y, _escala, _escala, 0, c_white, 1);

    // Parâmetros dos slots
    var _slot_w = 47 * _escala;
    var _slot_h = 52 * _escala;
    var _cols = 6;
    var _espacamento = 4 * 2.8;

    var _offset_x = 22 * _escala;
    var _offset_y = 20 * _escala;

    var _item_hover_index = -1;

    for (var _i = 0; _i < ds_grid_height(inventario_venda); _i++) {
        var _col = _i mod _cols;
        var _lin = _i div _cols;

        var _slot_x = _fundo_x + _offset_x + _col * (_slot_w + _espacamento);
        var _slot_y = _fundo_y + _offset_y + _lin * (_slot_h + _espacamento);

        var _mouse_hover = point_in_rectangle(_mx, _my, _slot_x, _slot_y, _slot_x + _slot_w, _slot_y + _slot_h);

        // Hover highlight
        if (_mouse_hover) {
            draw_set_alpha(0.4);
            draw_set_color(c_black);
            draw_rectangle(_slot_x, _slot_y, _slot_x + _slot_w, _slot_y + _slot_h, false);
            draw_set_alpha(1);
        }

        // Seleção de item
        if (_mouse_hover && mouse_check_button_pressed(mb_left)) {
            if (inventario_venda[# INFOS.ITEM, _i] != -1) {
                global.item_selecionado_venda = _i;
            } else {
                global.item_selecionado_venda = -1;
            }
        }

        // Borda de seleção
        if (global.item_selecionado_venda == _i) {
            draw_set_alpha(1);
            draw_set_color(c_lime);
            draw_rectangle(_slot_x, _slot_y, _slot_x + _slot_w, _slot_y + _slot_h, true);
        }

        // Desenhar sprite do item
        if (inventario_venda[# INFOS.ITEM, _i] != -1) {
            draw_sprite_ext(inventario_venda[# INFOS.SPRITE, _i],
                            inventario_venda[# INFOS.IMAGE_IND, _i],
                            _slot_x, _slot_y, _escala, _escala, 0, c_white, 1);

            draw_set_font(fnt_numeros);
            draw_set_halign(fa_right);
            draw_set_color(c_yellow);
            draw_text(_slot_x + _slot_w - 6, _slot_y + _slot_h + 4, string(inventario_venda[# INFOS.PRECO, _i]));
        }

        // Detecta item em hover
        if (_mouse_hover && inventario_venda[# INFOS.ITEM, _i] != -1) {
            _item_hover_index = _i;
        }
    }

    // Mostrar descrição (hover > selecionado)
    var _info_index = _item_hover_index != -1 ? _item_hover_index : global.item_selecionado_venda;
    if (_info_index != -1 && inventario_venda[# INFOS.ITEM, _info_index] != -1) {
        var _nome = inventario_venda[# INFOS.NOME, _info_index];
        var _descricao = inventario_venda[# INFOS.DESCRICAO, _info_index];

        draw_set_font(fnt_descricao);
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
        draw_set_color(c_white);

        draw_text_outlined_wrapped_block(498, 701, 758, 758, c_black, c_white, _nome, 20);
        draw_text_outlined_wrapped_block(882, 702, 1421, 974, c_black, c_white, _descricao, 1);
    }

    // Mostrar moedas
    draw_set_font(fnt_status);
    draw_set_halign(fa_right);
    draw_set_color(c_white);
    draw_text(_tela_w - 40, 30, "Moedas: " + string(global.moedas));

    // Botão de comprar
    var _btn_x = _fundo_x + 530;
    var _btn_y = _fundo_y + 480;
    var _btn_w = 240;
    var _btn_h = 60;
    var _btn_text = "Comprar";

    var _mouse_em_botao = point_in_rectangle(_mx, _my, _btn_x, _btn_y, _btn_x + _btn_w, _btn_y + _btn_h);

    // Estilo do botão
    if (global.item_selecionado_venda != -1) {
        draw_set_color(_mouse_em_botao ? c_yellow : c_green);
    } else {
        draw_set_color(c_gray);
    }
    draw_rectangle(_btn_x, _btn_y, _btn_x + _btn_w, _btn_y + _btn_h, false);

    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(fnt_status);
    draw_text(_btn_x + _btn_w / 2, _btn_y + _btn_h / 2, _btn_text);

    // Comprar item
    if (_mouse_em_botao and mouse_check_button_pressed(mb_left) and global.item_selecionado_venda != -1) {
        comprar_item_loja(global.item_selecionado_venda);
    }
}
