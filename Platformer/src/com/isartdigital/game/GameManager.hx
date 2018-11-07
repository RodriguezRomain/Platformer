package com.isartdigital.game;
import com.isartdigital.game.camera.AdvancedCamera;
import com.isartdigital.game.camera.BasicCamera;
import com.isartdigital.game.layers.BackgroundLayer1;
import com.isartdigital.game.layers.BackgroundLayer2;
import com.isartdigital.game.layers.GameLayer;
import com.isartdigital.game.layers.ScrollingLayer;
import com.isartdigital.game.levelDesign.LevelManager;
import com.isartdigital.game.sprites.levelElements.mobile.Player;
import com.isartdigital.ui.UIManager;
import com.isartdigital.utils.Timer;
import com.isartdigital.utils.events.EventType;
import com.isartdigital.utils.game.GameStage;
import com.isartdigital.utils.loader.GameLoader;
import com.isartdigital.utils.sound.SoundManager;
import com.isartdigital.utils.system.DeviceCapabilities;
import com.isartdigital.utils.system.Monitor;
import com.isartdigital.utils.system.MonitorField;
import haxe.Json;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.geom.Rectangle;
import org.zamedev.particles.ParticleSystem;
import org.zamedev.particles.loaders.ParticleLoader;
import org.zamedev.particles.renderers.DefaultParticleRenderer;


/**
 * ...
 * @author Chadi Husser
 */
class GameManager 
{
	
	private static var particleSystem :ParticleSystem;
	
	public static function start() : Void {
		UIManager.closeScreens();
		
		UIManager.openHud();
		
		//var lJson:Dynamic = Json.parse(GameLoader.getText("assets/settings/player.json"));
		//Monitor.setSettings(lJson, Player.getInstance());
		
		//var fields: Array<MonitorField> = [
			////{name:"state"},
			//{name:"x", step:1},
			//{name:"y", step:100},
			//{name:"velocity"},
			//{name:"frictionGround", min:0, max:1},
			//{name:"frictionAir", min:0, max:1},
			//{name:"accelerationGround", min:0, max:20},
			////{name:"accelerationAir", min:0, max:20},
			//{name:"maxHSpeed", min:0, max:50},
			//{name:"maxVSpeed", min:0, max:50},
			//{name:"impulse", min:0, max:50},
			//{name:"impulseDuration", min:0, max:50},
			//{name:"impulseCounter"},
			//{name:"gravity", min:0, max:50}
		//];
		//
		//Monitor.start(Player.getInstance(), fields/*, lJson*/);
		
		var fields: Array<MonitorField> = [
			{name:"ease"},
			{name:"anchorLeft"},
			{name:"anchorRight"}
		];
		
		Monitor.start(AdvancedCamera.getInstance(), fields);
		
		var clipFields: Array<MonitorField> = [
			{name:"margin", step:1},
		];
		
		Monitor.start(ClippingManager, clipFields);
		
		var lParticleRenderer = DefaultParticleRenderer.createInstance();
		//GameStage.getInstance().addChild(cast lParticleRenderer);
		//
		//particleSystem = ParticleLoader.load("assets/particles/fire.plist");
		//lParticleRenderer.addParticleSystem(particleSystem);
		
		lParticleRenderer = DefaultParticleRenderer.createInstance();
		GameLayer.getInstance().addChild(cast lParticleRenderer);
		
		GameLayer.getInstance().addChild(Player.getInstance());
		Player.getInstance().start();
		
		particleSystem = ParticleLoader.load("assets/particles/trail.plist");
		lParticleRenderer.addParticleSystem(particleSystem);
		
		//GameStage.getInstance().stage.addEventListener(MouseEvent.CLICK, onClick);
		
		AdvancedCamera.getInstance().setFocus(Player.getInstance());
		AdvancedCamera.getInstance().setTarget(GameLayer.getInstance());
		resumeGame();
	}
	
	public static function resumeGame() : Void {
		Main.instance.addEventListener(EventType.GAME_LOOP, gameLoop);
		SoundManager.getSound("world1").start();
	}
	
	private static function onClick(pEvent:MouseEvent) : Void {
		particleSystem.emit(GameStage.getInstance().mouseX, GameStage.getInstance().mouseY);
	}

	public static function pauseGame() : Void {
		SoundManager.getSound("world1").pause();
		Main.instance.removeEventListener(EventType.GAME_LOOP, gameLoop);
	}
	
	private static function gameLoop(pEvent:Event) : Void {
		Player.getInstance().doAction();
		AdvancedCamera.getInstance().setPosition();
		ScrollingLayer.moveAll();
		ClippingManager.clipGrid("Level", LevelManager.instanceGrid);
		ClippingManager.clipGrid("Background1", BackgroundLayer1.instanceGrid);
		ClippingManager.clipGrid("Background2", BackgroundLayer2.instanceGrid);
		particleSystem.emit(Player.getInstance().x, Player.getInstance().y);
	}
	
	
}