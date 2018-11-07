package com.isartdigital.game.sprites.levelElements;

import com.isartdigital.game.levelDesign.LevelData;
import com.isartdigital.game.pooling.PoolingManager;

/**
 * ...
 * @author Romain Rodriguez
 */
class Platform extends LevelElement 
{
	public static var list: Array<Platform> = new Array<Platform>();
	
	public function new()//pObject:LevelData, pSmoothing:Bool=false) 
	{
		super(null, "Platform");
	}
	
	override public function init(pObject:LevelData):Void 
	{
		super.init(pObject);
		assetName = "Platform";
		list.push(this);
	}
	
	override public function dispose():Void 
	{
		super.dispose();
		PoolingManager.addToPool("Platform", this);
	}
	
	override public function destroy():Void 
	{
		list.remove(this);
		super.destroy();
	}
}