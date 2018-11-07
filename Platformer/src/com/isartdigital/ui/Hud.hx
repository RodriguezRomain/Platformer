package com.isartdigital.ui;

import com.isartdigital.game.levelDesign.LevelManager;
import com.isartdigital.utils.system.System;
import com.isartdigital.utils.system.DeviceCapabilities;
import com.isartdigital.utils.ui.AlignType;
import com.isartdigital.utils.ui.Screen;
import com.isartdigital.utils.ui.UIPositionable;
import openfl.display.DisplayObject;
import openfl.display.DisplayObjectContainer;
import openfl.display.MovieClip;
import openfl.display.SimpleButton;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.events.TouchEvent;
import openfl.text.TextField;

/**
 * ...
 * @author Chadi Husser
 */
class Hud extends Screen 
{
	private static var instance : Hud;
	
	public static function getInstance() : Hud {
		if (instance == null) instance = new Hud();
		return instance;
	}
	
	public function new() 
	{
		super();
		cast(content.getChildByName("mcTopRight"), MovieClip).getChildByName("btnPause").addEventListener("click", onClick);
	}
	
	private function onClick(pEvent:Event)
	{
		LevelManager.clearLevel();
		UIManager.closeScreens();
		UIManager.addScreen(TitleCard.getInstance());
		UIManager.closeHud();
	}
	
	override public function destroy():Void 
	{
		cast(content.getChildByName("mcTopRight"), MovieClip).getChildByName("btnPause").removeEventListener("click", onClick);
		super.destroy();
	}
}