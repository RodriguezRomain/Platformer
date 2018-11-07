package com.isartdigital.utils.system;

import openfl.Lib;


#if html5
import js.Browser;
#end

import openfl.display.DisplayObject;
import openfl.geom.Point;
import openfl.geom.Rectangle;
	
/**
 * Classe Utilitaire donnant accès à des propriétés du périphérique cible
 * Tous les périphériques ne se comportant pas comme on l'attend, DeviceCapabilities permet de
 * masquer les comportement différents et présenter une facade unique au reste du code
 * @version 0.5.0
 * @author Mathieu ANTHOINE
 * @author Chadi Husser
 */
class DeviceCapabilities 
{		
	/**
	  * hauteur de la fenetre
	  */
	public static var height (get, never) : UInt;
	
	private static function get_height () {
		return Lib.current.stage.stageHeight;
	}
	
	/**
	  * largeur de la fenetre
	  */
	public static var width (get, never) : UInt;
	
	private static function get_width () {
		return Lib.current.stage.stageWidth;
	}
	
	/**
	 * Système d'exploitation du Device
	 */
	public static var system (get, never) : System;
	
	private static function get_system( ) {
		
		#if html5
		
		if ( ~/IEMobile/i.match(Browser.navigator.userAgent)) return System.WINDOWS_MOBILE;	
		else if ( ~/iPhone|iPad|iPod/i.match(Browser.navigator.userAgent)) return System.I_OS;
		else if ( ~/BlackBerry/i.match(Browser.navigator.userAgent)) return System.BLACK_BERRY;
		else if ( ~/PlayBook/i.match(Browser.navigator.userAgent)) return System.BB_PLAYBOOK;
		else if ( ~/Android/i.match(Browser.navigator.userAgent)) return System.ANDROID;
		else return System.DESKTOP;
		
		#elseif android
		
		return System.ANDROID;
		
		#elseif ios
		
		return System.I_OS;
		
		#else
		
		return System.DESKTOP;
		
		#end
	}
	
	/**
	 * Calcul la dimension idéale du bouton en fonction du device
	 * @return fullscreen ideal size
	 */
	public static function getSizeFactor ():Float {
		var lSize:Float=Math.floor(Math.min(width,height));
		if (system == System.DESKTOP) lSize /= 3;
		return lSize;
	}
		
	/**
	 * retourne un objet Rectangle correspondant aux dimensions de l'écran dans le repère du DisplayObject passé en paramètre
	 * @param pTarget repère cible
	 * @return objet Rectangle
	 */
	public static function getScreenRect(pTarget:DisplayObject):Rectangle {

		var lTopLeft:Point = new Point (0, 0);
		var lBottomRight:Point = new Point (width, height);
		
		lTopLeft = pTarget.globalToLocal(lTopLeft);
		lBottomRight = pTarget.globalToLocal(lBottomRight);
		
		return new Rectangle(lTopLeft.x, lTopLeft.y, lBottomRight.x - lTopLeft.x, lBottomRight.y - lTopLeft.y);
	}
}