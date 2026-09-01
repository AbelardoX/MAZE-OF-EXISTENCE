// Se o jogo estiver pausado ou em diálogo, não processa cooldowns
if (global.level_up || (variable_global_exists("dialogo") && global.dialogo)) exit;

var _owned_ids = variable_struct_get_names(skills_owned);
for (var _i = 0; _i < array_length(_owned_ids); _i++) {
    var _id = _owned_ids[_i];
    var _skill_def = global.skill_db[$ _id];
    var _owned_data = skills_owned[$ _id];
    
    if (_skill_def.type == SKILL_TYPE.ACTIVE) {
        if (_owned_data.cooldown_timer > 0) {
            _owned_data.cooldown_timer--;
        } else {
            var _level_stats = _skill_def.levels[_owned_data.level - 1];
            
            // O contexto 'with' garante que a skill execute a partir do player
            with (obj_player) {
                _skill_def.on_fire(_level_stats);
            }
            
            var _cd_mod = (variable_global_exists("player_cooldown_mod") ? global.player_cooldown_mod : 1);
            _owned_data.cooldown_timer = _level_stats.cooldown * _cd_mod;
        }
    }
}
