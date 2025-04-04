//   @jujuadams   v8.0.0   2021-12-15
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
//   @jujuadams   v8.0.0   2021-12-15
precision highp float;

const float PI = 3.14159265359;

varying vec2 v_vTexcoord;
varying vec4 v_vColor;

uniform vec2 u_vTexel;
uniform vec3 u_vOutlineColor;

const int  u_iOutlineSamples = 8;
const int  u_iOutlineSize    = 2;

void main()
{
    vec4 outlineColor = vec4(u_vOutlineColor, 1.0);
    vec4 newColor = vec4(u_vOutlineColor, 0.0);
    
    for(int iAngle = 0; iAngle < u_iOutlineSamples; iAngle++)
    {
        float fAngle = 2.0*PI*float(iAngle) / float(u_iOutlineSamples);
        for(int radius = 1; radius <= u_iOutlineSize; radius++)
        {
            newColor = mix(newColor, outlineColor, texture2D(gm_BaseTexture, v_vTexcoord + u_vTexel*(float(radius)*vec2(cos(fAngle), sin(fAngle)))).a);
        }
    }
    
    vec4 sample = texture2D(gm_BaseTexture, v_vTexcoord);
    gl_FragColor = v_vColor*mix(newColor, sample, sample.a);
    gl_FragColor.a = max(newColor.a,sample.a);
}

