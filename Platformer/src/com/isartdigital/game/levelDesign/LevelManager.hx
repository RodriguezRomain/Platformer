package com.isartdigital.game.levelDesign;
import com.isartdigital.game.camera.AdvancedCamera;
import com.isartdigital.game.layers.BackgroundLayer1;
import com.isartdigital.game.layers.BackgroundLayer2;
import com.isartdigital.game.layers.ForegroundLayer;
import com.isartdigital.game.layers.GameLayer;
import com.isartdigital.game.layers.ScrollingLayer;
import com.isartdigital.game.pooling.IPoolable;
import com.isartdigital.game.pooling.PoolingManager;
import com.isartdigital.game.sprites.decor.GameBack;
import com.isartdigital.game.sprites.decor.GameFront;
import com.isartdigital.game.sprites.levelElements.mobile.Player;
import com.isartdigital.game.sprites.backgrounds.Background;
import com.isartdigital.game.sprites.backgrounds.Background1;
import com.isartdigital.game.sprites.backgrounds.Background2;
import com.isartdigital.game.sprites.levelElements.LevelElement;
import com.isartdigital.game.sprites.levelElements.Platform;
import com.isartdigital.game.sprites.levelElements.Wall;
import com.isartdigital.ui.GraphicLoader;
import com.isartdigital.utils.events.AssetsLoaderEvent;
import com.isartdigital.utils.game.GameStage;
import com.isartdigital.utils.game.StateManager;
import com.isartdigital.utils.game.stateObjects.StateSpriteSheet;
import com.isartdigital.utils.loader.GameLoader;
import com.isartdigital.utils.system.DeviceCapabilities;
import haxe.Json;
import openfl.Vector;
import openfl.display.Tile;
import openfl.display.Tilemap;
import openfl.display.Tileset;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import openfl.utils.Assets;

/**
 * ...
 * @author Romain Rodriguez
 */
class LevelManager 
{
	static public var currentLevel:String;
	static public var currentWorld:String;
	
	static public var meta(get, null):Dynamic;
	
	static public var cellSize(get, null):Point = new Point(150, 150);
	
	static public var dataGrid: Vector<Vector<Cell>>;
	static public var instanceGrid: Vector<Vector<Array<IPoolable>>>;
	
	//Charge le fichier JSON puis lance la creation du niveau
	static public function createLevel(levelName:String)
	{
		currentLevel = levelName;
		
		var lGameLoader:GameLoader = new GameLoader();
		lGameLoader.addEventListener(AssetsLoaderEvent.PROGRESS, onLoadProgress);
		lGameLoader.addEventListener(AssetsLoaderEvent.COMPLETE, onLoadComplete);
		
		lGameLoader.addBitmapData("assets/images/Backgrounds1_" + currentWorld + ".png");
		lGameLoader.addText("assets/images/Backgrounds1_"+ currentWorld + ".json");
		lGameLoader.addBitmapData("assets/images/Backgrounds2_"+ currentWorld + ".png");
		lGameLoader.addText("assets/images/Backgrounds2_" + currentWorld + ".json");
		lGameLoader.addBitmapData("assets/images/GameBack_"+ currentWorld + ".png");
		lGameLoader.addText("assets/images/GameBack_" + currentWorld + ".json");
		lGameLoader.addBitmapData("assets/images/GameFront_"+ currentWorld + ".png");
		lGameLoader.addText("assets/images/GameFront_"+ currentWorld + ".json");
		lGameLoader.addBitmapData("assets/images/LevelDesigns_"+ currentWorld + ".png");
		lGameLoader.addText("assets/images/LevelDesigns_"+ currentWorld + ".json");
		lGameLoader.addBitmapData("assets/images/Characters.png");
		lGameLoader.addText("assets/images/Characters.json");
	
		lGameLoader.addText("assets/colliders.json");
		
		lGameLoader.addText("assets/pool.json");
		
		lGameLoader.load();
	}
	
	static public function clearLevel()
	{
		GameManager.pauseGame();
		
		AdvancedCamera.getInstance().destroy();
		for (i in Background.list) i.destroy();
		for (i in LevelElement.list) i.destroy();
		Player.getInstance().destroy();
		for (i in Background.list) i.destroy();
		for (i in GameBack.list) i.destroy();
		for (i in GameFront.list) i.destroy();
		
		unloadAssets();
	}
	
	static private function unloadAssets()
	{
		Assets.cache.clear("assets/images/Backgrounds1_" + currentWorld + ".png");
		Assets.cache.clear("assets/images/Backgrounds1_"+ currentWorld + ".json");
		Assets.cache.clear("assets/images/Backgrounds2_"+ currentWorld + ".png");
		Assets.cache.clear("assets/images/Backgrounds2_"+ currentWorld + ".json");
		Assets.cache.clear("assets/images/LevelDesigns_"+ currentWorld + ".png");
		Assets.cache.clear("assets/images/LevelDesigns_" + currentWorld + ".json");
		Assets.cache.clear("assets/images/GameBack_"+ currentWorld + ".png");
		Assets.cache.clear("assets/images/GameBack_" + currentWorld + ".json");
		Assets.cache.clear("assets/images/GameFront_"+ currentWorld + ".png");
		Assets.cache.clear("assets/images/GameFront_"+ currentWorld + ".json");
		Assets.cache.clear("assets/images/Characters.png");
		Assets.cache.clear("assets/images/Characters.json");
	
		Assets.cache.clear("assets/colliders.json");
		Assets.cache.clear("assets/pool.json");
	}
	
	static private function onLoadProgress (pEvent:AssetsLoaderEvent): Void
	{
		GraphicLoader.getInstance().setProgress(pEvent.filesLoaded / pEvent.nbFiles);	
	}

	static private function onLoadComplete (pEvent:AssetsLoaderEvent): Void
	{
		trace("LOAD COMPLETE");
		
		var lGameLoader : GameLoader = cast(pEvent.target, GameLoader);
		lGameLoader.removeEventListener(AssetsLoaderEvent.PROGRESS, onLoadProgress);
		lGameLoader.removeEventListener(AssetsLoaderEvent.COMPLETE, onLoadComplete);		
		
		//Ajout des states des stateObjects
		StateManager.addSpriteSheetFromAnimate(Json.parse(GameLoader.getText("assets/images/Backgrounds1_" + currentWorld + ".json")), GameLoader.getBitmapData("assets/images/Backgrounds1_" + currentWorld + ".png"));
		StateManager.addSpriteSheetFromAnimate(Json.parse(GameLoader.getText("assets/images/Backgrounds2_" + currentWorld + ".json")), GameLoader.getBitmapData("assets/images/Backgrounds2_" + currentWorld + ".png"));
		StateManager.addSpriteSheetFromAnimate(Json.parse(GameLoader.getText("assets/images/LevelDesigns_" + currentWorld + ".json")), GameLoader.getBitmapData("assets/images/LevelDesigns_" + currentWorld + ".png"));
		StateManager.addSpriteSheetFromAnimate(Json.parse(GameLoader.getText("assets/images/GameBack_" + currentWorld + ".json")), GameLoader.getBitmapData("assets/images/GameBack_" + currentWorld + ".png"));
		StateManager.addSpriteSheetFromAnimate(Json.parse(GameLoader.getText("assets/images/GameFront_" + currentWorld + ".json")), GameLoader.getBitmapData("assets/images/GameFront_" + currentWorld + ".png"));
		StateManager.addSpriteSheetFromAnimate(Json.parse(GameLoader.getText("assets/images/Characters.json")), GameLoader.getBitmapData("assets/images/Characters.png"));
	
		//Ajout des colliders des stateObjects
		StateManager.addColliders(Json.parse(GameLoader.getText("assets/colliders.json")));
		
		Assets.loadText("assets/levels/"+currentLevel + ".json").onComplete(buildBackgrounds);
	}
	
	private static function createLevelData(data:String) : Void 
	{
		
		dataGrid = ClippingManager.createDataGrid(meta, Json.parse(data).LevelDesign);
		instanceGrid = new Vector(meta.width);
		
		GameStage.getInstance().getGameSprite().addChild(GameLayer.getInstance());
		ClippingManager.clipGrid("Level", instanceGrid);
		buildGameFront(data);
	}
	
	static public function createLevelCell(pX:Int, pY:Int)
	{
		var lObject:StateSpriteSheet;
		var lDataPlayer:LevelData = null;
		
		if (dataGrid[pX] == null || dataGrid[pX][pY] == null)
			return;
		for (lObjectData in dataGrid[pX][pY].list){
			if (lObjectData.type == "Wall")
			{
				lObject = cast(PoolingManager.getFromPool("Wall"), StateSpriteSheet);
			}
			else if (lObjectData.type == "Platform")
			{
				lObject = cast(PoolingManager.getFromPool("Platform"), StateSpriteSheet);
			} else if (lObjectData.type == "Player"){
				lObject = Player.getInstance();
				lDataPlayer = lObjectData;
			}
			else
			{
				continue;
			}
			
			cast(lObject, IPoolable).init(lObjectData);
			
			if (instanceGrid[pX] == null)
				instanceGrid[pX] = new Vector<Array<IPoolable>>();
			if (instanceGrid[pX][pY] == null)
				instanceGrid[pX][pY] = new Array<IPoolable>();
				
			if (lObjectData.type != "Player")
				instanceGrid[pX][pY].push(cast(lObject, IPoolable));
			
			lObject.x = lObjectData.x;
			lObject.y = lObjectData.y;
			
			GameLayer.getInstance().addChild(lObject);
			lObject.start();
		}
		if(lDataPlayer != null)
			dataGrid[pX][pY].list.remove(lDataPlayer);
	}
	
	private static function buildBackgrounds(data:String) : Void 
	{
		PoolingManager.init(Json.parse(GameLoader.getText("assets/pool.json")));
		
		var lJson:Dynamic = Json.parse(data).Background2;
		
		meta = Json.parse(data).meta;
		
		BackgroundLayer2.tileMap = TillingManager.createTileMap("Backgrounds2", data);
		BackgroundLayer2.tileMapGameBack = TillingManager.createTileMap("GameBack", data);
		
		BackgroundLayer2.dataGrid = ClippingManager.createDataGrid(meta, lJson);
		BackgroundLayer2.instanceGrid = new Vector(meta.width);
		ClippingManager.clipGrid("Background2", BackgroundLayer2.instanceGrid);
		
		BackgroundLayer2.getInstance().addChild(BackgroundLayer2.tileMap);
		BackgroundLayer2.getInstance().addChild(BackgroundLayer2.tileMapGameBack);
		
		//TillingManager.createTiles(BackgroundLayer2.instanceGrid, BackgroundLayer2.tileMap);
		
		lJson = Json.parse(data).Background1;
		
		BackgroundLayer1.tileMap = TillingManager.createTileMap("Backgrounds1", data);
		BackgroundLayer1.getInstance().addChild(BackgroundLayer1.tileMap);
		
		BackgroundLayer1.dataGrid = ClippingManager.createDataGrid(meta, lJson);
		BackgroundLayer1.instanceGrid = new Vector(meta.width);
		ClippingManager.clipGrid("Background1", BackgroundLayer1.instanceGrid);
		
		//TillingManager.createTiles(BackgroundLayer1.instanceGrid, BackgroundLayer1.tileMap);
		
		GameStage.getInstance().getGameSprite().addChild(BackgroundLayer2.getInstance());
		GameStage.getInstance().getGameSprite().addChild(BackgroundLayer1.getInstance());
		
		createLevelData(data);
	}
	
	private static function buildGameFront(data:String)
	{
		var lObjectData:LevelData;
		var lTile:GameFront = null;
		
		var lJson:Dynamic = Json.parse(data).Foreground;
		
		ForegroundLayer.tileMap = TillingManager.createTileMap("GameFront", data);
		ForegroundLayer.getInstance().addChild(ForegroundLayer.tileMap);
		
		ForegroundLayer.dataGrid = ClippingManager.createDataGrid(meta, lJson);
		ForegroundLayer.instanceGrid = new Vector(meta.width);
		ClippingManager.clipGrid("Foreground", ForegroundLayer.instanceGrid);
		
		GameStage.getInstance().getGameSprite().addChild(ForegroundLayer.getInstance());
		
		GameManager.start();
	}
	
	public static function get_cellSize():Point
	{
		return cellSize;
	}
	
	public static function get_meta():Dynamic
	{
		return meta;
	}
}