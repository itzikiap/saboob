package com.asinmotion.effects{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.EventDispatcher;
	import flash.display.DisplayObject;
	
	public dynamic class Parallel extends Array implements IEventDispatcher{
		private var _delay:Number = 0;
		private var _eventDispatcher:EventDispatcher;
		
		public function Parallel():void{
			_eventDispatcher = new EventDispatcher();
		}

		public function addEffect(effectObj:Object):void{
			push(new Effect(effectObj))
		}
		
		public function start():void{
			if(length > 0)forEach(setup);
		}
		public function stop():void{
			if(length > 0)forEach(stopAnimation);
		}
		
		private function setup(item:*, index:int, array:Array):void {
			item.addEventListener('complete', cleanUp)
			item.run();
		}
		private function stopAnimation(item: * , index:int, array:Array) {
			item.halt();
		}

		internal function cleanUp(e:Event):void {
			splice(indexOf(e.target),1)
			if(length == 0){
				dispatchEvent(new Event('complete'));
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
