Shader "PS Vita/Particles/Unlit Blood" 
{
    Properties 
	{
        __MainTex ("Blood Texture", 2D) = "white" {}
    }
    SubShader 
	{
        Tags 
		{
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
            "CanUseSpriteAtlas"="True"
            "PreviewType"="Plane"
        }
        LOD 100
        Pass 
		{
            Name "FORWARD"
            Blend SrcAlpha OneMinusSrcAlpha
            Cull Off
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            sampler2D __MainTex; fixed4 __MainTex_ST;
            
			struct VertexInput 
			{
                fixed4 vertex : POSITION;
                fixed2 texcoord0 : TEXCOORD0;
                fixed2 texcoord2 : TEXCOORD2;
                fixed4 vertexColor : COLOR;
            };

            struct VertexOutput
			{
                fixed4 pos : SV_POSITION;
                fixed2 uv0 : TEXCOORD0;
                fixed2 uv2 : TEXCOORD1;
                fixed4 vertexColor : COLOR;
            };
            
			VertexOutput vert (VertexInput v) 
			{
                VertexOutput o;
                o.uv0 = v.texcoord0;
                o.uv2 = v.texcoord2;
                o.vertexColor = v.vertexColor;
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            fixed4 frag(VertexOutput i) : COLOR 
			{
                fixed4 __MainTex_var = tex2D(__MainTex,TRANSFORM_TEX(i.uv0, __MainTex));
                fixed3 DiffWithPSColor = (i.vertexColor.rgb*(__MainTex_var.r*__MainTex_var.r*__MainTex_var.r*__MainTex_var.r));
                return fixed4(DiffWithPSColor,(__MainTex_var.r*(1.0 - i.uv2.r)));
            }
            ENDCG
        }
    }
}
