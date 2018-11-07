package com.isartdigital.game.sprites.levelElements.mobile;

import com.isartdigital.game.levelDesign.LevelData;
import com.isartdigital.game.pooling.IPoolable;
import com.isartdigital.utils.game.stateObjects.StateSpriteSheet;
import openfl.geom.Point;

/**
 * ...
 * @author Romain Rodriguez
 */
class Mobile extends StateSpriteSheet implements IPoolable
{
	public var velocity(get,null):Point = new Point();
	private var acceleration:Point = new Point();
	private var friction:Point = new Point();
	
	private var maxHSpeed:Float = 0;
	private var maxVSpeed:Float = 0;
	
	private var gravity:Float = 0;
	
	function get_velocity()
	{
		return velocity;
	}
	
	public function new(pSpriteSheetName:String, pAssetName:String, pSmoothing:Bool=false) 
	{
		super(pSpriteSheetName, pAssetName, pSmoothing);
		
	}
	
	public function init(pObject:LevelData): Void
	{
		
	}
	
	private function move():Void
	{
		velocity.x += acceleration.x;
		velocity.y += acceleration.y;
		
		velocity.x *= friction.x;
		velocity.y *= friction.y;
		
		velocity.x = (velocity.x < 0? -1:1) * Math.min(Math.abs(velocity.x), maxHSpeed);
		velocity.y = (velocity.y < 0? -1:1) * Math.min(Math.abs(velocity.y), maxVSpeed);
		
		x += velocity.x;
		y += velocity.y;
		acceleration.setTo(0, 0);
	}
	
	public function dispose(): Void
	{
		if (parent != null)
			parent.removeChild(this);
		setModeVoid();
	}
}