// feather disable GM2017

/// @desc Retorna a estrutura de dados (Vetor de Item) da PENA (Passivo)
function scr_feather_config()
{
    return {
        stats_base: {
            speed_gain_percent: 0, 
			sprite_icon: spr_pena_icon
        },
        niveis: [
            { desc: "DEIXA O JOGADOR MAIS RÁPIDO (+5% Velocidade).", upgrade: function(_s) { _s.speed_gain_percent = 5; } },
            { desc: "VELOCIDADE AUMENTADA EM MAIS 5%.", upgrade: function(_s) { _s.speed_gain_percent = 5; } },
            { desc: "VELOCIDADE AUMENTADA EM MAIS 10%.", upgrade: function(_s) { _s.speed_gain_percent = 10; } },
            { desc: "VELOCIDADE AUMENTADA EM MAIS 10%.", upgrade: function(_s) { _s.speed_gain_percent = 10; } },
            { desc: "MEGA UPGRADE: VELOCIDADE AUMENTADA EM MAIS 15%.", upgrade: function(_s) { _s.speed_gain_percent = 15; } }
        ]
    };
}

/// @desc Lógica da 'Pena' (Aplica bônus permanente de Velocidade)
function scr_pena(_row_index) 
{
    if (global.level_up) exit;

    var _current_level = global.itens_vamp_grid[# ITENS_VAMP.LEVEL, _row_index]; 
    if (_current_level <= 0) exit;

    var _control_var_name = "passive_last_applied_pena_" + string(_row_index);
    if (!variable_global_exists(_control_var_name)) variable_global_set(_control_var_name, 0);
    
    var _last_applied_level = variable_global_get(_control_var_name);

    if (_last_applied_level < _current_level) 
    {
        var _config = scr_feather_config(); 
        var _upgrade_stats = scr_generic_calculate_passive_upgrade(_config, _current_level, global.itens_vamp_grid, _row_index, ITENS_VAMP.DESCRIPTION);

        if (_upgrade_stats.speed_gain_percent > 0) {
            global.speed_player *= (1 + (_upgrade_stats.speed_gain_percent / 100));
        }

        variable_global_set(_control_var_name, _current_level);
        show_debug_message("Pena Lvl "+string(_current_level)+"! Nova Velocidade: " + string(global.speed_player));
    }
}
