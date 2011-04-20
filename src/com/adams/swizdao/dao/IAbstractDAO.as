package com.adams.swizdao.dao
{
	import com.adams.swizdao.model.processor.IVOProcessor;
	import com.adams.swizdao.model.collections.ICollection;
	
	[Bindable]
	public interface IAbstractDAO
	{
		 function get destination():String 
		 function set destination( str:String ):void 
		 function get daoName():String
		 function set daoName(value:String):void
		 function get processor():IVOProcessor
		 function set processor(value:IVOProcessor):void
		 function get collection():ICollection 
		 function set collection(v:ICollection):void 
		 function get voClazz():Class 
		 function set voClazz(v:Class):void 
	}
}