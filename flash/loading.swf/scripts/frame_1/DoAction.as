function onResize(rm)
{
   rm.DisableAdditionalScaling = true;
   rm.ResetPositionByPixel(Panel,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_CENTER_X,0,Lib.ResizeManager.ALIGN_CENTER,Lib.ResizeManager.REFERENCE_CENTER_Y,0,Lib.ResizeManager.ALIGN_CENTER);
   if(mapImageLoaded)
   {
      rm.ResetPositionByPixel(Panel.Subpanel,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_CENTER_X,0,Lib.ResizeManager.ALIGN_CENTER,Lib.ResizeManager.REFERENCE_CENTER_Y,0,Lib.ResizeManager.ALIGN_CENTER);
   }
}
function showPanel()
{
   Panel._visible = true;
   Panel.ContinueButton._visible = false;
   Panel.AnimatingWidget._visible = false;
   Panel.CountdownText._visible = false;
   Panel.TimerIcon._visible = false;
   Panel.ProgressBar._visible = false;
   Panel.LoadingText._visible = false;
   Panel.SecondaryProgressBar._visible = false;
   Panel.SecondaryLoadingText._visible = false;
   Panel.MainText._visible = false;
   Panel.HintBar._visible = false;
   m_IconsToShowArray = [];
   Panel.OverviewIcons.CTSpawn._visible = false;
   Panel.OverviewIcons.TSpawn._visible = false;
   Panel.OverviewIcons.Bomb._visible = false;
   Panel.OverviewIcons.BombA._visible = false;
   Panel.OverviewIcons.BombB._visible = false;
   Panel.OverviewIcons.Hostage1._visible = false;
   Panel.OverviewIcons.Hostage2._visible = false;
   Panel.OverviewIcons.Hostage3._visible = false;
   Panel.OverviewIcons.Hostage4._visible = false;
   Panel.OverviewIcons.Hostage5._visible = false;
   Panel.OverviewIcons.Hostage6._visible = false;
   _global.PauseMenuMovie.hidePanel();
   m_bOverviewLoadSucceeded = false;
   m_nFailedToLoadOverviewTimes = 0;
   m_nFailedToLoadOverviewTimesGLOBAL = 0;
   gameAPI.ReadyForLoading();
}
function playAnim(animID)
{
   Panel.Subpanel.gotoAndPlay("Start_" + animID);
}
function setMapInfo(map, TeamIndex, MapName, GameType, GameMode, Scenario, jpgPath, bUseBlankScreen)
{
   m_bOverviewLoadSucceeded = false;
   infoMapName = MapName;
   infoGameType = GameType;
   infoGameMode = GameMode;
   infoScenario = Scenario;
   infoThumbPath = jpgPath;
   mapName = map;
   PostLoadInit();
}
function updateMapInfo(map, TeamIndex, MapName, GameType, GameMode, Scenario, jpgPath)
{
   infoMapName = MapName;
   infoGameType = GameType;
   infoGameMode = GameMode;
   infoScenario = Scenario;
   infoThumbPath = jpgPath;
   mapName = map;
   LoadOverviewMap(mapName);
}
function UnblurBGImage()
{
   if(ThumbNailImage == undefined || m_nBGBlur <= m_nTargetMinBlur)
   {
      killBlurTimer();
      trace("!!!!!!UnblurBGImage : killBlurTimer, AnimComplete!!");
      _global.LoadingAPI.AnimComplete();
      return undefined;
   }
   m_nBGBlur = m_nBGBlur - 0.33;
   var _loc2_ = new flash.filters.BlurFilter(m_nBGBlur,m_nBGBlur,2);
   ThumbNailImage.filters = [_loc2_];
}
function setLoadingThumbnail()
{
   trace("============ setLoadingThumbnail : " + infoThumbPath);
   var _loc3_ = new Object();
   _loc3_.onLoadInit = function(target_mc)
   {
      if(target_mc._width > 1000)
      {
         m_nTargetMinBlur = 0;
      }
      else
      {
         m_nTargetMinBlur = 5;
      }
      target_mc._x = thumbnailSize.x;
      target_mc._y = thumbnailSize.y;
      target_mc._width = thumbnailSize.width;
      target_mc._height = thumbnailSize.height;
      trace("!!!!!!onLoadInit : " + thumbnailSize.width + " x " + thumbnailSize.height);
      Panel.MapHolder.ImageThumbnail._visible = true;
      trace("Thumbnail, playing gotoAndPlay!!");
      ThumbNailImage = target_mc;
      m_nBGBlur = BG_BLUR_MAX;
      var _loc2_ = new flash.filters.BlurFilter(m_nBGBlur,m_nBGBlur,2);
      ThumbNailImage.filters = [_loc2_];
   };
   var _loc5_ = "../../" + infoThumbPath;
   var _loc1_ = Panel.MapHolder.ImageThumbnail;
   if(_loc1_ != undefined)
   {
      _loc1_.unloadMovie();
      trace("!!!!!! unloading thumbnail!");
   }
   if(infoThumbPath)
   {
      var _loc2_ = new MovieClipLoader();
      _loc2_.addListener(_loc3_);
      _loc2_.loadClip(_loc5_,_loc1_);
   }
   LoadOverviewMap(mapName);
}
function LoadOverviewMap(mapName)
{
   if(m_bOverviewLoadSucceeded)
   {
      return undefined;
   }
   var _loc4_ = "../../maps/" + mapName + "_loading.jpg";
   var _loc5_ = "../overviews/" + mapName + "_radar_spectate.dds";
   var _loc6_ = "../overviews/" + mapName + "_radar.dds";
   if(m_nFailedToLoadOverviewTimes == 0)
   {
      movieName = _loc4_;
   }
   else if(m_nFailedToLoadOverviewTimes == 1)
   {
      movieName = _loc5_;
   }
   else if(m_nFailedToLoadOverviewTimes == 2)
   {
      movieName = _loc6_;
   }
   else if(m_nFailedToLoadOverviewTimes > 2)
   {
      m_nFailedToLoadOverviewTimes = 0;
      m_nFailedToLoadOverviewTimesGLOBAL++;
      return undefined;
   }
   trace("!!!!!!LoadOverviewMap (trying to load " + movieName + ")");
   m_bStartedIconReveal = false;
   var _loc1_ = new Object();
   _loc1_.onLoadError = function(target_mc, errorCode, status)
   {
      trace("Error loading image: " + errorCode + " [" + status + "]");
      Panel.OverviewBG._visible = true;
      Panel.Overview._visible = false;
      Panel.OverviewBG.gotoAndStop("Init");
      m_nFailedToLoadOverviewTimes++;
      LoadOverviewMap(mapName);
   };
   _loc1_.onLoadInit = function(target_mc)
   {
      target_mc._x = overviewSize.x;
      target_mc._y = overviewSize.y;
      target_mc._width = overviewSize.width;
      target_mc._height = overviewSize.height;
      trace("!!!!!!onLoadInit (loaded loading overview image): " + overviewSize.width + " x " + overviewSize.height);
      m_bOverviewLoadSucceeded = true;
      if(m_nFailedToLoadOverviewTimesGLOBAL > 0)
      {
         Panel.OverviewBG.gotoAndPlay("FadeOut");
      }
      else
      {
         Panel.OverviewBG._visible = false;
      }
      Panel.Overview._visible = true;
   };
   var _loc2_ = Panel.Overview;
   if(_loc2_ != undefined)
   {
      _loc2_.unloadMovie();
   }
   var _loc3_ = new MovieClipLoader();
   _loc3_.addListener(_loc1_);
   _loc3_.loadClip(movieName,_loc2_);
}
function SetIconPosition(newType, x, y)
{
   var _loc4_ = [];
   _loc4_.type = newType;
   _loc4_.x = x;
   _loc4_.y = y;
   i = 0;
   while(i < m_IconsToShowArray.length)
   {
      if(m_IconsToShowArray[i].type == newType)
      {
         trace("!!!!!![exists already] SetIconPosition: type = " + type + ", x = " + x + ", y = " + y);
         return undefined;
      }
      i++;
   }
   trace("!!!!!![doesn\'t exist - adding] SetIconPosition: type = " + type + ", x = " + x + ", y = " + y);
   m_IconsToShowArray.push(_loc4_);
}
function setHintText(hint)
{
   hintText = hint;
   Panel.HintBar.Hint.HintText.htmlText = hintText;
}
function setLoadingText(text)
{
   loadText = text;
   Panel.LoadingText.LoadingText.htmlText = loadText;
}
function setSecondaryLoadingText(text)
{
   loadText = text;
   if(loadText == "")
   {
      Panel.SecondaryLoadingText._visible = false;
      return undefined;
   }
   Panel.SecondaryLoadingText._visible = true;
   Panel.SecondaryLoadingText.LoadingText.htmlText = loadText;
}
function showLoadinginfo()
{
   Panel.ProgressBar._visible = true;
   Panel.LoadingText._visible = true;
   Panel.MainText._visible = bShowMapSwf;
   Panel.HintBar._visible = true;
   Panel.MainText.ScenarioText.visible = bShowMapSwf;
   Panel.MainText.ModeText._visible = bShowMapSwf;
   Panel.DefaultArt._visible = !bShowMapSwf;
   if(bShowMapSwf)
   {
      Panel.MainText.TitleText.Title.htmlText = infoMapName;
      _global.AutosizeTextDown(Panel.MainText.TitleText.Title,24);
      if(infoGameType != "")
      {
         Panel.MainText.ModeText.Mode.htmlText = infoGameType + ": " + infoGameMode;
      }
      else
      {
         Panel.MainText.ModeText.Mode.htmlText = infoGameMode;
      }
      Panel.MainText.ScenarioText.Scenario.htmlText = infoScenario;
      _global.AutosizeTextDown(Panel.MainText.ScenarioText.Scenario,14);
      trace("!!!!!*********   [showLoadinginfo] infoScenario:" + infoScenario);
   }
   Panel.HintBar.Hint.HintText.htmlText = hintText;
   var _loc2_ = Panel.MainText.MapIcon;
   if(_loc2_ != undefined)
   {
      _loc2_._visible = false;
      _loc2_.unloadMovie();
   }
   if(mapName != "")
   {
      var _loc3_ = "images/map_icons/collection_icon_" + mapName + ".png";
      var _loc5_ = new Object();
      _loc5_.onLoadInit = function(target_mc)
      {
         target_mc.forceSmoothing = true;
         target_mc._width = m_MapIconWidth;
         target_mc._height = m_MapIconHeight;
         target_mc._alpha = 90;
         trace("Loaded map collection icon! h = " + m_MapIconHeight + ", w = " + m_MapIconWidth);
      };
      _loc2_._visible = true;
      var _loc4_ = new MovieClipLoader();
      _loc4_.addListener(_loc5_);
      _loc4_.loadClip(_loc3_,_loc2_);
      trace("Loading map collection icon: " + _loc3_);
   }
   setLoadingThumbnail();
}
function onLoadInit(_mc)
{
   PostLoadInit(_mc);
}
function PlayUnblurAnimation()
{
   killBlurTimer();
   imageBlurTimer = setInterval(UnblurBGImage,400,null);
   trace("!!!!!*********   PlayUnblurAnimation");
   trace("!!!!!!PlayUnblurAnimation: m_IconsToShowArray.length = " + m_IconsToShowArray.length);
}
function PostLoadInit(_mc)
{
   killTimers();
   if(Panel._visible)
   {
      bShowMapSwf = true;
      Placeholder = Panel.Subpanel;
      Panel.RetrievingDataNotification._visible = false;
      mapSWF = _mc;
      var _loc3_ = Panel.MapHolder.ImageThumbnail;
      thumbnailSize = new flash.geom.Rectangle(_loc3_._x,_loc3_._y,_loc3_._width,_loc3_._height);
      var _loc2_ = Panel.Overview;
      overviewSize = new flash.geom.Rectangle(_loc2_._x,_loc2_._y,_loc2_._width,_loc2_._height);
      Panel.Subpanel = _mc.Panel;
      showLoadinginfo();
      gameAPI.SWFLoadSuccess(mapSWF);
      mapImageLoaded = true;
      onResize(_global.resizeManager);
      Placeholder._visible = false;
      Panel.Subpanel.gotoAndPlay("StartShow");
      Panel.Subpanel._visible = true;
      Panel.Subpanel._alpha = 100;
      timeOfLastPhaseChange = 0;
      m_nFailedToLoadOverviewTimes = 0;
      m_bOverviewLoadSucceeded = false;
   }
   else
   {
      unloadMovie(_mc);
   }
}
function onLoadError(_mc)
{
   killTimers();
   bShowMapSwf = false;
   showLoadinginfo();
   gameAPI.SWFLoadError();
}
function DisplayOverviewIcons()
{
   var _loc1_ = m_nIconRevealIndex;
   if(m_IconsToShowArray[_loc1_].x == 0 && m_IconsToShowArray[_loc1_].y == 0)
   {
      m_nIconRevealIndex++;
      DisplayOverviewIcons();
      return undefined;
   }
   if(m_nIconRevealIndex >= m_IconsToShowArray.length)
   {
      return undefined;
   }
   trace("!!! DisplayOverviewIcons: m_nIconRevealIndex = " + m_nIconRevealIndex + ", Time = " + Time());
   if(m_IconsToShowArray[_loc1_].type == "CTSpawn")
   {
      overview = Panel.OverviewIcons.CTSpawn;
   }
   else if(m_IconsToShowArray[_loc1_].type == "TSpawn")
   {
      overview = Panel.OverviewIcons.TSpawn;
   }
   else if(m_IconsToShowArray[_loc1_].type == "Bomb")
   {
      overview = Panel.OverviewIcons.Bomb;
   }
   else if(m_IconsToShowArray[_loc1_].type == "BombA")
   {
      overview = Panel.OverviewIcons.BombA;
   }
   else if(m_IconsToShowArray[_loc1_].type == "BombB")
   {
      overview = Panel.OverviewIcons.BombB;
   }
   else if(m_IconsToShowArray[_loc1_].type == "Hostage1")
   {
      overview = Panel.OverviewIcons.Hostage1;
   }
   else if(m_IconsToShowArray[_loc1_].type == "Hostage2")
   {
      overview = Panel.OverviewIcons.Hostage2;
   }
   else if(m_IconsToShowArray[_loc1_].type == "Hostage3")
   {
      overview = Panel.OverviewIcons.Hostage3;
   }
   else if(m_IconsToShowArray[_loc1_].type == "Hostage4")
   {
      overview = Panel.OverviewIcons.Hostage4;
   }
   else if(m_IconsToShowArray[_loc1_].type == "Hostage5")
   {
      overview = Panel.OverviewIcons.Hostage5;
   }
   else if(m_IconsToShowArray[_loc1_].type == "Hostage6")
   {
      overview = Panel.OverviewIcons.Hostage6;
   }
   if(overview != undefined)
   {
      overview._alpha = 100;
      overview._visible = true;
      overview._x = m_IconsToShowArray[_loc1_].x * Panel.Overview._width;
      overview._y = m_IconsToShowArray[_loc1_].y * Panel.Overview._height;
      overview.gotoAndPlay("Show");
   }
   m_nIconRevealIndex++;
}
function setProgressFraction(progressFraction, elapsedTime)
{
   if(progressFraction > 0.01 && m_bStartedIconReveal == false)
   {
      m_nIconRevealIndex = 0;
      m_bStartedIconReveal = true;
      iconDisplayTimer = setInterval(DisplayOverviewIcons,500,null);
   }
   var _loc3_ = 100;
   var _loc1_ = 2;
   var _loc4_ = Panel.ProgressBar.ProgressBar;
   var _loc5_ = _loc1_ + progressFraction * (_loc3_ - _loc1_);
   _loc4_.gotoAndStop(_loc5_);
   trace("setProgressFraction: " + progressFraction);
}
function setSecondaryProgressFraction(progressFraction)
{
   if(progressFraction == 1)
   {
      Panel.SecondaryProgressBar._visible = false;
      return undefined;
   }
   Panel.SecondaryProgressBar._visible = true;
   Panel.SecondaryLoadingText._visible = true;
   var _loc3_ = 100;
   var _loc1_ = 2;
   var _loc4_ = Panel.SecondaryProgressBar.ProgressBar;
   var _loc5_ = _loc1_ + progressFraction * (_loc3_ - _loc1_);
   _loc4_.gotoAndStop(_loc5_);
   trace("setSecondaryProgressFraction: " + progressFraction);
}
function ShowContinueButton()
{
   Panel.ContinueButton._visible = true;
   Panel.AnimatingWidget._visible = true;
   Panel.CountdownText._visible = true;
   Panel.TimerIcon._visible = true;
   Panel.ContinueButton.ButtonText.SetText("#SFUI_Continue");
   Panel.ContinueButton.Action = function()
   {
      gameAPI.ContinueButtonPressed();
   };
   Panel.ProgressBar._visible = false;
   Panel.LoadingText._visible = false;
   Panel.SecondaryProgressBar._visible = false;
   Panel.SecondaryLoadingText._visible = false;
   Panel.Subpanel.spinner._visible = false;
   _global.navManager.PushLayout(LoadingNav,"LoadingNav");
   killTimers();
   timeTillAutoContinue = 5;
   SetCountdownText(timeTillAutoContinue);
   continueTimerInterval = setInterval(DecrementContinueTimer,1000,null);
   startTimerInterval = setInterval(StartButtonAnimation,1000,null);
}
function DecrementContinueTimer()
{
   timeTillAutoContinue--;
   SetCountdownText(timeTillAutoContinue);
   if(timeTillAutoContinue <= 0)
   {
      if(continueTimerInterval != kUNDEF)
      {
         killContinueTimer();
         gameAPI.ContinueButtonPressed();
      }
   }
}
function SetCountdownText(timeLeft)
{
   var _loc3_ = Math.floor(timeLeft / 60);
   var _loc2_ = timeLeft % 60;
   var _loc1_ = _loc3_;
   _loc1_ = _loc1_ + ":";
   if(_loc2_ < 10)
   {
      _loc1_ = _loc1_ + "0";
   }
   _loc1_ = _loc1_ + _loc2_;
   Panel.CountdownText.CountdownText.htmlText = _loc1_;
}
function StartButtonAnimation()
{
   killStartTimer();
   Panel.AnimatingWidget.gotoAndPlay("start");
}
function StartHide()
{
   StartHideTimer();
   _global.navManager.RemoveLayout(LoadingNav);
}
function StartHideTimer()
{
   killHideTimer();
   trace("LoadingScreen: StartHideTimer");
   timeTillHide = 0.5;
   hideTimerInterval = setInterval(DecrementHideTimer,50,null);
}
function DecrementHideTimer()
{
   timeTillHide--;
   if(timeTillHide <= 0)
   {
      if(hideTimerInterval != kUNDEF)
      {
         killTimers();
         trace("LoadingScreen: CloseAndUnload");
         if(!gameAPI.CloseAndUnload())
         {
            onUnload(mc);
         }
      }
   }
}
function killContinueTimer()
{
   if(continueTimerInterval != kUNDEF)
   {
      trace("LoadingScreen: killContinueTimer continueTimerInterval = " + continueTimerInterval);
      clearInterval(continueTimerInterval);
      continueTimerInterval = kUNDEF;
   }
}
function killHideTimer()
{
   if(hideTimerInterval != kUNDEF)
   {
      trace("LoadingScreen: killHideTimer hideTimerInterval = " + hideTimerInterval);
      clearInterval(hideTimerInterval);
      hideTimerInterval = kUNDEF;
      timeTillHide = 0;
   }
}
function killStartTimer()
{
   if(startTimerInterval != kUNDEF)
   {
      trace("LoadingScreen: killStartTimer startTimerInterval = " + startTimerInterval);
      clearInterval(startTimerInterval);
      startTimerInterval = kUNDEF;
   }
}
function killBlurTimer()
{
   if(imageBlurTimer != kUNDEF)
   {
      trace("LoadingScreen: killStartTimer startTimerInterval = " + startTimerInterval);
      clearInterval(imageBlurTimer);
      imageBlurTimer = kUNDEF;
   }
}
function killIconDisplayTimer()
{
   if(iconDisplayTimer != kUNDEF)
   {
      clearInterval(iconDisplayTimer);
      iconDisplayTimer = kUNDEF;
   }
}
function killTimers()
{
   killContinueTimer();
   killHideTimer();
   killStartTimer();
   killBlurTimer();
   killIconDisplayTimer();
}
function hidePanel()
{
   trace("LoadingScreen: hidePanel");
   killTimers();
   Panel._visible = false;
}
function onUnload(mc)
{
   trace("LoadingScreen: onUnload");
   hidePanel();
   unloadMovie(mapSWF);
   _global.resizeManager.RemoveListener(_global.LoadingMovie);
   _global.tintManager.DeregisterAll(_global.LoadingMovie);
   delete _global.LoadingMovie;
   delete _global.LoadingAPI;
   return true;
}
function onLoaded()
{
   _global.FrontEndBackgroundMovie.hideBackground();
   _global.resizeManager.AddListener(this);
   Panel._visible = false;
   onResize(_global.resizeManager);
   gameModeData = _global.GameInterface.LoadKVFile("GameModes.txt");
   gameAPI.OnReady();
}
_global.LoadingMovie = this;
_global.LoadingAPI = gameAPI;
var LoadingNav = new Lib.NavLayout();
LoadingNav.DenyInputToGame(true);
LoadingNav.ShowCursor(true);
LoadingNav.MakeExclusive(true);
var kUNDEF = 1.7976931348623157e308;
var continueTimerInterval = kUNDEF;
var hideTimerInterval = kUNDEF;
var timeTillHide = 0.5;
var startTimerInterval = kUNDEF;
var imageBlurTimer = kUNDEF;
var iconDisplayTimer = kUNDEF;
var gameModeData;
var movieLoader;
var timeOfLastPhaseChange;
var mapImageLoaded;
var mapName;
var timeTillAutoContinue = 5;
var m_nFailedToLoadOverviewTimes = 0;
var m_nFailedToLoadOverviewTimesGLOBAL = 0;
var m_bOverviewLoadSucceeded = false;
var m_bStartedIconReveal = false;
var m_nIconRevealIndex = 0;
var infoMapName;
var infoGameType;
var infoGameMode;
var infoScenario;
var bShowMapSwf = true;
var mapSWF = undefined;
var thumbnailSize;
var overviewSize;
var Placeholder = undefined;
var ThumbNailImage = undefined;
var BG_BLUR_MAX = 50;
var m_nTargetMinBlur = 0;
var m_nBGBlur = BG_BLUR_MAX;
var m_MapIconWidth = Panel.MainText.MapIcon._width;
var m_MapIconHeight = Panel.MainText.MapIcon._height;
var m_IconsToShowArray = [];
LoadingNav.SetInitialHighlight(Panel.ContinueButton);
LoadingNav.AddKeyHandlerTable({ACCEPT:{onDown:function(button, control, keycode)
{
   gameAPI.ContinueButtonPressed();
}},KEY_ESCAPE:{onDown:function(button, control, keycode)
{
   gameAPI.ContinueButtonPressed();
}}});
var infoMapName;
var infoGameType;
var infoGameMode;
var infoScenario;
var infoThumbPath;
var hintText;
_global.resizeManager.AddListener(this);
stop();
