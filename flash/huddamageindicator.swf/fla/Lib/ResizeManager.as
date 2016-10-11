class Lib.ResizeManager
{
   var ScalingFactors = new Array();
   var ReferencePositions = new Array();
   var ScreenWidth = -1;
   var ScreenHeight = -1;
   var ScreenX = -1;
   var ScreenY = -1;
   var Listeners = new Array();
   static var ALIGN_NONE = 0;
   static var ALIGN_LEFT = 0;
   static var ALIGN_RIGHT = 1;
   static var ALIGN_TOP = 0;
   static var ALIGN_BOTTOM = 1;
   static var ALIGN_CENTER = 0.5;
   static var POSITION_LEFT = 0;
   static var POSITION_SAFE_LEFT = 0.075;
   static var POSITION_RIGHT = 1;
   static var POSITION_SAFE_RIGHT = 0.925;
   static var POSITION_TOP = 0;
   static var POSITION_SAFE_TOP = 0.075;
   static var POSITION_BOTTOM = 1;
   static var POSITION_SAFE_BOTTOM = 0.925;
   static var POSITION_CENTER = 0.5;
   static var REFERENCE_LEFT = 0;
   static var REFERENCE_TOP = 1;
   static var REFERENCE_SAFE_LEFT = 2;
   static var REFERENCE_SAFE_TOP = 3;
   static var REFERENCE_RIGHT = 4;
   static var REFERENCE_BOTTOM = 5;
   static var REFERENCE_SAFE_RIGHT = 6;
   static var REFERENCE_SAFE_BOTTOM = 7;
   static var REFERENCE_CENTER_X = 8;
   static var REFERENCE_CENTER_Y = 9;
   static var SCALE_NONE = 0;
   static var SCALE_BIGGEST = 1;
   static var SCALE_SMALLEST = 2;
   static var SCALE_USING_VERTICAL = 3;
   static var SCALE_USING_HORIZONTAL = 4;
   static var PC_BORDER_SIZE = 10;
   function ResizeManager()
   {
      var _loc2_ = 0;
      while(_loc2_ <= Lib.ResizeManager.SCALE_USING_HORIZONTAL)
      {
         this.ScalingFactors.push(1);
         _loc2_ = _loc2_ + 1;
      }
      _loc2_ = 0;
      while(_loc2_ <= Lib.ResizeManager.REFERENCE_CENTER_Y)
      {
         this.ReferencePositions.push(0);
         _loc2_ = _loc2_ + 1;
      }
   }
   function UpdateReferencePositions()
   {
      this.ReferencePositions[Lib.ResizeManager.REFERENCE_LEFT] = this.ScreenX;
      this.ReferencePositions[Lib.ResizeManager.REFERENCE_RIGHT] = this.ScreenX + this.ScreenWidth;
      this.ReferencePositions[Lib.ResizeManager.REFERENCE_TOP] = this.ScreenY;
      this.ReferencePositions[Lib.ResizeManager.REFERENCE_BOTTOM] = this.ScreenY + this.ScreenHeight;
      this.ReferencePositions[Lib.ResizeManager.REFERENCE_CENTER_X] = Math.floor((this.ReferencePositions[Lib.ResizeManager.REFERENCE_LEFT] + this.ReferencePositions[Lib.ResizeManager.REFERENCE_RIGHT]) / 2);
      this.ReferencePositions[Lib.ResizeManager.REFERENCE_CENTER_Y] = Math.floor((this.ReferencePositions[Lib.ResizeManager.REFERENCE_TOP] + this.ReferencePositions[Lib.ResizeManager.REFERENCE_BOTTOM]) / 2);
      if(_global.IsPC != undefined && _global.IsPC())
      {
         this.ReferencePositions[Lib.ResizeManager.REFERENCE_SAFE_LEFT] = this.ReferencePositions[Lib.ResizeManager.REFERENCE_LEFT] + Lib.ResizeManager.PC_BORDER_SIZE;
         this.ReferencePositions[Lib.ResizeManager.REFERENCE_SAFE_TOP] = this.ReferencePositions[Lib.ResizeManager.REFERENCE_TOP] + Lib.ResizeManager.PC_BORDER_SIZE;
         this.ReferencePositions[Lib.ResizeManager.REFERENCE_SAFE_RIGHT] = this.ReferencePositions[Lib.ResizeManager.REFERENCE_RIGHT] - Lib.ResizeManager.PC_BORDER_SIZE;
         this.ReferencePositions[Lib.ResizeManager.REFERENCE_SAFE_BOTTOM] = this.ReferencePositions[Lib.ResizeManager.REFERENCE_BOTTOM] - Lib.ResizeManager.PC_BORDER_SIZE;
      }
      else
      {
         this.ReferencePositions[Lib.ResizeManager.REFERENCE_SAFE_LEFT] = this.ScreenX + Math.ceil(Lib.ResizeManager.POSITION_SAFE_LEFT * this.ScreenWidth);
         this.ReferencePositions[Lib.ResizeManager.REFERENCE_SAFE_TOP] = this.ScreenY + Math.ceil(Lib.ResizeManager.POSITION_SAFE_TOP * this.ScreenHeight);
         this.ReferencePositions[Lib.ResizeManager.REFERENCE_SAFE_RIGHT] = this.ScreenX + Math.floor(Lib.ResizeManager.POSITION_SAFE_RIGHT * this.ScreenWidth);
         this.ReferencePositions[Lib.ResizeManager.REFERENCE_SAFE_BOTTOM] = this.ScreenY + Math.floor(Lib.ResizeManager.POSITION_SAFE_BOTTOM * this.ScreenHeight);
      }
   }
   function SetScaling(obj, scaling)
   {
      if(obj.originalWidth == null)
      {
         obj.originalWidth = obj._width;
         obj.originalHeight = obj._height;
      }
      scaling = this.ScalingFactors[scaling];
      obj._width = Math.ceil(obj.originalWidth * scaling);
      obj._height = Math.ceil(obj.originalHeight * scaling);
   }
   function GetPctPosition(position, anchor, rectDim, stageDim)
   {
      return Math.floor(stageDim * position - rectDim * anchor);
   }
   function ResetPosition(obj, scaling, positiony, positionx, anchory, anchorx)
   {
      this.SetScaling(obj,scaling);
      var _loc4_ = this.GetPctPosition(positionx,anchorx,obj._width,this.ScreenWidth);
      var _loc3_ = this.GetPctPosition(positiony,anchory,obj._height,this.ScreenHeight);
      obj._x = this.ScreenX + _loc4_;
      obj._y = this.ScreenY + _loc3_;
   }
   function GetPixelPosition(screenReference, screenOffset, elementAlignment, elementSize)
   {
      return Math.floor(this.ReferencePositions[screenReference] + screenOffset - elementSize * elementAlignment);
   }
   function ResetPositionByPixel(obj, scaling, xScreenReference, xScreenOffset, xElementAlign, yScreenReference, yScreenOffset, yElementAlign)
   {
      this.SetScaling(obj,scaling);
      obj._x = this.GetPixelPosition(xScreenReference,xScreenOffset * this.ScalingFactors[scaling],xElementAlign,obj._width);
      obj._y = this.GetPixelPosition(yScreenReference,yScreenOffset * this.ScalingFactors[scaling],yElementAlign,obj._height);
   }
   function ResetPositionByPercentage(obj, scaling, xScreenReference, xScreenOffset, xElementAlign, yScreenReference, yScreenOffset, yElementAlign)
   {
      this.SetScaling(obj,scaling);
      obj._x = this.GetPixelPosition(xScreenReference,xScreenOffset * this.ScreenWidth,xElementAlign,obj._width);
      obj._y = this.GetPixelPosition(yScreenReference,yScreenOffset * this.ScreenHeight,yElementAlign,obj._height);
   }
   function onResize()
   {
      var _loc5_ = Stage.visibleRect;
      if(_loc5_ == null)
      {
         this.ScreenWidth = Stage.width;
         this.ScreenHeight = Stage.height;
         this.ScreenX = 0;
         this.ScreenY = 0;
      }
      else
      {
         var _loc6_ = false;
         var _loc9_ = Math.floor(_loc5_.left);
         var _loc7_ = Math.floor(_loc5_.top);
         var _loc12_ = Math.ceil(_loc5_.width);
         var _loc11_ = Math.ceil(_loc5_.height);
         if(this.ScreenWidth != _loc12_)
         {
            this.ScreenWidth = _loc12_;
            this.ScreenHeight = _loc11_;
            this.ScreenX = _loc9_;
            this.ScreenY = _loc7_;
            _loc6_ = true;
         }
         else if(this.ScreenHeight != _loc11_)
         {
            this.ScreenHeight = _loc11_;
            this.ScreenX = _loc9_;
            this.ScreenY = _loc7_;
            _loc6_ = true;
         }
         else if(this.ScreenX != _loc9_)
         {
            this.ScreenX = _loc9_;
            this.ScreenY = _loc7_;
            _loc6_ = true;
         }
         else if(this.ScreenY != _loc7_)
         {
            this.ScreenY = _loc7_;
            _loc6_ = true;
         }
         if(!_loc6_)
         {
            return undefined;
         }
      }
      var _loc8_ = this.ScreenWidth / this.AuthoredWidth;
      var _loc10_ = this.ScreenHeight / this.AuthoredHeight;
      if(_loc8_ >= _loc10_)
      {
         this.ScalingFactors[Lib.ResizeManager.SCALE_BIGGEST] = _loc8_;
         this.ScalingFactors[Lib.ResizeManager.SCALE_SMALLEST] = _loc10_;
      }
      else
      {
         this.ScalingFactors[Lib.ResizeManager.SCALE_BIGGEST] = _loc10_;
         this.ScalingFactors[Lib.ResizeManager.SCALE_SMALLEST] = _loc8_;
      }
      this.ScalingFactors[Lib.ResizeManager.SCALE_USING_VERTICAL] = _loc10_;
      this.ScalingFactors[Lib.ResizeManager.SCALE_USING_HORIZONTAL] = _loc8_;
      this.UpdateReferencePositions();
      var _loc4_ = this.Listeners.length;
      var _loc3_ = undefined;
      var _loc2_ = 0;
      while(_loc2_ < _loc4_)
      {
         _loc3_ = this.Listeners[_loc2_];
         if(_loc3_.onResize != undefined)
         {
            this.Listeners[_loc2_].onResize(this);
         }
         _loc2_ = _loc2_ + 1;
      }
   }
   function GetListenerIndex(listener, l)
   {
      var _loc2_ = 0;
      if(l == -1)
      {
         l = this.Listeners.length - 1;
      }
      while(_loc2_ <= l)
      {
         if(this.Listeners[_loc2_] == listener)
         {
            return _loc2_;
         }
         _loc2_ = _loc2_ + 1;
      }
      return -1;
   }
   function AddListener(listener)
   {
      if(this.GetListenerIndex(listener,-1) == -1)
      {
         this.Listeners.push(listener);
         listener.onResize(this);
      }
   }
   function RemoveListener(listener)
   {
      var _loc3_ = this.Listeners.length - 1;
      var _loc2_ = this.GetListenerIndex(listener,_loc3_);
      if(_loc2_ == -1)
      {
         return undefined;
      }
      if(_loc2_ == _loc3_)
      {
         this.Listeners.length = _loc3_;
      }
      else if(_loc2_ == 0)
      {
         this.Listeners.shift();
      }
      else
      {
         this.Listeners = this.Listeners.slice(0,_loc2_).concat(this.Listeners.slice(_loc2_ + 1,_loc3_ + 1));
      }
   }
   function Remove()
   {
      this.Listeners.length = 0;
      Stage.removeListener(this);
      _global.resizeManager = null;
   }
   static function Init()
   {
      if(_global.resizeManager == null)
      {
         var _loc2_ = new Lib.ResizeManager();
         var _loc3_ = Stage.originalRect;
         if(_loc3_ != null)
         {
            _loc2_.AuthoredWidth = _loc3_.width;
            _loc2_.AuthoredHeight = _loc3_.height;
         }
         else
         {
            _loc2_.AuthoredWidth = Stage.width;
            _loc2_.AuthoredHeight = Stage.height;
         }
         _loc2_.onResize();
         Stage.addListener(_loc2_);
         _global.resizeManager = _loc2_;
      }
   }
}
