package com.isartdigital.game.camera;
import com.isartdigital.game.sprites.levelElements.mobile.Player;
import com.isartdigital.utils.system.DeviceCapabilities;
import openfl.display.DisplayObject;
import openfl.geom.Point;
import openfl.geom.Rectangle;

/**
 * ...
 * @author Romain Rodriguez
 */
class BasicCamera 
{
	private static var instance:BasicCamera;
	
	private var target:DisplayObject;
	private var focus:DisplayObject;
	
	private var ease:Point = new Point(16, 10);
	
	public static function getInstance(): BasicCamera
	{
		if (instance == null) instance = new BasicCamera();
		return instance;
	}
	
	public function new() 
	{
		
	}
	
	public function setFocus(pFocus:DisplayObject)
	{
		focus = pFocus;
	}
	
	public function setTarget(pTarget:DisplayObject)
	{
		target = pTarget;
	}
	
	public function setPosition()
	{
		var lCenter:Rectangle = DeviceCapabilities.getScreenRect(target.parent);
		
		var lFocus:Point = target.globalToLocal(focus.parent.localToGlobal(new Point(focus.x, focus.y)));
		
		//target.x = lCenter.x + lCenter.width / 2 - lFocus.x;
		//target.y = lCenter.y + lCenter.height / 2 - lFocus.y;
		
		target.x += (lCenter.x + lCenter.width / 2 - lFocus.x - target.x) / ease.x;
		target.y += (lCenter.y + lCenter.height / 2 - lFocus.y - target.y) / ease.y;
		
	}
	
	public function destroy()
	{
		instance = null;
	}
	
}