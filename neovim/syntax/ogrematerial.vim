" File created by Aliaksandr Ivaniuk (rride), 2010
" A newer versions may be available at https://bitbucket.org/rride_a/myvim/
" Any issues can be posted at the issue tracker of the mentionaed repository.


 if version < 600
     syntax clear
 elseif exists("b:current_syntax")
     finish
 endif
		
syntax sync fromstart
" error region should be the first to have the lowest priority among all syntax classes. Only completely unknown structures should be highlighted as errors.
syntax region 	MaterialError 				 excludenl start="\i" end="$" contained

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" primitive data types
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


syntax keyword OnOff				on off contained 
syntax keyword Boolean				true false contained 
syntax match   Integer				"\d\|\(0x\)\d*" contained
 
" floats will be present in templates too often so use some scripting :)
let pattFloat	= '\<[0-9]\+\(\.[0-9]*\)\='
let pattFloat4  = printf( repeat( '%s\s\+', 3) . '%s\>', pattFloat, pattFloat, pattFloat, pattFloat )
let pattFloat6  = printf( '\(%s\s\+\)\{5}%s\>', pattFloat, pattFloat )
let pattFloat16 = printf( '\(%s\s\+\)\{15}\s+%s\>', pattFloat, pattFloat )

execute 'syntax match Float " ' . pattFloat. '" contained'
execute 'syntax match Float4 "' . pattFloat4 . '" contained'
execute 'syntax match Float6 "' . pattFloat6 . '" contained'
execute 'syntax match Float16 "' . pattFloat16 . '" contained'

syntax region  String				start=+"+ end=+"+ skip=+\\"+ contains=@Spell contained

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Material block
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax keyword GpuType 				matrix4x4 float4x4 float4 float contained
syntax match   GpuType				"\<float\([1-9]\d*\)\=\>" contained
syntax match   GpuType				"\<int\([1-9]\d*\)\=\>" contained

syntax region  Comment 				start="/\*" end="\*/"
syntax region  Comment 				excludenl start="//"	end="$"

let pattColorValue 			= printf( repeat( '%s\s\+', 2 ). '%s\(\s\+%s\)\=', pattFloat, pattFloat, pattFloat, pattFloat )  " match expression 'float float float [float]
let pattColorOrVertexColor 	= printf( '\(%s\)\|\(%s\)', pattColorValue, 'vertexcolor' )

"echo pattColorOrVertexColor
"echo match( "vertexcolor", "vertexcolor" )
"echo match("100 100 100 100 100 100", pattFloat6 )
execute 'syntax match	ColorValue "' 		.		pattColorValue . '" contained'
execute 'syntax match	ColorValueOrVertexColor "'.	pattColorOrVertexColor . '" contained'


syntax region 	UnknownBlock		matchgroup=Error start="{" end="}" transparent contains=UnknownBlock,Comment

syntax match    AbstractBlock 		nextgroup=PassBlock,TechniqueBlock skipwhite  "\<abstract\>" 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Material block
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax region 	MaterialBlock		matchgroup=MaterialBlock start="\<material\>" end="{"me=e-1 transparent contains=Comment nextgroup=MaterialBlockEnd 
syntax region	MaterialBlockEnd	matchgroup=MaterialBlock start="{" end="}" transparent contained contains=MaterialAttribute,Comment,TechniqueBlock,UnknownBlock skipempty

syntax keyword 	MaterialLodStrategy Distance PixelCount contained 
syntax region 	MaterialAttribute 	matchgroup=MaterialAttribute keepend start="^\s*lod_strategy\>" end="$"  contained skipwhite contains=MaterialLodStrategy,Comment,MaterialError

" lod_distances is a deprecated feature right now, so just skip it
syntax region 	MaterialAttribute 	matchgroup=MaterialAttribute keepend start="^\s*lod_distances\>" end="$" contained skipwhite contains=Comment,MaterialError
syntax region 	MaterialAttribute 	matchgroup=MaterialAttribute keepend start="^\s*receive_shadows\>" end="$" contained skipwhite contains=OnOff,Comment,MaterialError
syntax region 	MaterialAttribute 	matchgroup=MaterialAttribute keepend start="^\s*receive_shadows\>" end="$" contained skipwhite contains=OnOff,Comment,MaterialError
syntax region 	MaterialAttribute 	matchgroup=MaterialAttribute keepend start="^\s*transparency_casts_shadows\>" end="$" contained skipwhite contains=OnOff,Comment,MaterialError
syntax region 	MaterialAttribute 	matchgroup=MaterialAttribute keepend start="^\s*lod_values\>" end="$" contained skipwhite contains=OnOff,Comment,MaterialError


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Technique block
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax region TechniqueBlock		matchgroup=TechniqueBlock start="\<technique\>" end="{"me=e-1 transparent contained contains=Comment nextgroup=TechniqueBlockEnd
syntax region TechniqueBlockEnd		matchgroup=TechniqueBlock start="{" end="}" transparent contained contains=TechniqueAttribute,PassBlock,Comment,UnknownBlock

syntax region TechniqueAttribute 	matchgroup=TechniqueAttribute start="^\s*\<lod_index\>" end="$" transparent contained contains=Integer
syntax region TechniqueAttribute 	matchgroup=TechniqueAttribute start="^\s*\<shadow_caster_material\>" end="$" transparent contained contains=String
syntax region TechniqueAttribute	matchgroup=TechniqueAttribute start="^\s*\<shadow_receiver_material\>" end="$" transparent contained contains=String
syntax region TechniqueAttribute	matchgroup=TechniqueAttribute start="^\s*\<scheme\>" end="$" transparent contained contains=String

syntax keyword InclusionType		include exclude contained
syntax region TechniqueAttribute	matchgroup=TechniqueAttribute start="^\s*\<gpu_device_rule\>" end="$" transparent contained contains=InclusionType,Comment
syntax region TechniqueAttribute	matchgroup=TechniqueAttribute start="^\s*\<gpu_vendor_rule\>" end="$" transparent contained contains=InclusionType,Comment


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pass block
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax region PassBlock 	matchgroup=PassBlock start="\<pass\>" end="{"me=e-1 transparent contained contains=Comment nextgroup=PassBlockEnd
syntax region PassBlockEnd		matchgroup=PassBlock start="{" end="}" transparent contained contains=TextureUnit,PassAttribute,GpuProgramRef,Comment,UnknownBlock,MaterialError

syntax region PassAttribute		matchgroup=PassAttribute start="^\s*ambient\>" end="$" transparent contained contains=ColorValueOrVertexColor,Comment,MaterialError
syntax region PassAttribute		matchgroup=PassAttribute start="^\s*diffuse\>" end="$" transparent contained contains=ColorValueOrvertexColor,Comment,MaterialError

let pattSpecular = printf( '%s\s\+%s', pattColorOrVertexColor, pattFloat )
execute 'syntax match SpecularValue "' pattSpecular.'" contained'

syntax region PassAttribute		matchgroup=PassAttribute start="^\s*specular\>" end="$" transparent contained contains=SpecularValue,Comment,MaterialError
syntax region PassAttribute		matchgroup=PassAttribute start="^\s*emissive\>" end="$" transparent contained contains=ColorValueOrVertexColor,Comment,MaterialError

" composite scene blend value
syntax keyword SceneBlendValueOp	add modulate colour_blend alpha_blend contained
syntax keyword SceneBlendValueFactor one zero dest_colour src_colour one_minus_dest_colour one_minus_src_colour dest_alpha src_alpha one_minus_dest_alpha one_minus_src_alpha contained

syntax region PassAttribute		matchgroup=PassAttribute start="^\s*scene_blend\>" end="$" transparent contained contains=SceneBlendValueOp,SceneBlendValueFactor,Comment,MaterialError
syntax region PassAttribute		matchgroup=PassAttribute start="^\s*separate_scene_blend\>" end="$" transparent contained contains=SceneBlendValueFactor,SceneBlendValue,Comment,MaterialError

syntax keyword SceneBlendOpValue add subtract reverse_subtract min max contained
syntax region PassAttribute		matchgroup=PassAttribute start="^\s*scene_blend_op\>" end="$" transparent contained contains=SceneBlendOpValue,Comment,MaterialError
syntax region PassAttribute		matchgroup=PassAttribute start="^\s*separate_scene_blend_op\>" end="$" transparent contained contains=SceneBlendOpValue,Comment,MaterialError

syntax region PassAttribute		matchgroup=PassAttribute start="^\s*depth_check\>" end="$" transparent contained contains=OnOff,Comment,MaterialError
syntax region PassAttribute		matchgroup=PassAttribute start="^\s*depth_write\>" end="$" transparent contained contains=OnOff,Comment,MaterialError

syn keyword ComparisonFunctionValue	always_fail always_pass less less_equal equal not_equal greater_equal greater contained

syntax region PassAttribute		matchgroup=PassAttribute start="^\s*depth_func\>" end="$" transparent contained contains=ComparisonFunctionValue,Comment,MaterialError
syntax region PassAttribute		matchgroup=PassAttribute start="^\s*depth_bias\>" end="$" transparent contained contains=Float,Comment,MaterialError
syntax region PassAttribute		matchgroup=PassAttribute start="^\s*iteration_depth_bias\>" end="$" transparent contained contains=Float,Comment,MaterialError

syntax region PassAttribute		matchgroup=PassAttribute start="^\s*alpha_rejection\>" end="$" transparent contained contains=ComparisonFunctionValue,Integer,Comment,MaterialError
syntax region PassAttribute		matchgroup=PassAttribute start="^\s*alpha_to_coverage\>" end="$" transparent contained contains=OnOff,Comment,MaterialError

syntax region PassAttribute		matchgroup=PassAttribute start="^\s*light_scissor\>" end="$" transparent contained contains=OnOff,Comment,MaterialError
syntax region PassAttribute		matchgroup=PassAttribute start="^\s*light_clip_planes\>" end="$" transparent contained contains=OnOff,Comment,MaterialError

syntax keyword IlluminationStageValue ambient per_light decal contained
syntax region PassAttribute		matchgroup=PassAttribute start="^\s*illumination_stage\>" end="$" transparent contained contains=IlluminationStageValue,Comment,MaterialError
syntax region PassAttribute		matchgroup=PassAttribute start="^\s*normalise_normals\>" end="$" transparent contained contains=OnOff,Comment,MaterialError

syntax keyword TransparentSortingValue on off force contained
syntax region PassAttribute		matchgroup=PassAttribute start="^\s*transparent_sorting\>" end="$" transparent contained contains=TransparentSortingValue,Comment,MaterialError

syntax keyword HardwareCullingValue clockwise anticlockwise none contained
syntax keyword SoftwareCullingValue back front none contained

syntax region PassAttribute		matchgroup=PassAttribute start="^\s*cull_hardware\>" end="$" transparent contained contains=HardwareCullingValue,Comment,MaterialError
syntax region PassAttribute		matchgroup=PassAttribute start="^\s*cull_software\>" end="$" transparent contained contains=SoftwareCullingValue,Comment,MaterialError

syntax region PassAttribute		matchgroup=PassAttribute start="^\s*lighting\>" end="$" transparent contained contains=OnOff,Comment,MaterialError

syntax keyword ShadingType		flat gourard phong contained
syntax region PassAttribute		matchgroup=PassAttribute start="^\s*shading\>" end="$" transparent contained contains=ShadingType,Comment,MaterialError

syntax keyword PolygonMode		solid wireframe points contained
syntax region PassAttribute		matchgroup=PassAttribute start="^\s*polygon_mode\>" end="$" transparent contained contains=PolygonMode,Comment,MaterialError
syntax region PassAttribute		matchgroup=PassAttribute start="^\s*polygon_mode_overrideable\>" end="$" transparent contained contains=Boolean,Comment,MaterialError

syntax keyword FogTypes 		none linear exp exp2 contained skipwhite nextgroup=float6
syntax region PassAttribute		matchgroup=PassAttribute start="^\s*fog_override\>" end="$" transparent contained contains=Boolean,FogTypes,Comment,MaterialError
syntax region PassAttribute		matchgroup=PassAttribute start="^\s*colour_write\>" end="$" transparent contained contains=OnOff,Comment,MaterialError

syntax region PassAttribute		matchgroup=PassAttribute start="^\s*max_lights\>" end="$" transparent contained contains=Integer,Comment,MaterialError
syntax region PassAttribute		matchgroup=PassAttribute start="^\s*start_light\>" end="$" transparent contained contains=Integer,Comment,MaterialError


syntax keyword LightType 		point directional spot contained
syntax keyword IterationFrequency	once once_per_light per_light per_n_light
syntax region PassAttribute		matchgroup=PassAttribute start="^\s*iteration\>" end="$" transparent contained contains=LightType,IterationFrequency,Integer,Comment,MaterialError


syntax region PassAttribute		matchgroup=PassAttribute start="^\s*point_size\>" end="$" transparent contained contains=Float,Comment,MaterialError
syntax region PassAttribute		matchgroup=PassAttribute start="^\s*point_sprites\>" end="$" transparent contained contains=OnOff,Comment,MaterialError

syntax keyword PointSizeAttenuationType constant linear quadratic contained
syntax region PassAttribute		matchgroup=PassAttribute start="^\s*point_size_attenuation\>" end="$" transparent contained contains=OnOff,PointSizeAttenuationType,Comment,MaterialError

syntax region PassAttribute		matchgroup=PassAttribute start="^\s*point_size_min\>" end="$" transparent contained contains=Float,Comment,MaterialError
syntax region PassAttribute		matchgroup=PassAttribute start="^\s*point_size_max\>" end="$" transparent contained contains=Float,Comment,MaterialError

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Texture units blocks
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax region TextureUnit	 	matchgroup=TextureUnitBlock start="\<texture_unit\>" end="{"me=e-1 transparent contained contains=Comment nextgroup=TextureUnitEnd
syntax region TextureUnitEnd	matchgroup=TextureUnitBlock start="{" end="}" transparent contained contains=TextureUnitAttribute,Comment,UnknownBlock,MaterialError

" rride: let it be unsupported for now=)
" syntax region TextureUnitAttribute	matchgroup=TextureUnitAttribute	start="^\s*texture_source\>" end="$" transparent contained contains=Comment,MaterialError
syntax region TextureUnitAttribute	matchgroup=TextureUnitAttribute	start="^\s*texture_alias\>" end="$" transparent contained contains=Comment,MaterialError

syntax keyword TextureType 			1d 2d 3d cubic contained
syntax keyword TextureParams		unlimited alpha gamma contained
syntax keyword PixelFormat		
	\	PF_L8 
	\	PF_L16 
	\	PF_A8 
	\	PF_A4L4 
	\	PF_BYTE_LA 
	\	PF_R5G6B5 
	\	PF_B5G6R5 
	\	PF_R3G3B2 
	\	PF_A4R4G4B4 
	\	PF_A1R5G5B5 
	\	PF_R8G8B8 
	\	PF_B8G8R8 
	\	PF_A8R8G8B8 
	\	PF_A8B8G8R8 
	\	PF_B8G8R8A8 
	\	PF_R8G8B8A8 
	\	PF_X8R8G8B8 
	\	PF_X8B8G8R8 
	\	PF_A2R10G10B10 
	\	PF_A2B10G10R10 
	\	PF_FLOAT16_R 
	\	PF_FLOAT16_RGB 
	\	PF_FLOAT16_RGBA 
	\	PF_FLOAT32_R 
	\	PF_FLOAT32_RGB 
	\	PF_FLOAT32_RGBA 
	\	PF_SHORT_RGBA 
	\	contained


syntax region TextureUnitAttribute	matchgroup=TextureUnitAttribute	start="^\s*texture\>" end="$" transparent contained contains=String,TextureType,Integer,TextureParams,PixelFormat,Comment

" anim_texture <base_name> <num_frames> <duration>
"  - OR -
" anim_texture <frame1> <frame2> ... <duration>
syntax region TextureUnitAttribute	matchgroup=TextureUnitAttribute	start="^\s*anim_texture\>" end="$" transparent contained contains=String,Float,Comment,MaterialError

" Format1 (short): cubic_texture <base_name> <combinedUVW|separateUV>
" -OR-
" Format2 (long): cubic_texture <front> <back> <left> <right> <up> <down> separateUV
syntax keyword CubicTextureUsageMode combinedUVW separateUV contained
syntax region TextureUnitAttribute	matchgroup=TextureUnitAttribute	start="^\s*cubic_texture\>" end="$" transparent contained contains=String,CubicTextureUsageMode,Comment,MaterialError

" binding_type <vertex|fragment>
syntax keyword TextureUnitBindingType vertex fragment contained
syntax region TextureUnitAttribute	matchgroup=TextureUnitAttribute	start="^\s*binding_type\>" end="$" transparent contained contains=TextureUnitBindingType,Comment,MaterialError

" content_type <named|shadow|compositor> [<Referenced Compositor Name>] [<Referenced Texture Name>] [<Referenced MRT Index>] 
syntax keyword TextureContentType	named shadow compositor contained
syntax region TextureUnitAttribute	matchgroup=TextureUnitAttribute	start="^\s*content_type\>" end="$" transparent contained contains=TextureContentType,Comment,MaterialError

" tex_coord_set <set_num>
syntax region TextureUnitAttribute	matchgroup=TextureUnitAttribute	start="^\s*tex_coord_set\>" end="$" transparent contained contains=Integer,Comment,MaterialError

"tex_address_mode <uvw_mode> 
"tex_address_mode <u_mode> <v_mode> [<w_mode>]
syntax keyword TexAddressModeType	wrap clamp mirror border contained
syntax region TextureUnitAttribute	matchgroup=TextureUnitAttribute	start="^\s*tex_address_mode\>" end="$" transparent contained contains=TexAddressModeType,Comment,MaterialError

" tex_border_colour <red> <green> <blue> [<alpha>]
syntax region TextureUnitAttribute	matchgroup=TextureUnitAttribute	start="^\s*tex_border_colour\>" end="$" transparent contained contains=ColorValue,Comment,MaterialError

" filtering <none|bilinear|trilinear|anisotropic>
" -OR-
" filtering <minification> <magnification> <mip>
syntax keyword TextureFilteringType none bilinear trilinear anisotropic point linear contained
syntax region TextureUnitAttribute	matchgroup=TextureUnitAttribute	start="^\s*filtering\>" end="$" transparent contained contains=TextureFilteringType,Comment,MaterialError

syntax region TextureUnitAttribute	matchgroup=TextureUnitAttribute	start="^\s*max_anisotropy\>" end="$" transparent contained contains=Integer,Comment,MaterialError
syntax region TextureUnitAttribute	matchgroup=TextureUnitAttribute	start="^\s*mipmap_bias\>" end="$" transparent contained contains=Comment,MaterialError

" colour_op <replace|add|modulate|alpha_blend>
syntax keyword TextureUnitColorOp replace add modulate alpha_blend contained
syntax region TextureUnitAttribute	matchgroup=TextureUnitAttribute	start="^\s*colour_op\>" end="$" transparent contained contains=Comment,MaterialError

" colour_op_ex <operation> <source1> <source2> [<manual_factor>] [<manual_colour1>] [<manual_colour2>]
syntax keyword TextureUnitColorOpEx source1 source2 modulate modulate_x2 modulate_x4 add add_signed add_smooth contained
syntax keyword TextureUnitColorOpEx subtract blend_diffuse_alpha blend_texture_alpha blend_current_alpha contained
syntax keyword TextureUnitColorOpEx blend_manual dotproduct blend_diffuse_colour src_current src_texture src_diffuse src_specular src_manual contained
syntax region TextureUnitAttribute	matchgroup=TextureUnitAttribute	start="^\s*colour_op_ex\>" end="$" transparent contained contains=TextureUnitColorOpEx,Comment,MaterialError

syntax region TextureUnitAttribute	matchgroup=TextureUnitAttribute	start="^\s*colour_op_multipass_fallback\>" end="$" transparent contained contains=SceneBlendValueFactor,Comment,MaterialError

syntax region TextureUnitAttribute	matchgroup=TextureUnitAttribute	start="^\s*alpha_op_ex\>" end="$" transparent contained contains=TextureUnitColorOpEx,Comment,MaterialError

syntax keyword EnvMap				off spherical planar cubic_reflection cubic_normal contained
syntax region TextureUnitAttribute	matchgroup=TextureUnitAttribute	start="^\s*env_map\>" end="$" transparent contained contains=EnvMap,Comment,MaterialError

syntax region TextureUnitAttribute	matchgroup=TextureUnitAttribute	start="^\s*scroll\>" end="$" transparent contained contains=Float,Comment,MaterialError
syntax region TextureUnitAttribute	matchgroup=TextureUnitAttribute	start="^\s*scroll_anim\>" end="$" transparent contained contains=Float,Comment,MaterialError
syntax region TextureUnitAttribute	matchgroup=TextureUnitAttribute	start="^\s*rotate\>" end="$" transparent contained contains=Float,Comment,MaterialError
syntax region TextureUnitAttribute	matchgroup=TextureUnitAttribute	start="^\s*rotate_anim\>" end="$" transparent contained contains=Float,Comment,MaterialError
syntax region TextureUnitAttribute	matchgroup=TextureUnitAttribute	start="^\s*scale\>" end="$" transparent contained contains=Float,Comment,MaterialError

" wave_xform <xform_type> <wave_type> <base> <frequency> <phase> <amplitude>
syntax keyword TextureUnitXformType scroll_x scroll_y rotate scale_x scale_y contained
syntax keyword TextureUnitWaveType	sine triangle square sawtooth inverse_sawtooth contained
syntax region TextureUnitAttribute	matchgroup=TextureUnitAttribute	start="^\s*wave_xform\>" end="$" transparent contained contains=TextureUnitXformType,TextureUnitWaveType,Comment,MaterialError
syntax region TextureUnitAttribute	matchgroup=TextureUnitAttribute	start="^\s*transform\>" end="$" transparent contained contains=Float16,Comment,MaterialError


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GPU program references syntax
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax region GpuProgramRef 		matchgroup=GpuProgramRef start="\(\<vertex_program_ref\>\)\|\(\<fragment_program_ref\>\)\|\(\<geometry_program_ref\>\)" end="{"me=e-1 transparent contained contains=Comment nextgroup=GpuProgramRefBlock
syntax region GpuProgramRefBlock	matchgroup=GpuProgramRef start="{" end="}" transparent contained contains=GpuProgramParams,GpuSharedParamsRef,Comment,MaterialError


syntax keyword GpuAutoParamType
	\ 	world_matrix
	\ 	inverse_world_matrix
	\	transpose_world_matrix
	\	inverse_transpose_world_matrix
	\	world_matrix_array_3x4
	\	view_matrix
	\	inverse_view_matrix
	\	transpose_view_matrix
	\	inverse_transpose_view_matrix
	\	projection_matrix
	\	inverse_projection_matrix
	\	transpose_projection_matrix
	\	inverse_transpose_projection_matrix
	\	worldview_matrix
	\	inverse_worldview_matrix
	\	transpose_worldview_matrix
	\	inverse_transpose_worldview_matrix
	\	viewproj_matrix
	\	inverse_viewproj_matrix
	\	transpose_viewproj_matrix
	\	inverse_transpose_viewproj_matrix
	\	worldviewproj_matrix
	\	inverse_worldviewproj_matrix
	\	transpose_worldviewproj_matrix
	\	inverse_transpose_worldviewproj_matrix
	\	texture_matrix
	\	render_target_flipping
	\	vertex_winding
	\	light_diffuse_colour
	\	light_specular_colour
	\	light_attenuation
	\	spotlight_params
	\	light_position
	\	light_direction
	\	light_position_object_space
	\	light_direction_object_space
	\	light_distance_object_space
	\	light_position_view_space
	\	light_direction_view_space
	\	light_power
	\	light_diffuse_colour_power_scaled
	\	light_specular_colour_power_scaled
	\	light_number
	\	light_diffuse_colour_array
	\	light_specular_colour_array
	\	light_diffuse_colour_power_scaled_array
	\	light_specular_colour_power_scaled_array
	\	light_attenuation_array
	\	spotlight_params_array
	\	light_position_array
	\	light_direction_array
	\	light_position_object_space_array
	\	light_direction_object_space_array
	\	light_distance_object_space_array
	\	light_position_view_space_array
	\	light_direction_view_space_array
	\	light_power_array
	\	light_count
	\	light_casts_shadows
	\	ambient_light_colour
	\	surface_ambient_colour
	\	surface_diffuse_colour
	\	surface_specular_colour
	\	surface_emissive_colour
	\	surface_shininess
	\	derived_ambient_light_colour
	\	derived_scene_colour
	\	derived_light_diffuse_colour
	\	derived_light_specular_colour
	\	derived_light_diffuse_colour_array
	\	derived_light_specular_colour_array
	\	fog_colour
	\	fog_params
	\	camera_position
	\	camera_position_object_space
	\	lod_camera_position
	\	lod_camera_position_object_space
	\	time
	\	time_0_x
	\	costime_0_x
	\	sintime_0_x
	\	tantime_0_x
	\	time_0_x_packed
	\	time_0_1
	\	costime_0_1
	\	sintime_0_1
	\	tantime_0_1
	\	time_0_1_packed
	\	time_0_2pi
	\	costime_0_2pi
	\	sintime_0_2pi
	\	tantime_0_2pi
	\	time_0_2pi_packed
	\	frame_time
	\	fps
	\	viewport_width
	\	viewport_height
	\	inverse_viewport_width
	\	inverse_viewport_height
	\	viewport_size
	\	texel_offsets
	\	view_direction
	\	view_side_vector
	\	view_up_vector
	\	fov
	\	near_clip_distance
	\	far_clip_distance
	\	texture_viewproj_matrix
	\	texture_viewproj_matrix_array
	\	texture_worldviewproj_matrix
	\	texture_worldviewproj_matrix_array
	\	spotlight_viewproj_matrix
	\	spotlight_worldviewproj_matrix
	\	scene_depth_range
	\	shadow_scene_depth_range
	\	shadow_colour
	\	shadow_extrusion_distance
	\	texture_size
	\	inverse_texture_size
	\	packed_texture_size
	\	pass_number
	\	pass_iteration_number
	\	animation_parametric
	\	custom
	\ contained


syntax region GpuProgramParams matchgroup=GpuProgramParams start="\<param_named\>" end="$" transparent contained contains=GpuType,Float,Comment
syntax region GpuProgramParams matchgroup=GpuProgramParams start="\<param_named_auto\>" end="$" transparent contained contains=GpuAutoParamType,GpuType,Float,Comment
syntax region GpuProgramParams matchgroup=GpuProgramParams start="\<param_indexed\>" end="$" transparent contained contains=GpuType,Float,Comment
syntax region GpuProgramParams matchgroup=GpuProgramParams start="\<param_indexed_auto\>" end="$" transparent contained contains=GpuAutoParamType,GpuType,Float,Comment
syntax region GpuSharedParamsRef matchgroup=GpuSharedParamsRef start="\<shared_params_ref\>" end="$" transparent contained contains=Comment


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GPU program block
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

synta keyword GpuProgramType 	asm hlsl cg glsl contained
syntax region GpuProgram 		matchgroup=GpuProgram start="\(\<vertex_program\>\)\|\(\<fragment_program\>\)\|\(\<geometry_program\>\)" end="{"me=e-1 transparent contains=GpuProgramType,Comment nextgroup=GpuProgramBlock
syntax region GpuProgramBlock	matchgroup=GpuProgram start="{" end="}" transparent contained contains=GpuProgramAttribute,DefaultGPUProgramParams,Comment,MaterialError

syntax region GpuProgramAttribute matchgroup=GpuProgramAttribute start="\<source\>" end="$" transparent contained contains=String,Comment
syntax region GpuProgramAttribute matchgroup=GpuProgramAttribute start="\<entry_point\>" end="$" transparent contained contains=Comment

syntax keyword GpuProgramSyntax 
	\	vs_1_1 
	\	vs_2_0 
	\	vs_2_x 
	\	vs_3_0 
	\	arbvp1 
	\	vp20 
	\	vp30 
	\	vp40 
	\	ps_1_1 ps_1_2 ps_1_3 
	\	ps_1_4 
	\	ps_2_0 
	\	ps_2_x 
	\	ps_3_0 
	\	ps_3_x 
	\	arbfp1 
	\	fp20 
	\	fp30 
	\	fp40 
	\	gpu_gp gp4_gp 


syntax region GpuProgramAttribute matchgroup=GpuProgramAttribute start="\<profiles\>" end="$" transparent contained contains=GpuProgramSyntax,Comment,MaterialError
syntax region GpuProgramAttribute matchgroup=GpuProgramAttribute start="\<syntax\>" end="$" transparent contained contains=GpuProgramSyntax,Comment,MaterialError
syntax region GpuProgramAttribute matchgroup=GpuProgramAttribute start="\<target\>" end="$" transparent contained contains=GpuProgramSyntax,Comment,MaterialError
syntax region GpuProgramAttribute matchgroup=GpuProgramAttribute start="\<manual_named_constants\>" end="$" transparent contained contains=Comment

syntax match PreProc 			  "\i\+" contained
syntax region GpuProgramAttribute matchgroup=GpuProgramAttribute start="\<preprocessor_defines\>" end="$" transparent contained contains=PreProc,Comment

syntax region DefaultGPUProgramParams matchgroup=GpuProgram start="\<default_params\>" end="{"me=e-1 transparent contained contains=Comment nextgroup=GpuProgramRefBlock

"""""""""""
" attributes for high-level GPU programs
syntax region GpuProgramAttribute matchgroup=GpuProgramAttribute start="\<includes_skeletal_animation\>" end="$" transparent contained contains=Boolean,Comment,MaterialError
syntax region GpuProgramAttribute matchgroup=GpuProgramAttribute start="\<includes_morph_animation\>" end="$" transparent contained contains=Boolean,Comment,MaterialError
syntax region GpuProgramAttribute matchgroup=GpuProgramAttribute start="\<uses_vertex_texture_fetch\>" end="$" transparent contained contains=Boolean,Comment,MaterialError
syntax region GpuProgramAttribute matchgroup=GpuProgramAttribute start="\<uses_adjacency_information\>" end="$" transparent contained contains=Boolean,Comment,MaterialError
syntax region GpuProgramAttribute matchgroup=GpuProgramAttribute start="\<includes_pose_animation\>" end="$" transparent contained contains=Integer,Comment,MaterialError


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Gpu programs shared params
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax region GpuProgramSharedParamsBlock matchgroup=GpuProgramRef start="\<shared_params\>" end="{"me=e-1 transparent contained contains=Comment nextgroup=GpuProgramSharedParamsBlockEnd
syntax region GpuProgramSharedParamsBlockEnd matchgroup=GpuProgramRef start="{" end="}" transparent contained contains=GpuProgramParams,GpuSharedParamsRef,Comment,MaterialError

syntax region GpuProgramParams matchgroup=GpuProgramParams start="\<shared_param_named\>" end="$" transparent contained contains=GpuType,Float,Comment
syntax region GpuProgramParams matchgroup=GpuProgramParams start="\<shared_param_named_auto\>" end="$" transparent contained contains=GpuAutoParamType,GpuType,Float,Comment
syntax region GpuProgramParams matchgroup=GpuProgramParams start="\<shared_param_indexed\>" end="$" transparent contained contains=GpuType,Float,Comment
syntax region GpuProgramParams matchgroup=GpuProgramParams start="\<shared_param_indexed_auto\>" end="$" transparent contained contains=GpuAutoParamType,GpuType,Float,Comment
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Finalization
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"syntax region MaterialAttribute 
if version >= 508 || !exists("did_test_syntax_inits")
	if version < 508
		let did_lua_syntax_inits = 1
		command -nargs=+ HiLink hi link <args>
	else
		command -nargs=+ HiLink hi link <args>
	endif
	HiLink OnOff				Boolean
	HiLink MaterialError		Error

	HiLink Integer				Number

	HiLink Float				Number
	HiLink Float4				Number
	HiLink Float16				Number
	HiLink Float6				Number

	HiLink GpuType				Type

	HiLink AbstractBlock 		Keyword
	"material highlight defs
	HiLink MaterialBlock 		Structure
	HiLink MaterialAttribute 	Statement
	HiLink MaterialLodStrategy 	Constant

	" technique highlighting defs
	HiLink TechniqueBlock 		Structure
	HiLink TechniqueAttribute	Statement
	HiLink InclusionType	 	Constant

	" pass highlighting defs
	HiLink PassBlock 			Structure
	HiLink PassAttribute		Statement

	HiLink SpecularValue 		Constant
	HiLink PolygonMode			Constant
	HiLink FogTypes				Constant
	HiLink ShadingType			Constant
	HiLink SoftwareCullingValue Constant
	HiLink HardwareCullingValue Constant
	HiLink SceneBlendValueOp		Constant
	HiLink SceneBlendValueFactor	Constant
	HiLink SceneBlendOpValue 		Constant
	HiLink ComparisonFunctionValue	Constant
	HiLink IlluminationStageValue 	Constant
	HiLink TransparentSortingValue 	Constant
	HiLink LightType			Constant
	HiLink IterationFrequency	Constant	

	" taxture unit highlighting defs
	HiLink TextureUnitBlock 	Structure
	HiLink TextureUnitAttribute	Statement

	HiLink TextureType			Constant
	HiLink TextureParams		Constant
	HiLink PixelFormat			Constant
	HiLink CubicTextureUsageMod Constant
	HiLink TextureUnitBindingType Constant
	HiLink TextureContentType Constant

	HiLink TexAddressModeType Constant
	HiLink TextureFilteringType Constant
	HiLink TextureUnitColorOp Constant
	HiLink TextureUnitColorOpEx Constant
	HiLink EnvMap Constant
	HiLink TextureUnitXformType Constant
	HiLink TextureUnitWaveType Constant
	
	" gpu program refs
	HiLink GpuProgramRef 	Structure
	HiLink GpuProgramParams Statement
	HiLink GpuSharedParamsRef Statement

	" gpu programs secition
	HiLink GpuProgram		Structure
	HiLink GpuProgramAttribute	Statement
	HiLink GpuProgramType	Constant

	HiLink GpuAutoParamType Identifier

	delcommand HiLink
endif

let b:current_syntax = "ogrematerial"
