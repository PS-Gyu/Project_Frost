// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "beffio/The Hunt/Car Jet Exhaust"
{
	Properties
	{
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_Emissioncolor("Emission color", Color) = (1,1,1,0)
		_Thrustfallof("Thrust fallof", Range( 0 , 10)) = 0
		_Emissionintensity("Emission intensity", Range( 0 , 200)) = 0
		_TextureSample1("Texture Sample 1", 2D) = "white" {}
		_bars1("bars 1", 2D) = "white" {}
		_Barstiling("Bars tiling", Range( 0 , 50)) = 5
		_TextureSample2("Texture Sample 2", 2D) = "white" {}
		_swirl("swirl", 2D) = "white" {}
		_Speednoise("Speed noise", Range( 0 , 5)) = 0
		_Speedbars("Speed bars", Range( 0 , 5)) = 0
		_Thrusttiling("Thrust tiling", Range( 1 , 10)) = 1
		_Thrustspeed("Thrust speed", Range( 0 , 10)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float4 _Emissioncolor;
		uniform float _Emissionintensity;
		uniform sampler2D _TextureSample0;
		uniform float4 _TextureSample0_ST;
		uniform sampler2D _bars1;
		uniform float _Speedbars;
		uniform float _Barstiling;
		uniform sampler2D _TextureSample1;
		uniform sampler2D _swirl;
		uniform float _Speednoise;
		uniform sampler2D _TextureSample2;
		uniform float _Thrustspeed;
		uniform float _Thrusttiling;
		uniform float _Thrustfallof;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 _Color0 = float4(0,0,0,0);
			float2 uv_TextureSample0 = i.uv_texcoord * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
			float4 temp_cast_0 = (tex2D( _TextureSample0, uv_TextureSample0 ).a).xxxx;
			float2 appendResult21 = (float2(0.0 , _Speedbars));
			float2 temp_cast_1 = (_Barstiling).xx;
			float2 uv_TexCoord12 = i.uv_texcoord * temp_cast_1 + float2( 0,0 );
			float2 panner13 = ( uv_TexCoord12 + 1.0 * _Time.y * appendResult21);
			float2 appendResult23 = (float2(0.0 , 0.05));
			float2 temp_cast_2 = (0.0).xx;
			float2 uv_TexCoord24 = i.uv_texcoord * temp_cast_2 + float2( 0,0 );
			float2 panner25 = ( uv_TexCoord24 + 1.0 * _Time.y * appendResult23);
			float4 clampResult51 = clamp( tex2D( _TextureSample1, panner25 ) , float4( 0.2132353,0.2132353,0.2132353,0 ) , float4( 0.8970588,0.8970588,0.8970588,0 ) );
			float4 lerpResult29 = lerp( _Color0 , tex2D( _bars1, panner13 ) , clampResult51.r);
			float2 appendResult22 = (float2(0.0 , _Speednoise));
			float2 temp_cast_4 = (10.0).xx;
			float2 uv_TexCoord16 = i.uv_texcoord * temp_cast_4 + float2( 0,0 );
			float2 panner17 = ( uv_TexCoord16 + 1.0 * _Time.y * appendResult22);
			float4 lerpResult18 = lerp( lerpResult29 , _Color0 , tex2D( _swirl, panner17 ).r);
			float2 appendResult33 = (float2(_Thrustspeed , 0.0));
			float2 temp_cast_6 = (_Thrusttiling).xx;
			float2 uv_TexCoord34 = i.uv_texcoord * temp_cast_6 + float2( 0.55,0.56 );
			float2 panner32 = ( uv_TexCoord34 + 1.0 * _Time.y * appendResult33);
			float4 lerpResult10 = lerp( temp_cast_0 , _Color0 , abs( ( lerpResult18 - tex2D( _TextureSample2, panner32 ) ) ).r);
			float4 temp_cast_8 = (_Thrustfallof).xxxx;
			float4 temp_output_7_0 = pow( lerpResult10 , temp_cast_8 );
			float4 lerpResult3 = lerp( _Color0 , ( _Emissioncolor * _Emissionintensity ) , temp_output_7_0.r);
			o.Emission = lerpResult3.rgb;
			o.Alpha = temp_output_7_0.r;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard alpha:fade keepalpha fullforwardshadows 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				fixed3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			fixed4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = IN.worldPos;
				fixed3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=14201
8;100;1035;937;3698.418;923.543;1.6;True;False
Node;AmplifyShaderEditor.RangedFloatNode;28;-2690.111,-300.6929;Float;False;Constant;_Float3;Float 3;8;0;Create;0.05;0.02;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;26;-2679.672,-414.474;Float;False;Constant;_Float2;Float 2;5;0;Create;0;0;0;50;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;19;-2140.814,139.5837;Float;False;Property;_Speedbars;Speed bars;10;0;Create;0;0.47;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-2153.775,59.4079;Float;False;Property;_Barstiling;Bars tiling;6;0;Create;5;4.7;0;50;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;23;-2295.106,-304.5931;Float;False;FLOAT2;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;24;-2343.048,-459.6391;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;15;-2257.73,499.0065;Float;False;Constant;_Float1;Float 1;5;0;Create;10;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;21;-1780.21,250.2888;Float;False;FLOAT2;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-2147.565,736.8553;Float;False;Property;_Speednoise;Speed noise;9;0;Create;0;5;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;25;-2028.215,-450.4675;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0.7;False;1;FLOAT;1.0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;12;-1826.152,120.2428;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;13;-1533.42,122.9144;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0.7;False;1;FLOAT;1.0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;22;-1789.51,743.8889;Float;False;FLOAT2;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;42;-2468.599,302.0615;Float;False;Property;_Thrusttiling;Thrust tiling;11;0;Create;1;3.82;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;44;-2260.107,394.3992;Float;False;Property;_Thrustspeed;Thrust speed;12;0;Create;0;1.83;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;27;-1793.711,-417.8931;Float;True;Property;_TextureSample1;Texture Sample 1;4;0;Create;e7bae02c569040a4fbf67b8d98cf7828;e7bae02c569040a4fbf67b8d98cf7828;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;16;-1904.307,502.5414;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;2;-1116.98,-589.869;Float;False;Constant;_Color0;Color 0;1;0;Create;0,0,0,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;33;-1801.527,387.1794;Float;False;FLOAT2;4;0;FLOAT;1.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;9;-1335.513,45.13808;Float;True;Property;_bars1;bars 1;5;0;Create;e7bae02c569040a4fbf67b8d98cf7828;e7bae02c569040a4fbf67b8d98cf7828;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;17;-1576.475,490.713;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0.7;False;1;FLOAT;1.0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ClampOpNode;51;-1474.218,-221.2552;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0.2132353,0.2132353,0.2132353,0;False;2;COLOR;0.8970588,0.8970588,0.8970588,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;34;-2145.3,255.3574;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0.55,0.56;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;32;-1563.986,322.463;Float;False;3;0;FLOAT2;1,1;False;2;FLOAT2;0,0;False;1;FLOAT;1.0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;29;-1210.564,-167.603;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;14;-1196.727,466.6566;Float;True;Property;_swirl;swirl;8;0;Create;fa7b6704e3f282f4594e3e58fb3be164;fa7b6704e3f282f4594e3e58fb3be164;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;18;-1012.11,-85.55247;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;31;-1275.825,239.0029;Float;True;Property;_TextureSample2;Texture Sample 2;7;0;Create;fa7b6704e3f282f4594e3e58fb3be164;fa7b6704e3f282f4594e3e58fb3be164;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;43;-724.5991,-109.9385;Float;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;1;-1223.055,-423.7566;Float;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;None;a020c3e60fc51cb42b092ae7a59bb5d8;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.AbsOpNode;50;-517.1106,-119.9389;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-429.247,264.8203;Float;False;Property;_Emissionintensity;Emission intensity;3;0;Create;0;200;0;200;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;10;-431.5415,-261.869;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0;False;2;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-426.6545,150.2368;Float;False;Property;_Thrustfallof;Thrust fallof;2;0;Create;0;8.4;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;4;-576.7712,-664.3023;Float;False;Property;_Emissioncolor;Emission color;1;0;Create;1,1,1,0;0,1,0.7517238,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;7;-201.783,-68.33582;Float;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-241.4174,-333.5992;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;3;-12.0241,-163.4187;Float;False;3;0;COLOR;0.0,0,0,0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;409.8973,0.2411361;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;beffio/The Hunt/Car Jet Exhaust;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;Off;0;0;False;0;0;Transparent;0.5;True;True;0;False;Transparent;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;False;2;15;10;25;False;0.5;True;2;SrcAlpha;OneMinusSrcAlpha;0;Zero;Zero;OFF;OFF;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;23;1;28;0
WireConnection;24;0;26;0
WireConnection;21;1;19;0
WireConnection;25;0;24;0
WireConnection;25;2;23;0
WireConnection;12;0;11;0
WireConnection;13;0;12;0
WireConnection;13;2;21;0
WireConnection;22;1;20;0
WireConnection;27;1;25;0
WireConnection;16;0;15;0
WireConnection;33;0;44;0
WireConnection;9;1;13;0
WireConnection;17;0;16;0
WireConnection;17;2;22;0
WireConnection;51;0;27;0
WireConnection;34;0;42;0
WireConnection;32;0;34;0
WireConnection;32;2;33;0
WireConnection;29;0;2;0
WireConnection;29;1;9;0
WireConnection;29;2;51;0
WireConnection;14;1;17;0
WireConnection;18;0;29;0
WireConnection;18;1;2;0
WireConnection;18;2;14;0
WireConnection;31;1;32;0
WireConnection;43;0;18;0
WireConnection;43;1;31;0
WireConnection;50;0;43;0
WireConnection;10;0;1;4
WireConnection;10;1;2;0
WireConnection;10;2;50;0
WireConnection;7;0;10;0
WireConnection;7;1;8;0
WireConnection;5;0;4;0
WireConnection;5;1;6;0
WireConnection;3;0;2;0
WireConnection;3;1;5;0
WireConnection;3;2;7;0
WireConnection;0;2;3;0
WireConnection;0;9;7;0
ASEEND*/
//CHKSM=56C171A9E2126078A79D8ABC71B9E8CA30325BBE