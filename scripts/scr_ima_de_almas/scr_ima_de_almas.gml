// feather disable GM2017

/// @desc Retorna a estrutura de dados (Vetor de Item) do ÍMÃ DE ALMAS (Passivo)
function scr_ima_de_almas_config()
{
    return {
        stats_base: {
            range_gain: 0,
            sprite_icon: spr_ima_icon
        },
        niveis: [
            { desc: "AUMENTA O RAIO DE COLETA DE XP E ITENS (+50).", upgrade: function(_s) { _s.range_gain = 50; } },
            { desc: "RAIO DE COLETA AUMENTADO EM MAIS 50.", upgrade: function(_s) { _s.range_gain = 50; } },
            { desc: "RAIO DE COLETA AUMENTADO EM MAIS 70.", upgrade: function(_s) { _s.range_gain = 70; } },
            { desc: "RAIO DE COLETA AUMENTADO EM MAIS 80.", upgrade: function(_s) { _s.range_gain = 80; } },
            { desc: "MEGA UPGRADE: RAIO DE COLETA AUMENTADO EM MAIS 200.", upgrade: function(_s) { _s.range_gain = 200; } }
        ]
    };
}

/// @desc Lógica do 'Ímã de Almas' (Aplica bônus permanente de Coleta)
function scr_ima_de_almas(_row_index) 
{
    if (global.level_up) exit;

    var _current_level = global.itens_vamp_grid[# ITENS_VAMP.LEVEL, _row_index]; 
    if (_current_level <= 0) exit;

    var _control_var_name = "passive_last_applied_ima_" + string(_row_index);
    if (!variable_global_exists(_control_var_name)) variable_global_set(_control_var_name, 0);
    
    var _last_applied_level = variable_global_get(_control_var_name);

    if (_last_applied_level < _current_level) 
    {
        var _config = scr_ima_de_almas_config(); 
        var _upgrade_stats = scr_generic_calculate_passive_upgrade(_config, _current_level, global.itens_vamp_grid, _row_index, ITENS_VAMP.DESCRIPTION);

        if (_upgrade_stats.range_gain > 0) {
            if (!variable_global_exists("coleta")) global.coleta = 50;
            global.coleta += _upgrade_stats.range_gain;
        }

        variable_global_set(_control_var_name, _current_level);
        show_debug_message("Ímã de Almas Lvl "+string(_current_level)+"! Raio de Coleta Total: " + string(global.coleta));
    }
}
