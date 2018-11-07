package com.isartdigital.game.camera;
import com.isartdigital.game.sprites.levelElements.mobile.Player;
import com.isartdigital.utils.Config;
import com.isartdigital.utils.game.GameStage;
import openfl.display.Shape;
import openfl.geom.Point;

	
/**
 * ...
 * @author Romain Rodriguez
 */
class AdvancedCamera extends BasicCamera 
{
	
	/**
	 * instance unique de la classe AdvancedCamera
	 */
	private static var instance: AdvancedCamera;
	
	private var anchorLeft:Point = new Point(420, 1000);
	private var anchorRight:Point = new Point(1800, 1000);
	
	private var anchorLeftShape:Shape;
	private var anchorRightShape:Shape;
	
	/**
	 * Retourne l'instance unique de la classe, et la crée si elle n'existait pas au préalable
	 * @return instance unique
	 */
	public static function getInstance (): AdvancedCamera {
		if (instance == null) instance = new AdvancedCamera();
		return instance;
	}
	
	/**
	 * constructeur privé pour éviter qu'une instance soit créée directement
	 */
	private function new() 
	{
		super();
		
		createShapes();
	}
	
	private function createShapes()
	{
		anchorLeftShape = new Shape();
		anchorLeftShape.graphics.beginFill(0x000000);
		anchorLeftShape.graphics.drawCircle(0, 0, 10);
		anchorLeftShape.graphics.endFill();
		anchorLeftShape.alpha = Config.colliderAlpha;
		anchorLeftShape.x = anchorLeft.x;
		anchorLeftShape.y = anchorLeft.y;
		GameStage.getInstance().addChild(anchorLeftShape);
		
		anchorRightShape = new Shape();
		anchorRightShape.graphics.beginFill(0x000000);
		anchorRightShape.graphics.drawCircle(0, 0, 10);
		anchorRightShape.graphics.endFill();
		anchorRightShape.alpha = Config.colliderAlpha;
		anchorRightShape.x = anchorRight.x;
		anchorRightShape.y = anchorRight.y;
		GameStage.getInstance().addChild(anchorRightShape);
	}
	
	override public function setPosition() 
	{	
		var lFocus:Point = target.globalToLocal(focus.parent.localToGlobal(new Point(focus.x, focus.y)));
		
		if (focus.scaleX >= 0)
		{
			target.x += (anchorLeft.x - lFocus.x - target.x) / ease.x;
			target.y += (anchorLeft.y - lFocus.y - target.y) / ease.y;
		}
		else
		{
			target.x += (anchorRight.x- lFocus.x - target.x) / ease.x;
			target.y += (anchorRight.y - lFocus.y - target.y) / ease.y;
		}
		
		anchorLeftShape.x = anchorLeft.x;
		anchorLeftShape.y = anchorLeft.y;
		
		anchorRightShape.x = anchorRight.x;
		anchorRightShape.y = anchorRight.y;
	}

}