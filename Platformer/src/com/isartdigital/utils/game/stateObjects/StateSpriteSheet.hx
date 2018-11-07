package com.isartdigital.utils.game.stateObjects;

import com.isartdigital.utils.game.StateObject;
import openfl.Lib;
import openfl.events.Event;
import openfl.geom.Point;
import spritesheet.animation.AnimatedSpritesheet;

/**
 * ...
 * @author Chadi Husser
 */
class StateSpriteSheet extends StateObject<AnimatedSpritesheet>
{
	/**
	 * Nom de la spritesheet contenant les states associés 
	**/
	private var spriteSheetName:String;
	
	private var isPlaying :Bool = false;
	
	private var smoothing : Bool;
	
	private static var deltaTime:Int;
	
	public function new(pSpriteSheetName:String, pAssetName:String, pSmoothing:Bool = false) 
	{
		spriteSheetName = pSpriteSheetName;
		assetName = pAssetName;
		smoothing = pSmoothing;
		super();
		
		deltaTime = Math.floor(1000 / Lib.current.stage.frameRate);
		addEventListener(Event.ENTER_FRAME, animateFps);
	}
	
	private function animateFps(pEvent:Event):Void 
	{
		animate(deltaTime);
	}
	
	public function animate(pDeltaTime:Int, pReverse:Bool = false) : Void {
		if (!isPlaying) return;
		renderer.update(pDeltaTime, pReverse);
	}
	
	override private function createRenderer():Void 
	{
		renderer = new AnimatedSpritesheet(StateManager.getSpritesheet(spriteSheetName), smoothing);
		updateRenderer();
		super.createRenderer();
	}
	
	override private function updateRenderer():Void 
	{
		renderer.showBehavior(getID());

		renderer.update(0);
		
		
		var lPivot:Point = StateManager.getAnchor(getID());

		renderer.x = -lPivot.x * renderer.width * renderer.scaleX;
		renderer.y = -lPivot.y * renderer.height * renderer.scaleY;
		
	}

	override private function setBehavior(?pLoop:Bool = false, ?pAutoPlay:Bool = true, ?pStart:UInt = 0):Void 
	{
		renderer.currentFrameIndex = pStart;
		renderer.currentBehavior.loop = pLoop;
		isPlaying = pAutoPlay;
	}
	
	override private function get_isAnimEnded():Bool 
	{
		if (renderer != null && !renderer.currentBehavior.loop) return renderer.currentFrameIndex == renderer.currentBehavior.frames.length - 1;
		return false;
	}
	
	override public function pause():Void 
	{
		isPlaying = false;
	}
	
	override public function resume():Void 
	{
		isPlaying = true;
	}

	override private function destroyRenderer():Void 
	{
		removeEventListener(Event.ENTER_FRAME, animateFps);
		super.destroyRenderer();
	}
}