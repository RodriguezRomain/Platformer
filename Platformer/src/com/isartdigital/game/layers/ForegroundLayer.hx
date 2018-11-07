package com.isartdigital.game.layers;
import com.isartdigital.game.levelDesign.Cell;
import com.isartdigital.game.pooling.IPoolable;
import com.isartdigital.game.pooling.PoolingManager;
import com.isartdigital.game.sprites.decor.GameFront;
import openfl.Vector;
import openfl.display.Tilemap;
import openfl.geom.Point;

	
/**
 * ...
 * @author Romain Rodriguez
 */
class ForegroundLayer extends ScrollingLayer 
{
	
	/**
	 * instance unique de la classe GameFrontLayer
	 */
	private static var instance: ForegroundLayer;
	
	static public var cellSize(get, null):Point = new Point(450, 450);
	
	static public var dataGrid: Vector<Vector<Cell>>;
	static public var instanceGrid: Vector<Vector<Array<IPoolable>>>;
	
	static public var tileMap:Tilemap;
	
	/**
	 * Retourne l'instance unique de la classe, et la crée si elle n'existait pas au préalable
	 * @return instance unique
	 */
	public static function getInstance (): ForegroundLayer {
		if (instance == null) instance = new ForegroundLayer();
		return instance;
	}
	
	/**
	 * constructeur privé pour éviter qu'une instance soit créée directement
	 */
	private function new() 
	{
		super();
		speed.setTo(0.95, 0.95);
	}
	
	public static function createLevelCell(pX:Int, pY:Int)
	{
		var lObject:GameFront;
		
		if (dataGrid[pX] == null || dataGrid[pX][pY] == null)
			return;
		for (lObjectData in dataGrid[pX][pY].list){
			lObject = cast(PoolingManager.getFromPool("GameFront"), GameFront);
			lObject.init(lObjectData);
			
			if (instanceGrid[pX] == null)
				instanceGrid[pX] = new Vector<Array<IPoolable>>();
			if (instanceGrid[pX][pY] == null)
				instanceGrid[pX][pY] = new Array<IPoolable>();
			instanceGrid[pX][pY].push(lObject);
			
			tileMap.addTile(lObject);
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
		instance = null;
		super.destroy();
	}

}