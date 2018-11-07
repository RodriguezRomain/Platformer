package com.isartdigital.ui;

import com.isartdigital.game.levelDesign.LevelManager;
import com.isartdigital.utils.sound.SoundManager;
import com.isartdigital.utils.ui.Screen;
import openfl.events.MouseEvent;

	
/**
 * ...
 * @author Romain Rodriguez
 */
class LevelSelect extends Screen 
{
	
	/**
	 * instance unique de la classe LevelSelect
	 */
	private static var instance: LevelSelect;
	
	/**
	 * Retourne l'instance unique de la classe, et la crée si elle n'existait pas au préalable
	 * @return instance unique
	 */
	public static function getInstance (): LevelSelect {
		if (instance == null) instance = new LevelSelect();
		return instance;
	}
	
	/**
	 * constructeur privé pour éviter qu'une instance soit créée directement
	 */
	private function new(?pLibrary:String="ui") 
	{
		super(pLibrary);
		
		content.getChildByName("btnLevel1").addEventListener(MouseEvent.CLICK, onClick);
		content.getChildByName("btnLevel2").addEventListener(MouseEvent.CLICK, onClick);
	}
	
	private function onClick(pEvent:MouseEvent) : Void {
		if (pEvent.currentTarget == content.getChildByName("btnLevel1"))
			LevelManager.createLevel("Level1");
		else if (pEvent.currentTarget == content.getChildByName("btnLevel2"))
			LevelManager.createLevel("Level2");
		SoundManager.getSound("click").start();
		
		pEvent.stopPropagation();
	}
	
	/**
	 * détruit l'instance unique et met sa référence interne à null
	 */
	override public function destroy (): Void {
		content.getChildByName("btnLevel1").removeEventListener(MouseEvent.CLICK, onClick);
		content.getChildByName("btnLevel2").removeEventListener(MouseEvent.CLICK, onClick);
		instance = null;
	}

}