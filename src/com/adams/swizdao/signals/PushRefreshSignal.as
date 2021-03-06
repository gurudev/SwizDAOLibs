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
package com.adams.swizdao.signals
{ 
	import com.adams.swizdao.model.vo.SignalVO;
	
	import org.osflash.signals.Signal;
	
	public class PushRefreshSignal extends Signal
	{ 
		/**
		 * Constructor, signal to be listened by view after server response is received
		 */
		public function PushRefreshSignal()
		{
			super(SignalVO);
		}
	}
}