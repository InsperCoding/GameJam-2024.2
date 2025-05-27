shader_type canvas_item;

// Parâmetro para controlar a suavidade e o tamanho do efeito
uniform float smoothness : hint_range(0.1, 2.0) = 0.6;
// Parâmetro para controlar a intensidade da borda escura
uniform float opacity : hint_range(0.0, 1.0) = 1.0;


void fragment() {
    // Calcula a distância do centro da tela (0.5, 0.5) para o pixel atual
    float distance = length(SCREEN_UV - vec2(0.5));

    // Cria a transição suave usando a distância
    float vignette = smoothstep(0.0, smoothness, distance);

    // A cor final é preta, e a transparência é controlada pela vinheta e pela opacidade geral
    COLOR = vec4(0.0, 0.0, 0.0, vignette * opacity);
}