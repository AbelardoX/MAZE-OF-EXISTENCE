// feather disable GM2017
function cutscene_fada1() 
{
    var _fada = instance_find(obj_npc_fada, 0);
    if (_fada == noone) return;

    var _scene = new CutsceneBuilder();

    _scene
        .set_var(_fada, "dig", 3)
        .move(_fada, 0, 200, true, 3)     // Move relativo (+200y para descer)
        .sound(snd_fala, false)
        .scale(_fada, -3)                // Olha para o player (escala 3 base)
        .wait(1)
        .create(_fada.x + 200, _fada.y, "Instances_Enemys", obj_amoeba)
        .dialogue("C1")                         // NOVO: Chama o diálogo "C1" e espera terminar
        .move(_fada, 800, 0, true, 3)
        .finish(instance_find(obj_cutscene, 0))
        .run();
}