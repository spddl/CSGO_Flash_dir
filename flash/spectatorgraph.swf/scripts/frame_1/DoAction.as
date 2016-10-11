function onLoadInit(clip)
{
   if(clip._width != clip._height)
   {
      trace("*****************");
      trace("Level radar image: " + mapPath + " is not square");
      trace("*****************");
   }
   trace("------------- MapOverview: onLoadInit: MapLoaded - clip = " + clip);
   _global.SFMapOverviewGameAPI.MapLoaded(MAPSIZE,MAPSIZE / clip._width);
   clip._visible = true;
   clip._width = MAPSIZE;
   clip._height = MAPSIZE;
   clip._x = 0;
   clip._y = 0;
   delete mapName;
   delete mapPath;
   delete movieLoader;
}
function onLoadError(clip, errorCode)
{
   trace("*****************");
   trace(errorCode);
   trace("*****************");
   delete movieLoader;
   if(errorCode == "URLNotFound" && !bDidntFindSpecMap)
   {
      bDidntFindSpecMap = true;
      trace("Didn\'t find " + mapPath + ", trying to load the default radar map!");
      loadMap(mapName,true);
   }
}
function showPanel()
{
   if(!isShown)
   {
      onShow();
      RadarModule.gotoAndPlay("StartShow");
   }
}
function showPanelNow()
{
   if(!isShown)
   {
      onShow();
      RadarModule.gotoAndStop("Show");
   }
}
function onRefresh()
{
   if(RadarModule.Graph._visible == true && RadarModule.Graph._alpha == 100)
   {
      RadarModule.Graph.onRefresh();
   }
}
function onShow()
{
   var _loc2_ = _global.CScaleformComponent_MatchStats.ShouldShow();
   RadarModule._visible = true;
   RadarModule.Radar._visible = !_loc2_;
   RadarModule.Graph._visible = _loc2_;
   _global.SFRadar._visible = false;
   _global.SpectatorMovie.SpectatorMode.Panel._visible = false;
   _global.SpectatorMovie.SpectatorMode.Nav_Text._visible = false;
   _global.SpectatorMovie.OverviewBg._visible = true;
   _global.SpectatorMovie.OverviewBg._alpha = 30;
   isShown = true;
   if(_loc2_)
   {
      m_bIsDrawing = false;
      overviewNav.ShowCursor(true);
      overviewNav.MakeModal(true);
      m_bShouldDrawLines = false;
      RadarModule.Close._visible = false;
      RadarModule.OpenGraph._visible = false;
      RadarModule.DrawLayer._visible = false;
      RadarModule.Graph.m_strTypeDropdown = _global.CScaleformComponent_MatchStats.GetRangeNameByIndex(_global.CScaleformComponent_MatchStats.GetDesiredPage());
      RadarModule.Graph.GetGraphTypes();
      RadarModule.Graph.SetGraphDropdownType(RadarModule.Graph.m_strTypeDropdown);
   }
   else
   {
      m_bIsDrawing = false;
      if(_global.SFMapOverviewGameAPI.AllowMapDrawing())
      {
         m_bShouldDrawLines = true;
         overviewNav.ShowCursor(true);
         overviewNav.MakeModal(true);
         overviewNav.DenyInputToGame(false);
      }
      RadarModule.Close._visible = true;
      RadarModule.OpenGraph._visible = true;
      RadarModule.DrawLayer._visible = true;
   }
   RadarModule.ClearColorText._visible = m_bShouldDrawLines;
   RadarModule.btn_next._visible = m_bShouldDrawLines;
   _global.navManager.PushLayout(overviewNav,"overviewNav");
}
function hidePanel()
{
   if(isShown)
   {
      RadarModule.gotoAndPlay("StartHide");
      isShown = false;
      m_bIsDrawing = false;
      RadarModule.Graph._visible = false;
      _global.SpectatorMovie.OverviewBg._visible = false;
      _global.navManager.RemoveLayout(overviewNav);
      _global.SFRadar._visible = true;
      _global.SpectatorMovie.SpectatorMode.Panel._visible = true;
      _global.SpectatorMovie.SpectatorMode.Nav_Text._visible = true;
   }
}
function hidePanelNow()
{
   if(isShown)
   {
      RadarModule.gotoAndStop("Hide");
      isShown = false;
      m_bIsDrawing = false;
      RadarModule.Graph._visible = false;
      _global.SpectatorMovie.OverviewBg._visible = false;
      _global.navManager.RemoveLayout(overviewNav);
      _global.SFRadar._visible = true;
      _global.SpectatorMovie.SpectatorMode.Panel._visible = true;
   }
}
function IsGraphVisible()
{
   if(RadarModule.Graph._visible)
   {
      return true;
   }
   return false;
}
function loadMap(sMapName, bUseDefault)
{
   movieLoader = new MovieClipLoader();
   movieLoader.addListener(this);
   mapName = sMapName;
   if(bUseDefault)
   {
      mapPath = "../overviews/" + mapName + "_radar.dds";
   }
   else
   {
      mapPath = "../overviews/" + mapName + "_radar_spectate.dds";
   }
   movieLoader.loadClip(mapPath,RadarModule.Radar.MapRotation.MapTranslation.MapScale);
   trace("------------- MapOverview:  loaded " + mapPath);
}
function onLoaded()
{
   drawLayer.onPress = function()
   {
      _global.SFMapOverview.onProxyPressed();
   };
   drawLayer.onRelease = function()
   {
      _global.SFMapOverview.onProxyReleased();
   };
   drawLayer.onReleaseOutside = function()
   {
      _global.SFMapOverview.onProxyReleased();
   };
   drawLayer.onMouseMove = function()
   {
      _global.SFMapOverview.onProxyMouseMoved();
   };
   m_bIsDrawing = false;
   InitColorBox();
   gameAPI.OnReady();
   trace("------------- MapOverview: onLoaded ");
}
function onUnload(mc)
{
   delete _global.SFMapOverview;
   delete _global.SFMapOverviewGameAPI;
   _global.resizeManager.RemoveListener(this);
   _global.tintManager.DeregisterAll(this);
   _global.navManager.RemoveLayout(overviewNav);
   trace("------------- MapOverview: onUnload ");
   return true;
}
function onResize(rm)
{
   var _loc3_ = RadarModule.MapOverview.MapRotation._width;
   var _loc2_ = RadarModule.MapOverview.MapRotation._height;
   RadarModule.MapOverview.MapRotation._width = 32;
   RadarModule.MapOverview.MapRotation._height = 32;
   rm.DisableAdditionalScaling = true;
   rm.ResetPositionByPixel(RadarModule,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_CENTER_X,0,Lib.ResizeManager.ALIGN_CENTER,Lib.ResizeManager.REFERENCE_CENTER_Y,0,Lib.ResizeManager.ALIGN_CENTER);
   rm.DisableAdditionalScaling = false;
   RadarModule.MapOverview.MapRotation._width = _loc3_;
   RadarModule.MapOverview.MapRotation._height = _loc2_;
}
function onProxyPressed()
{
   if(m_bShouldDrawLines)
   {
      m_nOriginalMouseX = drawLayer._xmouse;
      m_nOriginalMouseY = drawLayer._ymouse;
      m_bIsDrawing = true;
      m_bNewLine = true;
   }
}
function onProxyMouseMoved()
{
   if(drawLayer && m_bIsDrawing)
   {
      currentDate = new Date();
      var _loc2_ = currentDate.getTime();
      var _loc1_ = new Array();
      _loc1_.x = drawLayer._xmouse;
      _loc1_.y = drawLayer._ymouse;
      _loc1_.color_r = activeDrawColor.color_r;
      _loc1_.color_g = activeDrawColor.color_g;
      _loc1_.color_b = activeDrawColor.color_b;
      _loc1_.time = _loc2_;
      _loc1_.newline = m_bNewLine;
      m_bNewLine = false;
      _loc1_["delete"] = false;
      lineData.push(_loc1_);
      trace("lineData[i][\'time\'] " + _loc2_);
      if(lineData.length > 1000)
      {
         lineData.shift();
      }
      DrawLines();
   }
   m_nOriginalMouseX = drawLayer._xmouse;
   m_nOriginalMouseY = drawLayer._ymouse;
}
function onProxyReleased()
{
   m_nOriginalMouseX = -1;
   m_nOriginalMouseY = -1;
   m_bIsDrawing = false;
}
function RGBtoHEX(r, g, b)
{
   var _loc1_ = r << 16 | g << 8 | b;
   return _loc1_;
}
function DrawLines()
{
   if(drawLayer && drawLayer._visible == true)
   {
      currentDate = new Date();
      var _loc11_ = currentDate.getTime();
      drawLayer.clear();
      var _loc13_ = drawLayer._width;
      var _loc12_ = drawLayer._height;
      var _loc10_ = lineData.length;
      if(_loc10_ < 2)
      {
         return undefined;
      }
      var _loc1_ = 1;
      while(_loc1_ < _loc10_)
      {
         var _loc2_ = 100;
         var _loc9_ = lineData[_loc1_].time;
         var _loc3_ = _loc11_ - _loc9_;
         if(_loc3_ > 60001)
         {
            _loc2_ = Math.round((1 - (_loc3_ - 8000) / 1250) * 100);
            if(_loc2_ <= 0)
            {
               _loc2_ = 0;
               lineData[_loc1_]["delete"] = true;
            }
            trace("flAlpha = " + _loc2_ + ", flDiff = " + _loc3_);
         }
         if(lineData[_loc1_].newline == false)
         {
            var _loc4_ = RGBtoHEX(lineData[_loc1_].color_r,lineData[_loc1_].color_g,lineData[_loc1_].color_b);
            drawLayer.lineStyle(nLineThickness,_loc4_,_loc2_);
            var _loc8_ = Math.round(lineData[_loc1_ - 1].x);
            var _loc7_ = Math.round(lineData[_loc1_ - 1].y);
            var _loc6_ = Math.round(lineData[_loc1_].x);
            var _loc5_ = Math.round(lineData[_loc1_].y);
            drawLayer.moveTo(_loc8_,_loc7_);
            drawLayer.lineTo(_loc6_,_loc5_);
         }
         _loc1_ = _loc1_ + 1;
      }
      _loc1_ = 0;
      while(_loc1_ < lineData.length)
      {
         if(lineData[_loc1_]["delete"] == true)
         {
            lineData.splice(_loc1_,1);
            trace("removing line point  (" + _loc1_ + ")");
            _loc1_ = _loc1_ - 1;
         }
         _loc1_ = _loc1_ + 1;
      }
   }
}
function ClearAllLines()
{
   lineData = [];
   lineData.length = 0;
   if(drawLayer && drawLayer._visible == true)
   {
      drawLayer.clear();
   }
}
function InitColorBox()
{
   var _loc1_ = RadarModule.btn_next;
   if(_loc1_ != undefined)
   {
      trace("found ColorBox");
      _loc1_.ButtonText.SetText("#SFUIHUD_MapOverview_NextColor");
      _loc1_._visible = true;
   }
   UpdateColorButton();
}
function ToggleDrawColor()
{
   nActiveDrawColorNum = nActiveDrawColorNum + 1;
   if(nActiveDrawColorNum >= drawColorsArray.length)
   {
      nActiveDrawColorNum = 0;
   }
   activeDrawColor = drawColorsArray[nActiveDrawColorNum];
   UpdateColorButton();
}
function UpdateColorButton()
{
   var _loc1_ = new flash.geom.ColorTransform();
   _loc1_.rgb = RGBtoHEX(activeDrawColor.color_r,activeDrawColor.color_g,activeDrawColor.color_b);
   var _loc2_ = new flash.geom.Transform(RadarModule.btn_next.Color);
   _loc2_.colorTransform = _loc1_;
}
var overviewNav = new Lib.NavLayout();
_global.SFMapOverview = this;
_global.SFMapOverviewGameAPI = gameAPI;
var movieLoader;
var mapName;
var mapPath;
var bDidntFindSpecMap = false;
var MAPSIZE = 455;
var isShown = true;
var m_bIsDrawing = false;
var m_nOriginalMouseX = -1;
var m_nOriginalMouseY = -1;
var m_bShouldDrawLines = false;
var drawLayer = RadarModule.DrawLayer;
RadarModule.Graph._visible = false;
var m_bNewLine = false;
var drawColorsArray = new Array();
drawColorsArray[0] = new Array();
drawColorsArray[0].color_r = 255;
drawColorsArray[0].color_g = 128;
drawColorsArray[0].color_b = 0;
drawColorsArray[1] = new Array();
drawColorsArray[1].color_r = 255;
drawColorsArray[1].color_g = 0;
drawColorsArray[1].color_b = 0;
drawColorsArray[2] = new Array();
drawColorsArray[2].color_r = 255;
drawColorsArray[2].color_g = 255;
drawColorsArray[2].color_b = 0;
drawColorsArray[3] = new Array();
drawColorsArray[3].color_r = 0;
drawColorsArray[3].color_g = 255;
drawColorsArray[3].color_b = 0;
drawColorsArray[4] = new Array();
drawColorsArray[4].color_r = 0;
drawColorsArray[4].color_g = 255;
drawColorsArray[4].color_b = 255;
drawColorsArray[5] = new Array();
drawColorsArray[5].color_r = 0;
drawColorsArray[5].color_g = 20;
drawColorsArray[5].color_b = 255;
drawColorsArray[6] = new Array();
drawColorsArray[6].color_r = 255;
drawColorsArray[6].color_g = 0;
drawColorsArray[6].color_b = 255;
drawColorsArray[7] = new Array();
drawColorsArray[7].color_r = 255;
drawColorsArray[7].color_g = 255;
drawColorsArray[7].color_b = 255;
var activeDrawColor = new Array();
var nActiveDrawColorNum = 0;
activeDrawColor = drawColorsArray[nActiveDrawColorNum];
var lineData = new Array();
var nLineThickness = 3;
overviewNav.AddKeyHandlers({onDown:function(button, control, keycode)
{
   if(_global.SFMapOverview != undefined && _global.SFMapOverview != null && _global.SFMapOverview.isShown)
   {
      ClearAllLines();
      return true;
   }
   return false;
},onUp:function(button, control, keycode)
{
   return true;
}},"KEY_SPACE");
overviewNav.AddKeyHandlers({onDown:function(button, control, keycode)
{
   if(_global.SFMapOverview != undefined && _global.SFMapOverview != null && _global.SFMapOverview.isShown)
   {
      ToggleDrawColor();
      return true;
   }
   return false;
},onUp:function(button, control, keycode)
{
   return true;
}},"KEY_ENTER");
_global.resizeManager.AddListener(this);
stop();
