package com.isartdigital.game.sprites.backgrounds;
import com.isartdigital.game.layers.BackgroundLayer1;
import com.isartdigital.game.levelDesign.LevelData;
import com.isartdigital.game.pooling.PoolingManager;

/**
 * ...
 * @author Romain Rodriguez
 */
class Background1 extends Background 
{
	public static var list: Array<Background1> = new Array<Background1>();
	
	public function new() 
	{
		super();//Std.parseInt(pObject.type.substr( -1, 1)), pObject.x, pObject.y);
		list.push(this);
	}
	
	override public function dispose():Void 
	{
		super.dispose();
		PoolingManager.addToPool("Background1", this);
		BackgroundLayer1.tileMap.removeTile(this);
	}
	
	override public function destroy():Void 
	{
		list.remove(this);
		super.destroy();
	}
}