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
package com.adams.swizdao.util
{
	public final class Action
	{
		public static const CREATE:String = 'create';
		public static const UPDATE:String = 'update';
		public static const READ:String = 'Read';
		public static const FIND_ID:String = 'findId';
		public static const FINDBY_NAME:String = 'findByName';
		public static const FINDBY_ID:String = 'findById';
		public static const FINDPUSH_ID:String = 'FindPushId';
		public static const DELETE:String = 'deleteById';
		public static const GET_COUNT:String = 'count';
		public static const GET_LIST:String = 'getList';
		public static const SQL_FINDALL:String = 'SQLFindAll';
		public static const BULK_UPDATE:String = 'bulkUpdate';
		public static const DELETE_ALL:String = 'deleteAll';
		public static const PUSH_MSG:String = 'PushMsg';
		public static const RECEIVE_MSG:String = 'receiveMsg';
		
		public static const PAGINATIONQUERY:String = 'findPersonsListOracle';
		public static const GETQUERYRESULT:String = 'getQueryResult';
		public static const PAGINATIONLISTVIEW:String = 'paginationListView';
		public static const QUERYLISTVIEW:String = 'queryListView';
		public static const PAGINATIONLISTVIEWID:String = 'paginationListViewId';
		public static const QUERYPAGINATION:String = 'queryPagination';
		public static const GETLOGINLISTRESULT:String = 'getLoginListResult';
		public static const CREATEPROJECT:String = 'createOracleNewProject';
		public static const CREATENAVTASK:String = 'createNavigationTasks';
		public static const GETPROJECTSLIST:String = 'findPersonsListCount';
		
		public static const UPDATETWEET:String = 'updateTweet';
		public static const SENDMAIL:String = 'sendMail';
		public static const CREATEPERSON:String = 'createPerson';
		public static const PAGINGACTIONS:Array = [GETQUERYRESULT,PAGINATIONLISTVIEW,QUERYLISTVIEW,PAGINATIONLISTVIEWID,QUERYPAGINATION,GETLOGINLISTRESULT,UPDATETWEET,SENDMAIL,CREATEPERSON];
		public function Action()
		{
		}
	}
}