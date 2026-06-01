// feather disable GM2017
draw_self(); // desenha o sprite normalmente

// Alpha oscilando entre 0.3 e 0.8
var _alpha_pulsante = 0.55 + 0.25 * sin(current_time * 0.005);

// Cor e alpha
draw_set_color(c_red);
draw_set_alpha(_alpha_pulsante);

// Restaura alpha padrão
draw_set_alpha(1);
