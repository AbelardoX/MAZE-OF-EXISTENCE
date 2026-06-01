// feather disable GM2017
/// Create Event do obj_next_room
room_destino = undefined; // Pode ser um Asset de Room ou um Array [x, y]
room_origem = undefined;
index = false;


// Contar o número total de inimigos na sala (todos os inimigos que têm 'obj_par_inimigos' como parente)
// feather ignore GM2017
var _total_inimigos = instance_number(obj_par_inimigos) + instance_number(par_boss);

