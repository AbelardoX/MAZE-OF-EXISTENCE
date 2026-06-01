// feather disable GM2017
/// @description Lógica de movimento e animação

// ========================================================
// FASE 1: Voando e Aparecendo (Ainda NÃO encostou)
// ========================================================
if (!ja_encostou) {
    
    // --- Lógica de Movimento ---
    // Verifica se o alvo ainda existe (ele pode ter morrido antes da bola chegar)
    if (instance_exists(alvo)) {
        // Move-se em linha reta em direção às coordenadas atuais do alvo
        move_towards_point(alvo.x, alvo.y, velocidade_movimento);
        
        // Opcional: Rotacionar a sprite para apontar pro alvo
    } else {
        // Se o alvo sumiu no meio do caminho, para de mover ou segue reto
        
        // Tenta achar um novo alvo próximo se o antigo sumiu
        alvo = instance_nearest(x, y, obj_par_inimigos);
    }
    
    // --- Sua Lógica de Animação (0 ao 3) ---
    // Se ainda não chegou no index 3, avança manualmente
    if (image_index < 3) {
        image_index += velocidade_aparecer;
    }
    
    // Garante que trave exatamente no index 3
    if (image_index >= 3) {
        image_index = 3;
    }

  
}
// FASE 2: ja_encostou é true.
// O código acima não roda. O objeto fica parado (speed=0)
// e a animação corre normal (image_speed = 1).