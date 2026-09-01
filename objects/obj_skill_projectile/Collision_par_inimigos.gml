if (!instance_exists(other)) exit;

var _kb_force = push_force;
var _kb_dir = direction;

scr_enemy_damage_apply(other, damage, _kb_force, _kb_dir, false);

instance_destroy();
