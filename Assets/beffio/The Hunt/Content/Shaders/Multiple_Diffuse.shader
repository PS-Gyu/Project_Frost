// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "beffio/The Hunt/Multiple_Diffuse"
{
	Properties
	{
		_Metallic("Metallic", 2D) = "white" {}
		_Mask("Mask", 2D) = "white" {}
		_Emission("Emission", 2D) = "white" {}
		_Albedo("Albedo", 2D) = "white" {}
		_EmissionColor("Emission Color", Color) = (0,0.462069,1,0)
		_ColorGreenchannelDefault("Color  Green channel (Default)", Color) = (1,0.8068966,0,0)
		_Normal("Normal", 2D) = "bump" {}
		_Emissionintensity("Emission intensity", Range( 0 , 200)) = 0
		_ColorBluechannel("Color Blue channel", Color) = (0,0.2965517,1,0)
		_Global_Multiply("Global_Multiply", Color) = (1,1,1,0)
		_ColorRedchannel("Color Red channel", Color) = (1,0,0,0)
		_Metallicshift("Metallic shift", Range( 0 , 2)) = 1
		_Occlusionshift("Occlusion shift", Range( 0 , 2)) = 1
		_Smoothnesshift("Smoothnes shift", Range( 0 , 2)) = 1
		_AmbientOcclusion("Ambient Occlusion", 2D) = "white" {}
		_DiffuseContrast("Diffuse Contrast", Range( 0 , 2)) = 0
		_GreenChannelMultiplyBlend("Green Channel Multiply/Blend", Range( 0 , 1)) = 0
		_BlueChannelMultiplyBlend("Blue Channel Multiply/Blend", Range( 0 , 1)) = 0
		_RedChannelMultiplyBlend("Red Channel Multiply/Blend", Range( 0 , 1)) = 0
		_RedBlending("Red Blending", Range( 0 , 10)) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _Normal;
		uniform float4 _Normal_ST;
		uniform sampler2D _Albedo;
		uniform float4 _Albedo_ST;
		uniform float4 _Global_Multiply;
		uniform float4 _ColorBluechannel;
		uniform float _BlueChannelMultiplyBlend;
		uniform sampler2D _Mask;
		uniform float4 _Mask_ST;
		uniform float4 _ColorRedchannel;
		uniform float _RedChannelMultiplyBlend;
		uniform float _RedBlending;
		uniform float4 _ColorGreenchannelDefault;
		uniform float _GreenChannelMultiplyBlend;
		uniform float _DiffuseContrast;
		uniform sampler2D _Emission;
		uniform float4 _Emission_ST;
		uniform float4 _EmissionColor;
		uniform float _Emissionintensity;
		uniform sampler2D _Metallic;
		uniform float4 _Metallic_ST;
		uniform float _Metallicshift;
		uniform float _Smoothnesshift;
		uniform sampler2D _AmbientOcclusion;
		uniform float4 _AmbientOcclusion_ST;
		uniform float _Occlusionshift;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Normal = i.uv_texcoord * _Normal_ST.xy + _Normal_ST.zw;
			o.Normal = UnpackNormal( tex2D( _Normal, uv_Normal ) );
			float2 uv_Albedo = i.uv_texcoord * _Albedo_ST.xy + _Albedo_ST.zw;
			float4 blendOpSrc38 = tex2D( _Albedo, uv_Albedo );
			float4 blendOpDest38 = _Global_Multiply;
			float4 temp_output_38_0 = ( saturate( ( blendOpSrc38 * blendOpDest38 ) ));
			float4 blendOpSrc22 = _ColorBluechannel;
			float4 blendOpDest22 = temp_output_38_0;
			float4 lerpResult54 = lerp( ( saturate( (( blendOpDest22 > 0.5 ) ? ( 1.0 - ( 1.0 - 2.0 * ( blendOpDest22 - 0.5 ) ) * ( 1.0 - blendOpSrc22 ) ) : ( 2.0 * blendOpDest22 * blendOpSrc22 ) ) )) , _ColorBluechannel , _BlueChannelMultiplyBlend);
			float2 uv_Mask = i.uv_texcoord * _Mask_ST.xy + _Mask_ST.zw;
			float4 tex2DNode7 = tex2D( _Mask, uv_Mask );
			float4 lerpResult24 = lerp( temp_output_38_0 , lerpResult54 , tex2DNode7.b);
			float4 blendOpSrc26 = _ColorRedchannel;
			float4 blendOpDest26 = lerpResult24;
			float4 lerpResult47 = lerp( ( saturate( ( blendOpSrc26 * blendOpDest26 ) )) , _ColorRedchannel , _RedChannelMultiplyBlend);
			float clampResult59 = clamp( ( tex2DNode7.r * _RedBlending ) , 0.0 , 1.0 );
			float4 lerpResult27 = lerp( lerpResult24 , lerpResult47 , clampResult59);
			float4 blendOpSrc35 = lerpResult27;
			float4 blendOpDest35 = _ColorGreenchannelDefault;
			float4 lerpResult56 = lerp( ( saturate( (( blendOpDest35 > 0.5 ) ? ( 1.0 - ( 1.0 - 2.0 * ( blendOpDest35 - 0.5 ) ) * ( 1.0 - blendOpSrc35 ) ) : ( 2.0 * blendOpDest35 * blendOpSrc35 ) ) )) , _ColorGreenchannelDefault , _GreenChannelMultiplyBlend);
			float4 lerpResult11 = lerp( lerpResult27 , lerpResult56 , tex2DNode7.g);
			float4 blendOpSrc46 = lerpResult11;
			float4 blendOpDest46 = lerpResult11;
			float4 lerpResult45 = lerp( lerpResult11 , ( saturate( (( blendOpDest46 > 0.5 ) ? ( 1.0 - ( 1.0 - 2.0 * ( blendOpDest46 - 0.5 ) ) * ( 1.0 - blendOpSrc46 ) ) : ( 2.0 * blendOpDest46 * blendOpSrc46 ) ) )) , _DiffuseContrast);
			o.Albedo = lerpResult45.rgb;
			float2 uv_Emission = i.uv_texcoord * _Emission_ST.xy + _Emission_ST.zw;
			float4 tex2DNode5 = tex2D( _Emission, uv_Emission );
			float4 blendOpSrc14 = tex2DNode5;
			float4 blendOpDest14 = _EmissionColor;
			float4 lerpResult49 = lerp( float4(0,0,0,0) , ( ( saturate( ( blendOpSrc14 + blendOpDest14 - 1.0 ) )) * _Emissionintensity ) , tex2DNode5.r);
			o.Emission = lerpResult49.rgb;
			float2 uv_Metallic = i.uv_texcoord * _Metallic_ST.xy + _Metallic_ST.zw;
			float4 tex2DNode6 = tex2D( _Metallic, uv_Metallic );
			o.Metallic = ( tex2DNode6 * _Metallicshift ).r;
			o.Smoothness = ( tex2DNode6.a * _Smoothnesshift );
			float2 uv_AmbientOcclusion = i.uv_texcoord * _AmbientOcclusion_ST.xy + _AmbientOcclusion_ST.zw;
			o.Occlusion = ( tex2D( _AmbientOcclusion, uv_AmbientOcclusion ) * _Occlusionshift ).r;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=14201
0;92;605;949;3452.983;1805.245;4.459402;False;False
Node;AmplifyShaderEditor.SamplerNode;3;-1868.731,-673.4716;Float;True;Property;_Albedo;Albedo;3;0;Create;None;0e0822ca96115fb478d4e6052e642b11;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;37;-1766.851,-1024.291;Float;False;Property;_Global_Multiply;Global_Multiply;9;0;Create;1,1,1,0;1,1,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BlendOpsNode;38;-1335.853,-706.4761;Float;False;Multiply;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;23;-1297.441,-1236.147;Float;False;Property;_ColorBluechannel;Color Blue channel;8;0;Create;0,0.2965517,1,0;1,0.724138,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;53;-1838.79,-323.9924;Float;False;Property;_BlueChannelMultiplyBlend;Blue Channel Multiply/Blend;17;0;Create;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.BlendOpsNode;22;-812.7372,-1005.207;Float;False;Overlay;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;7;-1919.207,234.3924;Float;True;Property;_Mask;Mask;1;0;Create;None;b55fb57283a6db5478edcda02e111fc0;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;54;-761.8105,-844.2001;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;58;-1655.064,692.5038;Float;False;Property;_RedBlending;Red Blending;19;0;Create;1;1;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;25;-1033.259,-1462.248;Float;False;Property;_ColorRedchannel;Color Red channel;10;0;Create;1,0,0,0;1,1,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;24;-395.2352,-657.0308;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;48;-1826.463,-418.3873;Float;False;Property;_RedChannelMultiplyBlend;Red Channel Multiply/Blend;18;0;Create;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.BlendOpsNode;26;-234.4426,-1209.49;Float;False;Multiply;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;57;-1240.749,393.3768;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;59;-498.5813,-249.3509;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;47;-160.417,-830.3444;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;27;25.17012,-650.1014;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;9;-820.4963,-538.9298;Float;False;Property;_ColorGreenchannelDefault;Color  Green channel (Default);5;0;Create;1,0.8068966,0,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BlendOpsNode;35;4.506126,-515.4468;Float;False;Overlay;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;55;-1822.371,-235.8938;Float;False;Property;_GreenChannelMultiplyBlend;Green Channel Multiply/Blend;16;0;Create;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;5;-1537.216,71.84898;Float;True;Property;_Emission;Emission;2;0;Create;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;56;234.3597,-420.1845;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;15;-1402.828,-156.5329;Float;False;Property;_EmissionColor;Emission Color;4;0;Create;0,0.462069,1,0;0,0,0,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;13;-787.6128,10.86938;Float;False;Property;_Emissionintensity;Emission intensity;7;0;Create;0;0;0;200;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;11;514.2861,-420.8474;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BlendOpsNode;14;-1049.792,-121.92;Float;True;LinearBurn;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;32;-1260.963,612.1141;Float;True;Property;_AmbientOcclusion;Ambient Occlusion;14;0;Create;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-196.0749,-120.2121;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;40;705.4797,-640.3873;Float;False;Property;_DiffuseContrast;Diffuse Contrast;15;0;Create;0;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;6;-1228.697,152.6628;Float;True;Property;_Metallic;Metallic;0;0;Create;None;1c28a67c455c1814da06e44bc02c3178;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;50;-222.7923,-311.6956;Float;False;Constant;_Color0;Color 0;17;0;Create;0,0,0,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;33;274.1371,-655.4389;Float;False;Property;_Occlusionshift;Occlusion shift;12;0;Create;1;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.BlendOpsNode;46;875.6191,-818.4446;Float;False;Overlay;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;29;258.3463,-742.1841;Float;False;Property;_Metallicshift;Metallic shift;11;0;Create;1;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;28;259.4688,-817.9962;Float;False;Property;_Smoothnesshift;Smoothnes shift;13;0;Create;1;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;16;-1183.142,-390.8418;Float;True;Property;_Normal;Normal;6;0;Create;None;a046a95ad3216d843877b5ab831ff8d8;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;49;94.40785,-179.0958;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;499.6075,-93.97874;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;498.3059,88.57674;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;45;1144.619,-595.4446;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;34;430.8076,214.3546;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1292.319,-291.2223;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;beffio/The Hunt/Multiple_Diffuse;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;False;2;15;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;OFF;OFF;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;38;0;3;0
WireConnection;38;1;37;0
WireConnection;22;0;23;0
WireConnection;22;1;38;0
WireConnection;54;0;22;0
WireConnection;54;1;23;0
WireConnection;54;2;53;0
WireConnection;24;0;38;0
WireConnection;24;1;54;0
WireConnection;24;2;7;3
WireConnection;26;0;25;0
WireConnection;26;1;24;0
WireConnection;57;0;7;1
WireConnection;57;1;58;0
WireConnection;59;0;57;0
WireConnection;47;0;26;0
WireConnection;47;1;25;0
WireConnection;47;2;48;0
WireConnection;27;0;24;0
WireConnection;27;1;47;0
WireConnection;27;2;59;0
WireConnection;35;0;27;0
WireConnection;35;1;9;0
WireConnection;56;0;35;0
WireConnection;56;1;9;0
WireConnection;56;2;55;0
WireConnection;11;0;27;0
WireConnection;11;1;56;0
WireConnection;11;2;7;2
WireConnection;14;0;5;0
WireConnection;14;1;15;0
WireConnection;12;0;14;0
WireConnection;12;1;13;0
WireConnection;46;0;11;0
WireConnection;46;1;11;0
WireConnection;49;0;50;0
WireConnection;49;1;12;0
WireConnection;49;2;5;0
WireConnection;31;0;6;0
WireConnection;31;1;29;0
WireConnection;30;0;6;4
WireConnection;30;1;28;0
WireConnection;45;0;11;0
WireConnection;45;1;46;0
WireConnection;45;2;40;0
WireConnection;34;0;32;0
WireConnection;34;1;33;0
WireConnection;0;0;45;0
WireConnection;0;1;16;0
WireConnection;0;2;49;0
WireConnection;0;3;31;0
WireConnection;0;4;30;0
WireConnection;0;5;34;0
ASEEND*/
//CHKSM=474B49AE0C9EE2169A34D96C1371A92BC1085586