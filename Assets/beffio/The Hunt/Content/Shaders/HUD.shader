// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "beffio/The Hunt/HUD"
{
	Properties
	{
		_EmissionColor("Emission/Color", 2D) = "white" {}
		_Opacityshift("Opacity shift", Range( 0 , 2)) = 1
		_Emissionintensity("Emission intensity", Range( 0 , 100)) = 0
		_Color("Color", Color) = (0,0,0,0)
		[Toggle]_PolychromeMonochrome("Polychrome/Monochrome", Float) = 0
		_Offset("Offset", Range( -0.09 , 0)) = 0
		[Toggle]_Movable("Movable", Float) = 0
		_TextureSample1("Texture Sample 1", 2D) = "white" {}
		[Toggle]_Verticalbars("Vertical bars", Float) = 0
		_Bars_offset("Bars_offset", Range( 0 , 2)) = 0
		_Barsblendng("Bars blendng", Range( 0 , 1)) = 0
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		struct Input
		{
			float2 uv_texcoord;
			float2 uv2_texcoord2;
		};

		uniform float _PolychromeMonochrome;
		uniform sampler2D _EmissionColor;
		uniform float4 _EmissionColor_ST;
		uniform float4 _Color;
		uniform sampler2D _TextureSample1;
		uniform float _Bars_offset;
		uniform float _Barsblendng;
		uniform float _Verticalbars;
		uniform float _Emissionintensity;
		uniform float _Opacityshift;
		uniform float _Offset;
		uniform float _Movable;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_EmissionColor = i.uv_texcoord * _EmissionColor_ST.xy + _EmissionColor_ST.zw;
			float4 tex2DNode1 = tex2D( _EmissionColor, uv_EmissionColor );
			float4 temp_output_6_0 = lerp(tex2DNode1,_Color,_PolychromeMonochrome);
			o.Albedo = temp_output_6_0.rgb;
			float2 appendResult43 = (float2(0.0 , _Bars_offset));
			float2 uv_TexCoord35 = i.uv_texcoord * float2( 1,1 ) + appendResult43;
			float cos36 = cos( radians( 45.0 ) );
			float sin36 = sin( radians( 45.0 ) );
			float2 rotator36 = mul( uv_TexCoord35 - float2( 45,0 ) , float2x2( cos36 , -sin36 , sin36 , cos36 )) + float2( 45,0 );
			float4 blendOpSrc32 = lerp(tex2DNode1,_Color,_PolychromeMonochrome);
			float4 blendOpDest32 = tex2D( _TextureSample1, rotator36 );
			float4 lerpResult45 = lerp( ( saturate( min( blendOpSrc32 , blendOpDest32 ) )) , lerp(tex2DNode1,_Color,_PolychromeMonochrome) , _Barsblendng);
			float4 lerpResult29 = lerp( lerp(tex2DNode1,_Color,_PolychromeMonochrome) , lerpResult45 , lerp(0.0,1.0,_Verticalbars));
			float temp_output_8_0 = ( tex2DNode1.a * _Opacityshift );
			float4 lerpResult2 = lerp( ( lerpResult29 * _Emissionintensity ) , float4( 0,0,0,0 ) , temp_output_8_0);
			o.Emission = lerpResult2.rgb;
			float2 appendResult15 = (float2(_Offset , 0.0));
			float2 uv2_TexCoord14 = i.uv2_texcoord2 * float2( 1,1 ) + appendResult15;
			float lerpResult25 = lerp( 0.0 , 10.0 , tex2D( _EmissionColor, uv2_TexCoord14 ).a);
			float lerpResult26 = lerp( 0.0 , lerpResult25 , temp_output_8_0);
			float myVarName022 = lerp(0.0,1.0,_Movable);
			float lerpResult27 = lerp( temp_output_8_0 , lerpResult26 , myVarName022);
			o.Alpha = lerpResult27;
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
				float4 customPack1 : TEXCOORD1;
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
				o.customPack1.zw = customInputData.uv2_texcoord2;
				o.customPack1.zw = v.texcoord1;
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
				surfIN.uv2_texcoord2 = IN.customPack1.zw;
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
8;100;1035;937;2116.385;1738.331;2.114971;True;False
Node;AmplifyShaderEditor.RangedFloatNode;44;-2548.541,-1693.048;Float;False;Property;_Bars_offset;Bars_offset;9;0;Create;0;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;43;-2176.692,-1606.081;Float;False;FLOAT2;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;35;-1921.987,-1403.197;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RadiansOpNode;40;-1840.203,-1102.975;Float;False;1;0;FLOAT;45.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;5;-1820.558,-195.2962;Float;False;Property;_Color;Color;3;0;Create;0,0,0,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RotatorNode;36;-1553.195,-1215.98;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;45,0;False;2;FLOAT;0.0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;1;-1862.974,28.13855;Float;True;Property;_EmissionColor;Emission/Color;0;0;Create;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;16;-2820.321,-827.3328;Float;False;Property;_Offset;Offset;5;0;Create;0;0;-0.09;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;6;-840.6366,-253.9566;Float;False;Property;_PolychromeMonochrome;Polychrome/Monochrome;4;0;Create;0;2;0;COLOR;0.0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;28;-1006.264,-1236.834;Float;True;Property;_TextureSample1;Texture Sample 1;7;0;Create;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;15;-2438.623,-842.7682;Float;False;FLOAT2;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BlendOpsNode;32;-438.1467,-977.7098;Float;False;Darken;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;46;-419.807,-677.168;Float;False;Property;_Barsblendng;Bars blendng;10;0;Create;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;14;-1893.074,-874.9438;Float;False;1;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;13;-1059.651,-851.3972;Float;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;None;None;True;1;False;white;Auto;False;Instance;1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;45;-111.9352,-502.6524;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ToggleSwitchNode;30;-631.6437,-507.3968;Float;False;Property;_Verticalbars;Vertical bars;8;0;Create;0;2;0;FLOAT;0.0;False;1;FLOAT;1.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-1851.298,285.168;Float;False;Property;_Opacityshift;Opacity shift;1;0;Create;1;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-1492.298,145.1681;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;4;-1678.974,399.8385;Float;False;Property;_Emissionintensity;Emission intensity;2;0;Create;0;0;0;100;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;17;-1366.828,-595.9103;Float;False;Property;_Movable;Movable;6;0;Create;0;2;0;FLOAT;0.0;False;1;FLOAT;1.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;25;-688.2396,432.2821;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;10.0;False;2;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;29;-249.1817,-113.7677;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;22;-987.1239,-571.8622;Float;False;myVarName0;-1;True;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;-6.205234,41.06103;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;21;-1016.197,-434.0471;Float;False;22;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;26;-356.7809,423.9538;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;2;165.6015,31.12654;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;27;-221.7667,206.3578;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;518.7476,-73.20157;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;beffio/The Hunt/HUD;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;Back;0;0;False;0;0;Transparent;0.5;True;True;0;False;Transparent;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;False;2;15;10;25;False;0.5;True;2;SrcAlpha;OneMinusSrcAlpha;0;Zero;Zero;OFF;OFF;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;43;1;44;0
WireConnection;35;1;43;0
WireConnection;36;0;35;0
WireConnection;36;2;40;0
WireConnection;6;0;1;0
WireConnection;6;1;5;0
WireConnection;28;1;36;0
WireConnection;15;0;16;0
WireConnection;32;0;6;0
WireConnection;32;1;28;0
WireConnection;14;1;15;0
WireConnection;13;1;14;0
WireConnection;45;0;32;0
WireConnection;45;1;6;0
WireConnection;45;2;46;0
WireConnection;8;0;1;4
WireConnection;8;1;9;0
WireConnection;25;2;13;4
WireConnection;29;0;6;0
WireConnection;29;1;45;0
WireConnection;29;2;30;0
WireConnection;22;0;17;0
WireConnection;3;0;29;0
WireConnection;3;1;4;0
WireConnection;26;1;25;0
WireConnection;26;2;8;0
WireConnection;2;0;3;0
WireConnection;2;2;8;0
WireConnection;27;0;8;0
WireConnection;27;1;26;0
WireConnection;27;2;21;0
WireConnection;0;0;6;0
WireConnection;0;2;2;0
WireConnection;0;9;27;0
ASEEND*/
//CHKSM=5F546848BC83A6CD69BCFB1AFF1CC13DC6F721F3