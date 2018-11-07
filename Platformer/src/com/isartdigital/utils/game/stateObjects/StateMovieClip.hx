package com.isartdigital.utils.game.stateObjects;
import com.isartdigital.utils.game.StateObject;
import openfl.Assets;
import openfl.display.MovieClip;

/**
 * ...
 * @author Chadi Husser
 */
class StateMovieClip extends StateObject<MovieClip>
{

	/**
	 * Nom du swf contenant les states associés
	**/
	private var libraryName:String;
	
	private var loop:Bool;
	
	public function new(pLibraryName:String, pAssetName:String) 
	{
		libraryName = pLibraryName;
		assetName = pAssetName;
		super();
	}
	
	override public function start():Void 
	{
		super.start();
		setState(STATE_DEFAULT);
	}
	
	override function getID():String 
	{
		return libraryName + ":" + super.getID();
	}
	
	override function updateRenderer():Void 
	{
		removeChild(renderer);
		createRenderer();
		super.updateRenderer();
	}
	
	override function setBehavior(?pLoop:Bool = false, ?pAutoPlay:Bool = true, ?pStart:UInt = 0):Void 
	{
		loop = pLoop;
		renderer.gotoAndStop(pStart);
		if (pAutoPlay) renderer.play();
	}
	
	override function get_isAnimEnded():Bool 
	{
		if (renderer != null && !loop) return renderer.currentFrame == renderer.totalFrames;
		return false;
	}
	
	override public function pause():Void 
	{
		if (renderer != null) renderer.stop();
	}
	
	override public function resume():Void 
	{
		if (renderer != null) renderer.play();
	}
	
	override function createRenderer():Void 
	{
		var lId:String = getID();
		renderer = Assets.getMovieClip(lId);
 		super.createRenderer();
	}
	
	override function destroyRenderer():Void 
	{
		renderer.stop();
		super.destroyRenderer();
	}
}