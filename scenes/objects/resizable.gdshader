shader_type canvas_item;

uniform vec4 line_color : source_color = vec4(1.0); // Color of the outline
uniform float width : hint_range(0, 10) = 0.0; // Width of the outline


// Offsets to check neighboring pixels for the outline
const vec2 OFFSETS[8] = vec2[](
    vec2(-1, -1), vec2(-1, 0), vec2(-1, 1),
    vec2(0, -1), vec2(0, 1),
    vec2(1, -1), vec2(1, 0), vec2(1, 1)
);

void vertex() {
    // Add margin to the original sprite vertices based on the outline width
    // This scales up the sprite, which will be scaled down later in the fragment() function
    VERTEX += (UV * 2.0 - 1.0) * width;
}

void fragment() {
    // Sample the color from the original texture
    vec4 color = texture(TEXTURE, UV);

    if (width > 0.0) {
        // Calculate the real texture size from the texture pixel size
        vec2 real_texture_size = 1.0 / TEXTURE_PIXEL_SIZE;

        // Calculate the size of the texture with the added margin for the outline
        vec2 added_margin_texture_pixel_size = 1.0 / (real_texture_size + (width * 2.0));

        // Calculate the width in texture coordinates
        vec2 width_size = added_margin_texture_pixel_size * width;

        // Shift the UV coordinates to account for the added margin
        vec2 shifted_uv = UV - width_size;

        // Calculate the ratio to scale down the UV coordinates to the original size
        vec2 ratio = TEXTURE_PIXEL_SIZE / added_margin_texture_pixel_size;
        vec2 scaled_shifted_uv = shifted_uv * ratio;

        // Sample the original texture with the adjusted UV to scale it back to the original size
        vec4 original_color = texture(TEXTURE, scaled_shifted_uv);

        // Check if the adjusted UV coordinates are outside the bounds of the texture
        if (scaled_shifted_uv.x < 0.0 || scaled_shifted_uv.x > 1.0 || scaled_shifted_uv.y < 0.0 || scaled_shifted_uv.y > 1.0) {
            original_color.a = 0.0; // Set alpha to 0 to remove artifacts outside the sprite boundary
        }

        // Initialize the outline alpha value
        float outline = 0.0;

        // Sum the alpha values of the neighboring pixels to create the outline
        for (int i = 0; i < 8; i++) {
            outline += texture(TEXTURE, scaled_shifted_uv + OFFSETS[i] * width_size).a;

        }

        // Clamp the outline value to a maximum of 1.0
        outline = min(outline, 1.0);

        // Mix the original color with the outline color based on the outline alpha value
        color = mix(original_color, line_color, outline - original_color.a);
    }

    // Set the final color of the fragment
    COLOR = color;
}