package com.adams.swizdao.dao
{
	import com.adams.swizdao.controller.ServiceController;
	import com.adams.swizdao.model.collections.AbstractCollection;
	import com.adams.swizdao.model.collections.ICollection;
	import com.adams.swizdao.model.processor.IVOProcessor;
	import com.adams.swizdao.model.vo.SignalVO;
	import com.adams.swizdao.response.AbstractResult;
	import com.adams.swizdao.response.SignalSequence;
	import com.adams.swizdao.util.Action;
	import com.adams.swizdao.util.ArrayUtil;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.remoting.mxml.RemoteObject;

	public class PagingDAO implements IAbstractDAO
	{
		
		[Inject]
		public var signalSeq:SignalSequence;
		
		[Inject]
		public var delegate:AbstractResult;
		
		public function PagingDAO()
		{
		}
		private var _daoName:String;
		public function get daoName():String
		{
			return _daoName;
		}
		
		public function set daoName(value:String):void
		{
			_daoName = value;
		}
		private var _processor:IVOProcessor;
		protected var _collection:ICollection;
		public function get processor():IVOProcessor
		{
			return _processor;
		}
		
		public function set processor(value:IVOProcessor):void
		{
			_processor = value;
		}
		public function get collection():ICollection {
			return _collection;
		}
		
		public function set collection(v:ICollection):void {
			_collection=v;
		}
		
		protected var _destination:String = ArrayUtil.PAGINGDAO;  
		public function get destination():String {
			return _destination;
		}
		
		public function set destination( str:String ):void {
			_destination = str;
		}
		/**
		 * <p>
		 * The destination of remote service is set accordingly
		 * </p>
		 */		
		public function invoke():void{
			remoteService.destination = destination;
		}
		
		[MediateSignal(type="AbstractSignal")]
		public function invokeAction( obj:SignalVO ):AsyncToken {
			invoke();
			if( obj.destination == this.destination ) {
				switch( obj.action ) {
					case Action.GETQUERYRESULT:
						delegate.token = remoteService.getQueryResult(obj.name) ;
						return delegate.token;
						break;
					case Action.PAGINATIONLISTVIEW:
						delegate.token = remoteService.paginationListView(obj.name,obj.startIndex,obj.endIndex) ;
						return delegate.token;
						break;
					case Action.QUERYLISTVIEW:
						delegate.token = remoteService.queryListView(obj.name) ;
						return delegate.token;
						break;
					case Action.PAGINATIONLISTVIEWID:
						delegate.token = remoteService.paginationListViewId(obj.name, obj.id, obj.startIndex,obj.endIndex) ;
						return delegate.token;
						break;
					case Action.QUERYPAGINATION:	
						delegate.token = remoteService.queryPagination(obj.name,obj.startIndex, obj.endIndex);
						return delegate.token;
						break;
					case Action.REFRESHTWEETS:
						delegate.token = remoteService.refreshTweets(obj.id) ;//void
						return delegate.token;
						break;
					case Action.UPDATETWEET:
						delegate.token = remoteService.updateTweet(obj.name, obj.id) ;//string
						delegate.token = remoteService.push(obj.name) ;//string
						return delegate.token;
						break;
					case Action.SENDMAIL:
						remoteService = _controlService.unAuthRo;
						remoteService.destination = ArrayUtil.UNSECUREDAO;
						delegate.token = remoteService.SmtpSSLMail(obj.emailId, obj.name, obj.emailBody);
						secureDAO();
						return delegate.token;
						break;
					case Action.CREATEPERSON:
						remoteService = _controlService.unAuthRo;
						remoteService.destination = ArrayUtil.UNSECUREPERSONDAO;
						delegate.token = remoteService.create( obj.valueObject );
						secureDAO();
						return delegate.token;
						break;
				}
			}
			return null;
		}
		public function secureDAO():void{
			remoteService.destination = ArrayUtil.PAGINGDAO;
			remoteService = _controlService.authRo;
		}
		protected var _remoteService:RemoteObject;  
		public function get remoteService():RemoteObject  {
			return _remoteService;
		}
		
		public function set remoteService( ro:RemoteObject ):void {
			_remoteService = ro; 
		}
		
		protected var _controlService:ServiceController;  
		public function get controlService():ServiceController  {
			return _controlService;
		}
		[Inject]
		public function set controlService( ro:ServiceController ):void {
			_controlService = ro; 
			remoteService = _controlService.authRo;
		}
	}
}