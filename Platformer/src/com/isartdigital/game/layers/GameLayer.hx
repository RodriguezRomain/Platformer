package com.isartdigital.game.layers;

import openfl.display.Sprite;

	
/**
 * ...
 * @author Romain Rodriguez
 */
class GameLayer extends Sprite 
{
	
	/**
	 * instance unique de la classe GameLayer
	 */
	private static var instance: GameLayer;
	
	/**
	 * Retourne l'instance unique de la classe, et la crée si elle n'existait pas au préalable
	 * @return instance unique
	 */
	public static function getInstance (): GameLayer {
		if (instance == null) instance = new GameLayer();
		return instance;
	}
	
	/**
	 * constructeur privé pour éviter qu'une instance soit créée directement
	 */
	private function new() 
	{
		super();
		
	}
	
	/**
	 * détruit l'instance unique et met sa référence interne à null
	 */
	public function destroy (): Void {
		instance = null;
	}

}