package com.adams.swizdao.views.components
{
	
	import mx.controls.DataGrid;
	
	import org.osflash.signals.Signal;
	
	public class NativeDatagrid extends DataGrid
	{
		public var renderSignal:Signal = new Signal();
		public var selectedSprint:Object;
		
		public function NativeDatagrid()
		{
			super();
		}
	}
}