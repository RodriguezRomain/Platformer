package com.isartdigital.utils.game;
import openfl.display.DisplayObject;
import openfl.geom.Point;

/**
 * ...
 * @author Chadi Husser
 */
class CollisionManager 
{
	public static function hitTestPoint(pObject:DisplayObject, pPoint:Point) : Bool {
		return pObject.hitTestPoint(pPoint.x, pPoint.y);
	}
}