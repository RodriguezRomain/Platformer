package com.isartdigital.game.sprites.backgrounds;

import com.isartdigital.game.levelDesign.LevelData;
import com.isartdigital.game.pooling.IPoolable;
import com.isartdigital.game.pooling.PoolingManager;
import com.isartdigital.utils.game.stateObjects.StateSpriteSheet;
import openfl.display.Tile;

/**
 * ...
 * @author Romain Rodriguez
 */
class Background extends Tile implements IPoolable
{
	public static var list: Array<Background> = new Array<Background>();
	
	public function new(pType:Int = 0, pX:Float = 0, pY:Float = 0) 
	{
		super(pType, pX, pY);
		
		//x = pObject.x;
		//y = pObject.y;
		//scaleX = pObject.scaleX;
		//scaleY = pObject.scaleY;
		//rotation = pObject.rotation;
		//setState(STATE_DEFAULT);
		//width = pObject.width;
		//height = pObject.height;
		//setModeNormal();
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
		list.remove(this);
	}
	
	public function destroy():Void 
	{
		dispose();
	}
	
}