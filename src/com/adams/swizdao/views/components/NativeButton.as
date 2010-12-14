package com.adams.swizdao.views.components
{
	import flash.events.MouseEvent;
	
	import org.osflash.signals.natives.NativeSignal;
	
	import spark.components.Button;
	
	public class NativeButton extends Button
	{
		public var clicked:NativeSignal;
		public function NativeButton()
		{
			super();
			clicked = new NativeSignal( this, MouseEvent.CLICK, MouseEvent );
		}
	}
}