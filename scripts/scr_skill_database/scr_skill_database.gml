// Enumeração para identificar o tipo de skill facilmente
enum SKILL_TYPE {
    ACTIVE,
    PASSIVE
}

function inicializar_skill_database() {
    global.skill_db = {};

    // ==========================================
    //           HABILIDADES ATIVAS
    // ==========================================

    // 1. Lâminas Giras (Orbital)
    global.skill_db.laminas_giras = {
        name: "Lâminas Giras",
        description: "Lâminas orbitam ao seu redor, cortando inimigos.",
        type: SKILL_TYPE.ACTIVE,
        icon: spr_icone_laminas, // Substitua pelo nome da sua sprite
        max_level: 5,
        levels: [
            { damage: 10, cooldown: 180, amount: 1, orbit_speed: 2 },   // Nvl 1
            { damage: 15, cooldown: 160, amount: 1, orbit_speed: 3 },   // Nvl 2
            { damage: 15, cooldown: 140, amount: 2, orbit_speed: 3 },   // Nvl 3
            { damage: 20, cooldown: 120, amount: 2, orbit_speed: 4 },   // Nvl 4
            { damage: 30, cooldown: 100, amount: 3, orbit_speed: 5 }    // Nvl 5
        ],
        on_fire: function(_level_data) {
            for (var i = 0; i < _level_data.amount; i++) {
                var _inst = instance_create_layer(obj_player.x, obj_player.y, "Instances", obj_skill_projectile);
                _inst.dano = _level_data.damage;
                _inst.comportamento = "orbitar";
                _inst.velocidade_orbita = _level_data.orbit_speed;
                // A separação angular seria 360 / amount calculada no Step do projétil
            }
        }
    };

    // 2. Rastro Sombrio (Poça de Dano)
    global.skill_db.rastro_sombrio = {
        name: "Rastro Sombrio",
        description: "Deixa poças de energia escura por onde você passa.",
        type: SKILL_TYPE.ACTIVE,
        icon: spr_icone_rastro,
        max_level: 5,
        levels: [
            { damage: 5,  cooldown: 60, duration: 120, scale: 1.0 },
            { damage: 8,  cooldown: 55, duration: 150, scale: 1.2 },
            { damage: 12, cooldown: 50, duration: 180, scale: 1.4 },
            { damage: 18, cooldown: 45, duration: 210, scale: 1.6 },
            { damage: 25, cooldown: 40, duration: 240, scale: 2.0 }
        ],
        on_fire: function(_level_data) {
            var _inst = instance_create_layer(obj_player.x, obj_player.y, "Instances", obj_skill_projectile);
            _inst.dano = _level_data.damage;
            _inst.comportamento = "estatico";
            _inst.tempo_vida = _level_data.duration;
            _inst.image_xscale = _level_data.scale * global.player_area_mod;
            _inst.image_yscale = _level_data.scale * global.player_area_mod;
        }
    };

    // 3. Adagas Velozes (Tiro Direto)
    global.skill_db.adagas_velozes = {
        name: "Adagas Velozes",
        description: "Dispara adagas na direção em que você está olhando.",
        type: SKILL_TYPE.ACTIVE,
        icon: spr_icone_adaga,
        max_level: 5,
        levels: [
            { damage: 8,  cooldown: 90, amount: 1, speed: 6 },
            { damage: 12, cooldown: 80, amount: 2, speed: 7 },
            { damage: 18, cooldown: 70, amount: 3, speed: 8 },
            { damage: 25, cooldown: 60, amount: 4, speed: 9 },
            { damage: 35, cooldown: 40, amount: 6, speed: 10 }
        ],
        on_fire: function(_level_data) {
            var _dir_base = obj_player.image_xscale > 0 ? 0 : 180; // Simplificado para olhar pra esq/dir
            
            for (var i = 0; i < _level_data.amount; i++) {
                var _inst = instance_create_layer(obj_player.x, obj_player.y, "Instances", obj_skill_projectile);
                _inst.dano = _level_data.damage;
                _inst.comportamento = "direto";
                _inst.speed = _level_data.speed;
                // Adiciona um leve spread (espalhamento) se for mais de 1 adaga
                var _spread = (_level_data.amount > 1) ? irandom_range(-15, 15) : 0;
                _inst.direction = _dir_base + _spread;
                _inst.image_angle = _inst.direction;
            }
        }
    };

    // ==========================================
    //           HABILIDADES PASSIVAS
    // ==========================================

    // 4. Anel Amplificador (Aumenta Área)
    global.skill_db.anel_amplificador = {
        name: "Anel Amplificador",
        description: "Aumenta o tamanho e a área de todos os seus ataques.",
        type: SKILL_TYPE.PASSIVE,
        icon: spr_icone_anel,
        max_level: 5,
        levels: [
            { area_bonus: 0.10 }, // +10%
            { area_bonus: 0.20 }, // +20%
            { area_bonus: 0.30 }, // +30%
            { area_bonus: 0.40 }, // +40%
            { area_bonus: 0.60 }  // +60%
        ],
        modifiers: function(_level_data) {
            global.player_area_mod += _level_data.area_bonus;
        }
    };

    // 5. Tomo da Celeridade (Reduz Cooldown)
    global.skill_db.tomo_celeridade = {
        name: "Tomo da Celeridade",
        description: "Habilidades disparam muito mais rápido.",
        type: SKILL_TYPE.PASSIVE,
        icon: spr_icone_tomo,
        max_level: 5,
        levels: [
            { cdr: 0.08 }, // -8%
            { cdr: 0.16 }, // -16%
            { cdr: 0.24 }, // -24%
            { cdr: 0.32 }, // -32%
            { cdr: 0.40 }  // -40%
        ],
        modifiers: function(_level_data) {
            // Se o modificador base é 1.0, subtraímos a redução
            global.player_cooldown_mod -= _level_data.cdr;
        }
    };

    // 6. Ímã de Almas (Área de Coleta)
    global.skill_db.ima_de_almas = {
        name: "Ímã de Almas",
        description: "Atrai XP e itens de muito mais longe.",
        type: SKILL_TYPE.PASSIVE,
        icon: spr_icone_ima,
        max_level: 5,
        levels: [
            { pickup_bonus: 20 }, // +20 pixels
            { pickup_bonus: 40 },
            { pickup_bonus: 60 },
            { pickup_bonus: 80 },
            { pickup_bonus: 120 }
        ],
        modifiers: function(_level_data) {
            global.coleta += _level_data.pickup_bonus;
        }
    };
}