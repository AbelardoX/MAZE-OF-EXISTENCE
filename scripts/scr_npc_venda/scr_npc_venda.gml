// feather disable GM2017
function inicializar_itens_venda(_npc_level) {
    randomize();
    ds_grid_clear(inventario_venda, -1);
    
    // Define quantos itens o NPC terá para vender (baseado no nível)
    var _quantidade_itens = clamp(3 + floor(_npc_level / 2), 3, 8); // Mínimo 3, máximo 8 itens
    
    // Filtra itens baseado no nível do NPC
    var _itens_disponiveis = filtrar_itens_por_nivel(_npc_level);
    
    // Adiciona itens aleatórios ao inventário de venda
    for (var _i = 0; _i < _quantidade_itens; _i++) {
        // Escolhe um _item aleatório da lista filtrada
        var _item_index = irandom(ds_list_size(_itens_disponiveis) - 1);
        var _item = _itens_disponiveis[| _item_index];
        
        // Define _quantidade aleatória baseada no tipo de _item e nível do NPC
        var _quantidade = 1;
        if (_item[8] == "uso") { // Itens de uso têm quantidades maiores
            _quantidade = irandom_range(1, 3 + _npc_level);
        }
        
        // Adiciona o _item ao inventário de venda
        adicionar_item_venda(
            _item[0],       // sprite
            _item[7],       // image_index
            _quantidade,    // _quantidade (USA A VARIÁVEL CALCULADA)
            _item[1],       // nome
            _item[2],       // descricao
            _item[4],       // dano
            _item[5],       // armadura
            _item[6],       // velocidade
            _item[3],       // cura
            _item[8],       // tipo
            _item[7],       // ind (usando image_index)
            calcular_preco_com_base_no_nivel(_item[9], _npc_level) // preco ajustado
        );
        
        // Remove o _item da lista temporária para evitar duplicatas
        ds_list_delete(_itens_disponiveis, _item_index);
        
        // Se não houver mais itens disponíveis, sai do loop
        if (ds_list_size(_itens_disponiveis) == 0) break;
    }
    
    // Limpa a lista temporária
    ds_list_destroy(_itens_disponiveis);
}

function filtrar_itens_por_nivel(_npc_level) {
    var _itens_filtrados = ds_list_create();
    
    for (var _i = 0; _i < ds_list_size(global.lista_itens); _i++) {
        var _item = global.lista_itens[| _i];
        var _item_tier = determinar_tier_do_item(_item);
        
        // Itens de tier mais alto só aparecem para NPCs de nível mais alto
        if (_item_tier <= _npc_level) {
            ds_list_add(_itens_filtrados, _item);
        }
    }
    
    return _itens_filtrados;
}

function determinar_tier_do_item(_item) {
    // Define o tier do _item baseado em suas propriedades
    var _poder = 0;
    
    switch (_item[8]) { // tipo
        case "uso":
            _poder = _item[3] / 10; // baseado na cura
            break;
        case "arma":
            _poder = _item[4] / 2;  // baseado no dano
            break;
        case "armadura":
            _poder = _item[5];      // baseado na armadura
            break;
        case "bota":
            _poder = _item[6];      // baseado na velocidade
            break;
    }
    
    return clamp(floor(_poder / 2), 1, 5); // Tiers de 1 a 5
}

function calcular_preco_com_base_no_nivel(_preco_base, _npc_level) {
    // Aumenta o preço baseado no nível do NPC (10% por nível)
    var _multiplicador = 1 + (_npc_level * 0.1);
    
    // Adiciona uma variação aleatória de ±20%
    var _variacao = random_range(0.8, 1.2);
    
    return round(_preco_base * _multiplicador * _variacao);
}

function adicionar_item_venda(_sprite, _img_index, _quantidade, _nome, _descricao, _dano, _armadura, _velocidade, _cura, _tipo, _ind, _preco) {
    // Encontra o primeiro slot vazio
    for (var _i = 0; _i < ds_grid_height(inventario_venda); _i++) {
        if (inventario_venda[# INFOS.ITEM, _i] == -1) {
            // Preenche os dados do item
            inventario_venda[# INFOS.ITEM, _i] = _i; // ID único
            inventario_venda[# INFOS.QUANTIDADE, _i] = _quantidade;
            inventario_venda[# INFOS.SPRITE, _i] = _sprite;
            inventario_venda[# INFOS.NOME, _i] = _nome;
            inventario_venda[# INFOS.DESCRICAO, _i] = _descricao;
            inventario_venda[# INFOS.DANO, _i] = _dano;
            inventario_venda[# INFOS.ARMADURA, _i] = _armadura;
            inventario_venda[# INFOS.VELOCIDADE, _i] = _velocidade;
            inventario_venda[# INFOS.CURA, _i] = _cura;
            inventario_venda[# INFOS.TIPO, _i] = _tipo;
            inventario_venda[# INFOS.IMAGE_IND, _i] = _ind;
            inventario_venda[# INFOS.PRECO, _i] = _preco;
            break;
        }
    }
}