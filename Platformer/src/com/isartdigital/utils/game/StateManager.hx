package com.isartdigital.utils.game;
import com.isartdigital.utils.game.stateObjects.imports.Frame as AFrame;
import com.isartdigital.utils.game.stateObjects.imports.Meta;
import com.isartdigital.utils.math.geom.Circle;
import haxe.Json;
import haxe.ds.StringMap;
import openfl.display.BitmapData;
import openfl.display.Tileset;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import spritesheet.behaviors.Behavior;
import spritesheet.frames.Frame;
import spritesheet.frames.SpritesheetFrame;
import spritesheet.frames.TilesheetFrame;
import spritesheet.sheets.Spritesheet;
import spritesheet.sheets.Tilesheet;

/**
 * Manager chargé de gérer des opérations globales sur les StateObjects et les ressources associées
 * @author Mathieu Anthoine
 */
class StateManager 
{
	
	/**
	 * nombre de zéro à ajouter pour construire un nom de frame
	 */
	private static var digits:String;	
	
	/**
	 * longueur de la numérotation des textures
	 */
	public static var textureDigits (default, set) :UInt = 4;
	
	private static function set_textureDigits (pDigits:UInt) : UInt {
		digits = "";
		for (i in 0...pDigits) digits += "0";
		return textureDigits = pDigits;	
	}
	
	/**
	 * cache des colliders de tous les StateObject
	 */
	private static var colliders:Map<String,Map<String,Dynamic>>;
	
	
	private static var tilesheets : Map<String, Tilesheet> = new Map<String, Tilesheet>();
	
	private static var tileAnchors : Map<String, Point> = new Map<String, Point>();
	
	private static var spritesheets : Map<String, Spritesheet> = new Map<String, Spritesheet>();
	
	/**
	   Récupère une tilesheet en cache
	   @param	pName le nom de la tilesheet
	   @return la tilesheet en cache
	**/
	public static function getTilesheet(pName:String) : Tilesheet {
		var lTilesheet : Tilesheet = tilesheets.get(pName);
		
		if (lTilesheet == null) throw 'La tilesheet $pName n\'existe pas';
		
		return lTilesheet;
	}
	
	/**
	   Récupère une spritesheet en cache
	   @param	pName le nom de la spritesheet
	   @return la spritesheet en cache
	**/
	public static function getSpritesheet(pName:String) : Spritesheet {
		var lSpritesheet: Spritesheet = spritesheets.get(pName);
		
		if (lSpritesheet == null) throw 'La spritesheet $pName n\'existe pas';
		
		return lSpritesheet;
	}
	
	/**
	   Récupère l'ancre associé à l'ID
	   @param	pID
	   @return l'ancre
	**/
	public static function getAnchor(pID:String) : Point {
		return tileAnchors.get(pID);
	}
	
	/**
	   Ajoute une tilesheet depuis un json généré par animate
	   @param	pJson fichier exporté par animate
	   @param	pBitmapData bitmapdata associé au json
	**/
	public static function addTilesheetFromAnimate(pJson:Json, pBitmapData:BitmapData): Void { 
		var lFrames:Dynamic = Reflect.field(pJson, "frames");
		var lMeta:Meta = Reflect.field(pJson, "meta");
		var lName:String = lMeta.image.split(".")[0];
		var lFrameRate:Int = 30; // lMeta.frameRate;
		var lFrame: AFrame;
		var lID: String;
		var lNum: Null<Int>;

		var lBehaviorMap : StringMap<Array<AFrame>> = new StringMap<Array<AFrame>>();
		var lBehavior : Array<AFrame>;
		
		for (frameName in Reflect.fields(lFrames)) {
			lFrame = Reflect.field(lFrames, frameName);
			lID = frameName.split(".")[0];
			
			lNum = Std.parseInt(lID.substr(-1*textureDigits));
			if (lNum != null) lID = lID.substr(0, lID.length - textureDigits);
			
			if (lBehaviorMap.exists(lID)) {
				lBehavior = lBehaviorMap.get(lID);
			} else {
				lBehavior = new Array<AFrame>();
				lBehaviorMap.set(lID, lBehavior);
			}
			lBehavior.push(lFrame);
			
			tileAnchors.set(lID, new Point(lFrame.pivot.x, lFrame.pivot.y));
		}
		
		tilesheets.set(lName, generateTileSheetForBehaviors(pBitmapData, lBehaviorMap, lFrameRate));
	}
	
	/**
	   Ajoute une spritesheet depuis un json généré par animate
	   @param	pJson fichier exporté par animate
	   @param	pBitmapData bitmapdata associé au json
	**/
	public static function addSpriteSheetFromAnimate(pJson:Dynamic, pBitmapData:BitmapData): Void { 
		var lFrames:Dynamic = Reflect.field(pJson, "frames");
		var lMeta:Meta = Reflect.field(pJson, "meta");
		
		var lName:String = lMeta.image.split(".")[0];
		var lFrameRate:Int = 30; // lMeta.frameRate;
		var lFrame: AFrame;
		var lID: String;
		var lNum:Null<Int>;
		
		var lBehaviorMap : StringMap<Array<AFrame>> = new StringMap<Array<AFrame>>();
		var lBehavior : Array<AFrame>;
		
		for (frameName in Reflect.fields(lFrames)) {
			lFrame = Reflect.field(lFrames, frameName);
			lID = frameName.split(".")[0];
			
			lNum = Std.parseInt(lID.substr(-1*textureDigits));
			if (lNum != null) lID = lID.substr(0, lID.length - textureDigits);
			
			if (lBehaviorMap.exists(lID)) {
				lBehavior = lBehaviorMap.get(lID);
			} else {
				lBehavior = new Array<AFrame>();
				lBehaviorMap.set(lID, lBehavior);
			}
			lBehavior.push(lFrame);
			
			tileAnchors.set(lID, new Point(lFrame.pivot.x, lFrame.pivot.y));
		}
		
		spritesheets.set(lName, generateSpriteSheetForBehaviors(pBitmapData, lBehaviorMap, lFrameRate));
	}
	
	private static function generateSpriteSheetForBehaviors(bitmapData:BitmapData, behaviorNames:StringMap<Array<AFrame>>, pFrameRate):Spritesheet {
        var allFrames = new Array<Frame>();
        var allBehaviors = new Map <String, Behavior>();
		
        for (key in behaviorNames.keys()) {
            var indexes = new Array<Int>();
            var frames = behaviorNames.get(key);

            for (i in 0...frames.length) {
                var tpFrame:AFrame = frames[i];

                var sFrame = new SpritesheetFrame (tpFrame.frame.x, tpFrame.frame.y, tpFrame.frame.w, tpFrame.frame.h);
                if (tpFrame.trimmed) {
                    sFrame.offsetX = tpFrame.spriteSourceSize.x;
                    sFrame.offsetY = tpFrame.spriteSourceSize.y;
                }

                indexes.push(allFrames.length);
                allFrames.push(sFrame);
            }

            if (isBehaviorIgnored(key)) {
                continue;
            }

            allBehaviors.set(key, new Behavior(key, indexes, false, false, pFrameRate));
        }

        return new Spritesheet(bitmapData, null, allFrames, allBehaviors);
    }
	
	private static function generateTileSheetForBehaviors(bitmapData:BitmapData, behaviorNames:StringMap<Array<AFrame>>, pFrameRate:Int):Tilesheet {
        var allFrames = new Array<Frame>();
        var allBehaviors = new Map <String, Behavior>();
        var allRects = new Array<Rectangle>();

        for (key in behaviorNames.keys()) {
            var indexes = new Array<Int>();
            var frames = behaviorNames.get(key);

            for (i in 0...frames.length) {
                var tpFrame:AFrame = frames[i];

                var sFrame = new TilesheetFrame (tpFrame.frame.x, tpFrame.frame.y, tpFrame.frame.w, tpFrame.frame.h);
                sFrame.rect = new Rectangle(tpFrame.frame.x, tpFrame.frame.y, tpFrame.frame.w, tpFrame.frame.h);
				sFrame.id =  i;
                if (tpFrame.trimmed) {
                    sFrame.offsetX = tpFrame.spriteSourceSize.x;
                    sFrame.offsetY = tpFrame.spriteSourceSize.y;
                }

                indexes.push(allFrames.length);
                allFrames.push(sFrame);
                allRects.push(sFrame.rect);
            }

            if (isBehaviorIgnored(key)) {
                continue;
            }

            allBehaviors.set(key, new Behavior(key, indexes, false, false, pFrameRate));
        }

        return new Tilesheet(new Tileset(bitmapData, allRects), allFrames, allBehaviors);
    }

	private static function isBehaviorIgnored(pKey:String) : Bool {
		return pKey == '';
	}
	
	
	
	/**
	 * Créer tous les Colliders
	 * @param	pJson Fichier contenant la description des colliders
	 */
	static public function addColliders (pJson:Dynamic): Void {
		
		if (colliders == null) colliders = new Map<String,Map<String,Dynamic>>();
		var lItem;
		var lObj;
		for (lName in Reflect.fields(pJson)) {
			lItem = Reflect.field(pJson, lName);
			colliders[lName] = new Map<String,Dynamic>();			
			
			for (lObjName in Reflect.fields(lItem)) {
				lObj = Reflect.field(lItem, lObjName);
				if (lObj.type == "Rectangle") colliders[lName][lObjName] = new Rectangle(lObj.x, lObj.y, lObj.width, lObj.height);
				else if (lObj.type == "Circle") colliders[lName][lObjName] = new Circle(lObj.x, lObj.y, lObj.radius);
				else if (lObj.type == "Point") colliders[lName][lObjName] = new Point(lObj.x, lObj.y);

			}
			
		}
		
	}
	

	/**
	 * Cherche dans le cache général des colliders, celui correspondant au state demandé
	 * @param	pState State de l'instance
	 * @return	le collider correspondant
	 * @return
	 */
	public static function getCollider (pState:String):Map<String,Dynamic> {
		return colliders[pState];
	}
	
}