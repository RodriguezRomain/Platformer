package com.isartdigital.game.sprites.levelElements;

import com.isartdigital.game.levelDesign.LevelData;
import com.isartdigital.game.levelDesign.LevelManager;
import com.isartdigital.game.pooling.IPoolable;
import com.isartdigital.utils.game.ColliderType;
import com.isartdigital.utils.game.stateObjects.StateSpriteSheet;

/**
 * ...
 * @author Romain Rodriguez
 */
class LevelElement extends StateSpriteSheet implements IPoolable
{
	public static var list: Array<LevelElement> = new Array<LevelElement>();

	public function new(pObject:LevelData, pType:String, pSmoothing:Bool=false) 
	{
		super("LevelDesigns_" + LevelManager.currentWorld, pType, pSmoothing);
		
		colliderType = ColliderType.SIMPLE;
		
		//setModeNormal();
		//rotation = pObject.rotation;
		//width = pObject.width;
		//height = pObject.height;
		//scaleX = pObject.scaleX;
		//scaleY = pObject.scaleY;
		//x = pObject.x;
		//y = pObject.y;
	}
	
	override function setModeNormal():Void 
	{
		super.setModeNormal();
		setState(STATE_DEFAULT, true);
	}
	
	public function init(pObject:LevelData): Void
	{
		list.push(this);
		rotation = pObject.rotation;
		width = pObject.width;
		height = pObject.height;
		scaleX = pObject.scaleX;
		scaleY = pObject.scaleY;
		x = pObject.x;
		y = pObject.y;
		setModeNormal();
	}
	
	public function dispose(): Void
	{
		if (parent != null)
			parent.removeChild(this);
		list.remove(this);
		setModeVoid();
	}
	
	override public function destroy():Void 
	{
		super.destroy();
		dispose();
	}
}