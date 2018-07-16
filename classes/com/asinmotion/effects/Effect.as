package com.asinmotion.effects{
	import flash.display.DisplayObject;
	import com.asinmotion.easing.*;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;
	
	public class Effect extends EventDispatcher{
		private var _easing:Function = Linear.easeNone;
		private var _duration:Number = 1000;
		private var _startVals:Object = {};
		private var _endVals:Object = {};
		private var _changeVals:Object = {};
		private var _target:DisplayObject;
		private var _delay:Number;
		private var _iterations:Number;
		private var _tweenTimer:Timer;
		
		public function Effect(o:Object = null):void{
			if(o)make(o);
		}
		//*****
		//private functions
		//*****
		function update(e:TimerEvent):void{
			dispatchEvent(new Event('update'))
			render(e.target.currentCount)
		}
		
		//*****
		//public functions
		//******
		function render(timePos:Number):void{
			for(var i:String in _endVals){
				var newVal:Number =_easing(timePos,_startVals[i],_changeVals[i],_iterations)
				if(_target.hasOwnProperty(i)){
					_target[i] = newVal;
				}else{
					if(i.match(/scroll/)){
						var prop:String = i.replace(/scroll/,'').toLowerCase();
						var modRect:Rectangle = _target.scrollRect;
						modRect[prop] = newVal;
						_target.scrollRect = modRect;
						trace(_target.scrollRect)
					}
				}
			}
			dispatchEvent(new Event('render'))
		}
		
  		function finished(e:TimerEvent):void{
			for(var i:String in _endVals){
				if(_target.hasOwnProperty(i)){
					if(i.match(/scroll/)){
						_target.scrollRect[i..replace(/scroll/,'').toLowerCase()] = _endVals[i];
					} else {
						_target[i] = _endVals[i];
					}
				}
			}
			dispatchEvent(new Event('complete'))
  		}
  		function addChangeProps():void{
  			for(var i:String in _endVals){
  				_changeVals[i] = _endVals[i] - _startVals[i];
  			}
  		}
  		function addStartProp(s:String, n:Number):void{
  			var prop:String = s.replace(/start_/,'');
  			if(s.match(/scroll/)){
  				var scrollProp:String = prop.replace(/scroll/,'').toLowerCase();
  				if(_target.scrollRect){
  					if(_target.scrollRect[scrollProp]!=n)_target.scrollRect[scrollProp]=n;
  				}else{
  					var rect:Rectangle = new Rectangle(0,0,_target.width,_target.height);
  					rect[scrollProp] = n;
  					_target.scrollRect = rect;
  				}
  				_startVals[prop] = _target.scrollRect[scrollProp];
  			} else {
  				_startVals[prop] = n;
  				if(_target[prop]!=n)_target[prop]=n;
  			}

  		}

  		function addEndProp(s:String, n:Number):void{
  			var prop:String = s.replace(/end_/,'')||s;
  			if(s.match(/scroll/)){
  				_endVals[prop] = n;
  			} else {
  				_endVals[prop] = n;
  				if(!_startVals.hasOwnProperty(prop))addStartProp(prop,_target[prop]);
  			}
  		}

  		function make(o:Object):void{
  			target = o.target;
			_easing = o.ease||Linear.easeNone;
			duration = o.time||1000;
			o.setPropertyIsEnumerable("target",false);
			o.setPropertyIsEnumerable("ease",false);
			o.setPropertyIsEnumerable("time",false);
			for(var i:String in o){
				if(i.match(/start_/)){
					addStartProp(i,o[i])
				}else if (i.match(/end_/)||_target.hasOwnProperty(i)){
					addEndProp(i,o[i])
				}
			}
  		}

  		public function run():void{
  			addChangeProps();
	  		_tweenTimer= new Timer(_delay,_iterations);
	  		_tweenTimer.addEventListener('timer',update)
	  		_tweenTimer.addEventListener('timerComplete',finished)
	  		_tweenTimer.start();
  		}
		/**
		 * by Itzik Arzoni
		 */
  		public function halt():void{
  			addChangeProps();
			if (_tweenTimer != null) {
				_tweenTimer.removeEventListener('timerComplete',finished);
				_tweenTimer.removeEventListener('timer',update);
				_tweenTimer.stop();
			}
  		}

		public function set ease(f:Function):void{
  			 _easing = f;
  		}

  		public function set duration(n:Number):void{
  			 _duration = n;
  			 if(_delay){_iterations = _duration/_delay;}
  		}

  		public function set target(d:DisplayObject):void{
  			_target = d;
  			_delay = 1000/_target.stage.frameRate;
  			if(_delay){_iterations = _duration/_delay;}
  		}


	}
}
