function InitStream()
{
   if(m_bIsClosed)
   {
      return undefined;
   }
   SetupButtons();
   _global.CScaleformComponent_EmbeddedStream.OnLoadFinished(this,_global.UISlot);
   _global.CScaleformComponent_EmbeddedStream.OnReady();
   _global.resizeManager.AddListener(this);
   chrome_html_mc.BrowserStarted = true;
   Bg.onRollOver = function()
   {
   };
   Close.dialog = this;
   Close.Action = function()
   {
      this.dialog.HideStreamPanel(false);
      m_bIsClosed = true;
   };
}
function ShutdownStreamPanel()
{
   if(chrome_html_mc.BrowserStarted)
   {
      chrome_html_mc.BrowserStarted = false;
      chrome_html_mc.RemoveLayout();
      _global.resizeManager.RemoveListener(this);
      _global.CScaleformComponent_EmbeddedStream.OnUnload(this);
   }
}
function onResize(rm)
{
   if(chrome_html_mc.RenderTargetName != undefined && chrome_html_mc.LastScreenWidth != rm.ScreenWidth && chrome_html_mc.LastScreenHeight != rm.ScreenHeight)
   {
      InitChromeHTMLRenderTarget(chrome_html_mc.RenderTargetName);
   }
}
function ShowStreamPanel()
{
   var _loc3_ = _global.CScaleformComponent_EmbeddedStream.IsVideoPlaying();
   if(!_loc3_ || _global.LobbyMovie)
   {
      HideStreamPanel(true);
      return undefined;
   }
   if(!this._visible)
   {
      new Lib.Tween(this,"_alpha",mx.transitions.easing.Strong.easeOut,0,100,2,true);
   }
   this._visible = true;
   _global.MainMenuMovie.SetMainMenuNav("");
   _global.MainMenuMovie.Panel.Blog.EnableInput(false);
   SetupEventInfo();
   if(chrome_html_mc.RenderTargetName != undefined && !chrome_html_mc.BrowserStarted)
   {
      InitStream();
   }
}
function HideStreamPanel(bOnlyHide)
{
   this._visible = false;
   _global.MainMenuMovie.Panel.Blog.EnableInput(true);
   if(!bOnlyHide)
   {
      ShutdownStreamPanel();
   }
}
function LoadImage(imagePath, objImage, numWidth, numHeight)
{
   var _loc1_ = new Object();
   _loc1_.onLoadInit = function(target_mc)
   {
      target_mc._width = numWidth;
      target_mc._height = numHeight;
   };
   _loc1_.onLoadError = function(target_mc, errorCode, status)
   {
      trace("Error loading item image: " + errorCode + " [" + status + "] ----- ");
   };
   var _loc3_ = imagePath;
   var _loc2_ = new MovieClipLoader();
   _loc2_.addListener(_loc1_);
   _loc2_.loadClip(_loc3_,objImage.Image);
}
function SetupEventInfo()
{
   var _loc3_ = _global.CScaleformComponent_News.GetActiveTournamentEventID();
   var _loc4_ = _global.CScaleformComponent_EmbeddedStream.GetStreamEventVenueID();
   var _loc5_ = "images/ui_icons/";
   if(_loc4_ >= 10)
   {
      LoadImage("econ/tournaments/steam_bg_" + _loc3_ + "_" + _loc4_ + ".png",BgImage,623,466);
      TournmentInfo._visible = false;
      PickEm._visible = false;
      Live._visible = false;
   }
   else
   {
      LoadImage("econ/tournaments/steam_bg_" + _loc3_ + ".png",BgImage,623,466);
      TournmentInfo._visible = true;
      PickEm._visible = true;
      Live._visible = true;
      TournmentInfo.dialog = this;
      TournmentInfo.SetText("#CSGO_Watch_Info_Tournament_" + _loc3_);
      TournmentInfo.ButtonText.Text.autoSize = "left";
      TournmentInfo.ButtonText.Text._x = 15;
      TournmentInfo.Action = function()
      {
         onOpenTournamentSite();
      };
      LoadImage(_loc5_ + "info" + ".png",TournmentInfo.ImageHolder,28,28,false);
      PickEm.dialog = this;
      PickEm.SetText("#CSGO_Play_FantasyPickEm");
      PickEm.ButtonText.Text.autoSize = "left";
      PickEm.ButtonText.Text._x = 15;
      PickEm.Action = function()
      {
         onPickEm();
      };
      LoadImage(_loc5_ + "team" + ".png",PickEm.ImageHolder,28,28,false);
      Live.dialog = this;
      Live.SetText("#CSGO_Watch_Info_gotv");
      Live.ButtonText.Text.autoSize = "left";
      Live.ButtonText.Text._x = 15;
      Live.Action = function()
      {
         onLive();
      };
      LoadImage(_loc5_ + "gotv" + ".png",Live.ImageHolder,28,28,false);
   }
   Text.StageTitle.htmlText = "#SFUI_MajorEventVenue_Title_" + _loc3_ + "_" + _loc4_;
   Text.StageSubtitle.htmlText = "#SFUI_MajorEventVenue_Subtitle_" + _loc3_ + "_" + _loc4_;
   SetVolumeFromExternalValue();
}
function SetupButtons()
{
   var _loc10_ = "images/ui_icons/";
   var _loc8_ = Controls.Fullscreen;
   _loc8_.dialog = this;
   _loc8_.Action = function()
   {
      this.dialog.onOpenStream();
   };
   LoadImage(_loc10_ + "external_link" + ".png",_loc8_.ImageHolder,28,28,false);
   var objVolSlider = Controls.VolSlider.Btn;
   SetVolumeFromExternalValue();
   objVolSlider.ratio = 0;
   objVolSlider.onPress = function()
   {
      objVolSlider.startDrag(true,0,0,m_numLenghtOfSlider,0);
      var SndLevel = 0;
      objVolSlider.onEnterFrame = function()
      {
         objVolSlider.ratio = Math.round(objVolSlider._x * (100 / m_numLenghtOfSlider));
         if(objVolSlider.ratio != SndLevel)
         {
            _global.CScaleformComponent_EmbeddedStream.SetAudioVolume(objVolSlider.ratio);
            trace("---------------objVolSlider.ratio--------" + objVolSlider.ratio);
         }
         SndLevel = objVolSlider.ratio;
         if(objVolSlider._x <= 1)
         {
            Controls.MuteBtn._alpha = 30;
         }
         else
         {
            Controls.MuteBtn._alpha = 100;
         }
      };
   };
   objVolSlider.onRelease = objVolSlider.onReleaseOutside = stopDrag;
   var _loc7_ = 10;
   var _loc4_ = 0;
   while(_loc4_ < _loc7_)
   {
      var _loc3_ = Controls.VolSlider["BtnVol" + _loc4_];
      var _loc5_ = Math.round(m_numLenghtOfSlider / _loc7_ * _loc4_);
      var _loc6_ = Math.round(_loc5_ * (100 / m_numLenghtOfSlider));
      _loc3_.dialog = this;
      _loc3_._alpha = 0;
      if(_loc4_ >= 9)
      {
         _loc3_._SndVal = 100;
         _loc3_._SliderPos = m_numLenghtOfSlider;
      }
      else if(_loc4_ <= 0)
      {
         _loc3_._SndVal = 0;
         _loc3_._SliderPos = 0;
      }
      else
      {
         _loc3_._SndVal = _loc6_;
         _loc3_._SliderPos = _loc5_;
      }
      _loc3_.onPress = function()
      {
         this.dialog.onSetVolume(this);
      };
      _loc4_ = _loc4_ + 1;
   }
   var _loc9_ = Controls.MuteBtn;
   _loc9_.dialog = this;
   _loc9_.onPress = function()
   {
      this.dialog.onMute();
   };
}
function onMute()
{
   var _loc3_ = _global.CScaleformComponent_EmbeddedStream.GetAudioVolume();
   if(GetVolume() >= 1)
   {
      SetVolumeSlider(0);
      _global.CScaleformComponent_EmbeddedStream.SetAudioVolume(0);
   }
   else
   {
      var _loc2_ = Math.round(25 * (m_numLenghtOfSlider / 100));
      SetVolumeSlider(_loc2_);
      _global.CScaleformComponent_EmbeddedStream.SetAudioVolume(25);
   }
}
function SetVolumeFromExternalValue()
{
   var _loc1_ = Math.round(GetVolume() * (m_numLenghtOfSlider / 100));
   SetVolumeSlider(_loc1_);
}
function onSetVolume(VolBtn)
{
   _global.CScaleformComponent_EmbeddedStream.SetAudioVolume(VolBtn._SndVal);
   SetVolumeSlider(VolBtn._SliderPos);
}
function SetVolumeSlider(numSliderPos)
{
   Controls.VolSlider.Btn._x = numSliderPos;
   if(numSliderPos <= 1)
   {
      Controls.MuteBtn._alpha = 30;
   }
   else
   {
      Controls.MuteBtn._alpha = 100;
   }
}
function GetVolume()
{
   return _global.CScaleformComponent_EmbeddedStream.GetAudioVolume();
}
function onOpenStream()
{
   _global.CScaleformComponent_EmbeddedStream.OpenStreamInExternalBrowser();
}
function onOpenTournamentSite()
{
   _global.CScaleformComponent_SteamOverlay.OpenExternalBrowserURL("http://www.eleague.com/major");
}
function onLive()
{
   _global.MainMenuMovie.Panel.SelectPanel.OnWatchPressed(true);
}
function onPickEm()
{
   _global.MainMenuMovie.Panel.SelectPanel.OnWatchPressed(false);
}
function InitChromeHTMLRenderTarget(strRendertargetName)
{
   trace("------------------- EmbeddedStream InitChromeHTMLRenderTarget --------------------");
   chrome_html_mc.LoadChromeHTMLImage(strRendertargetName,StreamsBg);
   _global.CScaleformComponent_EmbeddedStream.SetHTMLBrowserSize(StreamsBg._width,StreamsBg._height,_global.resizeManager.ScreenWidth,_global.resizeManager.ScreenHeight);
}
this._visible = false;
var m_bIsClosed = false;
var m_numLenghtOfSlider = 75;
this.stop();
