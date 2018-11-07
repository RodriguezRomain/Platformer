package com.isartdigital.controllers;
import openfl.Lib;
import openfl.events.KeyboardEvent;
import openfl.ui.Keyboard;

/**
 * ...
 * @author Romain Rodriguez
 */
class ControlerKeyboard extends Controler 
{
	private var keys:Map<Int, Bool> = new Map();
	
	public function new() 
	{
		super();
		
	}
	
	override public function start()
	{
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, registerKey);
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_UP, unregisterKey);
	}
	
	override public function stop()
	{
		Lib.current.stage.removeEventListener(KeyboardEvent.KEY_DOWN, registerKey);
		Lib.current.stage.removeEventListener(KeyboardEvent.KEY_UP, unregisterKey);
	}
	
	private function registerKey(pEvent:KeyboardEvent)
	{
		keys[pEvent.keyCode] = true;
	}
	
	private function unregisterKey(pEvent:KeyboardEvent)
	{
		keys[pEvent.keyCode] = false;
	}
	
	override function get_left():Bool 
	{
		return keys[Keyboard.LEFT];
	}
	
	//@:getter(right)
	override function get_right():Bool 
	{
		return keys[Keyboard.RIGHT];
	}
	
	//@:getter(space)
	override function get_jump():Bool 
	{
		return keys[Keyboard.SPACE];
	}
}