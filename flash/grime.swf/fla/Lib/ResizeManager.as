class Lib.ResizeManager
{
   var ScalingFactors = new Array();
   var ReferencePositions = new Array();
   var ScreenWidth = -1;
   var ScreenHeight = -1;
   var ScreenX = -1;
   var ScreenY = -1;
   var DisableAdditionalScaling = false;
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
   function getSafezone(name)
   {
      var _loc2_ = 0.85;
      if(_global.GameInterface)
      {
         _loc2_ = _global.GameInterface.GetConvarNumber(name);
      }
      if(_loc2_ == null || _loc2_ == undefined)
      {
         _loc2_ = 0.85;
      }
      if(_loc2_ <= 0.1)
      {
         _loc2_ = 0.1;
      }
      else if(_loc2_ > 1)
      {
         _loc2_ = 1;
      }
      return _loc2_;
   }
   function UpdateReferencePositions()
   {
      var _loc3_ = this.getSafezone("safezonex");
      var _loc4_ = this.getSafezone("safezoney");
      if(_global.GameInterface)
      {
         this.AdditionalScaling = _global.GameInterface.GetConvarNumber("hud_scaling");
      }
      Lib.ResizeManager.POSITION_SAFE_LEFT = (1 - _loc3_) / 2;
      Lib.ResizeManager.POSITION_SAFE_RIGHT = Lib.ResizeManager.POSITION_SAFE_LEFT + _loc3_;
      Lib.ResizeManager.POSITION_SAFE_TOP = (1 - _loc4_) / 2;
      Lib.ResizeManager.POSITION_SAFE_BOTTOM = Lib.ResizeManager.POSITION_SAFE_TOP + _loc4_;
      this.ReferencePositions[Lib.ResizeManager.REFERENCE_LEFT] = this.ScreenX;
      this.ReferencePositions[Lib.ResizeManager.REFERENCE_RIGHT] = this.ScreenX + this.ScreenWidth;
      this.ReferencePositions[Lib.ResizeManager.REFERENCE_TOP] = this.ScreenY;
      this.ReferencePositions[Lib.ResizeManager.REFERENCE_BOTTOM] = this.ScreenY + this.ScreenHeight;
      this.ReferencePositions[Lib.ResizeManager.REFERENCE_CENTER_X] = Math.floor((this.ReferencePositions[Lib.ResizeManager.REFERENCE_LEFT] + this.ReferencePositions[Lib.ResizeManager.REFERENCE_RIGHT]) / 2);
      this.ReferencePositions[Lib.ResizeManager.REFERENCE_CENTER_Y] = Math.floor((this.ReferencePositions[Lib.ResizeManager.REFERENCE_TOP] + this.ReferencePositions[Lib.ResizeManager.REFERENCE_BOTTOM]) / 2);
      this.ReferencePositions[Lib.ResizeManager.REFERENCE_SAFE_LEFT] = this.ScreenX + Math.ceil(Lib.ResizeManager.POSITION_SAFE_LEFT * this.ScreenWidth);
      this.ReferencePositions[Lib.ResizeManager.REFERENCE_SAFE_TOP] = this.ScreenY + Math.ceil(Lib.ResizeManager.POSITION_SAFE_TOP * this.ScreenHeight);
      this.ReferencePositions[Lib.ResizeManager.REFERENCE_SAFE_RIGHT] = this.ScreenX + Math.floor(Lib.ResizeManager.POSITION_SAFE_RIGHT * this.ScreenWidth);
      this.ReferencePositions[Lib.ResizeManager.REFERENCE_SAFE_BOTTOM] = this.ScreenY + Math.floor(Lib.ResizeManager.POSITION_SAFE_BOTTOM * this.ScreenHeight);
   }
   function GetScalingValue(index, disableAdditionalScaling)
   {
      if(disableAdditionalScaling == null || disableAdditionalScaling == undefined)
      {
         disableAdditionalScaling = this.DisableAdditionalScaling;
      }
      if(this.ApplyAdditionalScaling && !disableAdditionalScaling)
      {
         return this.ScalingFactors[index] * this.AdditionalScaling;
      }
      return this.ScalingFactors[index];
   }
   function SetXYScaling(obj, scalingX, disableAdditionalScalingX, scalingY, disableAdditionalScalingY)
   {
      if(obj.originalWidth == null)
      {
         obj.originalWidth = obj._width;
         obj.originalHeight = obj._height;
      }
      var _loc3_ = this.GetScalingValue(scalingX,disableAdditionalScalingX);
      var _loc4_ = this.GetScalingValue(scalingY,disableAdditionalScalingY);
      obj.scaledWidth = Math.ceil(obj.originalWidth * _loc3_);
      obj.scaledHeight = Math.ceil(obj.originalHeight * _loc4_);
      return {x:_loc3_,y:_loc4_};
   }
   function SetScaling(obj, scaling)
   {
      if(obj.originalWidth == null)
      {
         obj.originalWidth = obj._width;
         obj.originalHeight = obj._height;
      }
      scaling = this.GetScalingValue(scaling);
      obj.scaledWidth = Math.ceil(obj.originalWidth * scaling);
      obj.scaledHeight = Math.ceil(obj.originalHeight * scaling);
      return scaling;
   }
   function SetMatrixXY(obj, x, y, scaleX, scaleY)
   {
      var _loc2_ = new flash.geom.Matrix(scaleX,0,0,scaleY,x,y);
      obj.transform.matrix = _loc2_;
      obj._width = Math.ceil(obj._width);
      obj._height = Math.ceil(obj._height);
   }
   function SetMatrix(obj, x, y, scale)
   {
      var _loc2_ = new flash.geom.Matrix(scale,0,0,scale,x,y);
      obj.transform.matrix = _loc2_;
      obj._width = Math.ceil(obj._width);
      obj._height = Math.ceil(obj._height);
   }
   function GetPctPosition(position, anchor, rectDim, stageDim)
   {
      return Math.floor(stageDim * position - rectDim * anchor);
   }
   function ResetPosition(obj, scaling, positiony, positionx, anchory, anchorx)
   {
      var _loc3_ = this.SetScaling(obj,scaling);
      var _loc5_ = this.GetPctPosition(positionx,anchorx,obj.scaledWidth,this.ScreenWidth);
      var _loc4_ = this.GetPctPosition(positiony,anchory,obj.scaledHeight,this.ScreenHeight);
      this.SetMatrix(obj,this.ScreenX + _loc5_,this.ScreenY + _loc4_,_loc3_);
   }
   function GetPixelPosition(screenReference, screenOffset, elementAlignment, elementSize)
   {
      return Math.floor(this.ReferencePositions[screenReference] + screenOffset - elementSize * elementAlignment);
   }
   function ResetPositionByPixel(obj, scaling, xScreenReference, xScreenOffset, xElementAlign, yScreenReference, yScreenOffset, yElementAlign)
   {
      var _loc3_ = this.SetScaling(obj,scaling);
      var _loc5_ = this.GetPixelPosition(xScreenReference,xScreenOffset,xElementAlign,obj.scaledWidth);
      var _loc4_ = this.GetPixelPosition(yScreenReference,yScreenOffset,yElementAlign,obj.scaledHeight);
      this.SetMatrix(obj,_loc5_,_loc4_,_loc3_);
   }
   function ResetXYPositionByPixel(obj, scalingX, includeAdditionalScalingX, scalingY, includeAdditionalScalingY, xScreenReference, xScreenOffset, xElementAlign, yScreenReference, yScreenOffset, yElementAlign)
   {
      var _loc2_ = this.SetXYScaling(obj,scalingX,includeAdditionalScalingX,scalingY,includeAdditionalScalingY);
      var _loc5_ = this.GetPixelPosition(xScreenReference,xScreenOffset,xElementAlign,obj.scaledWidth);
      var _loc4_ = this.GetPixelPosition(yScreenReference,yScreenOffset,yElementAlign,obj.scaledHeight);
      this.SetMatrixXY(obj,_loc5_,_loc4_,_loc2_.x,_loc2_.y);
   }
   function ResetPositionByPercentage(obj, scaling, xScreenReference, xScreenOffset, xElementAlign, yScreenReference, yScreenOffset, yElementAlign)
   {
      var _loc3_ = this.SetScaling(obj,scaling);
      var _loc5_ = this.GetPixelPosition(xScreenReference,xScreenOffset * this.ScreenWidth,xElementAlign,obj.scaledWidth);
      var _loc4_ = this.GetPixelPosition(yScreenReference,yScreenOffset * this.ScreenHeight,yElementAlign,obj.scaledHeight);
      this.SetMatrix(obj,_loc5_,_loc4_,_loc3_);
   }
   function updateSafeZone()
   {
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
            this.DisableAdditionalScaling = false;
         }
         _loc2_ = _loc2_ + 1;
      }
   }
   function onResize()
   {
      this.doResize(false);
   }
   function doResize(force)
   {
      var _loc2_ = Stage.visibleRect;
      if(_loc2_ == null)
      {
         this.ScreenWidth = Stage.width;
         this.ScreenHeight = Stage.height;
         this.ScreenX = 0;
         this.ScreenY = 0;
      }
      else
      {
         var _loc3_ = false;
         var _loc6_ = Math.floor(_loc2_.left);
         var _loc4_ = Math.floor(_loc2_.top);
         var _loc9_ = Math.ceil(_loc2_.width);
         var _loc8_ = Math.ceil(_loc2_.height);
         if(this.ScreenWidth != _loc9_ || force)
         {
            this.ScreenWidth = _loc9_;
            this.ScreenHeight = _loc8_;
            this.ScreenX = _loc6_;
            this.ScreenY = _loc4_;
            _loc3_ = true;
         }
         else if(this.ScreenHeight != _loc8_)
         {
            this.ScreenHeight = _loc8_;
            this.ScreenX = _loc6_;
            this.ScreenY = _loc4_;
            _loc3_ = true;
         }
         else if(this.ScreenX != _loc6_)
         {
            this.ScreenX = _loc6_;
            this.ScreenY = _loc4_;
            _loc3_ = true;
         }
         else if(this.ScreenY != _loc4_)
         {
            this.ScreenY = _loc4_;
            _loc3_ = true;
         }
         if(!_loc3_)
         {
            return undefined;
         }
      }
      var _loc5_ = this.ScreenWidth / this.AuthoredWidth;
      var _loc7_ = this.ScreenHeight / this.AuthoredHeight;
      if(_loc5_ >= _loc7_)
      {
         this.ScalingFactors[Lib.ResizeManager.SCALE_BIGGEST] = _loc5_;
         this.ScalingFactors[Lib.ResizeManager.SCALE_SMALLEST] = _loc7_;
      }
      else
      {
         this.ScalingFactors[Lib.ResizeManager.SCALE_BIGGEST] = _loc7_;
         this.ScalingFactors[Lib.ResizeManager.SCALE_SMALLEST] = _loc5_;
      }
      this.ScalingFactors[Lib.ResizeManager.SCALE_USING_VERTICAL] = _loc7_;
      this.ScalingFactors[Lib.ResizeManager.SCALE_USING_HORIZONTAL] = _loc5_;
      this.updateSafeZone();
   }
   function changeUIDevice()
   {
      var _loc4_ = this.Listeners.length;
      var _loc3_ = undefined;
      var _loc2_ = 0;
      while(_loc2_ < _loc4_)
      {
         _loc3_ = this.Listeners[_loc2_];
         if(_loc3_.changeUIDevice != undefined)
         {
            this.Listeners[_loc2_].changeUIDevice();
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
         this.DisableAdditionalScaling = false;
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
