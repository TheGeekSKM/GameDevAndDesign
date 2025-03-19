precision highp float;

attribute vec3 in_Position;
attribute vec4 in_Colour;
attribute vec2 in_TextureCoord;

varying vec2 v_vTexcoord;
varying vec4 v_vColor;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vColor = in_Colour;
    v_vTexcoord = in_TextureCoord;
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~
precision highp float;

varying vec2 v_vTexcoord;
varying vec4 v_vColor;

uniform vec2 u_vTexel;
uniform vec2 u_vShadowDelta;

float InsideTexture(vec2 point)
{
    vec2 result = step(0.0, point) - step(1.0, point);
    return result.x*result.y;   
}

void main()
{
    if (all(equal(u_vShadowDelta, vec2(0.0))))
    {
        gl_FragColor = vec4(texture2D(gm_BaseTexture, v_vTexcoord).a,
                            0.0,
                            0.0,
                            1.0);
    }
    else
    {
        vec2 shadowTexcoord = v_vTexcoord - u_vTexel*u_vShadowDelta;
        gl_FragColor = vec4(texture2D(gm_BaseTexture, v_vTexcoord).a,
                            0.0,
                            texture2D(gm_BaseTexture, shadowTexcoord).a*InsideTexture(shadowTexcoord),
                            1.0);
    }
}

