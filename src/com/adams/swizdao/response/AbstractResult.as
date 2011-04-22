/*
* Copyright 2010 @nsdevaraj
* 
* Licensed under the Apache License, Version 2.0 (the "License"); you may not
* use this file except in compliance with the License. You may obtain a copy of
* the License. You may obtain a copy of the License at
* 
* http://www.apache.org/licenses/LICENSE-2.0
* 
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
* WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
* License for the specific language governing permissions and limitations under
* the License.
*/
package com.adams.swizdao.response
{
	import com.adams.swizdao.model.collections.ICollection;
	import com.adams.swizdao.model.processor.IVOProcessor;
	import com.adams.swizdao.model.vo.CurrentInstance;
	import com.adams.swizdao.model.vo.IValueObject;
	import com.adams.swizdao.model.vo.SignalVO;
	import com.adams.swizdao.signals.AbstractSignal;
	import com.adams.swizdao.signals.PushRefreshSignal;
	import com.adams.swizdao.signals.ResultSignal;
	import com.adams.swizdao.util.Action;
	import com.adams.swizdao.util.GetVOUtil;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	import mx.collections.IList;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.swizframework.controller.AbstractController;
	import org.swizframework.utils.services.ServiceHelper;
	
	public class AbstractResult extends AbstractController
	{
		
		[Inject]
		public var service:ServiceHelper;
		
		[Inject]
		public var serviceSignal:AbstractSignal;
		
		[Inject]
		public var resultSignal:ResultSignal;
		
		[Inject]
		public var pushRefreshSignal:PushRefreshSignal;
		
		[Inject]
		public var signalSeq:SignalSequence;
		
		[Inject]
		public var currentInstance:CurrentInstance; 
		
		public function AbstractResult()
		{
		} 
		
		private var _token:AsyncToken = new AsyncToken();
		public function get token():AsyncToken {
			return _token;
		}
		/** <p>
		 * delegate for global service response assigned with Global result and fault handler
		 * </p>
		 */
		public function set token( value:AsyncToken ):void {
			_token = value; 
			service.executeServiceCall( _token, resultHandler, faultHandler, [ serviceSignal ] );
		} 
		
		/** The resultSignal is dispatched to intimate about the Server process is complete.
		 * So, further View updates can take place. Also, local parent set mappings of persistent object
		 * can be done to map with Backend
		 * <p>
		 * Handler function, globally manage the server responses.
		 * the SignalSequence is invoked onSignalDone(), to proceed with next queued signals.
		 * </p>
		 */
		protected var resultObj:Object
		protected function resultHandler( rpcevt:ResultEvent, prevSignal:AbstractSignal = null ):void { 
			var currentVO:IValueObject;
			resultObj = rpcevt.result;
			
			if( resultObj is ArrayCollection ) {
				if( ArrayCollection( resultObj ).length != 0 ) {
					currentVO = ArrayCollection( resultObj ).getItemAt( 0 ) as IValueObject;	
				}
			}
			else {
				currentVO = resultObj as IValueObject;
			}
			var processedArr:Array =[]
			if(Action.PAGINGACTIONS.indexOf( prevSignal.currentSignal.action ) ==-1) {
				var outCollection:ICollection = updateCollection( prevSignal.currentCollection, prevSignal.currentSignal, resultObj );
				if( prevSignal.currentProcessor ) {
					processVO( prevSignal.currentProcessor, outCollection );
					var pkArr:Array =[]
					for each(var valueObject:Object in resultObj){
						pkArr.push(valueObject[prevSignal.currentSignal.destination])
					}
					for each(var pKey:int in pkArr){
						processedArr.push(GetVOUtil.getVOObject(pKey, prevSignal.currentSignal.collection.items, prevSignal.currentSignal.destination, prevSignal.currentSignal.clazz ))
					}
				} 
				prevSignal.currentSignal.currentProcessedCollection = new ArrayCollection( processedArr);
			}  
		} 
		
		/** <p>
		 * if Processor exists, for every VO the processor will be used to do the server mappings
		 * in client side. The mappings like one-one, one-many, many-one and many-many
		 * </p>
		 */
		public function processVO( process:IVOProcessor, collection:ICollection ):void {
			process.processCollection( collection.items );
		}
		
		/** <p>
		 * modifies the particular VO's Persistent Collection Object with the received server response.
		 * </p>
		 */
		public function updateCollection( collection:ICollection, currentSignal:SignalVO, resultObj:Object ):ICollection {
			switch( currentSignal.action ) {
				case Action.CREATE:
					collection.addItem( resultObj );
					break;
				case Action.UPDATE:
				case Action.DIRECTUPDATE:
					collection.updateItem( currentSignal.valueObject, resultObj );
					break;
				case Action.READ:
				case Action.FINDBY_NAME: 
				case Action.FIND_ID: 
				case Action.FINDBY_ID:  
				case Action.FINDPUSH_ID:
					collection.modifyItems( resultObj as ArrayCollection );
					break;
				case Action.DELETE:
					ArrayCollection( collection.items ).refresh();
					collection.removeItem( currentSignal.valueObject );
					break;
				case Action.GET_COUNT:
					//collection.length = resultObj as int;
					break;
				case Action.GET_LIST:
					collection.updateItems( resultObj as ArrayCollection );
					break;
				case Action.BULK_UPDATE:
				case Action.FINDTASKSLIST:
					collection.modifyItems( resultObj as ArrayCollection );
					break;
				case Action.DELETE_ALL:
					collection.removeAll();
					break;
				case Action.SQL_FINDALL:
					break;
				default:
					break;	
			}
			return collection;
		}  
		/** <p>
		 * Global fault handler for server response.
		 * </p>
		 */
		private function faultHandler( event:FaultEvent ):void {
			trace( serviceSignal.currentSignal.action + ' ' + serviceSignal.currentSignal.destination + ' failed ' + event );
			signalSeq.onSignalDone();
		}
	}
}