package com.isartdigital.game.sprites.levelElements.mobile;

import com.isartdigital.controllers.Controler;
import com.isartdigital.game.camera.BasicCamera;
import com.isartdigital.game.levelDesign.LevelData;
import com.isartdigital.game.sprites.levelElements.LevelElement;
import com.isartdigital.game.sprites.levelElements.Wall;
import com.isartdigital.game.sprites.levelElements.mobile.Mobile;
import com.isartdigital.utils.Timer;
import com.isartdigital.utils.game.ColliderType;
import com.isartdigital.utils.game.GameStage;
import com.isartdigital.utils.game.stateObjects.StateSpriteSheet;
import com.isartdigital.utils.math.geom.Vector2;
import openfl.display.DisplayObject;
import openfl.events.KeyboardEvent;
import openfl.geom.Point;
import openfl.ui.Keyboard;

/**
 * ...
 * @author Chadi Husser
 */
class Player extends Mobile
{
	private static var instance:Player;
	
	private var frictionGround:Float = 0.75;
	private var accelerationGround:Float = 8;
	
	private var frictionAir:Float = 0.95;
	private var accelerationAir:Float = 1.2;
	
	private var impulse:Float = 17;
	private var impulseDuration:Float = 20;
	private var impulseCounter:Float = 0;
	
	private var WAIT(default, never):String = "wait";
	private var WALK(default, never):String = "walk";
	private var JUMP(default, never):String = "jump";
	private var FALL(default, never):String = "fall";
	private var RECEPTION(default, never):String = "reception";
	
	private var controler:Controler;
	
	private var isJumping:Bool = false;
	private var jumpCounter:Int = 0;
	
	private var floor:LevelElement;
	private var leftSide:Wall;
	private var rightSide:Wall;
	
	public static function getInstance():Player {
		if (instance == null) instance = new Player();
		return instance;
	}
	
	private function new() 
	{
		super("Characters", "Player", false);
	}
	
	override public function init(pObject:LevelData):Void 
	{
		super.init(pObject);
		
		rotation = pObject.rotation;
		width = pObject.width;
		height = pObject.height;
		scaleX = pObject.scaleX;
		scaleY = pObject.scaleY;
		x = pObject.x;
		y = pObject.y;
		
		colliderType = ColliderType.SIMPLE;
		
		controler = Controler.current;
		controler.start();
		
		maxHSpeed = 20;
		maxVSpeed = 24;
		
		gravity = 4;
		setModeNormal();
	}
	
	override function get_hitBox():DisplayObject 
	{
		return collider.getChildByName("mcGlobalBox");
	}
	
	private function bottom():Point
	{
		return globalPoint("mcBottom");
	}
	
	private function checkBottom(): Point
	{
		return globalPoint("mcCheckBottom");
	}
	
	private function top():Point
	{
		return globalPoint("mcTop");
	}
	
	private function checkTop(): Point
	{
		return globalPoint("mcCheckTop");
	}
	
	private function front():Point
	{
		return globalPoint("mcFront");
	}
	
	private function checkFront(): Point
	{
		return globalPoint("mcCheckFront");
	}
	
	private function back():Point
	{
		return globalPoint("mcBack");
	}
	
	private function checkBack(): Point
	{
		return globalPoint("mcCheckBack");
	}
	
	private function globalPoint(pName:String): Point
	{
		var lTarget:DisplayObject = collider.getChildByName(pName);
		return collider.localToGlobal(new Point(lTarget.x, lTarget.y));
	}
	
	private function hitFloor(?pHit:Point = null):Bool
	{
		if (pHit == null) pHit = bottom();
		
		var lCollision:LevelElement = testPoint(Wall.list, pHit);
		
		if (lCollision == null) lCollision = testPoint(Platform.list, pHit);
		
		if (lCollision != null)
		{
			floor = lCollision;
			y = floor.y;
			return true;
		}
		
		floor = null;
		return false;
	}
	
	private function hitLeftSide(?pHit:Point = null):Bool
	{
		if (pHit == null) pHit = left();
		
		var lCollision:Wall = hitSide(pHit);
		
		if (lCollision != null)
		{
			leftSide = lCollision;
			x = Math.max(leftSide.x + leftSide.hitBox.width + hitBox.width / 2, x);
			return true;
		}
		
		leftSide = null;
		return false;
	}
	
	private function hitRightSide(?pHit:Point = null):Bool
	{
		if (pHit == null) pHit = right();
		
		var lCollision:Wall = hitSide(pHit);
		
		if (lCollision != null)
		{
			rightSide = lCollision;
			x = Math.min(rightSide.x - hitBox.width / 2, x);
			return true;
		}
		
		rightSide = null;
		return false;
	}
	
	private function hitSide(pHit:Point): Wall
	{
		var lCollision:Wall = testPoint(Wall.list, pHit);
		
		if (lCollision != null)
		{
			velocity.x = 0;
			return lCollision;
		}
		
		return null;
	}
	
	private function left():Point
	{
		return scaleX > 0? back() : front();
	}
	
	private function right():Point
	{
		return scaleX < 0? back() : front();
	}
	
	private function checkLeft():Point
	{
		return scaleX > 0? checkBack() : checkFront();
	}
	
	private function checkRight():Point
	{
		return scaleX < 0? checkBack() : checkFront();
	}
	
	
	
	//private function hitTest<T:LevelElement>(pList:Array<T>, pGlobalPoint:Point): Bool
	//{
		//for (lObject in pList)
		//{
			//if (lObject.hitBox.hitTestPoint(pGlobalPoint.x, pGlobalPoint.y))
			//{
				//y = lObject.y;
				//return true;
			//}
		//}
		//return false;
	//}
	
	private function testPoint<T:LevelElement>(pList:Array<T>, pGlobalPoint:Point): T
	{
		for (lObject in pList)
		{
			if (lObject.hitBox.hitTestPoint(pGlobalPoint.x, pGlobalPoint.y))
			{
				return lObject;
			}
		}
		return null;
	}
	
	private function airControl()
	{
		if (canGoLeft()){
			acceleration.x = -accelerationAir;
			flipLeft();
		} else if (canGoRight()){
			acceleration.x = accelerationAir;
			flipRight();
		}
	}
	
	private function flipLeft()
	{
		if (scaleX > 0) scaleX = -1 * Math.abs(scaleX);
	}
	
	private function flipRight()
	{
		if (scaleX < 0) scaleX = Math.abs(scaleX);
	}
	
	private function canFall():Bool
	{
		//return !hitFloor(checkBottom());
		
		var lCheckBottom:Point = checkBottom();
		
		if (floor != null && testPoint([floor], lCheckBottom) == floor) return false;
		
		return !hitFloor(lCheckBottom);
	}
	
	private function canJump():Bool
	{
		return controler.jump && !isJumping && testPoint(Wall.list, checkTop()) == null;
	}
	
	private function canGoLeft():Bool
	{
		if (leftSide != null && testPoint([leftSide], checkLeft()) == leftSide) return false;
		return ! hitLeftSide() && controler.left;
	}
	
	private function canGoRight():Bool
	{
		if (rightSide != null && testPoint([rightSide], checkRight()) == rightSide) return false;
		return !hitRightSide() && controler.right;
	}

	override function setModeNormal():Void 
	{
		super.setModeNormal();
		setState("wait", true);
	}
	
	override function doActionNormal():Void 
	{
		if (canFall()) setModeFall();
		
		if (!controler.jump) isJumping = false;
		
		if (canJump()) setModeJump();
		else if (canGoLeft() || canGoRight()) setModeWalk();
	}
	
	private function setModeWalk():Void
	{
		setState("walk", true);
		friction.x = frictionGround;
		doAction = doActionWalk;
	}
	
	private function doActionWalk (): Void
	{
		if (canFall()) setModeFall();
		
		if (!controler.jump) isJumping = false;
		
		if (canJump()) setModeJump();
		else if (canGoLeft()){
			acceleration.setTo( -accelerationGround, 0);
			flipLeft();
		} else if (canGoRight()){
			acceleration.setTo(accelerationGround, 0);
			flipRight();
		}
		move();
		
		if (Math.abs(velocity.x) < 1 && Math.abs(velocity.y) < 1) setModeNormal();
	}
	
	private function setModeJump():Void
	{
		setState("jump");
		isJumping = true;
		
		impulseCounter = 0;
		acceleration.y = -impulse;
		friction.setTo(frictionAir, frictionAir);
		doAction = doActionJump;
	}
	
	private function doActionJump(): Void
	{
		if (impulseCounter++ < impulseDuration) acceleration.y = -impulse;
		
		if (!controler.jump){
			impulseCounter = impulseDuration;
			isJumping = false;
		} else if (!isJumping && jumpCounter < 1) {
			setModeJump();
			jumpCounter++;
		}
		
		airControl();
		
		acceleration.y += gravity;
		move();
		
		if (velocity.y > 0) setModeFall();
		else{
			var lCeil:LevelElement = testPoint(Wall.list, top());
			
			if (lCeil != null){
				velocity.y = 0;
				y = lCeil.y + lCeil.hitBox.height + hitBox.height;
				setModeFall();
			}
		}
	}
	
	private function setModeFall():Void
	{
		setState("fall");
		friction.setTo(frictionAir, frictionAir);
		doAction = doActionFall;
	}
	
	private function doActionFall(): Void
	{
		acceleration.y += gravity;
		
		if (!controler.jump){
			isJumping = false;
		} else if (!isJumping && jumpCounter < 1) {
			setModeJump();
			jumpCounter++;
		} else {
			isJumping = true;
		}
		
		airControl();
		
		move();
		
		if (hitFloor()) setModeReception();
	}
	
	private function setModeReception():Void
	{
		setState("reception");
		friction.setTo(frictionGround, 0);
		jumpCounter = 0;
		doAction = doActionReception;
	}
	
	private function doActionReception(): Void
	{
		if (!controler.jump) isJumping = false;
		if (canJump()) setModeJump();
		else if (canGoLeft() || canGoRight()) setModeWalk();
        else if (isAnimEnded) setModeNormal();
		
		move();
		
	}
	
	override public function dispose():Void 
	{
		super.dispose();
	}
	
	override public function destroy():Void 
	{
		instance = null;
		super.destroy();
		dispose();
	}
}