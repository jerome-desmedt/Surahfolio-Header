package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import components.Header;
	
	import settings.Config;
	
	
	[SWF(backgroundColor="0x675E6C", frameRate="40", width="1280", height="120")]
	public class Preloader extends Sprite
	{
		private var URL:URLLoader;
		
		public function Preloader():void
		{
			initStage();
			
			(URL=new URLLoader()).load(new URLRequest(Config.XML_FILE));
			URL.addEventListener(Event.COMPLETE, onLoadCompleteHandler, false, 0, true);
		}
		private function initStage():void
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.addEventListener(Event.RESIZE, onStageResizeHandler, false, 0, true);
		}
		private function launchSite():void
		{
			
		}
		private function onLoadCompleteHandler(event:Event):void
		{
			/*URL.removeEventListener(ProgressEvent.PROGRESS, onSiteLoadProgressHandler);
			URL.removeEventListener(IOErrorEvent.IO_ERROR, onSiteLoadErrorHandler);
			URL.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSiteLoadErrorHandler);*/
			URL.removeEventListener(Event.COMPLETE, onLoadCompleteHandler);
			
			launchSite();
			
			Config.DATA_XML=new XML(event.target.data);
			addChild(new Header(event.target.data));
		}
		private function onStageResizeHandler(event:Event=null):void
		{
			
		}
	}
}