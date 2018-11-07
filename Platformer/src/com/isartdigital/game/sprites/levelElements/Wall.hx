package com.isartdigital.game.sprites.levelElements;

import com.isartdigital.game.levelDesign.LevelData;
import com.isartdigital.game.pooling.PoolingManager;

/**
 * ...
 * @author Romain Rodriguez
 */
class Wall extends LevelElement 
{
	public static var list: Array<Wall> = new Array<Wall>();
	
	public function new() 
	{
		super(null, "Wall");
	}
	
	override public function init(pObject:LevelData):Void 
	{
		super.init(pObject);
		list.push(this);
	}
	
	override public function dispose():Void 
	{
		super.dispose();
		PoolingManager.addToPool("Wall", this);
	}
	
	override public function destroy():Void 
	{
		list.remove(this);
		super.destroy();
	}
}