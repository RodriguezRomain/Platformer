package;


import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import lime.utils.Assets;

#if sys
import sys.FileSystem;
#end

@:access(lime.utils.Assets)


@:keep @:dox(hide) class ManifestResources {
	
	
	public static var preloadLibraries:Array<AssetLibrary>;
	public static var preloadLibraryNames:Array<String>;
	
	
	public static function init (config:Dynamic):Void {
		
		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();
		
		var rootPath = null;
		
		if (config != null && Reflect.hasField (config, "rootPath")) {
			
			rootPath = Reflect.field (config, "rootPath");
			
		}
		
		if (rootPath == null) {
			
			#if (ios || tvos || emscripten)
			rootPath = "assets/";
			#elseif (sys && windows && !cs)
			rootPath = FileSystem.absolutePath (haxe.io.Path.directory (#if (haxe_ver >= 3.3) Sys.programPath () #else Sys.executablePath () #end)) + "/";
			#else
			rootPath = "";
			#end
			
		}
		
		Assets.defaultRootPath = rootPath;
		
		#if (openfl && !flash && !display)
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_fonts_arial_italic_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_fonts_myfont_ttf);
		
		#end
		
		var data, manifest, library;
		
		#if kha
		
		null
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("null", library);
		
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("null");
		
		#else
		
		data = '{"name":"loader","assets":"aoy4:pathy25:lib%2Floader%2Floader.biny4:sizei1050y4:typey4:TEXTy2:idR1y7:preloadtgh","rootPath":null,"version":2,"libraryArgs":["lib/loader/loader.bin"],"libraryType":"openfl._internal.swf.SWFLiteLibrary"}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("loader", library);
		data = '{"name":"ui","assets":"aoy4:pathy17:lib%2Fui%2Fui.biny4:sizei23291y4:typey4:TEXTy2:idR1y7:preloadtgh","rootPath":null,"version":2,"libraryArgs":["lib/ui/ui.bin"],"libraryType":"openfl._internal.swf.SWFLiteLibrary"}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("ui", library);
		data = '{"name":null,"assets":"aoy4:pathy23:assets%2Fcolliders.jsony4:sizei991y4:typey4:TEXTy2:idR1goR0y20:assets%2Fconfig.jsonR2i115R3R4R5R6goR2i553284R3y4:FONTy9:classNamey38:__ASSET__assets_fonts_arial_italic_ttfR5y35:assets%2Ffonts%2FArial%20Italic.ttfy7:preloadtgoR2i16312R3R7R8y32:__ASSET__assets_fonts_myfont_ttfR5y27:assets%2Ffonts%2FMyFont.ttfR11tgoR0y42:assets%2Fimages%2FBackgrounds1_world1.jsonR2i2246R3R4R5R14goR0y41:assets%2Fimages%2FBackgrounds1_world1.pngR2i21091R3y5:IMAGER5R15goR0y42:assets%2Fimages%2FBackgrounds2_world1.jsonR2i2182R3R4R5R17goR0y41:assets%2Fimages%2FBackgrounds2_world1.pngR2i32001R3R16R5R18goR0y33:assets%2Fimages%2FCharacters.jsonR2i18622R3R4R5R19goR0y32:assets%2Fimages%2FCharacters.pngR2i1519457R3R16R5R20goR0y38:assets%2Fimages%2FGameBack_world1.jsonR2i830R3R4R5R21goR0y37:assets%2Fimages%2FGameBack_world1.pngR2i2134R3R16R5R22goR0y39:assets%2Fimages%2FGameFront_world1.jsonR2i850R3R4R5R23goR0y38:assets%2Fimages%2FGameFront_world1.pngR2i11594R3R16R5R24goR0y42:assets%2Fimages%2FLevelDesigns_world1.jsonR2i624R3R4R5R25goR0y41:assets%2Fimages%2FLevelDesigns_world1.pngR2i830R3R16R5R26goR0y29:assets%2Flevels%2FLevel1.jsonR2i22046R3R4R5R27goR0y29:assets%2Flevels%2FLevel2.jsonR2i19914R3R4R5R28goR0y29:assets%2Flib%2Fdat.gui.min.jsR2i50167R3R4R5R29goR0y31:assets%2Flibraries%2Floader.swfR2i505R3y6:BINARYR5R30goR0y27:assets%2Flibraries%2Fui.swfR2i191416R3R31R5R32goR0y31:assets%2Fparticles%2Fdust.plistR2i3105R3R4R5R33goR0y29:assets%2Fparticles%2Fdust.pngR2i3803R3R16R5R34goR0y31:assets%2Fparticles%2Ffire.plistR2i3289R3R4R5R35goR0y29:assets%2Fparticles%2Ffire.pngR2i2567R3R16R5R36goR0y32:assets%2Fparticles%2Ftrail.plistR2i2880R3R4R5R37goR0y30:assets%2Fparticles%2Ftrail.pngR2i776R3R16R5R38goR0y18:assets%2Fpool.jsonR2i114R3R4R5R39goR2i16686R3y5:MUSICR5y27:assets%2Fsounds%2Fclick.mp3y9:pathGroupaR41hgoR2i5415664R3R40R5y35:assets%2Fsounds%2FDerp%20Nugget.mp3R42aR43hgoR0y29:assets%2Fsounds%2Fsounds.jsonR2i232R3R4R5R44goR0R6R2i115R3R4R5R6R11tgoR0R44R2i232R3R4R5R44R11tgh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("default", library);
		
		
		library = Assets.getLibrary ("loader");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("loader");
		library = Assets.getLibrary ("default");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("default");
		
		
		#end
		
	}
	
	
}


#if kha

null

#else

#if !display
#if flash

@:keep @:bind #if display private #end class __ASSET__assets_colliders_json extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_config_json extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_fonts_arial_italic_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_fonts_myfont_ttf extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_images_backgrounds1_world1_json extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_images_backgrounds1_world1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_backgrounds2_world1_json extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_images_backgrounds2_world1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_characters_json extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_images_characters_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_gameback_world1_json extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_images_gameback_world1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_gamefront_world1_json extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_images_gamefront_world1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_images_leveldesigns_world1_json extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_images_leveldesigns_world1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_levels_level1_json extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_levels_level2_json extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_lib_dat_gui_min_js extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_libraries_loader_swf extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_libraries_ui_swf extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_particles_dust_plist extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_particles_dust_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_particles_fire_plist extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_particles_fire_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_particles_trail_plist extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_particles_trail_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind #if display private #end class __ASSET__assets_pool_json extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_click_mp3 extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_derp_nugget_mp3 extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_sounds_json extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_config_json1 extends null { }
@:keep @:bind #if display private #end class __ASSET__assets_sounds_sounds_json1 extends null { }
@:keep @:bind #if display private #end class __ASSET__lib_loader_loader_bin extends null { }
@:keep @:bind #if display private #end class __ASSET__lib_loader_json extends null { }
@:keep @:bind #if display private #end class __ASSET__lib_ui_ui_bin extends null { }
@:keep @:bind #if display private #end class __ASSET__lib_ui_json extends null { }
@:keep @:bind #if display private #end class __ASSET__manifest_default_json extends null { }


#elseif (desktop || cpp)

@:keep @:file("assets/config.json") #if display private #end class __ASSET__assets_config_json1 extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/sounds.json") #if display private #end class __ASSET__assets_sounds_sounds_json1 extends haxe.io.Bytes {}
@:keep @:file("C:/Users/Romain Rodriguez/Desktop/RODRIGUEZ_R/deliveries/20181014_Platformer/Platformer/bin/html5/obj/libraries/loader/loader.bin") #if display private #end class __ASSET__lib_loader_loader_bin extends haxe.io.Bytes {}
@:keep @:file("") #if display private #end class __ASSET__lib_loader_json extends haxe.io.Bytes {}
@:keep @:file("C:/Users/Romain Rodriguez/Desktop/RODRIGUEZ_R/deliveries/20181014_Platformer/Platformer/bin/html5/obj/libraries/ui/ui.bin") #if display private #end class __ASSET__lib_ui_ui_bin extends haxe.io.Bytes {}
@:keep @:file("") #if display private #end class __ASSET__lib_ui_json extends haxe.io.Bytes {}
@:keep @:file("") #if display private #end class __ASSET__manifest_default_json extends haxe.io.Bytes {}

@:keep #if display private #end class __ASSET__assets_fonts_arial_italic_ttf extends lime.text.Font { public function new () { __fontPath = #if (ios || tvos) "assets/" + #end "assets/fonts/Arial Italic"; name = "Arial Italic"; super (); }}
@:keep #if display private #end class __ASSET__assets_fonts_myfont_ttf extends lime.text.Font { public function new () { __fontPath = #if (ios || tvos) "assets/" + #end "assets/fonts/MyFont"; name = "Super Mario 256"; super (); }}


#else

@:keep @:expose('__ASSET__assets_fonts_arial_italic_ttf') #if display private #end class __ASSET__assets_fonts_arial_italic_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/fonts/Arial Italic"; #else ascender = 1854; descender = -434; height = 2355; numGlyphs = 2516; underlinePosition = -292; underlineThickness = 150; unitsPerEM = 2048; #end name = "Arial Italic"; super (); }}
@:keep @:expose('__ASSET__assets_fonts_myfont_ttf') #if display private #end class __ASSET__assets_fonts_myfont_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/fonts/MyFont"; #else ascender = 750; descender = -250; height = 1000; numGlyphs = 128; underlinePosition = -100; underlineThickness = 50; unitsPerEM = 1000; #end name = "Super Mario 256"; super (); }}


#end

#if (openfl && !flash)

#if html5
@:keep @:expose('__ASSET__OPENFL__assets_fonts_arial_italic_ttf') #if display private #end class __ASSET__OPENFL__assets_fonts_arial_italic_ttf extends openfl.text.Font { public function new () { name = "Arial Italic"; super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_myfont_ttf') #if display private #end class __ASSET__OPENFL__assets_fonts_myfont_ttf extends openfl.text.Font { public function new () { name = "Super Mario 256"; super (); }}

#else
@:keep @:expose('__ASSET__OPENFL__assets_fonts_arial_italic_ttf') #if display private #end class __ASSET__OPENFL__assets_fonts_arial_italic_ttf extends openfl.text.Font { public function new () { __fontPath = #if (ios || tvos) "assets/" + #end "assets/fonts/Arial Italic"; name = "Arial Italic"; super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_myfont_ttf') #if display private #end class __ASSET__OPENFL__assets_fonts_myfont_ttf extends openfl.text.Font { public function new () { __fontPath = #if (ios || tvos) "assets/" + #end "assets/fonts/MyFont"; name = "Super Mario 256"; super (); }}

#end

#end
#end

#end