package com.asinmotion.effects{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.EventDispatcher;
	import flash.display.DisplayObject;
	public class Queue extends Array implements IEventDispatcher{
		private var _delay:Number = 0;
		private var _eventDispatcher:EventDispatcher;
		public function Queue():void{
			_eventDispatcher = new EventDispatcher();
		}
		internal function runEffect(e:TimerEvent = null):void{
			if(length > 0){
				var effectObj = shift();
				var efkt = new Effect(effectObj);
				efkt.addEventListener('complete', nextEffect)
				_delay = effectObj.delay || 0;
				efkt.run();
			}else{
				dispatchEvent(new Event('complete'))
			}
		}
		internal function nextEffect(e:Event = null):void{
			var t:Timer = new Timer(_delay,1);
			t.addEventListener('timerComplete',runEffect);
			t.start();
		}
		public function addEffect(effectObj:Object):void{
			checkForStartVals(effectObj)
			push(effectObj)
		}
		public function checkForStartVals(o:Object):void{
			var target:DisplayObject = o.target;
			for(var i:String in o){
				if(i.match(/start_/)){
					var prop:String = i.replace(/start_/,'')
					if(prop.match(/scroll/)){
						target[prop.replace(/scroll/,'').toLowerCase()] = o[i]
					} else{
						target[prop] = o[i];
					}	
				}
			}
		}
		
		public function start():void{
			if(length > 0){
				runEffect();
			}
		}
		
		public function append(p:Parallel):void {
			for each(var item in p){
				push(item);
			}
		}
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void{
			_eventDispatcher.addEventListener(type,listener,useCapture, priority, useWeakReference)
		}
		public function dispatchEvent(event:Event):Boolean{
			return _eventDispatcher.dispatchEvent(event)
		}
		public function hasEventListener(type:String):Boolean{
			return _eventDispatcher.hasEventListener(type)
		}
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = true):void{
			_eventDispatcher.removeEventListener(type, listener, useCapture)
		}
		public function willTrigger(type:String):Boolean{
			return _eventDispatcher.willTrigger(type);
		}
	}
}