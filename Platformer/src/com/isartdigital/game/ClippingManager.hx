package com.isartdigital.game;
import com.isartdigital.game.layers.BackgroundLayer1;
import com.isartdigital.game.layers.BackgroundLayer2;
import com.isartdigital.game.layers.ForegroundLayer;
import com.isartdigital.game.layers.GameLayer;
import com.isartdigital.game.levelDesign.Cell;
import com.isartdigital.game.levelDesign.LevelData;
import com.isartdigital.game.levelDesign.LevelManager;
import com.isartdigital.game.pooling.IPoolable;
import com.isartdigital.utils.game.stateObjects.StateSpriteSheet;
import com.isartdigital.utils.system.DeviceCapabilities;
import openfl.Vector;
import openfl.geom.Point;
import openfl.geom.Rectangle;

/**
 * ...
 * @author Romain Rodriguez
 */
class ClippingManager 
{
	static public var currentDisplay:Rectangle = null;
	
	static private var margin:Int = 3;
	
	public static function createDataGrid(pMeta:Dynamic, pJson:Dynamic): Vector<Vector<Cell>>
	{
		var lObjectData:LevelData;
		var xCoord:Int;
		var yCoord:Int;
		
		var dataGrid = new Vector(pMeta.width);
		
		for (name in Reflect.fields(pJson)) {
			lObjectData = Reflect.field(pJson, name);
			
			xCoord = Math.floor(lObjectData.x / LevelManager.cellSize.x);
			yCoord = Math.floor(lObjectData.y / LevelManager.cellSize.y);
			
			if (dataGrid[xCoord] == null)
				dataGrid[xCoord] = new Vector<Cell>(pMeta.height);
			if (dataGrid[xCoord][yCoord] == null)
				dataGrid[xCoord][yCoord] = new Cell();
			dataGrid[xCoord][yCoord].list.push(lObjectData);
		}
		
		return dataGrid;
	}
	
	public static function clipGrid<T: IPoolable>(pType:String, instanceGrid:Vector<Vector<Array<T>>>)
	{
		var lObject:StateSpriteSheet = null;
		var lScreen:Rectangle = DeviceCapabilities.getScreenRect(GameLayer.getInstance());
		var lXMin:Int;
		var lXMax:Int;
		var lYMin:Int;
		var lYMax:Int;
		var lX:Int = 0;
		var lY:Int = 0;
		
		var lCellSize:Point;
		
		//if (pType == "Background1")
			//lCellSize = BackgroundLayer1.cellSize;
		//else if (pType == "Background2")
			//lCellSize = BackgroundLayer2.cellSize;
		//else if (pType == "Foreground")
			//lCellSize = ForegroundLayer.cellSize;
		//else
		lCellSize = LevelManager.cellSize;
		
		if (currentDisplay == null)
			currentDisplay = lScreen;
		
		if (lScreen.right > currentDisplay.right)
		{
			lXMin = Math.floor(currentDisplay.left / lCellSize.x);
			lXMax = Math.ceil(lScreen.right / lCellSize.x);
		} else {
			lXMin = Math.floor(lScreen.left / lCellSize.x);
			lXMax = Math.ceil(currentDisplay.right / lCellSize.x);
		}
		
		if (lScreen.bottom > currentDisplay.bottom)
		{
			lYMin = Math.floor(currentDisplay.top / lCellSize.y);
			lYMax = Math.ceil(lScreen.bottom / lCellSize.y);
		}else {
			lYMin = Math.floor(lScreen.top / lCellSize.y);
			lYMax = Math.ceil(currentDisplay.bottom / lCellSize.y);
		}
		
		lXMin -= 10;
		lXMax += 10;
		
		lYMin -= 10;
		lYMax += 10;
		
		if (lXMin < 0)
			lXMin = 0;
		if (lYMin < 0)
			lYMin = 0;
		
		lX = lXMin;
		
		while (lX < lXMax)
		{
			if (instanceGrid[lX] == null){
				instanceGrid[lX] = new Vector<Array<T>>(LevelManager.meta.height);
			}
			
			lY = lYMin;
			
			while (lY < lYMax)
			{
				if (instanceGrid[lX][lY] == null){
					instanceGrid[lX][lY] = new Array<T>();
				}
				
				if (lX * lCellSize.x + lCellSize.x >= lScreen.left - margin * lCellSize.x && lX * lCellSize.x <= lScreen.right + margin * lCellSize.x)
				{
					if (lY * lCellSize.y + lCellSize.y >= lScreen.top - margin * lCellSize.y && lY * lCellSize.y <= lScreen.bottom + margin * lCellSize.y)
					{
						if (instanceGrid[lX][lY].length == 0)
						{
							createCell(pType, lX, lY);
						}
					}else {
						destroyCell(instanceGrid, lX, lY);
					}
				}else {
					destroyCell(instanceGrid, lX, lY);
				}
				
				lY++;
			}
			lX++;
		}
		
		currentDisplay = lScreen;
	}
	
	static private function createCell(pType:String,pX:Int, pY:Int)
	{
		if (pType == "Level")
			LevelManager.createLevelCell(pX, pY);
		else if (pType == "Background1")
			BackgroundLayer1.createLevelCell(pX, pY);
		else if (pType == "Background2")
			BackgroundLayer2.createLevelCell(pX, pY);
		else if (pType == "Foreground")
			ForegroundLayer.createLevelCell(pX, pY);
	}
	
	static private function destroyCell<T: IPoolable>(pGrid:Vector<Vector<Array<T>>>,pX:Int, pY:Int)
	{
		while (pGrid[pX][pY].length > 0)
		{
			pGrid[pX][pY].pop().dispose();
		}
	}
	
}