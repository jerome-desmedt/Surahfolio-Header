package components
{
	import com.greensock.TweenMax;
	import com.greensock.plugins.RoundPropsPlugin;
	import com.greensock.plugins.TintPlugin;
	import com.greensock.plugins.TweenPlugin;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	

	
	[SWF(backgroundColor="0x675E6C", frameRate="40"]
	public class Header extends Sprite
	{
		public var 			dataXML			:XML;	
		private var 			btn					:HeadButton;
		
		public function Header(xml:Object):void
		{
			dataXML=new XML(xml);
			
			if(!stage)
				this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler, false, 0, true);
		}
		private function onAddedToStageHandler(event:Event=null):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStageHandler);
			
			InitMenu();
		}
		private function InitMenu():void
		{
			TweenPlugin.activate([TintPlugin]);
			TweenPlugin.activate([RoundPropsPlugin]); 
			SetButton();
		}
		private function OnMouseOverHandler(event:MouseEvent):void
		{
			if(!CheckBtnStatus(event.currentTarget))
				TweenMax.to(event.currentTarget.btn_txt, 0.4, {tint:0xEAEAEA});
		}
		private function OnMouseOutHandler(event:MouseEvent):void
		{
			if(!CheckBtnStatus(event.currentTarget))
				TweenMax.to(event.currentTarget.btn_txt, 0.4, {tint:0x969295});
		}
		private function OnClickHandler(event:MouseEvent):void
		{
			event.currentTarget.metaData.@locked='true';
			if(!CheckBtnStatus(event.currentTarget))
			{
				UnsetButton(event.currentTarget, dataXML.Header.MenuBars.Group, true);
				event.currentTarget.btn_txt.gotoAndStop("labelOn");
				event.currentTarget.btn_txt.label.text=event.currentTarget.metaData.@labelDown;
				if(event.currentTarget.metaData.@GrpTarget!='null')
					SetButton(event.currentTarget.metaData.@GrpTarget, event.currentTarget.y+30);
			}
			else
			{
				UnsetButton(event.currentTarget, dataXML.Header.MenuBars.Group);
				event.currentTarget.btn_txt.gotoAndStop("labelOff");
				event.currentTarget.btn_txt.label.text=event.currentTarget.metaData.@labelUp;
			}
			event.currentTarget.metaData.@locked='false';
		}
		private function CheckBtnStatus(btn:Object):Boolean
		{
			var btnStatus:Boolean;
			
			if((btn.btn_txt.currentLabel=="labelOff")&&(btn.btn_txt.currentLabel!=null))
				btnStatus=false;
			else if((btn.btn_txt.currentLabel=="labelOn")&&(btn.btn_txt.currentLabel!=null))
				btnStatus=true;
			
			return btnStatus;
		}
		private function SetButton(GrpNum:uint=0, yPos:uint=0, data:XML=null):void
		{
			data=dataXML.Header.MenuBars.Group[GrpNum];
			
			for(var iXML:uint=0;iXML<data.Button.length();iXML++)
			{
				btn=new HeadButton();
				
				btn.y=((iXML-1)*30)-yPos;
				btn.btn_txt.label.text=data.Button[iXML].@labelUp;
				btn.btn_txt.x=(30*data.@indent)-18;
				btn.name=data.Button[iXML];
				btn.metaData=data.Button[iXML];
				
				btn.addEventListener(MouseEvent.MOUSE_OVER, OnMouseOverHandler, false, 0, true);
				btn.addEventListener(MouseEvent.MOUSE_OUT, OnMouseOutHandler, false, 0, true);
				btn.addEventListener(MouseEvent.CLICK, OnClickHandler, false, 0, true);
				
				addChildAt(btn, 0);
				TweenMax.to(btn, 0.3, {y: ((iXML)*30)+yPos, roundProps:["y"]});
			}
		}
		private function UnsetButton(btnTarget:Object, pathXML:XMLList, btnStatus:Boolean=false):void
		{
			if(btnStatus)
			{
				for(var iBtn:int=btnTarget.metaData.parent().Button.length()-1; iBtn>=0; iBtn--)
				{
					if((getChildByName(btnTarget.metaData.parent().Button[iBtn])!=null)&&(btnTarget.metaData.parent().Button[iBtn]!=btnTarget.metaData)&&(getChildByName(btnTarget.metaData.parent().Button[iBtn]).visible))
						getChildByName(btnTarget.metaData.parent().Button[iBtn]).visible=false;	
					else if((getChildByName(btnTarget.metaData.parent().Button[iBtn])!=null)&&(btnTarget.metaData.parent().Button[iBtn]!=btnTarget.metaData))
						getChildByName(btnTarget.metaData.parent().Button[iBtn]).visible=true;	
				}
			}
			else if(!btnStatus)
			{
				if((btnTarget!=null)&&(btnTarget.metaData.@GrpTarget!='null'))
				{
					UnsetButton(btnTarget, pathXML, true);
					for(var iXML:int=pathXML[btnTarget.metaData.@GrpTarget].Button.length()-1; iXML>=0; iXML--)
						UnsetButton(getChildByName(pathXML[btnTarget.metaData.@GrpTarget].Button[iXML]), pathXML);
					while((getChildByName(btnTarget.name)!=null)&&(btnTarget.metaData.@locked!='true'))
						removeChild(getChildByName(btnTarget.name));
				}
				else if((btnTarget!=null)&&(btnTarget.metaData.@GrpTarget=='null'))
				{
					UnsetButton(btnTarget, pathXML, true);
					while((getChildByName(btnTarget.name)!=null)&&(btnTarget.metaData.@locked!='true'))
						removeChild(getChildByName(btnTarget.name));
				}
			}
		}
	}
}
