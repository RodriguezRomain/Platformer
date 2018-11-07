package com.isartdigital.game.layers;
import com.isartdigital.game.levelDesign.Cell;
import com.isartdigital.game.pooling.IPoolable;
import com.isartdigital.game.pooling.PoolingManager;
import com.isartdigital.game.sprites.backgrounds.Background2;
import com.isartdigital.game.sprites.decor.GameBack;
import openfl.Vector;
import openfl.display.Tile;
import openfl.display.Tilemap;
import openfl.geom.Point;

	
/**
 * ...
 * @author Romain Rodriguez
 */
class BackgroundLayer2 extends ScrollingLayer 
{
	
	/**
	 * instance unique de la classe BackgroundLayer2
	 */
	private static var instance: BackgroundLayer2;
	
	static public var cellSize(get, null):Point = new Point(450, 450);
	
	static public var dataGrid: Vector<Vector<Cell>>;
	static public var instanceGrid: Vector<Vector<Array<IPoolable>>>;
	
	static public var tileMap:Tilemap;
	static public var tileMapGameBack:Tilemap;
	
	/**
	 * Retourne l'instance unique de la classe, et la crée si elle n'existait pas au préalable
	 * @return instance unique
	 */
	public static function getInstance (): BackgroundLayer2 {
		if (instance == null) instance = new BackgroundLayer2();
		return instance;
	}
	
	/**
	 * constructeur privé pour éviter qu'une instance soit créée directement
	 */
	private function new() 
	{
		super();
		speed.setTo(0.5, 0.5);
	}
	
	public static function createLevelCell(pX:Int, pY:Int)
	{
		var lObject:IPoolable;
		
		if (dataGrid[pX] == null || dataGrid[pX][pY] == null)
			return;
		for (lObjectData in dataGrid[pX][pY].list){
			if (lObjectData.type.substr(0, lObjectData.type.length - 2) == "Background2")
				lObject = cast(PoolingManager.getFromPool("Background2"), Background2);
			else
				lObject = cast(PoolingManager.getFromPool("GameBack"), GameBack);
				
			lObject.init(lObjectData);
			
			if (instanceGrid[pX] == null)
				instanceGrid[pX] = new Vector<Array<IPoolable>>();
			if (instanceGrid[pX][pY] == null)
				instanceGrid[pX][pY] = new Array<IPoolable>();
			instanceGrid[pX][pY].push(lObject);
			
			if (lObjectData.type.substr(0, lObjectData.type.length - 2) == "Background2")
				tileMap.addTile(cast(lObject, Tile));
			else
				tileMapGameBack.addTile(cast(lObject, Tile));
		}
	}
	
	public static function get_cellSize():Point
	{
		return cellSize;
	}
	
	/**
	 * détruit l'instance unique et met sa référence interne à null
	 */
	override public function destroy (): Void {
		super.destroy();
		instance = null;
	}

}