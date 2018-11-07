package com.isartdigital.utils.game.stateObjects;

import com.isartdigital.utils.game.StateObject;
import openfl.geom.Point;
import spritesheet.animation.AnimatedTilesheet;

/**
 * ...
 * @author Chadi Husser
 */
class StateTileSheet extends StateObject<AnimatedTilesheet>
{	
	
	/**
	 * Nom de la tilesheet contenant les states associés 
	**/
	private var tileSheetName:String;
	
	private var isPlaying :Bool = false;
	
	private var smoothing : Bool;
	
	public function new(pTileSheetName:String, pAssetName:String, pSmoothing:Bool = false) 
	{
		tileSheetName = pTileSheetName;
		assetName = pAssetName;
		smoothing = pSmoothing;
		super();
	}

	override public function start():Void 
	{
		super.start();
		setState(STATE_DEFAULT, true);
	}
	
	public function animate(pDeltaTime:Int, pReverse:Bool = false) : Void {
		if (!isPlaying) return;
		renderer.update(pDeltaTime, pReverse);
	}
	
	override private function createRenderer():Void 
	{
		renderer = new AnimatedTilesheet(StateManager.getTilesheet(tileSheetName), smoothing);
		updateRenderer();
		super.createRenderer();
	}
	
	override private function updateRenderer():Void 
	{
		renderer.showBehavior(getID());
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
		if (renderer != null && !renderer.currentBehavior.loop) return renderer.currentFrameIndex == renderer.currentBehavior.frames.length;
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
		super.destroyRenderer();
	}
	
}