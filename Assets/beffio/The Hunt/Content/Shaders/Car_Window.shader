// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "beffio/The Hunt/Car Window"
{
	Properties
	{
		_Metallic("Metallic", 2D) = "white" {}
		_Albedo("Albedo", 2D) = "white" {}
		_Normal("Normal", 2D) = "bump" {}
		_Opacityshift("Opacity shift", Range( 0 , 2)) = 1
		_Smoothnessshift("Smoothness shift", Range( 0 , 2)) = 1
		_raindrops_vert("raindrops_vert", 2D) = "bump" {}
		_Rainspeed("Rain speed", Range( 0 , 50)) = 5
		_Rainintensity("Rain intensity", Range( 0 , 10)) = 0
		_Raintiling("Rain tiling", Vector) = (1,1,0,0)
		_Raindrops_normals("Raindrops_normals", 2D) = "bump" {}
		_Colorshift("Color shift", Color) = (0.6691177,0.6691177,0.6691177,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" }
		Cull Back
		CGINCLUDE
		#include "UnityStandardUtils.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) fixed3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float2 uv_texcoord;
			float2 uv2_texcoord2;
			float3 worldNormal;
			INTERNAL_DATA
		};

		uniform sampler2D _Normal;
		uniform float _Rainintensity;
		uniform sampler2D _raindrops_vert;
		uniform float2 _Raintiling;
		uniform float _Rainspeed;
		uniform sampler2D _Raindrops_normals;
		uniform float4 _Raindrops_normals_ST;
		uniform sampler2D _Albedo;
		uniform float4 _Colorshift;
		uniform sampler2D _Metallic;
		uniform float _Smoothnessshift;
		uniform float _Opacityshift;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_TexCoord1 = i.uv_texcoord * float2( 1,1 ) + float2( 0,0 );
			float2 uv2_TexCoord48 = i.uv2_texcoord2 * _Raintiling + float2( 0,0 );
			float2 appendResult51 = (float2(frac( uv2_TexCoord48.x ) , frac( uv2_TexCoord48.y )));
			// *** BEGIN Flipbook UV Animation vars ***
			// Total tiles of Flipbook Texture
			float fbtotaltiles53 = 5.0 * 5.0;
			// Offsets for cols and rows of Flipbook Texture
			float fbcolsoffset53 = 1.0f / 5.0;
			float fbrowsoffset53 = 1.0f / 5.0;
			// Speed of animation
			float fbspeed53 = _Time[ 1 ] * _Rainspeed;
			// UV Tiling (col and row offset)
			float2 fbtiling53 = float2(fbcolsoffset53, fbrowsoffset53);
			// UV Offset - calculate current tile linear index, and convert it to (X * coloffset, Y * rowoffset)
			// Calculate current tile linear index
			float fbcurrenttileindex53 = round( fmod( fbspeed53 + 0.0, fbtotaltiles53) );
			fbcurrenttileindex53 += ( fbcurrenttileindex53 < 0) ? fbtotaltiles53 : 0;
			// Obtain Offset X coordinate from current tile linear index
			float fblinearindextox53 = round ( fmod ( fbcurrenttileindex53, 5.0 ) );
			// Multiply Offset X by coloffset
			float fboffsetx53 = fblinearindextox53 * fbcolsoffset53;
			// Obtain Offset Y coordinate from current tile linear index
			float fblinearindextoy53 = round( fmod( ( fbcurrenttileindex53 - fblinearindextox53 ) / 5.0, 5.0 ) );
			// Reverse Y to get tiles from Top to Bottom
			fblinearindextoy53 = (int)(5.0-1) - fblinearindextoy53;
			// Multiply Offset Y by rowoffset
			float fboffsety53 = fblinearindextoy53 * fbrowsoffset53;
			// UV Offset
			float2 fboffset53 = float2(fboffsetx53, fboffsety53);
			// Flipbook UV
			half2 fbuv53 = appendResult51 * fbtiling53 + fboffset53;
			// *** END Flipbook UV Animation vars ***
			float2 uv_Raindrops_normals = i.uv_texcoord * _Raindrops_normals_ST.xy + _Raindrops_normals_ST.zw;
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 lerpResult61 = lerp( UnpackScaleNormal( tex2D( _raindrops_vert, fbuv53 ) ,_Rainintensity ) , UnpackNormal( tex2D( _Raindrops_normals, uv_Raindrops_normals ) ) , pow( ase_worldNormal.y , 5.0 ));
			o.Normal = BlendNormals( UnpackNormal( tex2D( _Normal, uv_TexCoord1 ) ) , lerpResult61 );
			float4 tex2DNode2 = tex2D( _Albedo, uv_TexCoord1 );
			float4 blendOpSrc66 = tex2DNode2;
			float4 blendOpDest66 = _Colorshift;
			o.Albedo = ( saturate( (( blendOpDest66 > 0.5 ) ? ( 1.0 - ( 1.0 - 2.0 * ( blendOpDest66 - 0.5 ) ) * ( 1.0 - blendOpSrc66 ) ) : ( 2.0 * blendOpDest66 * blendOpSrc66 ) ) )).rgb;
			float4 tex2DNode7 = tex2D( _Metallic, uv_TexCoord1 );
			o.Metallic = tex2DNode7.r;
			o.Smoothness = ( tex2DNode7.a * _Smoothnessshift );
			o.Alpha = ( tex2DNode2.a * _Opacityshift );
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
				float4 tSpace0 : TEXCOORD2;
				float4 tSpace1 : TEXCOORD3;
				float4 tSpace2 : TEXCOORD4;
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
				fixed3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				fixed3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.customPack1.zw = customInputData.uv2_texcoord2;
				o.customPack1.zw = v.texcoord1;
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
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				fixed3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
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
8;100;1035;937;-887.8291;1230.385;1.276784;True;False
Node;AmplifyShaderEditor.Vector2Node;57;-211.152,-229.9692;Float;False;Property;_Raintiling;Rain tiling;9;0;Create;1,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;48;167.6949,-352.9884;Float;False;1;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FractNode;49;214.4341,-34.32491;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;50;335.434,-148.325;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;51;351.5458,-11.7844;Float;False;FLOAT2;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;52;127.57,171.5715;Float;False;Property;_Rainspeed;Rain speed;7;0;Create;5;18;0;50;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;56;493.6835,104.2762;Float;False;Property;_Rainintensity;Rain intensity;8;0;Create;0;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;62;614.0874,-320.9106;Float;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TFHCFlipBookUVAnimation;53;549.9252,-110.7771;Float;False;0;0;6;0;FLOAT2;0,0;False;1;FLOAT;5.0;False;2;FLOAT;5.0;False;3;FLOAT;20.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SamplerNode;59;858.2143,-463.1411;Float;True;Property;_Raindrops_normals;Raindrops_normals;10;0;Create;194d22aa25743524cb4291bbd3b29f78;194d22aa25743524cb4291bbd3b29f78;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;1;529.3282,-656.377;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;46;989.9158,-102.2693;Float;True;Property;_raindrops_vert;raindrops_vert;6;0;Create;None;None;True;1;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;63;1045.025,-214.7687;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;5.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;5;1256.407,-666.0992;Float;True;Property;_Normal;Normal;3;0;Create;None;None;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;67;1787.962,-1093.769;Float;False;Property;_Colorshift;Color shift;11;0;Create;0.6691177,0.6691177,0.6691177,0;0.6691177,0.6691177,0.6691177,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2;1263.788,-909.3498;Float;True;Property;_Albedo;Albedo;2;0;Create;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;61;1503.559,-100.135;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;7;1249.912,-463.0313;Float;True;Property;_Metallic;Metallic;1;0;Create;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;65;1860.288,257.9102;Float;False;Property;_Opacityshift;Opacity shift;4;0;Create;1;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;9;1863.482,155.0537;Float;False;Property;_Smoothnessshift;Smoothness shift;5;0;Create;1;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.BlendNormalsNode;54;1899.816,-395.0341;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;2613.313,159.5323;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;64;2653.681,32.53113;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TriplanarNode;55;-100.9163,-651.7175;Float;True;Spherical;World;False;Top Texture 0;_TopTexture0;white;0;None;Mid Texture 0;_MidTexture0;white;-1;None;Bot Texture 0;_BotTexture0;white;-1;None;Triplanar Sampler;False;8;0;SAMPLER2D;;False;5;FLOAT;1.0;False;1;SAMPLER2D;;False;6;FLOAT;0.0;False;2;SAMPLER2D;;False;7;FLOAT;0.0;False;3;FLOAT;1.0;False;4;FLOAT;1.0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BlendOpsNode;66;2057.731,-619.2831;Float;False;Overlay;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;3133.387,64.83808;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;beffio/The Hunt/Car Window;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;Back;0;0;False;0;0;Transparent;0.5;True;True;0;False;Transparent;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;False;2;15;10;25;False;0.5;True;2;SrcAlpha;OneMinusSrcAlpha;0;Zero;Zero;OFF;OFF;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;48;0;57;0
WireConnection;49;0;48;2
WireConnection;50;0;48;1
WireConnection;51;0;50;0
WireConnection;51;1;49;0
WireConnection;53;0;51;0
WireConnection;53;3;52;0
WireConnection;46;1;53;0
WireConnection;46;5;56;0
WireConnection;63;0;62;2
WireConnection;5;1;1;0
WireConnection;2;1;1;0
WireConnection;61;0;46;0
WireConnection;61;1;59;0
WireConnection;61;2;63;0
WireConnection;7;1;1;0
WireConnection;54;0;5;0
WireConnection;54;1;61;0
WireConnection;8;0;7;4
WireConnection;8;1;9;0
WireConnection;64;0;2;4
WireConnection;64;1;65;0
WireConnection;66;0;2;0
WireConnection;66;1;67;0
WireConnection;0;0;66;0
WireConnection;0;1;54;0
WireConnection;0;3;7;0
WireConnection;0;4;8;0
WireConnection;0;9;64;0
ASEEND*/
//CHKSM=B60D8E9F9F30EEA18E5F176AA99C9528AE5E993A