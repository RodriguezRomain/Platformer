package com.isartdigital.game.layers;
import com.isartdigital.game.levelDesign.Cell;
import com.isartdigital.game.pooling.IPoolable;
import com.isartdigital.game.pooling.PoolingManager;
import com.isartdigital.game.sprites.backgrounds.Background1;
import openfl.Vector;
import openfl.display.Tilemap;
import openfl.geom.Point;

	
/**
 * ...
 * @author Romain Rodriguez
 */
class BackgroundLayer1 extends ScrollingLayer 
{
	
	/**
	 * instance unique de la classe BackgroundLayer1
	 */
	private static var instance: BackgroundLayer1;
	
	static public var cellSize(get, null):Point = new Point(400, 400);
	
	static public var dataGrid: Vector<Vector<Cell>>;
	static public var instanceGrid: Vector<Vector<Array<IPoolable>>>;
	
	static public var tileMap:Tilemap;
	
	/**
	 * Retourne l'instance unique de la classe, et la crée si elle n'existait pas au préalable
	 * @return instance unique
	 */
	public static function getInstance (): BackgroundLayer1 {
		if (instance == null) instance = new BackgroundLayer1();
		return instance;
	}
	
	/**
	 * constructeur privé pour éviter qu'une instance soit créée directement
	 */
	private function new() 
	{
		super();
		speed.setTo(0.75, 0.75);
	}
	
	public static function createLevelCell(pX:Int, pY:Int)
	{
		var lObject:Background1;
		
		if (dataGrid[pX] == null || dataGrid[pX][pY] == null)
			return;
		for (lObjectData in dataGrid[pX][pY].list){
			lObject = cast(PoolingManager.getFromPool("Background1"), Background1);
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