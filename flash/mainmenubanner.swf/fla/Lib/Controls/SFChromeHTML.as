class Lib.Controls.SFChromeHTML extends mx.core.UIComponent
{
   var chromeNav = undefined;
   var m_nBoundingWidth = 0;
   var m_nBoundingHeight = 0;
   var className = "SFChromeHTML";
   static var symbolName = "SFChromeHTML";
   static var symbolOwner = Lib.Controls.SFChromeHTML;
   function SFChromeHTML()
   {
      super();
   }
   function init()
   {
      super.init();
      this.LastScreenWidth = 0;
      this.LastScreenHeight = 0;
      this.BrowserStarted = false;
      this.InitNav();
   }
   function createChildren()
   {
      this.size();
      this.invalidate();
   }
   function size()
   {
      super.size();
      this.invalidate();
   }
   function draw()
   {
      super.draw();
   }
   function InitNav()
   {
      this.chromeNav = new Lib.NavLayout();
      this.chromeNav.ChromeHTML = this;
      this.chromeNav.ShowCursor(true);
      this.chromeNav.AddKeyHandlerTable({MOUSE_WHEEL_UP:{onDown:function(button, control, keycode)
      {
         control.ChromeHTML.onMouseWheel(1);
         return true;
      }},MOUSE_WHEEL_DOWN:{onDown:function(button, control, keycode)
      {
         control.ChromeHTML.onMouseWheel(-1);
         return true;
      }},ANY:{onDown:function(button, control, keycode)
      {
         control.ChromeHTML.onKeyboardDown(button,control,keycode);
         return true;
      },onUp:function(button, control, keycode)
      {
         control.ChromeHTML.onKeyboardUp(button,control,keycode);
         return true;
      }}});
      this.chromeNav.onCharTyped = function(typed)
      {
         return this.ChromeHTML.onKeyTyped(typed);
      };
   }
   function PushLayout()
   {
      _global.navManager.PushLayout(this.chromeNav,"chromeNav");
   }
   function RemoveLayout()
   {
      _global.navManager.RemoveLayout(this.chromeNav);
   }
   function LoadChromeHTMLImage(strRendertargetName, targetMovieClip)
   {
      var oldWidth = targetMovieClip._width;
      var oldHeight = targetMovieClip._height;
      var oldPosX = targetMovieClip._x;
      var oldPosY = targetMovieClip._y;
      this._x = targetMovieClip._x;
      this._y = targetMovieClip._y;
      this.m_nBoundingWidth = targetMovieClip._width;
      this.m_nBoundingHeight = targetMovieClip._height;
      if(targetMovieClip != undefined)
      {
         targetMovieClip.unloadMovie();
      }
      var _loc5_ = new Object();
      _loc5_.onLoadInit = function(target_mc)
      {
         target_mc.forceSmoothing = false;
         target_mc._width = oldWidth;
         target_mc._height = oldHeight;
         target_mc._x = oldPosX;
         target_mc._y = oldPosY;
      };
      var _loc4_ = new MovieClipLoader();
      _loc4_.addListener(_loc5_);
      _loc4_.loadClip(strRendertargetName,targetMovieClip);
      this.RenderTargetName = strRendertargetName;
      this.LastScreenWidth = _global.resizeManager.ScreenWidth;
      this.LastScreenHeight = _global.resizeManager.ScreenHeight;
   }
   function CheckMouseInBounds(x, y)
   {
      if(x < 0 || x > this.m_nBoundingWidth)
      {
         return false;
      }
      if(y < 0 || y > this.m_nBoundingHeight)
      {
         return false;
      }
      return true;
   }
   function onMouseDown(evt)
   {
      if(this.MouseDownCallback != null && this.CheckMouseInBounds(this._xmouse,this._ymouse))
      {
         this.MouseDownCallback(this._xmouse,this._ymouse);
      }
   }
   function onMouseUp(evt)
   {
      if(this.MouseUpCallback != null && this.CheckMouseInBounds(this._xmouse,this._ymouse))
      {
         this.MouseUpCallback(this._xmouse,this._ymouse);
      }
   }
   function onMouseMove(evt)
   {
      if(this.MouseMoveCallback != null && this.CheckMouseInBounds(this._xmouse,this._ymouse))
      {
         this.MouseMoveCallback(this._xmouse,this._ymouse);
      }
   }
   function onMouseWheel(delta)
   {
      if(this.MouseWheelCallback != null && this.CheckMouseInBounds(this._xmouse,this._ymouse))
      {
         this.MouseWheelCallback(delta);
      }
   }
   function onKeyboardDown(button, control, keycode)
   {
      if(this.KeyDownCallback != null)
      {
         this.KeyDownCallback(keycode);
      }
   }
   function onKeyboardUp(button, control, keycode)
   {
      if(this.KeyUpCallback != null)
      {
         this.KeyUpCallback(keycode);
      }
   }
   function onKeyTyped(typed)
   {
      if(this.KeyTypedCallback != null)
      {
         this.KeyTypedCallback(typed.charCodeAt(0));
         return true;
      }
      return false;
   }
}
