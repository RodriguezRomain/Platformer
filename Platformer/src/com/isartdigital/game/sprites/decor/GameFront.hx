package com.isartdigital.game.sprites.decor;

import com.isartdigital.game.levelDesign.LevelData;
import com.isartdigital.game.pooling.IPoolable;
import com.isartdigital.game.pooling.PoolingManager;
import openfl.display.Tile;

/**
 * ...
 * @author Romain Rodriguez
 */
class GameFront extends Tile implements IPoolable
{
	public static var list: Array<GameFront> = new Array<GameFront>();
	
	public function new() 
	{
		super(0, 0, 0);
	}
	
	public function init(pObject:LevelData): Void
	{
		var lType:Int;
		
		if (pObject.type == "House")
			lType = 0;
		else
		{
			lType = Std.parseInt(pObject.type.substr( -1, 1));
		}
		
		__id = lType;
		x = pObject.x;
		y = pObject.y;
		list.push(this);
	}
	
	public function dispose(): Void
	{
		PoolingManager.addToPool("GameFront", this);
		list.remove(this);
	}
	
	public function destroy():Void 
	{
		dispose();
	}
}