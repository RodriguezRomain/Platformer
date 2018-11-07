package com.isartdigital.utils;

/**
 * Classe utilitaire contenant les données de configuration du jeu
 * @author Mathieu ANTHOINE
 * @author Chadi Husser
 * @version 0.3.0
 */
class Config 
{
	/**
	 * version de l'application
	 */
	public static var version (get,never):String;
	
	/**
	 * défini si le jeu est en mode "debug" ou pas (si prévu dans le code du jeu)
	 */
	public static var debug (get, never): Bool;
	
	/**
	 * défini si il faut afficher les fps ou non
	 */
	public static var fps (get, never): Bool;
	
	/**
	 * défini l'alpha des colliders
	 */
	public static var colliderAlpha(get, never): Float;

	/**
	 * défini l'alpha des renderers
	 */
	public static var rendererAlpha(get, never):Float;
	
	/**
	 * conteneur des données de configuration
	 */
	public static var data (get, never):Dynamic;
	private static var _data:Dynamic={};
	
	public static function init(pConfig:Dynamic): Void {		
		for (i in Reflect.fields(pConfig)) Reflect.setField(_data, i, Reflect.field(pConfig, i));
		
		if (_data.version == null || _data.version=="") _data.version = "0.0.0";
		if (_data.gameName == null) _data.gameName = "";
		
		if (_data.debug == null || _data.debug == "") _data.debug = false;
		if (_data.fps == null || _data.fps == "") _data.fps = false;
		

	}
	
	private static function get_data ():Dynamic {
		return _data;
	}
	
	private static function get_version ():String {
		return _data.version;
	}
	
	private static function get_debug ():Bool {
		return data.debug;
	}
	
	private static function get_fps ():Bool {
		return data.fps;
	}
	
	private static function get_colliderAlpha(): Float {
		return data.colliderAlpha;
	}
	
	private static function get_rendererAlpha(): Float {
		return data.rendererAlpha;
	}
}