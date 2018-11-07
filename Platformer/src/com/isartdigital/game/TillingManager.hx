package com.isartdigital.game;
import com.isartdigital.game.levelDesign.LevelData;
import com.isartdigital.game.levelDesign.LevelManager;
import com.isartdigital.game.pooling.IPoolable;
import com.isartdigital.game.sprites.backgrounds.Background;
import com.isartdigital.game.sprites.backgrounds.Background1;
import com.isartdigital.game.sprites.backgrounds.Background2;
import com.isartdigital.game.sprites.decor.GameBack;
import com.isartdigital.game.sprites.decor.GameFront;
import com.isartdigital.utils.loader.GameLoader;
import haxe.Json;
import openfl.display.Tile;
import openfl.display.Tilemap;
import openfl.display.Tileset;
import openfl.geom.Rectangle;

/**
 * ...
 * @author Romain Rodriguez
 */
class TillingManager 
{

	static public function createTiles(pJson:Dynamic, pTileMap:Tilemap)
	{
		var lTile:Tile;
		var lObjectData:LevelData;
		
		for (name in Reflect.fields(pJson)){
			lObjectData = Reflect.field(pJson, name);
			
			if (lObjectData.type.substr(0, lObjectData.type.length - 2) == "Background1")
				lTile = new Background1();
			else if (lObjectData.type.substr(0, lObjectData.type.length - 2) == "Background2")
				lTile = new Background2();
			else if (lObjectData.type.substr(0, lObjectData.type.length - 1) == "Tree")
				lTile = new GameBack();
			else
				lTile = new GameFront();
			cast(lTile, IPoolable).init(lObjectData);
			
			pTileMap.addTile(lTile);
		}
	}
	
	static public function createTileMap(pString:String, data:String):Tilemap
	{
		var lJson:Dynamic = Json.parse(data).meta;
		
		var lRects:Array<Rectangle> = new Array<Rectangle>();
		
		var lFrame:Rectangle;
		
		var lObject:Dynamic = Json.parse(GameLoader.getText("assets/images/" + pString + "_" + LevelManager.currentWorld + ".json"));
		
		for (lName in Reflect.fields(lObject.frames))
		{
			var lObject:Dynamic = Reflect.field(lObject.frames, lName).frame;
			
			lFrame = new Rectangle(lObject.x,lObject.y,lObject.w,lObject.h);
			lRects.push(lFrame);
		}
		
		var lTileset:Tileset = new Tileset(GameLoader.getBitmapData("assets/images/"+ pString + "_"+ LevelManager.currentWorld + ".png"), lRects);
		
		return new Tilemap(lJson.width, lJson.height, lTileset);
	}
}