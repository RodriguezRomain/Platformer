package com.isartdigital.utils.game;

import openfl.display.DisplayObjectContainer;

/**
 * Classe de base des objets interactifs dans le jeu
 * Met à jour automatiquement ses données internes de position et transformation
 * @author Mathieu ANTHOINE
 */
class GameObject extends DisplayObjectContainer
{

	public function new() 
	{
		super();
	}
	
	
	/**
	 * nettoie et détruit l'instance
	 */
	public function destroy() {
		parent.removeChild(this);
	}
	
}