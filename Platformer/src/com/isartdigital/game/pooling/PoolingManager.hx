package com.isartdigital.game.pooling;
import com.isartdigital.game.sprites.backgrounds.Background1;
import com.isartdigital.game.sprites.backgrounds.Background2;
import com.isartdigital.game.sprites.decor.GameBack;
import com.isartdigital.game.sprites.decor.GameFront;
import com.isartdigital.game.sprites.levelElements.Platform;
import com.isartdigital.game.sprites.levelElements.Wall;
import haxe.Json;
import openfl.display.DisplayObject;
import openfl.utils.Assets;

/**
 * ...
 * @author Romain Rodriguez
 */
class PoolingManager 
{
	private static var pool:Map<String, Array<IPoolable>> = new Map<String, Array<IPoolable>>();
	
	public static function init(pJson:Dynamic)
	{
		
		pool.set("Platform", new Array<IPoolable>());
		pool.set("Wall", new Array<IPoolable>());
		pool.set("Background1", new Array<IPoolable>());
		pool.set("Background2", new Array<IPoolable>());
		pool.set("GameFront", new Array<IPoolable>());
		pool.set("GameBack", new Array<IPoolable>());
		
		var i:Int = 0;
		
		for (name in Reflect.fields(pJson))
		{
			i = 0;
			while (i < Reflect.field(pJson, name))
			{
				if (name == "Platform")
					pool.get(name).push(new Platform());
				if (name == "Wall")
					pool.get(name).push(new Wall());
				if (name == "Background1")
					pool.get(name).push(new Background1());
				if (name == "Background2")
					pool.get(name).push(new Background2());
				if (name == "GameFront")
					pool.get(name).push(new GameFront());
				if (name == "GameBack")
					pool.get(name).push(new GameBack());
				i++;
			}
		}
	}
	
	public static function getFromPool(pPoolName:String) : IPoolable
	{
		return pool.get(pPoolName).pop();
	}
	
	public static function clear()
	{
		for (array in pool){
			for (object in array){
				array.remove(object);
			}
		}
	}
	
	public static function addToPool(pPoolName:String, pPoolObject:IPoolable) : Void
	{
		pool.get(pPoolName).push(pPoolObject);
	}
	
}