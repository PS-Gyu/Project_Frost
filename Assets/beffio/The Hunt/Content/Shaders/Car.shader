// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "beffio/The Hunt/Car"
{
	Properties
	{
		_Metallic("Metallic", 2D) = "white" {}
		_Albedo("Albedo", 2D) = "white" {}
		_Normal("Normal", 2D) = "bump" {}
		_Smoothnessshift("Smoothness shift", Range( 0 , 2)) = 1
		_Carpaintcolor("Carpaint color", Color) = (0,0,0,0)
		_Tirecolor("Tire color", Color) = (0.7426471,0.7426471,0.7426471,0)
		_Wheelscolor("Wheels color", Color) = (0,0,0,0)
		_Typocolor("Typo color", Color) = (0,0,0,0)
		_Turnlightsemissionintensity("Turn lights emission intensity", Range( 0 , 400)) = 0
		_Rearlightsemissionintensity("Rear lights emission intensity", Range( 0 , 400)) = 0
		_Frontlightsemissionintensity("Front lights emission intensity", Range( 0 , 400)) = 0
		_Featuresemissionintensity("Features emission intensity", Range( 0 , 400)) = 0
		_EmissionMask("Emission Mask", 2D) = "white" {}
		_Rearlightsemission("Rear lights emission", Color) = (0,0,0,0)
		_Featuresemission("Features emission", Color) = (0,0,0,0)
		_Frontlightsemission("Front lights emission", Color) = (0,0,0,0)
		_Turnlightsemission("Turn lights emission", Color) = (0,0,0,0)
		_Albedomask("Albedo mask", 2D) = "white" {}
		_raindrops_vert("raindrops_vert", 2D) = "bump" {}
		_Rainspeed("Rain speed", Range( 0 , 50)) = 5
		_Rainintensity("Rain intensity", Range( 0 , 10)) = 0
		_Raintiling("Rain tiling", Vector) = (1,1,0,0)
		_Raindrops_normals("Raindrops_normals", 2D) = "bump" {}
		_Tiresmoothness("Tire smoothness", Range( 0 , 2)) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
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
		uniform sampler2D _Albedo;
		uniform float4 _Carpaintcolor;
		uniform sampler2D _Albedomask;
		uniform float4 _Albedomask_ST;
		uniform float4 _Typocolor;
		uniform float4 _Wheelscolor;
		uniform float4 _Tirecolor;
		uniform float4 _Featuresemission;
		uniform float _Featuresemissionintensity;
		uniform float4 _Frontlightsemission;
		uniform float _Frontlightsemissionintensity;
		uniform sampler2D _EmissionMask;
		uniform float4 _EmissionMask_ST;
		uniform float4 _Turnlightsemission;
		uniform float _Turnlightsemissionintensity;
		uniform float4 _Rearlightsemission;
		uniform float _Rearlightsemissionintensity;
		uniform sampler2D _Metallic;
		uniform float _Smoothnessshift;
		uniform float _Tiresmoothness;

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
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float clampResult80 = clamp( pow( ase_worldNormal.y , 10.0 ) , 0.0 , 1.0 );
			float3 lerpResult61 = lerp( UnpackScaleNormal( tex2D( _raindrops_vert, fbuv53 ) ,_Rainintensity ) , UnpackNormal( tex2D( _Raindrops_normals, ( uv2_TexCoord48 * float2( 2,2 ) ) ) ) , clampResult80);
			o.Normal = BlendNormals( UnpackNormal( tex2D( _Normal, uv_TexCoord1 ) ) , lerpResult61 );
			float4 tex2DNode2 = tex2D( _Albedo, uv_TexCoord1 );
			float4 blendOpSrc12 = tex2DNode2;
			float4 blendOpDest12 = _Carpaintcolor;
			float2 uv_Albedomask = i.uv_texcoord * _Albedomask_ST.xy + _Albedomask_ST.zw;
			float4 tex2DNode27 = tex2D( _Albedomask, uv_Albedomask );
			float4 lerpResult28 = lerp( tex2DNode2 , ( saturate( (( blendOpDest12 > 0.5 ) ? ( 1.0 - ( 1.0 - 2.0 * ( blendOpDest12 - 0.5 ) ) * ( 1.0 - blendOpSrc12 ) ) : ( 2.0 * blendOpDest12 * blendOpSrc12 ) ) )) , tex2DNode27.g);
			float4 blendOpSrc30 = lerpResult28;
			float4 blendOpDest30 = _Typocolor;
			float4 lerpResult29 = lerp( lerpResult28 , ( saturate( (( blendOpDest30 > 0.5 ) ? ( 1.0 - ( 1.0 - 2.0 * ( blendOpDest30 - 0.5 ) ) * ( 1.0 - blendOpSrc30 ) ) : ( 2.0 * blendOpDest30 * blendOpSrc30 ) ) )) , tex2DNode27.r);
			float4 blendOpSrc33 = lerpResult29;
			float4 blendOpDest33 = _Wheelscolor;
			float4 lerpResult32 = lerp( lerpResult29 , ( saturate( (( blendOpDest33 > 0.5 ) ? ( 1.0 - ( 1.0 - 2.0 * ( blendOpDest33 - 0.5 ) ) * ( 1.0 - blendOpSrc33 ) ) : ( 2.0 * blendOpDest33 * blendOpSrc33 ) ) )) , tex2DNode27.b);
			float4 blendOpSrc70 = lerpResult32;
			float4 blendOpDest70 = _Tirecolor;
			float4 lerpResult69 = lerp( ( saturate( (( blendOpDest70 > 0.5 ) ? ( 1.0 - ( 1.0 - 2.0 * ( blendOpDest70 - 0.5 ) ) * ( 1.0 - blendOpSrc70 ) ) : ( 2.0 * blendOpDest70 * blendOpSrc70 ) ) )) , lerpResult32 , tex2DNode27.a);
			o.Albedo = lerpResult69.rgb;
			float2 uv_EmissionMask = i.uv_texcoord * _EmissionMask_ST.xy + _EmissionMask_ST.zw;
			float4 tex2DNode15 = tex2D( _EmissionMask, uv_EmissionMask );
			float4 lerpResult16 = lerp( float4(0,0,0,0) , ( _Frontlightsemission * _Frontlightsemissionintensity ) , tex2DNode15.r);
			float4 lerpResult17 = lerp( lerpResult16 , ( _Turnlightsemission * _Turnlightsemissionintensity ) , tex2DNode15.g);
			float4 lerpResult18 = lerp( lerpResult17 , ( _Rearlightsemission * _Rearlightsemissionintensity ) , tex2DNode15.b);
			float4 lerpResult19 = lerp( ( _Featuresemission * _Featuresemissionintensity ) , lerpResult18 , tex2DNode15.a);
			o.Emission = lerpResult19.rgb;
			float4 tex2DNode7 = tex2D( _Metallic, uv_TexCoord1 );
			o.Metallic = tex2DNode7.r;
			float temp_output_8_0 = ( tex2DNode7.a * _Smoothnessshift );
			float lerpResult66 = lerp( ( temp_output_8_0 * _Tiresmoothness ) , temp_output_8_0 , tex2DNode27.a);
			o.Smoothness = lerpResult66;
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha fullforwardshadows 

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
8;100;1035;937;-882.9022;864.9271;1.710214;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;1;529.3282,-656.377;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2;1263.788,-909.3498;Float;True;Property;_Albedo;Albedo;3;0;Create;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;11;1615.487,-1292.294;Float;False;Property;_Carpaintcolor;Carpaint color;6;0;Create;0,0,0,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BlendOpsNode;12;2019.291,-774.1635;Float;False;Overlay;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;27;1280.107,-1230.795;Float;True;Property;_Albedomask;Albedo mask;19;0;Create;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;57;-211.152,-229.9692;Float;False;Property;_Raintiling;Rain tiling;23;0;Create;1,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.ColorNode;31;2000.86,-1267.674;Float;False;Property;_Typocolor;Typo color;9;0;Create;0,0,0,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;28;2192.415,-566.472;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;48;167.6949,-352.9884;Float;False;1;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;14;735.0698,187.397;Float;False;Property;_Frontlightsemissionintensity;Front lights emission intensity;12;0;Create;0;0;0;400;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;21;1116.206,818.7881;Float;False;Property;_Frontlightsemission;Front lights emission;17;0;Create;0,0,0,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BlendOpsNode;30;2404.664,-749.5435;Float;False;Overlay;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FractNode;49;214.4341,-34.32491;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;50;335.434,-148.325;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;39;737.8629,258.1297;Float;False;Property;_Turnlightsemissionintensity;Turn lights emission intensity;10;0;Create;0;0;0;400;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;34;2277.662,-1282.512;Float;False;Property;_Wheelscolor;Wheels color;8;0;Create;0,0,0,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;22;1111.943,986.4812;Float;False;Property;_Turnlightsemission;Turn lights emission;18;0;Create;0,0,0,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldNormalVector;62;614.0874,-320.9106;Float;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SamplerNode;15;1112.385,434.5185;Float;True;Property;_EmissionMask;Emission Mask;14;0;Create;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;52;127.57,171.5715;Float;False;Property;_Rainspeed;Rain speed;21;0;Create;5;18;0;50;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;51;351.5458,-11.7844;Float;False;FLOAT2;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;29;2427.448,-353.0987;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;1418.109,702.3782;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;20;1119.048,652.5173;Float;False;Constant;_Color0;Color 0;9;0;Create;0,0,0,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;43;1426.26,828.4808;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;7;1249.912,-463.0313;Float;True;Property;_Metallic;Metallic;2;0;Create;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;40;729.8629,328.1297;Float;False;Property;_Rearlightsemissionintensity;Rear lights emission intensity;11;0;Create;0;0;0;400;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;63;947.5428,-221.6096;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;10.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;9;2120.377,1024.793;Float;False;Property;_Smoothnessshift;Smoothness shift;5;0;Create;1;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;16;1824.327,358.821;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCFlipBookUVAnimation;53;549.9252,-110.7771;Float;False;0;0;6;0;FLOAT2;0,0;False;1;FLOAT;5.0;False;2;FLOAT;5.0;False;3;FLOAT;20.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;56;493.6835,104.2762;Float;False;Property;_Rainintensity;Rain intensity;22;0;Create;0;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;72;557.4507,-461.5554;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;2,2;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BlendOpsNode;33;2681.466,-764.3817;Float;False;Overlay;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;23;1117.628,1152.752;Float;False;Property;_Rearlightsemission;Rear lights emission;15;0;Create;0,0,0,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;17;1820.172,474.0889;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;44;1421.26,956.4808;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;80;1132.593,-192.8132;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;71;2766.385,-1189.018;Float;False;Property;_Tirecolor;Tire color;7;0;Create;0.7426471,0.7426471,0.7426471,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;24;1113.363,1313.338;Float;False;Property;_Featuresemission;Features emission;16;0;Create;0,0,0,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;2132.905,-19.38924;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;59;812.2833,-482.054;Float;True;Property;_Raindrops_normals;Raindrops_normals;24;0;Create;194d22aa25743524cb4291bbd3b29f78;194d22aa25743524cb4291bbd3b29f78;True;1;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;46;900.7554,-60.39087;Float;True;Property;_raindrops_vert;raindrops_vert;20;0;Create;None;None;True;1;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;32;2749.137,-361.0712;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;68;1964.123,217.659;Float;False;Property;_Tiresmoothness;Tire smoothness;25;0;Create;1;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;41;736.8629,405.1297;Float;False;Property;_Featuresemissionintensity;Features emission intensity;13;0;Create;0;0;0;400;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;67;2447.063,185.0283;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;45;1415.9,1082.361;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;61;1389.872,-150.2115;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;18;1827.171,583.3568;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;5;1256.407,-666.0992;Float;True;Property;_Normal;Normal;4;0;Create;None;None;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BlendOpsNode;70;2996.33,-622.8981;Float;False;Overlay;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;19;1827.171,699.8887;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TriplanarNode;55;-100.9163,-651.7175;Float;True;Spherical;World;False;Top Texture 0;_TopTexture0;white;0;None;Mid Texture 0;_MidTexture0;white;-1;None;Bot Texture 0;_BotTexture0;white;-1;None;Triplanar Sampler;False;8;0;SAMPLER2D;;False;5;FLOAT;1.0;False;1;SAMPLER2D;;False;6;FLOAT;0.0;False;2;SAMPLER2D;;False;7;FLOAT;0.0;False;3;FLOAT;1.0;False;4;FLOAT;1.0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BlendNormalsNode;54;2052.116,-328.9341;Float;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;69;3032.761,-225.8159;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;3;589.989,713.3738;Float;True;Property;_TextureSample1;Texture Sample 1;1;0;Create;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;4;163.4675,650.3709;Float;False;1;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;66;2706.445,137.5356;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;3247.921,33.4926;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;beffio/The Hunt/Car;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;False;2;15;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;OFF;OFF;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;2;1;1;0
WireConnection;12;0;2;0
WireConnection;12;1;11;0
WireConnection;28;0;2;0
WireConnection;28;1;12;0
WireConnection;28;2;27;2
WireConnection;48;0;57;0
WireConnection;30;0;28;0
WireConnection;30;1;31;0
WireConnection;49;0;48;2
WireConnection;50;0;48;1
WireConnection;51;0;50;0
WireConnection;51;1;49;0
WireConnection;29;0;28;0
WireConnection;29;1;30;0
WireConnection;29;2;27;1
WireConnection;42;0;21;0
WireConnection;42;1;14;0
WireConnection;43;0;22;0
WireConnection;43;1;39;0
WireConnection;7;1;1;0
WireConnection;63;0;62;2
WireConnection;16;0;20;0
WireConnection;16;1;42;0
WireConnection;16;2;15;1
WireConnection;53;0;51;0
WireConnection;53;3;52;0
WireConnection;72;0;48;0
WireConnection;33;0;29;0
WireConnection;33;1;34;0
WireConnection;17;0;16;0
WireConnection;17;1;43;0
WireConnection;17;2;15;2
WireConnection;44;0;23;0
WireConnection;44;1;40;0
WireConnection;80;0;63;0
WireConnection;8;0;7;4
WireConnection;8;1;9;0
WireConnection;59;1;72;0
WireConnection;46;1;53;0
WireConnection;46;5;56;0
WireConnection;32;0;29;0
WireConnection;32;1;33;0
WireConnection;32;2;27;3
WireConnection;67;0;8;0
WireConnection;67;1;68;0
WireConnection;45;0;24;0
WireConnection;45;1;41;0
WireConnection;61;0;46;0
WireConnection;61;1;59;0
WireConnection;61;2;80;0
WireConnection;18;0;17;0
WireConnection;18;1;44;0
WireConnection;18;2;15;3
WireConnection;5;1;1;0
WireConnection;70;0;32;0
WireConnection;70;1;71;0
WireConnection;19;0;45;0
WireConnection;19;1;18;0
WireConnection;19;2;15;4
WireConnection;54;0;5;0
WireConnection;54;1;61;0
WireConnection;69;0;70;0
WireConnection;69;1;32;0
WireConnection;69;2;27;4
WireConnection;3;1;4;0
WireConnection;66;0;67;0
WireConnection;66;1;8;0
WireConnection;66;2;27;4
WireConnection;0;0;69;0
WireConnection;0;1;54;0
WireConnection;0;2;19;0
WireConnection;0;3;7;0
WireConnection;0;4;66;0
ASEEND*/
//CHKSM=B7CF4FCC27F60A0F396C3A12937A3F25F9C28EFA