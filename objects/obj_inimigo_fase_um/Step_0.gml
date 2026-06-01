// feather disable GM2017
// Verifica se o obj_sperm existe na sala
if (instance_exists(obj_sperm)) {
    // Obtém a posição do obj_sperm
    var _alvo_x = obj_sperm.x;
    var _alvo_y = obj_sperm.y;
    
    // Direção do inimigo para o obj_sperm
    var _direcao = point_direction(x, y, _alvo_x, _alvo_y);
    
    // Ajustar a rotação do inimigo para a direção calculada
    image_angle = _direcao + 90;  // Subtrai 90 graus para alinhar o "frente" do retângulo corretamente
    
    // Velocidade do inimigo
  
    
    // Movimentar o inimigo na direção do obj_sperm
    x += lengthdir_x(velocidade_inimigo, _direcao);
    y += lengthdir_y(velocidade_inimigo, _direcao);
}

