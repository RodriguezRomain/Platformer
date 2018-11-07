package com.isartdigital.ui;

import com.isartdigital.game.levelDesign.LevelManager;
import com.isartdigital.utils.sound.SoundManager;
import com.isartdigital.utils.ui.Screen;
import openfl.events.MouseEvent;

	
/**
 * ...
 * @author Romain Rodriguez
 */
class WorldSelect extends Screen 
{
	
	/**
	 * instance unique de la classe WorldSelect
	 */
	private static var instance: WorldSelect;
	
	/**
	 * Retourne l'instance unique de la classe, et la crée si elle n'existait pas au préalable
	 * @return instance unique
	 */
	public static function getInstance (): WorldSelect {
		if (instance == null) instance = new WorldSelect();
		return instance;
	}
	
	/**
	 * constructeur privé pour éviter qu'une instance soit créée directement
	 */
	private function new(?pLibrary:String="ui") 
	{
		super(pLibrary);
		
		content.getChildByName("btnWorld1").addEventListener(MouseEvent.CLICK, onClick);
		content.getChildByName("btnWorld2").addEventListener(MouseEvent.CLICK, onClick);
	}
	
	private function onClick(pEvent:MouseEvent) : Void {
		if (pEvent.currentTarget == content.getChildByName("btnWorld1"))
		{
			LevelManager.currentWorld = "world1";
		} else {
			LevelManager.currentWorld = "world2";
		}
		
		UIManager.closeScreens();
		UIManager.addScreen(LevelSelect.getInstance());
		SoundManager.getSound("click").start();
		
		pEvent.stopPropagation();
	}
	
	/**
	 * détruit l'instance unique et met sa référence interne à null
	 */
	override public function destroy (): Void {
		instance = null;
	}

}