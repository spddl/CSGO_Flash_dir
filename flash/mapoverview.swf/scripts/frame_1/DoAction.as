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
   m_szMetersString = _global.GameInterface.Translate("#SFUI_Meters");
   m_szSecondsString = _global.GameInterface.Translate("#SFUI_Seconds");
   m_szSecondString = _global.GameInterface.Translate("#SFUI_Seconds");
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
   m_bShowGrid = false;
   if(_global.GameInterface.GetConvarNumber("mapoverview_allow_grid_usage") == 1)
   {
      m_bShowGrid = true;
   }
   if(m_bSnapToGrid == true && m_bShowGrid == false)
   {
      ToggleSnapToGrid();
   }
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
   RadarModule.ColorButton1._visible = m_bShouldDrawLines;
   RadarModule.ColorButton2._visible = m_bShouldDrawLines;
   RadarModule.DistanceText._visible = m_bShouldDrawLines;
   RadarModule.SnapToGridText._visible = m_bShouldDrawLines && m_bShowGrid;
   RadarModule.GridSizeText._visible = m_bShouldDrawLines && m_bShowGrid;
   DrawGrid();
   _global.navManager.PushLayout(overviewNav,"overviewNav");
}
function hidePanel()
{
   if(isShown)
   {
      RadarModule.gotoAndPlay("StartHide");
      isShown = false;
      m_bIsDrawing = false;
      m_bStartDrawingWithShift = false;
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
      m_bStartDrawingWithShift = false;
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
      _global.SFMapOverview.onProxyPressed(false);
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
   m_bStartDrawingWithShift = false;
   InitColorBox1();
   InitColorBox2();
   UpdateSnapToGridText();
   UpdateGridSizeText();
   gameAPI.OnReady();
   trace("------------- MapOverview: onLoaded ");
   _global.KeyDownEvent = function(key, vkey, slot, binding)
   {
      Lib.SFKey.setKeyCode(key,vkey,slot,binding);
      var _loc2_ = Lib.SFKey.KeyName(Lib.SFKey.getKeyCode());
      if(_loc2_ == "MOUSE_RIGHT")
      {
         RightClickManager();
      }
      return _global.navManager.onKeyDown();
   };
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
function RightClickManager()
{
}
function onProxyPressedLeft()
{
   onProxyPressed(false);
}
function onProxyPressedRight()
{
   onProxyPressed(true);
}
function onProxyPressed(bIsRight)
{
   if(m_bShouldDrawLines)
   {
      if(bIsRight == false)
      {
         trace("left mouse click");
         m_bIsRightMouseClick = false;
      }
      else
      {
         trace("right mouse click");
         m_bIsRightMouseClick = true;
      }
      m_bNewLine = true;
      m_nOriginalMouseX = drawLayer._xmouse;
      m_nOriginalMouseY = drawLayer._ymouse;
      if(m_bShiftKeyDown == true)
      {
         if(m_bIsDrawing == false)
         {
            StartDistanceDrawing();
         }
         m_bStartDrawingWithShift = true;
      }
      else
      {
         m_bStartDrawingWithShift = false;
      }
      m_bIsDrawing = true;
   }
}
function onProxyMouseMoved()
{
   var _loc4_ = drawLayer._xmouse;
   var _loc3_ = drawLayer._ymouse;
   trace("onProxyMouseMoved");
   if(m_bSnapToGrid == true)
   {
      UpdateClosestGridSnapPoint();
   }
   if(drawLayer && m_bIsDrawing)
   {
      var _loc8_ = m_activeDrawColor1;
      if(m_bIsRightMouseClick)
      {
         _loc8_ = m_activeDrawColor2;
      }
      var _loc20_ = currentDate.getTime();
      var _loc13_ = false;
      var _loc1_ = 0;
      var _loc17_ = drawLayer._xmouse;
      var _loc16_ = drawLayer._ymouse;
      if(m_bShiftKeyDown)
      {
         _loc1_ = lineDataMaster.length - 1;
         if(_loc1_ == 0)
         {
            _loc1_ = 1;
         }
         _loc13_ = true;
      }
      if(m_bSnapToGrid == true)
      {
         _loc4_ = m_gridSnapPoint.x;
         _loc3_ = m_gridSnapPoint.y;
      }
      var _loc11_ = lineDataMaster[_loc1_].length - 1;
      var _loc19_ = lineDataMaster[_loc1_][_loc11_].x;
      var _loc18_ = lineDataMaster[_loc1_][_loc11_].y;
      var _loc12_ = _loc17_ - _loc19_;
      var _loc10_ = _loc16_ - _loc18_;
      if(Math.sqrt(_loc12_ * _loc12_ + _loc10_ * _loc10_) < 9)
      {
         return undefined;
      }
      trace("onProxyMouseMoved: [" + _loc1_ + "], X:" + _loc4_ + ", Y:" + _loc3_);
      AddPoint(_loc1_,_loc4_,_loc3_,_loc8_,_loc13_);
      if(lineDataMaster[_loc1_].length > 1000)
      {
         lineDataMaster[_loc1_].shift();
      }
      var _loc2_ = lineDataMaster[_loc1_].length - 2;
      var _loc9_ = lineDataMaster[_loc1_].length - 1;
      if(_loc2_ >= 0)
      {
         trace("indexFrom =" + _loc2_);
         var _loc7_ = lineDataMaster[_loc1_][_loc2_].x;
         var _loc6_ = lineDataMaster[_loc1_][_loc2_].y;
         var _loc15_ = _loc7_;
         var _loc14_ = _loc6_;
         indexPrev = lineDataMaster[_loc1_].length - 3;
         if(indexPrev >= 0 && lineDataMaster[_loc1_][_loc2_].newline == false)
         {
            _loc19_ = lineDataMaster[_loc1_][indexPrev].x;
            _loc18_ = lineDataMaster[_loc1_][indexPrev].y;
            var _loc5_ = 1.25;
            _loc15_ = (1 - _loc5_) * _loc19_ + _loc5_ * _loc7_;
            _loc14_ = (1 - _loc5_) * _loc18_ + _loc5_ * _loc6_;
         }
         if(m_bSnapToGrid == true)
         {
            DrawLine(lineDataMaster[_loc1_][_loc2_],lineDataMaster[_loc1_][_loc9_]);
         }
         else
         {
            DrawCurveLine(lineDataMaster[_loc1_][_loc2_],lineDataMaster[_loc1_][_loc9_],_loc15_,_loc14_);
         }
         trace("Drawing line from:  X:" + _loc7_ + ", Y:" + _loc6_);
      }
      m_bNewLine = false;
   }
   m_nOriginalMouseX = _loc4_;
   m_nOriginalMouseY = _loc3_;
}
function AddPoint(index, x1, y1, color, bTrackDist)
{
   var _loc7_ = currentDate.getTime();
   var _loc1_ = new Array();
   _loc1_.x = x1;
   _loc1_.y = y1;
   _loc1_.color_r = color.color_r;
   _loc1_.color_g = color.color_g;
   _loc1_.color_b = color.color_b;
   _loc1_.time = _loc7_;
   _loc1_.newline = m_bNewLine;
   _loc1_.trackdist = bTrackDist;
   _loc1_["delete"] = false;
   lineDataMaster[index].push(_loc1_);
   var _loc3_ = lineDataMaster[index].length - 1;
   trace("Adding point at [" + index + "]: " + _loc3_ + ", X:" + x1 + ", Y:" + y1);
   trace("lineDataMaster[" + index + "].length-1 = " + _loc3_);
   m_nLastDrawPointX = x1;
   m_nLastDrawPointY = y1;
   m_bNewLine = false;
}
function UpdateClosestGridSnapPoint()
{
   if(m_bShowGrid == false)
   {
      return undefined;
   }
   var _loc1_ = gridSizeArray[m_nActiveGridSizeSlot];
   var _loc5_ = drawLayer._xmouse % _loc1_ / _loc1_;
   var _loc4_ = drawLayer._ymouse % _loc1_ / _loc1_;
   if(_loc5_ > 0.4 && _loc5_ < 0.6 || _loc4_ > 0.4 && _loc4_ < 0.6)
   {
      return undefined;
   }
   var _loc3_ = Math.round(drawLayer._xmouse / _loc1_) * _loc1_;
   var _loc2_ = Math.round(drawLayer._ymouse / _loc1_) * _loc1_;
   RadarModule.DrawLayer.SnapPoint._visible = true;
   RadarModule.DrawLayer.SnapPoint._x = _loc3_ - RadarModule.DrawLayer.SnapPoint._width / 2;
   RadarModule.DrawLayer.SnapPoint._y = _loc2_ - RadarModule.DrawLayer.SnapPoint._height / 2;
   m_gridSnapPoint.x = _loc3_;
   m_gridSnapPoint.y = _loc2_;
}
function onProxyReleased()
{
   if(m_bShiftKeyDown)
   {
      StopDistanceDrawing();
   }
   m_nOriginalMouseX = -1;
   m_nOriginalMouseY = -1;
   m_bIsDrawing = false;
   m_bIsRightMouseClick = false;
}
function StartDistanceDrawing()
{
   var _loc5_ = new Array();
   lineDataMaster.push(_loc5_);
   var _loc3_ = lineDataMaster.length - 1;
   trace("StartDistanceDrawing: lineDataMaster.length = " + lineDataMaster.length);
   trace("StartDistanceDrawing: " + spot + ", X:" + m_nOriginalMouseX + ", Y:" + m_nOriginalMouseY);
   var _loc4_ = m_activeDrawColor1;
   if(m_bIsRightMouseClick)
   {
      _loc4_ = m_activeDrawColor2;
   }
   AddPoint(_loc3_,m_nOriginalMouseX,m_nOriginalMouseY,_loc4_,true);
   var _loc2_ = new Array();
   _loc2_.inches = 1;
   _loc2_.time = 1;
   _loc2_.starticon = 1;
   _loc2_.endicon = 1;
   _loc2_.disttext = 1;
   lineDataMasterDist[_loc3_] = _loc2_;
   var _loc1_ = RadarModule.DrawLayer.DrawDistStart.duplicateMovieClip("starticon" + _loc3_,RadarModule.DrawLayer.getNextHighestDepth());
   _loc1_._visible = true;
   _loc1_._x = m_nOriginalMouseX - _loc1_._width / 2;
   _loc1_._y = m_nOriginalMouseY - _loc1_._height / 2;
   _loc1_.gotoAndPlay(1);
   lineDataMasterDist[_loc3_].starticon = _loc1_;
}
function StopDistanceDrawing()
{
   trace("StopDistanceDrawing");
   var _loc3_ = lineDataMaster.length - 1;
   var _loc18_ = RadarModule.DrawLayer.DrawDistEnd.duplicateMovieClip("endicon" + _loc3_,RadarModule.DrawLayer.getNextHighestDepth());
   _loc18_._visible = true;
   _loc18_._x = m_nOriginalMouseX - _loc18_._width / 2;
   _loc18_._y = m_nOriginalMouseY - _loc18_._height / 2;
   _loc18_.gotoAndPlay(1);
   lineDataMasterDist[_loc3_].endicon = _loc18_;
   var _loc15_ = 0;
   var _loc28_ = 0;
   var _loc19_ = lineDataMaster[_loc3_].length;
   var _loc2_ = 1;
   while(_loc2_ < _loc19_)
   {
      if(lineDataMaster[_loc3_][_loc2_].newline == false)
      {
         var _loc14_ = Math.round(lineDataMaster[_loc3_][_loc2_ - 1].x);
         var _loc13_ = Math.round(lineDataMaster[_loc3_][_loc2_ - 1].y);
         var _loc11_ = Math.round(lineDataMaster[_loc3_][_loc2_].x);
         var _loc9_ = Math.round(lineDataMaster[_loc3_][_loc2_].y);
         var _loc5_ = {x:_loc14_,y:_loc13_};
         drawLayer.localToGlobal(_loc5_);
         RadarModule.Radar.IconRotation.IconTranslation.globalToLocal(_loc5_);
         var _loc4_ = {x:_loc11_,y:_loc9_};
         drawLayer.localToGlobal(_loc4_);
         RadarModule.Radar.IconRotation.IconTranslation.globalToLocal(_loc4_);
         var _loc10_ = _loc5_.x;
         var _loc7_ = _loc5_.y;
         var _loc8_ = _loc4_.x;
         var _loc6_ = _loc4_.y;
         var _loc12_ = int(_global.SFMapOverviewGameAPI.GetWorldDistance(_loc10_,_loc7_,_loc8_,_loc6_));
         _loc15_ = _loc15_ + _loc12_;
      }
      _loc2_ = _loc2_ + 1;
   }
   var _loc26_ = int(_loc15_);
   var _loc27_ = int(_loc15_ / 250 + 0.5);
   lineDataMasterDist[_loc3_].inches = _loc26_;
   lineDataMasterDist[_loc3_].time = _loc27_;
   var _loc20_ = RadarModule.DrawLayer.DistanceText.duplicateMovieClip("disttext" + _loc3_,RadarModule.DrawLayer.getNextHighestDepth());
   var _loc25_ = lineDataMasterDist[_loc3_].inches;
   var _loc21_ = lineDataMasterDist[_loc3_].time;
   var _loc24_ = int(_loc25_ * 0.0254);
   var _loc22_ = m_szSecondsString;
   if(_loc21_ <= 1)
   {
      _loc22_ = m_szSecondString;
   }
   var _loc23_ = _loc24_ + " " + m_szMetersString + "\n~" + _loc21_ + " " + _loc22_;
   _loc20_.Text.htmlText = _loc23_;
   _loc20_._x = m_nOriginalMouseX + 8;
   _loc20_._y = m_nOriginalMouseY - _loc20_._height / 6;
   lineDataMasterDist[_loc3_].disttext = _loc20_;
}
function RGBtoHEX(r, g, b)
{
   var _loc1_ = r << 16 | g << 8 | b;
   return _loc1_;
}
function DrawLine(dataFrom, dataTo)
{
   if(drawLayer && drawLayer._visible == true)
   {
      if(dataTo.newline == false)
      {
         var _loc4_ = RGBtoHEX(dataTo.color_r,dataTo.color_g,dataTo.color_b);
         var _loc7_ = 100;
         drawLayer.lineStyle(nLineThickness,_loc4_,_loc7_);
         var _loc3_ = Math.round(dataFrom.x);
         var _loc2_ = Math.round(dataFrom.y);
         var _loc6_ = Math.round(dataTo.x);
         var _loc5_ = Math.round(dataTo.y);
         drawLayer.moveTo(_loc3_,_loc2_);
         drawLayer.lineTo(_loc6_,_loc5_);
         trace("drawing line from (" + _loc3_ + ", " + _loc2_ + ")");
      }
   }
}
function DrawCurveLine(dataFrom, dataTo, midX, midY)
{
   if(drawLayer && drawLayer._visible == true)
   {
      if(dataTo.newline == false)
      {
         var _loc4_ = RGBtoHEX(dataTo.color_r,dataTo.color_g,dataTo.color_b);
         var _loc7_ = 100;
         drawLayer.lineStyle(nLineThickness,_loc4_,_loc7_);
         var _loc3_ = Math.round(dataFrom.x);
         var _loc2_ = Math.round(dataFrom.y);
         var _loc9_ = midX;
         var _loc8_ = midY;
         var _loc6_ = Math.round(dataTo.x);
         var _loc5_ = Math.round(dataTo.y);
         drawLayer.moveTo(_loc3_,_loc2_);
         drawLayer.curveTo(_loc9_,_loc8_,_loc6_,_loc5_);
         trace("drawing line from (" + _loc3_ + ", " + _loc2_ + ")");
      }
   }
}
function DrawLines()
{
   if(drawLayer && drawLayer._visible == true)
   {
      var _loc26_ = currentDate.getTime();
      drawLayer.clear();
      var _loc30_ = drawLayer._width;
      var _loc29_ = drawLayer._height;
      var _loc28_ = lineDataMaster.length;
      var _loc2_ = 0;
      while(_loc2_ < _loc28_)
      {
         var _loc20_ = lineDataMaster[_loc2_].length;
         if(_loc20_ >= 2)
         {
            var _loc12_ = 0;
            var _loc27_ = 0;
            var _loc3_ = 1;
            while(_loc3_ < _loc20_)
            {
               var _loc4_ = 100;
               var _loc19_ = lineDataMaster[_loc2_][_loc3_].time;
               var _loc7_ = _loc26_ - _loc19_;
               if(_loc7_ > 60001)
               {
                  _loc4_ = Math.round((1 - (_loc7_ - 8000) / 1250) * 100);
                  if(_loc4_ <= 0)
                  {
                     _loc4_ = 0;
                     lineDataMaster[_loc2_][_loc3_]["delete"] = true;
                  }
                  trace("flAlpha = " + _loc4_ + ", flDiff = " + _loc7_);
               }
               if(lineDataMaster[_loc2_][_loc3_].newline == false)
               {
                  var _loc16_ = RGBtoHEX(lineDataMaster[_loc2_][_loc3_].color_r,lineDataMaster[_loc2_][_loc3_].color_g,lineDataMaster[_loc2_][_loc3_].color_b);
                  drawLayer.lineStyle(nLineThickness,_loc16_,_loc4_);
                  var _loc11_ = Math.round(lineDataMaster[_loc2_][_loc3_ - 1].x);
                  var _loc10_ = Math.round(lineDataMaster[_loc2_][_loc3_ - 1].y);
                  var _loc9_ = Math.round(lineDataMaster[_loc2_][_loc3_].x);
                  var _loc8_ = Math.round(lineDataMaster[_loc2_][_loc3_].y);
                  drawLayer.moveTo(_loc11_,_loc10_);
                  drawLayer.lineTo(_loc9_,_loc8_);
                  trace("Drawing lines in array " + _loc2_);
               }
               var _loc21_ = RadarModule._xscale / 100;
               var _loc6_ = {x:_loc11_,y:_loc10_};
               drawLayer.localToGlobal(_loc6_);
               RadarModule.Radar.IconRotation.IconTranslation.globalToLocal(_loc6_);
               var _loc5_ = {x:_loc9_,y:_loc8_};
               drawLayer.localToGlobal(_loc5_);
               RadarModule.Radar.IconRotation.IconTranslation.globalToLocal(_loc5_);
               var _loc17_ = _loc6_.x;
               var _loc14_ = _loc6_.y;
               var _loc15_ = _loc5_.x;
               var _loc13_ = _loc5_.y;
               var _loc18_ = int(_global.SFMapOverviewGameAPI.GetWorldDistance(_loc17_,_loc14_,_loc15_,_loc13_));
               _loc12_ = _loc12_ + _loc18_;
               _loc3_ = _loc3_ + 1;
            }
            var _loc22_ = int(_loc12_);
            var _loc23_ = int(_loc12_ / 250 + 0.5);
            lineDataMasterDist[_loc2_].inches = _loc22_;
            lineDataMasterDist[_loc2_].time = _loc23_;
            RadarModule.DistanceText.SetText("Dist = " + int(_loc22_ / 12) + " ft, Time = ~" + _loc23_ + " sec");
            _loc3_ = 0;
            while(_loc3_ < lineDataMaster[_loc2_].length)
            {
               if(lineDataMaster[_loc2_][_loc3_]["delete"] == true)
               {
                  lineDataMaster[_loc2_].splice(_loc3_,1);
                  trace("removing line point  (" + _loc3_ + ")");
                  _loc3_ = _loc3_ - 1;
               }
               _loc3_ = _loc3_ + 1;
            }
         }
         _loc2_ = _loc2_ + 1;
      }
   }
}
function ClearAllLines()
{
   lineDataMaster = [];
   var _loc7_ = new Array();
   lineDataMaster.push(_loc7_);
   var _loc5_ = lineDataMasterDist.length;
   var _loc1_ = 0;
   while(_loc1_ < _loc5_)
   {
      var _loc3_ = lineDataMasterDist[_loc1_].starticon;
      if(_loc3_)
      {
         _loc3_.removeMovieClip();
      }
      var _loc4_ = lineDataMasterDist[_loc1_].endicon;
      if(_loc4_)
      {
         _loc4_.removeMovieClip();
      }
      var _loc2_ = lineDataMasterDist[_loc1_].disttext;
      if(_loc2_)
      {
         _loc2_.removeMovieClip();
      }
      _loc1_ = _loc1_ + 1;
   }
   trace("ClearAllLines: Removing " + _loc5_ + " items");
   lineDataMasterDist = [];
   lineDataMasterDist.length = 0;
   var _loc6_ = new Array();
   _loc6_.inches = 1;
   _loc6_.time = 1;
   lineDataMasterDist.push(_loc6_);
   if(drawLayer && drawLayer._visible == true)
   {
      drawLayer.clear();
   }
   trace("ClearAllLines");
}
function InitColorBox1()
{
   var _loc2_ = RadarModule.ColorButton1;
   if(_loc2_ != undefined)
   {
      _loc2_.dialog = this;
      _loc2_.Action = function()
      {
         ToggleDrawColor1();
      };
      trace("found ColorBox");
      _loc2_.ButtonText.SetText("#SFUIHUD_MapOverview_NextColor1");
      _loc2_._visible = true;
   }
   UpdateColorButton1();
}
function ToggleDrawColor1()
{
   m_nActiveDrawColorNum1 = m_nActiveDrawColorNum1 + 1;
   if(m_nActiveDrawColorNum1 >= drawColorsArray.length)
   {
      m_nActiveDrawColorNum1 = 0;
   }
   m_activeDrawColor1 = drawColorsArray[m_nActiveDrawColorNum1];
   UpdateColorButton1();
}
function UpdateColorButton1()
{
   var _loc1_ = new flash.geom.ColorTransform();
   _loc1_.rgb = RGBtoHEX(m_activeDrawColor1.color_r,m_activeDrawColor1.color_g,m_activeDrawColor1.color_b);
   var _loc2_ = new flash.geom.Transform(RadarModule.ColorButton1.Color);
   _loc2_.colorTransform = _loc1_;
}
function InitColorBox2()
{
   var _loc2_ = RadarModule.ColorButton2;
   if(_loc2_ != undefined)
   {
      _loc2_.dialog = this;
      _loc2_.Action = function()
      {
         ToggleDrawColor2();
      };
      trace("found ColorBox2");
      _loc2_.ButtonText.SetText("#SFUIHUD_MapOverview_NextColor2");
      _loc2_._visible = true;
   }
   UpdateColorButton2();
}
function ToggleDrawColor2()
{
   m_nActiveDrawColorNum2 = m_nActiveDrawColorNum2 + 1;
   if(m_nActiveDrawColorNum2 >= drawColorsArray.length)
   {
      m_nActiveDrawColorNum2 = 0;
   }
   m_activeDrawColor2 = drawColorsArray[m_nActiveDrawColorNum2];
   UpdateColorButton2();
}
function UpdateColorButton2()
{
   var _loc1_ = new flash.geom.ColorTransform();
   _loc1_.rgb = RGBtoHEX(m_activeDrawColor2.color_r,m_activeDrawColor2.color_g,m_activeDrawColor2.color_b);
   var _loc2_ = new flash.geom.Transform(RadarModule.ColorButton2.Color);
   _loc2_.colorTransform = _loc1_;
}
function ToggleSnapToGrid()
{
   m_bSnapToGrid = !m_bSnapToGrid;
   UpdateSnapToGridText();
   UpdateGridSizeText();
   DrawGrid();
   if(m_bSnapToGrid)
   {
      _global.navManager.PlayNavSound("ButtonAction");
      RadarModule.DrawLayer.SnapPoint._visible = true;
   }
   else
   {
      _global.navManager.PlayNavSound("ButtonRollover");
      RadarModule.DrawLayer.SnapPoint._visible = false;
   }
}
function UpdateSnapToGridText()
{
   var _loc1_ = RadarModule.SnapToGridText;
   if(_loc1_ != undefined)
   {
      _loc1_.Text.htmlText = "[A] Turn Off Grid Snap";
      if(m_bSnapToGrid)
      {
         _loc1_.Text.htmlText = "[A] Turn Off Grid Snap";
      }
      else
      {
         _loc1_.Text.htmlText = "[A] Turn On Grid Snap";
      }
      _loc1_._visible = true;
   }
}
function ToggleGridSize()
{
   m_nActiveGridSizeSlot = m_nActiveGridSizeSlot + 1;
   if(m_nActiveGridSizeSlot >= gridSizeArray.length)
   {
      m_nActiveGridSizeSlot = 0;
   }
   UpdateSnapToGridText();
   UpdateGridSizeText();
   _global.navManager.PlayNavSound("ButtonAction");
   DrawGrid();
}
function DrawGrid()
{
   var _loc3_ = 346;
   var _loc6_ = 74;
   var _loc4_ = 586;
   drawLayerGrid.clear();
   if(m_bShouldDrawLines == false || m_bSnapToGrid == false || m_bShowGrid == false)
   {
      return undefined;
   }
   var _loc2_ = gridSizeArray[m_nActiveGridSizeSlot];
   var _loc1_ = 1;
   while(_loc1_ < 2000)
   {
      if(_loc1_ * _loc2_ > _loc3_ + _loc4_)
      {
         break;
      }
      var _loc5_ = drawColorsArray[7];
      var _loc9_ = RGBtoHEX(_loc5_.color_r,_loc5_.color_g,_loc5_.color_b);
      var _loc12_ = 5;
      drawLayerGrid.lineStyle(0.1,_loc9_,_loc12_);
      var _loc7_ = Math.round(_loc1_ * _loc2_);
      var _loc13_ = _loc6_;
      var _loc10_ = _loc6_ + _loc4_;
      if(_loc1_ * _loc2_ > _loc3_ && _loc1_ * _loc2_ < _loc3_ + _loc4_)
      {
         drawLayerGrid.moveTo(_loc7_,_loc13_);
         drawLayerGrid.lineTo(_loc7_,_loc10_);
      }
      var _loc8_ = Math.round(_loc1_ * _loc2_);
      var _loc14_ = _loc3_;
      var _loc11_ = _loc3_ + _loc4_;
      if(_loc1_ * _loc2_ > _loc6_ && _loc1_ * _loc2_ < _loc6_ + _loc4_)
      {
         drawLayerGrid.moveTo(_loc14_,_loc8_);
         drawLayerGrid.lineTo(_loc11_,_loc8_);
      }
      _loc1_ = _loc1_ + 1;
   }
}
function UpdateGridSizeText()
{
   var _loc1_ = RadarModule.GridSizeText;
   if(_loc1_ != undefined)
   {
      _loc1_.Text.htmlText = "[S] Grid Size: " + gridSizeArray[m_nActiveGridSizeSlot];
      _loc1_._visible = true;
   }
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
var m_bShowGrid = false;
var m_nOriginalMouseX = -1;
var m_nOriginalMouseY = -1;
var m_nLastDrawPointX = -1;
var m_nLastDrawPointY = -1;
var m_bShouldDrawLines = false;
var m_bShiftKeyDown = false;
var m_bStartDrawingWithShift = false;
var m_bIsRightMouseClick = false;
var m_szMetersString = "";
var m_szSecondsString = "";
var m_szSecondString = "";
var m_gridSnapPoint = {x:1,y:1};
var m_bSnapToGrid = false;
var currentDate = new Date();
var drawLayer = RadarModule.DrawLayer;
var drawLayerGrid = RadarModule.DrawLayerGrid;
RadarModule.DrawLayer.DrawDistEnd._visible = false;
RadarModule.DrawLayer.DrawDistStart._visible = false;
RadarModule.DrawLayer.DistanceText._visible = false;
RadarModule.DrawLayer.SnapPoint._visible = false;
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
drawColorsArray[4].color_g = 200;
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
var m_activeDrawColor1 = new Array();
var m_activeDrawColor2 = new Array();
var m_nActiveDrawColorNum1 = 0;
var m_nActiveDrawColorNum2 = 4;
m_activeDrawColor1 = drawColorsArray[m_nActiveDrawColorNum1];
m_activeDrawColor2 = drawColorsArray[m_nActiveDrawColorNum2];
var m_nActiveGridSizeSlot = 1;
var gridSizeArray = new Array();
gridSizeArray[0] = 10;
gridSizeArray[1] = 20;
gridSizeArray[2] = 40;
var lineDataMaster = new Array();
var lineDataMasterDist = new Array();
var lineData = new Array();
lineDataMaster.push(lineData);
var dist = new Array();
dist.inches = 1;
dist.time = 1;
lineDataMasterDist.push(dist);
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
      ToggleDrawColor1();
      return true;
   }
   return false;
},onUp:function(button, control, keycode)
{
   return true;
}},"KEY_Z");
overviewNav.AddKeyHandlers({onDown:function(button, control, keycode)
{
   if(_global.SFMapOverview != undefined && _global.SFMapOverview != null && _global.SFMapOverview.isShown)
   {
      ToggleDrawColor2();
      return true;
   }
   return false;
},onUp:function(button, control, keycode)
{
   return true;
}},"KEY_X");
overviewNav.AddKeyHandlers({onDown:function(button, control, keycode)
{
   if(m_bIsDrawing == false)
   {
      trace("m_bShiftKeyDown = true");
      m_bShiftKeyDown = true;
   }
   return true;
},onUp:function(button, control, keycode)
{
   if(m_bIsDrawing && m_bShiftKeyDown)
   {
      StopDistanceDrawing();
   }
   trace("m_bShiftKeyDown = false");
   m_bShiftKeyDown = false;
   return true;
}},"KEY_LSHIFT","KEY_RSHIFT");
overviewNav.AddKeyHandlers({onDown:function(button, control, keycode)
{
   return true;
},onUp:function(button, control, keycode)
{
   if(m_bShowGrid == true)
   {
      trace("ToggleSnapToGrid");
      ToggleSnapToGrid();
   }
   return true;
}},"KEY_A");
overviewNav.AddKeyHandlers({onDown:function(button, control, keycode)
{
   return true;
},onUp:function(button, control, keycode)
{
   if(m_bShowGrid == true)
   {
      trace("ToggleGridSize");
      ToggleGridSize();
   }
   return true;
}},"KEY_S");
overviewNav.AddKeyHandlers({onDown:function(button, control, keycode)
{
   onProxyPressedRight();
   return true;
},onUp:function(button, control, keycode)
{
   onProxyReleased();
   return true;
}},"MOUSE_RIGHT");
_global.resizeManager.AddListener(this);
stop();
