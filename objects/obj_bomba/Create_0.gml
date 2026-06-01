// feather disable GM2017
// Variáveis iniciais (definidas pelo script de lançamento)
start_x = x;
start_y = y;
target_x = 0;
target_y = 0;
damage = 0;
radius = 0; // O raio real da explosão
push_force = 0;
splash_multiplier = 0;

flight_timer = 0;
flight_duration = 1;

state = "flying"; // Pode ser "flying" ou "exploding"

var _dist = point_distance(x, y, target_x, target_y);
throw_height = 40;
throw_speed = _dist / 20;

initial_x = x;
initial_y = y;

// --- NOVAS VARIÁVEIS PARA GERENCIAR O TAMANHO ---
base_bomb_size = 600; // Tamanho base (em pixels) do seu sprite de bomba. Ajuste se necessário.
z = 0;             // Por exemplo, se o seu spr_bomba tem 32x32 pixels.
// --- FIM DAS NOVAS VARIÁVEIS ---

// Variáveis para a explosão
explosion_timer = 0;
explosion_duration = 30;
exploded = false;


image_speed = 1;
image_xscale = 1; // Escala inicial
image_yscale = 1; // Escala inicial