package com.isartdigital;

import com.isartdigital.controllers.Controler;
import com.isartdigital.ui.GraphicLoader;
import com.isartdigital.ui.TitleCard;
import com.isartdigital.ui.UIManager;
import com.isartdigital.utils.Config;
import com.isartdigital.utils.debug.Debug;
import com.isartdigital.utils.debug.DebugPanel;
import com.isartdigital.utils.events.AssetsLoaderEvent;
import com.isartdigital.utils.events.EventType;
import com.isartdigital.utils.events.LoadEventType;
import com.isartdigital.utils.game.GameStage;
import com.isartdigital.utils.game.GameStageScale;
import com.isartdigital.utils.game.StateManager;
import com.isartdigital.utils.loader.GameLoader;
import com.isartdigital.utils.sound.SoundManager;
import haxe.Json;
import openfl.Assets;
import openfl.display.Sprite;
import openfl.display.StageAlign;
import openfl.display.StageScaleMode;
import openfl.events.Event;


class Main extends Sprite
{
	
	public static var instance(default, null):Main;

	public function new ()
	{
		instance = this;
		
		super ();
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.align = StageAlign.TOP_LEFT;
		
		stage.frameRate = 60;
		
		//SETUP de la config
		Config.init(Json.parse(Assets.getText("assets/config.json")));

		//SETUP du gamestage
		GameStage.getInstance().scaleMode = GameStageScale.SHOW_ALL;
		GameStage.getInstance().init(null, 2160, 1440);
		
		stage.addChild(GameStage.getInstance());
		stage.addEventListener(Event.RESIZE, resize);
		resize();
		
		Controler.setupController();
		
		//SETUP du debug
		Debug.getInstance().init();

		UIManager.addScreen(GraphicLoader.getInstance());

		//CHARGEMENT
		var lGameLoader:GameLoader = new GameLoader();
		lGameLoader.addEventListener(AssetsLoaderEvent.PROGRESS, onLoadProgress);
		lGameLoader.addEventListener(AssetsLoaderEvent.COMPLETE, onLoadComplete);
		
		//Chargement des sons
		var soundPaths : Array<String> = SoundManager.setupSoundsData(Json.parse(Assets.getText("assets/sounds/sounds.json")), this);
		for (soundPath in soundPaths) {
			lGameLoader.addSound(soundPath);
		}
		
        //Chargement des particules
		lGameLoader.addText("assets/particles/fire.plist");
		lGameLoader.addBitmapData("assets/particles/fire.png");
		
		lGameLoader.addText("assets/particles/trail.plist");
		lGameLoader.addBitmapData("assets/particles/trail.png");
		
		//Chargement de l'ui
		lGameLoader.addLibrary("ui");
		lGameLoader.addFont("assets/fonts/MyFont.ttf");
		lGameLoader.addFont("assets/fonts/Arial Italic.ttf");
		
		//Chargement des spritesheets
		//lGameLoader.addBitmapData("assets/images/Backgrounds1.png");
		//lGameLoader.addText("assets/images/Backgrounds1.json");
		//lGameLoader.addBitmapData("assets/images/Backgrounds2.png");
		//lGameLoader.addText("assets/images/Backgrounds2.json");
		//lGameLoader.addBitmapData("assets/images/LevelDesigns.png");
		//lGameLoader.addText("assets/images/LevelDesigns.json");
		//lGameLoader.addBitmapData("assets/images/Characters.png");
		//lGameLoader.addText("assets/images/Characters.json");
	//
		//lGameLoader.addText("assets/colliders.json");
		
		lGameLoader.load();
	}

	private function onLoadProgress (pEvent:AssetsLoaderEvent): Void
	{
		GraphicLoader.getInstance().setProgress(pEvent.filesLoaded / pEvent.nbFiles);	
	}

	private function onLoadComplete (pEvent:AssetsLoaderEvent): Void
	{
		trace("LOAD COMPLETE");
		
		var lGameLoader : GameLoader = cast(pEvent.target, GameLoader);
		lGameLoader.removeEventListener(AssetsLoaderEvent.PROGRESS, onLoadProgress);
		lGameLoader.removeEventListener(AssetsLoaderEvent.COMPLETE, onLoadComplete);		
		
		SoundManager.initSounds();
		
		//Ajout des states des stateObjects
		//StateManager.addSpriteSheetFromAnimate(Json.parse(GameLoader.getText("assets/images/Backgrounds1.json")), GameLoader.getBitmapData("assets/images/Backgrounds1.png"));
		//StateManager.addSpriteSheetFromAnimate(Json.parse(GameLoader.getText("assets/images/Backgrounds2.json")), GameLoader.getBitmapData("assets/images/Backgrounds2.png"));
		//StateManager.addSpriteSheetFromAnimate(Json.parse(GameLoader.getText("assets/images/LevelDesigns.json")), GameLoader.getBitmapData("assets/images/LevelDesigns.png"));
		//StateManager.addSpriteSheetFromAnimate(Json.parse(GameLoader.getText("assets/images/Characters.json")), GameLoader.getBitmapData("assets/images/Characters.png"));
	//
		////Ajout des colliders des stateObjects
		//StateManager.addColliders(Json.parse(GameLoader.getText("assets/colliders.json")));
			
		UIManager.addScreen(TitleCard.getInstance());
		
		addEventListener(Event.ENTER_FRAME, gameLoop);
	}

	private static function importClasses() : Void {

	}
	
	private function gameLoop(pEvent:Event) : Void {
		dispatchEvent(new Event(EventType.GAME_LOOP));
	}
	
	public function resize (pEvent:Event = null): Void
	{
		GameStage.getInstance().resize();
	}

}