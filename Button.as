package components
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Button extends Sprite
	{	
		private var dataXML:XMLList;
		
		public function Button(superData:XMLList):void
		{
			if(stage)
				onAddedToStageHandler(null);
			else
			{
				this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler, false, 0, true);
				dataXML=superData;
			}
		}
		private function onAddedToStageHandler(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler);
			
			stage.addEventListener(Event.RESIZE, OnStageResizeHandler, false, 0, true);
			OnStageResizeHandler(null);
			
			InitButton();
		}
		private function InitButton(GrpNum:uint=0, yPos:uint=0):void
		{
			
		}
		
		private function OnStageResizeHandler(e:Event=null):void
		{
			if(stage)
				btn_bg.width=stage.stageWidth;
		}
	}	
}
