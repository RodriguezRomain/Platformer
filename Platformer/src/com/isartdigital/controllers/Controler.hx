package com.isartdigital.controllers;
import com.isartdigital.utils.system.System;
import com.isartdigital.utils.system.DeviceCapabilities;


/**
 * ...
 * @author Romain Rodriguez
 */
class Controler 
{
	public var left(get, null):Bool;
	public var right(get, null):Bool;
	public var jump(get, null):Bool;
	
	public static var current:Controler;
	
	public function new() 
	{
		
	}
	
	public static function setupController()
	{
		if (DeviceCapabilities.system == System.DESKTOP)
			current = new ControlerKeyboard();
		else
			current = new ControlerTouch();
	}
	
	private function get_left(): Bool
	{
		return false;
	}
	
	private function get_right(): Bool
	{
		return false;
	}
	
	private function get_jump(): Bool
	{
		return false;
	}
	
	public function start()
	{
		
	}
	
	public function stop()
	{
		
	}
}