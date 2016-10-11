function InitBlog()
{
   SetupScrollButtons();
   SetupHtmlControlButtons();
   _global.CScaleformComponent_Blog.OnLoadFinished(this,_global.UISlot);
   _global.CScaleformComponent_Blog.OnReady();
   _global.resizeManager.AddListener(this);
   chrome_html_mc.BrowserStarted = true;
}
function ShutdownBlog()
{
   if(chrome_html_mc.BrowserStarted)
   {
      chrome_html_mc.BrowserStarted = false;
      chrome_html_mc.RemoveLayout();
      _global.resizeManager.RemoveListener(this);
      _global.CScaleformComponent_Blog.OnUnload(this);
   }
}
function onResize(rm)
{
   if(chrome_html_mc.RenderTargetName != undefined && chrome_html_mc.LastScreenWidth != rm.ScreenWidth && chrome_html_mc.LastScreenHeight != rm.ScreenHeight)
   {
      InitChromeHTMLRenderTarget(chrome_html_mc.RenderTargetName);
   }
}
function SetupScrollButtons()
{
   VScrollBar.Init(false);
   VScrollBar.dialog = this;
   VScrollBar.NotifyValueChange = function()
   {
      this.dialog.onHTMLVertScrollBarChanged();
   };
   VScrollBar.m_bNotifyWhileMoving = true;
   VScrollBar.setDisabled(true);
   VScrollBar._visible = false;
   HScrollBar.Init(false);
   HScrollBar.dialog = this;
   HScrollBar.NotifyValueChange = function()
   {
      this.dialog.onHTMLHorzScrollBarChanged();
   };
   HScrollBar.m_bNotifyWhileMoving = true;
   HScrollBar.setDisabled(true);
   HScrollBar._visible = false;
}
function SetupHtmlControlButtons()
{
   ButtonBack.setDisabled(true);
   ButtonBack.Action = function()
   {
      _global.CScaleformComponent_Blog.OnHTMLBackButtonClicked();
   };
   ButtonForward.setDisabled(true);
   ButtonForward.Action = function()
   {
      _global.CScaleformComponent_Blog.OnHTMLForwardButtonClicked();
   };
   ButtonReload.Action = function()
   {
      _global.CScaleformComponent_Blog.OnHTMLRefreshButtonClicked();
   };
   ButtonStop._visible = false;
   ButtonStop.setDisabled(true);
   ButtonStop.Action = function()
   {
      _global.CScaleformComponent_Blog.OnHTMLStopButtonClicked();
   };
   ButtonExternal.Action = function()
   {
      _global.CScaleformComponent_Blog.OnHTMLExternalBrowserButtonClicked();
   };
   ButtonLoading._visible = true;
}
function RegisterChromeHtmlCallbacks()
{
   chrome_html_mc.MouseDownCallback = onHTMLMouseDown;
   chrome_html_mc.MouseUpCallback = onHTMLMouseUp;
   chrome_html_mc.MouseMoveCallback = onHTMLMouseMove;
   chrome_html_mc.MouseWheelCallback = onHTMLMouseWheel;
   chrome_html_mc.KeyDownCallback = onHTMLKeyDown;
   chrome_html_mc.KeyUpCallback = onHTMLKeyUp;
   chrome_html_mc.KeyTypedCallback = onHTMLKeyTyped;
}
function UnregisterChromeHtmlCallbacks()
{
   chrome_html_mc.MouseDownCallback = null;
   chrome_html_mc.MouseUpCallback = null;
   chrome_html_mc.MouseMoveCallback = null;
   chrome_html_mc.MouseWheelCallback = null;
   chrome_html_mc.KeyDownCallback = null;
   chrome_html_mc.KeyUpCallback = null;
   chrome_html_mc.KeyTypedCallback = null;
}
function EnableInput(bEnabled)
{
   m_bInputEnabled = bEnabled;
}
function ShowBlogPanel()
{
   this._visible = true;
   RegisterChromeHtmlCallbacks();
   EnableInput(true);
   if(chrome_html_mc.RenderTargetName != undefined && !chrome_html_mc.BrowserStarted)
   {
      InitBlog();
   }
}
function HideBlogPanel()
{
   this._visible = false;
   UnregisterChromeHtmlCallbacks();
   EnableInput(false);
   if(chrome_html_mc.RenderTargetName != undefined && chrome_html_mc.BrowserStarted)
   {
      ShutdownBlog();
      VScrollBar.SetValue(0);
      HScrollBar.SetValue(0);
   }
}
function InitChromeHTMLRenderTarget(strRendertargetName)
{
   chrome_html_mc.LoadChromeHTMLImage(strRendertargetName,NewsScroll);
   _global.CScaleformComponent_Blog.SetHTMLBrowserSize(NewsScroll._width,NewsScroll._height,_global.resizeManager.ScreenWidth,_global.resizeManager.ScreenHeight);
   RegisterChromeHtmlCallbacks();
}
function UpdateHTMLScrollbar(iScroll, iTall, iMax, bVisible, bVert)
{
   if(bVert)
   {
      VScrollBar.DefineScaledValueRange(0,iMax);
      VScrollBar.SetValueScaled(iScroll);
      VScrollBar.setDisabled(!bVisible);
      VScrollBar._visible = bVisible;
   }
   else
   {
      HScrollBar.DefineScaledValueRange(0,iMax);
      HScrollBar.SetValueScaled(iScroll);
      HScrollBar.setDisabled(!bVisible);
      HScrollBar._visible = bVisible;
   }
}
function setBackButtonEnabled(bEnabled)
{
   ButtonBack.setDisabled(!bEnabled);
}
function setForwardButtonEnabled(bEnabled)
{
   ButtonForward.setDisabled(!bEnabled);
}
function setRefreshButtonEnabled(bEnabled)
{
   ButtonReload.setDisabled(!bEnabled);
}
function setExternalBrowserButtonEnabled(bEnabled)
{
   ButtonExternal.setDisabled(!bEnabled);
}
function setPageLoadState(isLoading)
{
   ButtonLoading._visible = isLoading;
   ButtonStop.setDisabled(!isLoading);
   ButtonStop._visible = isLoading;
   ButtonReload.setDisabled(isLoading);
   ButtonReload._visible = !isLoading;
}
function onHTMLMouseDown(x, y)
{
   if(m_bInputEnabled)
   {
      _global.CScaleformComponent_Blog.OnHTMLMouseDown(x,y,0);
   }
}
function onHTMLMouseUp(x, y)
{
   if(m_bInputEnabled)
   {
      _global.CScaleformComponent_Blog.OnHTMLMouseUp(x,y);
   }
}
function onHTMLMouseMove(x, y)
{
   if(m_bInputEnabled)
   {
      _global.CScaleformComponent_Blog.OnHTMLMouseMove(x,y);
   }
}
function onHTMLMouseWheel(delta)
{
   if(m_bInputEnabled)
   {
      _global.CScaleformComponent_Blog.OnHTMLMouseWheel(delta);
   }
}
function onHTMLKeyDown(keycode)
{
   if(m_bInputEnabled)
   {
      _global.CScaleformComponent_Blog.OnHTMLKeyDown(keycode);
   }
}
function onHTMLKeyUp(keycode)
{
   if(m_bInputEnabled)
   {
      _global.CScaleformComponent_Blog.OnHTMLKeyUp(keycode);
   }
}
function onHTMLKeyTyped(charCode)
{
   if(m_bInputEnabled)
   {
      _global.CScaleformComponent_Blog.OnHTMLKeyTyped(charCode);
   }
}
function onHTMLVertScrollBarChanged()
{
   if(m_bInputEnabled)
   {
      _global.CScaleformComponent_Blog.OnHTMLScrollBarChanged(VScrollBar.GetValueScaled(),true);
   }
}
function onHTMLHorzScrollBarChanged()
{
   if(m_bInputEnabled)
   {
      _global.CScaleformComponent_Blog.OnHTMLScrollBarChanged(HScrollBar.GetValueScaled(),false);
   }
}
var m_bInputEnabled = false;
this.stop();
