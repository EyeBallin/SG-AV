//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform vec2 aspectRatio;
uniform float screenWidth;
uniform float screenHeight;

vec2 curveRemapUV(vec2 uv)
{
    // as we near the edge of our screen apply greater distortion using a cubic function
    uv = uv * 2.0 - 1.0;
    vec2 offset = abs(uv.yx) / vec2(5.0, 5.0);
    uv = uv + uv * offset * offset;
    uv = uv * 0.5 + 0.5;
    return uv;
}

void main()
{
    vec2 finalDisplay = curveRemapUV(v_vTexcoord);
    
    vec4 currCol = texture2D(gm_BaseTexture, finalDisplay);
    vec2 fragAlphaVecTL = clamp(finalDisplay * 25.0, 0.0, 1.0);
    vec2 fragAlphaVecBR = clamp((1.0 - finalDisplay) * 25.0, 0.0, 1.0);
    float fragAlphaMin = min(min(fragAlphaVecTL.x, fragAlphaVecTL.y), min(fragAlphaVecBR.x, fragAlphaVecBR.y));
    
    //Clear stuff out of bounds
    vec2 xyInBounds = step(0.0, finalDisplay) - step(1.0, finalDisplay);
    float isInBounds = xyInBounds.x * xyInBounds.y;
    vec3 borderCol = vec3(isInBounds);
    vec4 blackBorder = vec4(borderCol, 1.0);
    
    gl_FragColor = v_vColour * vec4(currCol.r, currCol.g, currCol.b, fragAlphaMin) * blackBorder;
    //gl_FragColor = v_vColour * vec4(currCol.r, currCol.g, currCol.b, fragAlphaMin) * texture2D(gm_BaseTexture, v_vTexcoord + fragDistortAmt);
    //gl_FragColor = v_vColour * vec4(1.0, 0.0, 0.0, 1.0);
}
