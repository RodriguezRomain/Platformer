package com.isartdigital.game.layers;

import openfl.display.Sprite;
import openfl.geom.Point;

/**
 * ...
 * @author Romain Rodriguez
 */
class ScrollingLayer extends Sprite 
{
	private var speed:Point = new Point(0,0);
	
	private var target:Sprite = GameLayer.getInstance();
	
	private var prevTargetPos:Point;
	
	public static var list:Array<ScrollingLayer> = new Array<ScrollingLayer>();
	
	public function new() 
	{
		super();
		list.push(this);
		
		prevTargetPos = new Point(target.x, target.y);
	}
	
	public function move()
	{
		var lMovement:Point = new Point();
		
		lMovement.x = target.x - prevTargetPos.x;
		lMovement.y = target.y - prevTargetPos.y;
		
		x += lMovement.x * speed.x;
		y += lMovement.y * speed.y;
		
		prevTargetPos.x = target.x;
		prevTargetPos.y = target.y;
	}
	
	public static function moveAll()
	{
		for (lLayer in list)
		{
			lLayer.move();
		}
	}
	
	public function destroy()
	{
		list.remove(this);
		if (parent != null)
			parent.removeChild(this);
	}
}