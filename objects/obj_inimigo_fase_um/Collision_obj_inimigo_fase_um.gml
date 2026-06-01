// feather disable GM2017
/// @description Insert description here
// You can write your code in this editor


    // Código que será executado em caso de colisão
    // Por exemplo: parar o movimento ou aplicar um efeito
    
    // Aqui você pode parar o movimento ou fazer outro comportamento
    speed = 2;

    // Alternativamente, você pode aplicar uma força contrária para "empurrar" os inimigos
    var _direcao_colisao = point_direction(x, y, other.x, other.y);
    x += lengthdir_x(-3, _direcao_colisao);  // Empurra o inimigo para trás
    y += lengthdir_y(-3, _direcao_colisao);

// Quando dois inimigos colidem

// Calcular a direção entre os dois inimigos para afastá-los
var _direcao = point_direction(x, y, other.x, other.y);

// Empurrar ambos os inimigos na direção oposta à colisão
x += lengthdir_x(-3, _direcao);
y += lengthdir_y(-3, _direcao);

// Também mover o outro inimigo
other.x += lengthdir_x(3, _direcao);
other.y += lengthdir_y(3, _direcao);

// Código adicional para colisão (parar movimento, mudar direção, etc.)













