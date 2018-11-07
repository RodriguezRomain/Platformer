package  {
	
	import flash.display.MovieClip;
	import flash.utils.*;
	import flash.display.DisplayObjectContainer;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	import flash.events.Event;
	
	/**
	* Exporte les informations necessaire à la reconstruction du ld
	* @author Chadi Husser
	*/
	public class ExportLevelDesign extends MovieClip {
		
		private var content:Object;
		private var file: FileReference;
		private var level:String;
		
		public function ExportLevelDesign() {
			stop();
			browse();
		}
		
		private function browse (pEvent:Event=null):void {
			browseLevel(DisplayObjectContainer(getChildAt(0)));
			if (pEvent==null) nextFrame();
		}
		
		private function browseLevel (pChild:DisplayObjectContainer): void {
			
			content = {};
			
			var lLevel:String = getQualifiedClassName(pChild);
			var lPlaneName:String;
			var lPlane:DisplayObjectContainer;
			
			file = new FileReference();			
			
			var lItem;
			var lName:String;
			
			var lLDObject = {};
			
			for (var i:int = 0; i < pChild.numChildren; i++) {
				lPlane = pChild.getChildAt(i) as DisplayObjectContainer;
				
				if (lPlane == null) continue;
				
				var lPlaneData: Object = {};
				lPlaneName = getQualifiedClassName(lPlane).split("_").pop();
				
				for (var j:int = 0; j < lPlane.numChildren; j++) 
				{
					lItem = lPlane.getChildAt(j);
					if (lItem is DisplayObjectContainer) {
						lName = lItem.name;
						lLDObject = {};
						lLDObject.type=getQualifiedClassName(lItem);
						lLDObject.x=lItem.x;
						lLDObject.y=lItem.y;
						lLDObject.scaleX=lItem.scaleX;
						lLDObject.scaleY=lItem.scaleY;
						lLDObject.rotation=lItem.rotation;
						lLDObject.width = lItem.width;
						lLDObject.height = lItem.height;
						
						lPlaneData[lName] = lLDObject;
					}
				}
				
				content[lPlaneName] = lPlaneData;
			}
			
			var lMeta = {};
			lMeta.width = pChild.width;
			lMeta.height = pChild.height;
			content.meta = lMeta;
			
			var lData:ByteArray = new ByteArray();
			lData.writeMultiByte(JSON.stringify(content,null,"\t"), "utf-8" );

			if (currentFrame<totalFrames) file.addEventListener(Event.COMPLETE,browse);
			
			file.save(lData, lLevel+".json" );
			
			
		}
		
	}
	
}
