package com.isartdigital.utils.debug;

import com.isartdigital.utils.Config;
import com.isartdigital.utils.game.GameStage;
import openfl.display.FPS;
import openfl.display.Sprite;


/**
 * Classe de Debug
 * @author Mathieu ANTHOINE
 */
class Debug
{

	/**
	 * instance unique de la classe Debug
	 */
	private static var instance: Debug;	
	
	/**
	 * instance de DebugPanel
	 */
	private var debugPanel:DebugPanel;

	/**
	 * Retourne l'instance unique de la classe, et la crée si elle n'existait pas au préalable
	 * @return instance unique
	 */
	public static function getInstance (): Debug {
		if (instance == null) instance = new Debug();
		return instance;
	}	
	
	private function new() {}
	
	public function init():Void 
	{
		if (!Config.debug) return;
		
		if (Config.fps) {
			debugPanel = new DebugPanel();
			GameStage.getInstance().addChild(debugPanel);
		}
	}
	
	public function destroy (): Void 
	{
		if (Config.fps) {
			GameStage.getInstance().removeChild(debugPanel);
			debugPanel = null;
		}
	}

}