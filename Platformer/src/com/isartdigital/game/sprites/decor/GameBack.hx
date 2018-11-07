package com.isartdigital.game.sprites.decor;

import com.isartdigital.game.layers.BackgroundLayer2;
import com.isartdigital.game.levelDesign.LevelData;
import com.isartdigital.game.pooling.IPoolable;
import com.isartdigital.game.pooling.PoolingManager;
import openfl.display.Tile;

/**
 * ...
 * @author Romain Rodriguez
 */
class GameBack extends Tile implements IPoolable
{

	public static var list: Array<GameBack> = new Array<GameBack>();
	
	public function new() 
	{
		super(0, 0, 0);//Std.parseInt(pObject.type.substr(-1,1)), pObject.x, pObject.y);
	}
	
	public function init(pObject:LevelData): Void
	{
		__id = Std.parseInt(pObject.type.substr( -1, 1));
		x = pObject.x;
		y = pObject.y;
		list.push(this);
	}
	
	public function dispose(): Void
	{
		PoolingManager.addToPool("GameBack", this);
		list.remove(this);
		BackgroundLayer2.tileMapGameBack.removeTile(this);
	}
	
	public function destroy():Void 
	{
		dispose();
	}
	
}