// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "beffio/The Hunt/Human Detector"
{
	Properties
	{
		_Albedo("Albedo", 2D) = "white" {}
		_Metallic("Metallic", 2D) = "white" {}
		_Mask("Mask", 2D) = "white" {}
		_Emission("Emission", 2D) = "white" {}
		_Normal("Normal", 2D) = "bump" {}
		_AmbientOcclusion("Ambient Occlusion", 2D) = "white" {}
		_Human_Detector_Emission("Human_Detector_Emission", 2D) = "white" {}
		_bars("bars", 2D) = "white" {}
		_GUI_1_Flipbook("GUI_1_Flipbook", 2D) = "white" {}
		_Global_Multiply("Global_Multiply", Color) = (1,1,1,0)
		_DiffuseContrast("Diffuse Contrast", Range( 0 , 2)) = 0
		_Occlusionshift("Occlusion shift", Range( 0 , 2)) = 1
		_ColorGreenchannelDefault("Color  Green channel (Default)", Color) = (1,0.8068966,0,0)
		_SmoothnessshiftGreen("Smoothness shift (Green)", Range( 0 , 2)) = 1
		_MetallicshiftGreen("Metallic shift (Green)", Range( 0 , 2)) = 1
		_ColorBluechannel("Color Blue channel", Color) = (0,0.2965517,1,0)
		_SmoothnessshiftBlue("Smoothness shift (Blue)", Range( 0 , 2)) = 1
		_MetallicshiftBlue("Metallic shift (Blue)", Range( 0 , 2)) = 1
		_ColorRedchannel("Color Red channel", Color) = (1,0,0,0)
		_SmoothnessshiftRed("Smoothness shift (Red)", Range( 0 , 2)) = 1
		_MetallicshiftRed("Metallic shift (Red)", Range( 0 , 2)) = 1
		_EmissionColorButtons("Emission Color (Buttons)", Color) = (1,0,0,0)
		_EmissionintensityButtons("Emission intensity (Buttons)", Range( 0 , 100)) = 1
		_EmissionColorCoil("Emission Color (Coil)", Color) = (0,0.462069,1,0)
		_EmissionintensityCoil("Emission intensity (Coil)", Range( 0 , 100)) = 1
		_EmissionColorDisplay("Emission Color (Display)", Color) = (0,1,0.9172413,0)
		_EmissionintensityDisplaybacklight("Emission intensity (Display backlight)", Range( 0 , 10)) = 1
		_EmissionintensityDisplay("Emission intensity (Display)", Range( 0 , 100)) = 1
		_Dislpayanimspeed("Dislpay anim speed", Range( 0 , 50)) = 25
		_Glitchpower("Glitch power", Range( 0.9 , 1)) = 0
		_Glitchspeed("Glitch speed", Range( 0 , 10)) = 0
		_GUI_2_Flipbook("GUI_2_Flipbook", 2D) = "white" {}
		[Toggle]_Monochrome("Monochrome", Float) = 1
		[Toggle]_GUI12("GUI 1/2", Float) = 0
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
			float2 uv2_texcoord2;
		};

		uniform sampler2D _Normal;
		uniform float4 _Normal_ST;
		uniform sampler2D _Albedo;
		uniform float4 _Albedo_ST;
		uniform float4 _Global_Multiply;
		uniform float4 _ColorBluechannel;
		uniform sampler2D _Mask;
		uniform float4 _Mask_ST;
		uniform float4 _ColorRedchannel;
		uniform float4 _ColorGreenchannelDefault;
		uniform float _DiffuseContrast;
		uniform float _Monochrome;
		uniform float _GUI12;
		uniform sampler2D _GUI_2_Flipbook;
		uniform float _Dislpayanimspeed;
		uniform sampler2D _bars;
		uniform float _Glitchspeed;
		uniform float _Glitchpower;
		uniform sampler2D _Emission;
		uniform float4 _Emission_ST;
		uniform sampler2D _GUI_1_Flipbook;
		uniform float4 _EmissionColorDisplay;
		uniform sampler2D _Human_Detector_Emission;
		uniform float4 _Human_Detector_Emission_ST;
		uniform float _EmissionintensityDisplaybacklight;
		uniform float4 _EmissionColorButtons;
		uniform float _EmissionintensityButtons;
		uniform float4 _EmissionColorCoil;
		uniform float _EmissionintensityCoil;
		uniform float _EmissionintensityDisplay;
		uniform sampler2D _Metallic;
		uniform float4 _Metallic_ST;
		uniform float _MetallicshiftRed;
		uniform float _MetallicshiftGreen;
		uniform float _MetallicshiftBlue;
		uniform float _SmoothnessshiftRed;
		uniform float _SmoothnessshiftGreen;
		uniform float _SmoothnessshiftBlue;
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
			float2 uv_Mask = i.uv_texcoord * _Mask_ST.xy + _Mask_ST.zw;
			float4 tex2DNode7 = tex2D( _Mask, uv_Mask );
			float4 lerpResult24 = lerp( temp_output_38_0 , ( saturate( ( blendOpSrc22 * blendOpDest22 ) )) , tex2DNode7.b);
			float4 blendOpSrc26 = _ColorRedchannel;
			float4 blendOpDest26 = lerpResult24;
			float4 lerpResult27 = lerp( lerpResult24 , ( saturate( ( blendOpSrc26 * blendOpDest26 ) )) , tex2DNode7.r);
			float4 blendOpSrc35 = lerpResult27;
			float4 blendOpDest35 = _ColorGreenchannelDefault;
			float4 lerpResult11 = lerp( lerpResult27 , ( saturate( (( blendOpDest35 > 0.5 ) ? ( 1.0 - ( 1.0 - 2.0 * ( blendOpDest35 - 0.5 ) ) * ( 1.0 - blendOpSrc35 ) ) : ( 2.0 * blendOpDest35 * blendOpSrc35 ) ) )) , tex2DNode7.g);
			float4 blendOpSrc46 = lerpResult11;
			float4 blendOpDest46 = lerpResult11;
			float4 lerpResult45 = lerp( lerpResult11 , ( saturate( (( blendOpDest46 > 0.5 ) ? ( 1.0 - ( 1.0 - 2.0 * ( blendOpDest46 - 0.5 ) ) * ( 1.0 - blendOpSrc46 ) ) : ( 2.0 * blendOpDest46 * blendOpSrc46 ) ) )) , _DiffuseContrast);
			float2 uv2_TexCoord89 = i.uv2_texcoord2 * float2( 1,1 ) + float2( 0,0 );
			// *** BEGIN Flipbook UV Animation vars ***
			// Total tiles of Flipbook Texture
			float fbtotaltiles88 = 4.0 * 4.0;
			// Offsets for cols and rows of Flipbook Texture
			float fbcolsoffset88 = 1.0f / 4.0;
			float fbrowsoffset88 = 1.0f / 4.0;
			// Speed of animation
			float fbspeed88 = _Time[ 1 ] * _Dislpayanimspeed;
			// UV Tiling (col and row offset)
			float2 fbtiling88 = float2(fbcolsoffset88, fbrowsoffset88);
			// UV Offset - calculate current tile linear index, and convert it to (X * coloffset, Y * rowoffset)
			// Calculate current tile linear index
			float fbcurrenttileindex88 = round( fmod( fbspeed88 + 0.0, fbtotaltiles88) );
			fbcurrenttileindex88 += ( fbcurrenttileindex88 < 0) ? fbtotaltiles88 : 0;
			// Obtain Offset X coordinate from current tile linear index
			float fblinearindextox88 = round ( fmod ( fbcurrenttileindex88, 4.0 ) );
			// Multiply Offset X by coloffset
			float fboffsetx88 = fblinearindextox88 * fbcolsoffset88;
			// Obtain Offset Y coordinate from current tile linear index
			float fblinearindextoy88 = round( fmod( ( fbcurrenttileindex88 - fblinearindextox88 ) / 4.0, 4.0 ) );
			// Reverse Y to get tiles from Top to Bottom
			fblinearindextoy88 = (int)(4.0-1) - fblinearindextoy88;
			// Multiply Offset Y by rowoffset
			float fboffsety88 = fblinearindextoy88 * fbrowsoffset88;
			// UV Offset
			float2 fboffset88 = float2(fboffsetx88, fboffsety88);
			// Flipbook UV
			half2 fbuv88 = uv2_TexCoord89 * fbtiling88 + fboffset88;
			// *** END Flipbook UV Animation vars ***
			float2 appendResult110 = (float2(0.0 , _Glitchspeed));
			float2 panner96 = ( uv2_TexCoord89 + 1.0 * _Time.y * appendResult110);
			float clampResult104 = clamp( UnpackNormal( tex2D( _bars, panner96 ) ).b , _Glitchpower , 2.0 );
			float2 uv_Emission = i.uv_texcoord * _Emission_ST.xy + _Emission_ST.zw;
			float4 tex2DNode5 = tex2D( _Emission, uv_Emission );
			float lerpResult99 = lerp( 1.0 , clampResult104 , tex2DNode5.g);
			float3 appendResult105 = (float3(0.0 , 1.0 , 0.0));
			float2 Offset94 = ( ( lerpResult99 - 1 ) * appendResult105.xy * 1.0 ) + fbuv88;
			float2 appendResult112 = (float2(0.0 , ( 1.0 - _Glitchpower )));
			float2 temp_output_115_0 = ( Offset94 + appendResult112 );
			float3 desaturateVar123 = lerp( lerp(tex2D( _GUI_2_Flipbook, temp_output_115_0 ),tex2D( _GUI_1_Flipbook, temp_output_115_0 ),_GUI12).rgb,dot(lerp(tex2D( _GUI_2_Flipbook, temp_output_115_0 ),tex2D( _GUI_1_Flipbook, temp_output_115_0 ),_GUI12).rgb,float3(0.299,0.587,0.114)).xxx,1.0);
			float4 lerpResult124 = lerp( float4( 0,0,0,0 ) , _EmissionColorDisplay , desaturateVar123.x);
			float4 lerpResult84 = lerp( lerpResult45 , lerp(lerp(tex2D( _GUI_2_Flipbook, temp_output_115_0 ),tex2D( _GUI_1_Flipbook, temp_output_115_0 ),_GUI12),lerpResult124,_Monochrome) , tex2DNode5.g);
			o.Albedo = lerpResult84.rgb;
			float4 _Color0 = float4(0,0,0,0);
			float2 uv_Human_Detector_Emission = i.uv_texcoord * _Human_Detector_Emission_ST.xy + _Human_Detector_Emission_ST.zw;
			float4 lerpResult66 = lerp( _Color0 , ( ( _EmissionColorDisplay * tex2D( _Human_Detector_Emission, uv_Human_Detector_Emission ) ) * _EmissionintensityDisplaybacklight ) , tex2DNode5.g);
			float4 lerpResult65 = lerp( _Color0 , ( _EmissionColorButtons * _EmissionintensityButtons ) , tex2DNode5.r);
			float4 lerpResult67 = lerp( _Color0 , ( _EmissionColorCoil * _EmissionintensityCoil ) , tex2DNode5.b);
			float4 temp_output_77_0 = ( lerpResult66 + lerpResult65 + lerpResult67 );
			float4 lerpResult85 = lerp( temp_output_77_0 , ( ( lerp(lerp(tex2D( _GUI_2_Flipbook, temp_output_115_0 ),tex2D( _GUI_1_Flipbook, temp_output_115_0 ),_GUI12),lerpResult124,_Monochrome) * _EmissionintensityDisplay ) + temp_output_77_0 ) , tex2DNode5.g);
			o.Emission = lerpResult85.rgb;
			float2 uv_Metallic = i.uv_texcoord * _Metallic_ST.xy + _Metallic_ST.zw;
			float4 tex2DNode6 = tex2D( _Metallic, uv_Metallic );
			float4 temp_output_31_0 = ( tex2DNode6 * 1.0 );
			float4 lerpResult56 = lerp( temp_output_31_0 , ( temp_output_31_0 * _MetallicshiftRed ) , tex2DNode7.r);
			float4 lerpResult57 = lerp( lerpResult56 , ( temp_output_31_0 * _MetallicshiftGreen ) , tex2DNode7.g);
			float4 lerpResult58 = lerp( lerpResult57 , ( temp_output_31_0 * _MetallicshiftBlue ) , tex2DNode7.b);
			o.Metallic = lerpResult58.r;
			float temp_output_30_0 = ( tex2DNode6.a * 1.0 );
			float lerpResult47 = lerp( temp_output_30_0 , ( temp_output_30_0 * _SmoothnessshiftRed ) , tex2DNode7.r);
			float lerpResult48 = lerp( lerpResult47 , ( temp_output_30_0 * _SmoothnessshiftGreen ) , tex2DNode7.g);
			float lerpResult51 = lerp( lerpResult48 , ( temp_output_30_0 * _SmoothnessshiftBlue ) , tex2DNode7.b);
			o.Smoothness = lerpResult51;
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
8;100;1035;937;351.1115;1702.857;1.578894;True;False
Node;AmplifyShaderEditor.RangedFloatNode;109;-1070.554,-2443.635;Float;False;Property;_Glitchspeed;Glitch speed;31;0;Create;0;1.44;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;89;-1048.239,-1705.816;Float;False;1;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;110;-693.5538,-2435.635;Float;False;FLOAT2;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;96;-579.7162,-2362.53;Float;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0,2;False;1;FLOAT;1.0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;106;-517.8918,-1917.924;Float;False;Property;_Glitchpower;Glitch power;30;0;Create;0;0.9839;0.9;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;95;-136.2173,-2333.271;Float;True;Property;_bars;bars;8;0;Create;74082dda369008f42a9492dcd339e85f;74082dda369008f42a9492dcd339e85f;True;1;False;white;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;91;151.5193,-1233.457;Float;False;Property;_Dislpayanimspeed;Dislpay anim speed;29;0;Create;25;10.4;0;50;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;116;-279.1241,-1760.006;Float;False;Constant;_Float1;Float 1;34;0;Create;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;104;335.2875,-2143.124;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;2.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;5;-2189.318,-15.49196;Float;True;Property;_Emission;Emission;4;0;Create;None;bbd60631c1b7dd9418899f4c53ee3ebd;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;3;-1868.731,-673.4716;Float;True;Property;_Albedo;Albedo;1;0;Create;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;37;-1767.851,-1024.291;Float;False;Property;_Global_Multiply;Global_Multiply;10;0;Create;1,1,1,0;1,1,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;99;640.5105,-2082.489;Float;False;3;0;FLOAT;1.0;False;1;FLOAT;0.0;False;2;FLOAT;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;117;20.53417,-1741.279;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCFlipBookUVAnimation;88;695.7578,-1266.321;Float;False;0;0;6;0;FLOAT2;0,0;False;1;FLOAT;4.0;False;2;FLOAT;4.0;False;3;FLOAT;25.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.DynamicAppendNode;105;768.9547,-1672.793;Float;False;FLOAT3;4;0;FLOAT;0.0;False;1;FLOAT;1.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BlendOpsNode;38;-1335.853,-706.4761;Float;False;Multiply;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;23;-1181.148,-1059.328;Float;False;Property;_ColorBluechannel;Color Blue channel;16;0;Create;0,0.2965517,1,0;0.5514706,0.3884889,0.3000634,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ParallaxMappingNode;94;1083.444,-1717.198;Float;False;Normal;4;0;FLOAT2;0,0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;3;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;112;536.633,-1540.783;Float;False;FLOAT2;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;7;-1244.865,356.2242;Float;True;Property;_Mask;Mask;3;0;Create;None;5dd147f934a4f13458db3daa595d90a2;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BlendOpsNode;22;-837.0982,-966.5164;Float;False;Multiply;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;115;1222.016,-1490.477;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;24;-374.1381,-624.6592;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;25;-1156.596,-1298.415;Float;False;Property;_ColorRedchannel;Color Red channel;19;0;Create;1,0,0,0;0.6901471,0.722,0.7048653,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;87;1391.306,-1299.338;Float;True;Property;_GUI_1_Flipbook;GUI_1_Flipbook;9;0;Create;35ea2deb50728904795c7fa675d699bf;35ea2deb50728904795c7fa675d699bf;True;1;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;118;1442.091,-1539.821;Float;True;Property;_GUI_2_Flipbook;GUI_2_Flipbook;32;0;Create;4a3f592243360b14e8153160cac18c36;4a3f592243360b14e8153160cac18c36;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;79;-2961.365,88.68093;Float;True;Property;_Human_Detector_Emission;Human_Detector_Emission;7;0;Create;29b634836a67bd1419e85709971cd567;29b634836a67bd1419e85709971cd567;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;15;-2540.36,-430.3323;Float;False;Property;_EmissionColorDisplay;Emission Color (Display);26;0;Create;0,1,0.9172413,0;0.170307,0.2154352,0.5147058,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BlendOpsNode;26;-201.5878,-945.0125;Float;False;Multiply;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ToggleSwitchNode;119;1812.001,-1380.52;Float;False;Property;_GUI12;GUI 1/2;34;0;Create;0;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;68;-2126.682,-360.2437;Float;False;Property;_EmissionColorButtons;Emission Color (Buttons);22;0;Create;1,0,0,0;1,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;29;258.3463,-742.1841;Float;False;Constant;_Metallicshift;Metallic shift;11;0;Create;1;0.358;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;9;-1182.281,-573.2393;Float;False;Property;_ColorGreenchannelDefault;Color  Green channel (Default);13;0;Create;1,0.8068966,0,0;0.3529397,0.3529397,0.3529397,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;108;-2455.789,-683.5286;Float;False;Property;_EmissionintensityDisplaybacklight;Emission intensity (Display backlight);27;0;Create;1;0.89;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;81;-2229.951,-415.6473;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;69;-2133.682,-198.2437;Float;False;Property;_EmissionColorCoil;Emission Color (Coil);24;0;Create;0,0.462069,1,0;0.4558824,0.5722111,1,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;28;234.1591,-996.9714;Float;False;Constant;_Smoothnesshift;Smoothnes shift;13;0;Create;1;1.144;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;72;-2432.32,-576.3967;Float;False;Property;_EmissionintensityButtons;Emission intensity (Buttons);23;0;Create;1;6.8;0;100;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;27;23.7689,-650.1014;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;73;-2427.32,-498.3967;Float;False;Property;_EmissionintensityCoil;Emission intensity (Coil);25;0;Create;1;4.3;0;100;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;6;-1228.697,152.6628;Float;True;Property;_Metallic;Metallic;2;0;Create;None;a6778a3b687ec0240b9612ab03cc44be;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DesaturateOpNode;123;1621.504,-1095.145;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;1.0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;53;277.8557,388.9003;Float;False;Property;_SmoothnessshiftRed;Smoothness shift (Red);20;0;Create;1;0.799;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;98.77544,70.49846;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BlendOpsNode;35;75.84579,-438.073;Float;False;Overlay;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;74;-1777.32,-461.3967;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;495.7585,-273.3929;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;76;-1406.32,-465.3967;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;71;-2666.044,-198.3378;Float;False;Constant;_Color0;Color 0;22;0;Create;0,0,0,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;124;1810.321,-973.5738;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;62;287.5459,499.5544;Float;False;Property;_MetallicshiftRed;Metallic shift (Red);21;0;Create;1;1.303;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;75;-1606.32,-462.3967;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-2418.927,-788.4343;Float;False;Property;_EmissionintensityDisplay;Emission intensity (Display);28;0;Create;1;22.9;0;100;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;67;-1307.682,-236.2437;Float;False;3;0;COLOR;0.0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;49;668.8929,230.1859;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;65;-1497.682,-226.2437;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;66;-1741.682,-217.2437;Float;False;3;0;COLOR;0.0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;11;514.2861,-420.8474;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;59;664.1775,-128.3218;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ToggleSwitchNode;122;2146.472,-1119.86;Float;False;Property;_Monochrome;Monochrome;33;0;Create;1;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;63;637.024,505.2981;Float;False;Property;_MetallicshiftGreen;Metallic shift (Green);15;0;Create;1;0.888;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;54;625.866,383.023;Float;False;Property;_SmoothnessshiftGreen;Smoothness shift (Green);14;0;Create;1;2;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.BlendOpsNode;46;875.6191,-818.4446;Float;False;Overlay;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;40;705.4797,-640.3873;Float;False;Property;_DiffuseContrast;Diffuse Contrast;11;0;Create;0;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;47;808.009,-34.44551;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;60;877.1775,-123.3218;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;86;1782.219,-654.5727;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;55;910.4495,379.5096;Float;False;Property;_SmoothnessshiftBlue;Smoothness shift (Blue);17;0;Create;1;0.768;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;50;909.6767,168.8244;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;56;791.7277,-258.4424;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;64;931.024,505.2981;Float;False;Property;_MetallicshiftBlue;Metallic shift (Blue);18;0;Create;1;0.272;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;77;-1071.25,-135.9536;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;107;2043.221,-573.9596;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;48;1037.865,-45.2435;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;33;274.1371,-655.4389;Float;False;Property;_Occlusionshift;Occlusion shift;12;0;Create;1;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;32;-1260.963,612.1141;Float;True;Property;_AmbientOcclusion;Ambient Occlusion;6;0;Create;None;7896dfa99c8a14047bebdff4627ac24a;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;61;1074.177,-131.3218;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;52;1137.138,154.3316;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;45;1144.619,-595.4446;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;57;987.0374,-246.4329;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;84;2522.976,-866.2999;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TriplanarNode;90;1680.068,-1976.18;Float;True;Spherical;World;False;Top Texture 0;_TopTexture0;white;0;None;Mid Texture 0;_MidTexture0;white;-1;None;Bot Texture 0;_BotTexture0;white;-1;None;Triplanar Sampler;False;8;0;SAMPLER2D;;False;5;FLOAT;1.0;False;1;SAMPLER2D;;False;6;FLOAT;0.0;False;2;SAMPLER2D;;False;7;FLOAT;0.0;False;3;FLOAT;1.0;False;4;FLOAT;1.0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;85;2351.385,-397.0219;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;51;1246.823,-73.04723;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;34;430.8076,214.3546;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;16;-1183.142,-390.8418;Float;True;Property;_Normal;Normal;5;0;Create;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;58;1183.527,-239.2442;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;3006.836,-247.2065;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;beffio/The Hunt/Human Detector;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;False;2;15;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;OFF;OFF;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;110;1;109;0
WireConnection;96;0;89;0
WireConnection;96;2;110;0
WireConnection;95;1;96;0
WireConnection;104;0;95;3
WireConnection;104;1;106;0
WireConnection;99;1;104;0
WireConnection;99;2;5;2
WireConnection;117;0;116;0
WireConnection;117;1;106;0
WireConnection;88;0;89;0
WireConnection;88;3;91;0
WireConnection;38;0;3;0
WireConnection;38;1;37;0
WireConnection;94;0;88;0
WireConnection;94;1;99;0
WireConnection;94;3;105;0
WireConnection;112;1;117;0
WireConnection;22;0;23;0
WireConnection;22;1;38;0
WireConnection;115;0;94;0
WireConnection;115;1;112;0
WireConnection;24;0;38;0
WireConnection;24;1;22;0
WireConnection;24;2;7;3
WireConnection;87;1;115;0
WireConnection;118;1;115;0
WireConnection;26;0;25;0
WireConnection;26;1;24;0
WireConnection;119;0;118;0
WireConnection;119;1;87;0
WireConnection;81;0;15;0
WireConnection;81;1;79;0
WireConnection;27;0;24;0
WireConnection;27;1;26;0
WireConnection;27;2;7;1
WireConnection;123;0;119;0
WireConnection;30;0;6;4
WireConnection;30;1;28;0
WireConnection;35;0;27;0
WireConnection;35;1;9;0
WireConnection;74;0;81;0
WireConnection;74;1;108;0
WireConnection;31;0;6;0
WireConnection;31;1;29;0
WireConnection;76;0;69;0
WireConnection;76;1;73;0
WireConnection;124;1;15;0
WireConnection;124;2;123;0
WireConnection;75;0;68;0
WireConnection;75;1;72;0
WireConnection;67;0;71;0
WireConnection;67;1;76;0
WireConnection;67;2;5;3
WireConnection;49;0;30;0
WireConnection;49;1;53;0
WireConnection;65;0;71;0
WireConnection;65;1;75;0
WireConnection;65;2;5;1
WireConnection;66;0;71;0
WireConnection;66;1;74;0
WireConnection;66;2;5;2
WireConnection;11;0;27;0
WireConnection;11;1;35;0
WireConnection;11;2;7;2
WireConnection;59;0;31;0
WireConnection;59;1;62;0
WireConnection;122;0;119;0
WireConnection;122;1;124;0
WireConnection;46;0;11;0
WireConnection;46;1;11;0
WireConnection;47;0;30;0
WireConnection;47;1;49;0
WireConnection;47;2;7;1
WireConnection;60;0;31;0
WireConnection;60;1;63;0
WireConnection;86;0;122;0
WireConnection;86;1;13;0
WireConnection;50;0;30;0
WireConnection;50;1;54;0
WireConnection;56;0;31;0
WireConnection;56;1;59;0
WireConnection;56;2;7;1
WireConnection;77;0;66;0
WireConnection;77;1;65;0
WireConnection;77;2;67;0
WireConnection;107;0;86;0
WireConnection;107;1;77;0
WireConnection;48;0;47;0
WireConnection;48;1;50;0
WireConnection;48;2;7;2
WireConnection;61;0;31;0
WireConnection;61;1;64;0
WireConnection;52;0;30;0
WireConnection;52;1;55;0
WireConnection;45;0;11;0
WireConnection;45;1;46;0
WireConnection;45;2;40;0
WireConnection;57;0;56;0
WireConnection;57;1;60;0
WireConnection;57;2;7;2
WireConnection;84;0;45;0
WireConnection;84;1;122;0
WireConnection;84;2;5;2
WireConnection;85;0;77;0
WireConnection;85;1;107;0
WireConnection;85;2;5;2
WireConnection;51;0;48;0
WireConnection;51;1;52;0
WireConnection;51;2;7;3
WireConnection;34;0;32;0
WireConnection;34;1;33;0
WireConnection;58;0;57;0
WireConnection;58;1;61;0
WireConnection;58;2;7;3
WireConnection;0;0;84;0
WireConnection;0;1;16;0
WireConnection;0;2;85;0
WireConnection;0;3;58;0
WireConnection;0;4;51;0
WireConnection;0;5;34;0
ASEEND*/
//CHKSM=57F6323EEADE52C2706D66ACC9795DDEA1517133