function getLayerClipFromArray(layerArr, layerIdx)
{
   if(layerArr == null)
   {
      return null;
   }
   if(layerArr.length <= layerIdx)
   {
      return null;
   }
   return (MovieClip)layerArr[layerIdx];
}
function getLayerClip(layerIdx)
{
   var _loc1_ = !m_bIsRound?m_mapLayersSq:m_mapLayersRnd;
   return getLayerClipFromArray(_loc1_,layerIdx);
}
function createLayeredRadar()
{
   function finishCurrentTransition()
   {
      if(m_nextRadar)
      {
         trace("RADAR: Transition complete, clearing " + m_currentRadar._target);
         m_nextRadar._alpha = ADOBE_MAX_ALPHA;
         m_currentRadar._visible = false;
         m_currentRadar = m_nextRadar;
         m_nextRadar = null;
      }
   }
   function clearTweenUpdate()
   {
      RadarModule.Radar.onEnterFrame = null;
   }
   function forceLayerTransitionToComplete()
   {
      finishCurrentTransition();
      clearTweenUpdate();
   }
   function tweenUpdate()
   {
      var _loc2_ = m_nextRadar._alpha + ALPHA_PER_FRAME * ADOBE_MAX_ALPHA;
      if(_loc2_ < ADOBE_MAX_ALPHA)
      {
         m_nextRadar._alpha = _loc2_;
         return undefined;
      }
      finishCurrentTransition();
      var _loc1_ = getLayerClip(m_visibleLayer);
      if(_loc1_ == null || _loc1_ == m_currentRadar)
      {
         clearTweenUpdate();
         return undefined;
      }
      OnDesiredLayerChange();
   }
   function startTweenUpdate()
   {
      RadarModule.Radar.onEnterFrame = tweenUpdate;
   }
   function OnDesiredLayerChange()
   {
      var _loc1_ = getLayerClip(m_visibleLayer);
      if(_loc1_ == null)
      {
         return undefined;
      }
      if(m_currentRadar == null)
      {
         trace("RADAR: Pop to visible (from no radar):" + _loc1_._target);
         m_currentRadar = _loc1_;
         m_currentRadar._visible = true;
         m_currentRadar._alpha = ADOBE_MAX_ALPHA;
         return undefined;
      }
      if(m_nextRadar == null)
      {
         if(m_currentRadar == _loc1_)
         {
            return undefined;
         }
         m_nextRadar = _loc1_;
         trace("RADAR: Start transition, maing visible " + m_nextRadar._target);
         m_nextRadar._visible = true;
         m_nextRadar._alpha = 0;
         if(m_nextRadar.getDepth() < m_currentRadar.getDepth())
         {
            m_nextRadar.swapDepths(m_currentRadar);
         }
         startTweenUpdate();
         return undefined;
      }
      if(m_nextRadar == _loc1_)
      {
         return undefined;
      }
      if(m_currentRadar == _loc1_)
      {
         trace("RADAR: Flip transition direction");
         m_currentRadar = m_nextRadar;
         m_nextRadar = _loc1_;
         m_nextRadar.swapDepths(m_currentRadar);
         m_nextRadar._alpha = ADOBE_MAX_ALPHA - m_currentRadar._alpha;
         m_currentRadar._alpha = ADOBE_MAX_ALPHA;
         return undefined;
      }
   }
   function OnClipLoaded(clip)
   {
      trace("RADAR: clip loaded " + clip._target);
      if(clip == m_currentRadar || clip == m_nextRadar)
      {
         trace("RADAR: currently active clip loaded, making visible: " + clip._target);
         clip._visible = true;
         return undefined;
      }
      if(m_currentRadar != null)
      {
         OnDesiredLayerChange();
         return undefined;
      }
      var _loc2_ = getLayerClip(m_visibleLayer);
      if(_loc2_ == clip)
      {
         trace("RADAR: loaded clip is current layer, making visible: " + clip._target);
         clip._visible = true;
         m_currentRadar = clip;
      }
   }
   function PreSwitchRadarType()
   {
      trace("RADAR: PreSwitchType");
      forceLayerTransitionToComplete();
      if(m_currentRadar != null)
      {
         trace("RADAR: preswitch, making invisible: " + m_currentRadar._target);
         m_currentRadar._visible = false;
      }
      m_currentRadar = null;
   }
   function PostSwitchRadarType()
   {
      trace("RADAR: PostSwitchType");
      if(m_currentRadar != null)
      {
         PreSwitchRadarType();
      }
      OnDesiredLayerChange();
   }
   var ALPHA_PER_FRAME = 0.08;
   var ADOBE_MAX_ALPHA = 100;
   var m_currentRadar = null;
   var m_nextRadar = null;
   var _loc2_ = new Object();
   _loc2_.preSwitchRadarType = function()
   {
      PreSwitchRadarType();
   };
   _loc2_.postSwitchRadarType = function()
   {
      PostSwitchRadarType();
   };
   _loc2_.onDesiredLayerChange = function()
   {
      OnDesiredLayerChange();
   };
   _loc2_.onRadarClipLoaded = function(clip)
   {
      OnClipLoaded(clip);
   };
   return _loc2_;
}
function verifyMapClip(clip, name)
{
   if(clip._width != clip._height)
   {
      trace("*****************");
      trace("Level radar image: " + name + " is not square");
      trace("*****************");
   }
   var _loc3_ = RadarModule.Radar.MapRotationSq.BackgroundSq._width;
   _global.SFRadarGameAPI.MapLoaded(0.3125,_loc3_);
   clip._visible = false;
   clip._width = MAPSIZE;
   clip._height = MAPSIZE;
   clip._x = 0;
   clip._y = 0;
}
function createRadarLoader(radarType, layer, target)
{
   var _loc2_ = new Object();
   _loc2_.m_radarType = radarType;
   _loc2_.m_movieLoader = null;
   _loc2_.m_mapName = "unknown";
   _loc2_.m_target = target;
   _loc2_.m_layer = layer;
   _loc2_.onLoadInit = function(clip)
   {
      trace("RADAR: Loaded " + this.m_radarType + "(" + this.m_layer + ") radar image for " + this.m_mapName);
      verifyMapClip(clip,this.m_mapName);
      this.setLoader(null,"unknown");
      if(m_layeredRadar)
      {
         m_layeredRadar.onRadarClipLoaded(clip);
      }
   };
   _loc2_.onLoadError = function(clip, errorCode)
   {
      trace("*****************");
      trace(errorCode);
      trace("*****************");
   };
   _loc2_.beginLoad = function(mapName, filePath, clipArray)
   {
      this.m_mapName = mapName;
      var _loc2_ = new MovieClipLoader();
      var _loc3_ = this.m_target.createEmptyMovieClip("layer" + this.m_layer,this.m_target.getNextHighestDepth());
      this.setLoader(_loc2_,this.m_mapName);
      _loc2_.loadClip(filePath,_loc3_);
      if(clipArray != null && clipArray.length > this.m_layer)
      {
         clipArray[this.m_layer] = _loc3_;
      }
   };
   _loc2_.setLoader = function(loader, mapName)
   {
      if(this.m_movieLoader != null)
      {
         delete this.m_movieLoader;
      }
      this.m_movieLoader = loader;
      this.m_mapName = mapName;
      if(this.m_movieLoader != null)
      {
         loader.addListener(this);
      }
   };
   return _loc2_;
}
function ForceResizeHud()
{
   _global.ForceResize();
}
function showPanel()
{
   if(!m_bIsShown)
   {
      RadarModule._visible = true;
      RadarModule.gotoAndPlay("StartShow");
      m_bIsShown = true;
      onResize(_global.resizeManager);
   }
   var _loc3_ = 13887384;
   var _loc2_ = 13887384;
   if(_global.SFRadar)
   {
      _loc3_ = _global.SFRadar.GetBGHudTextHexColor(0.5,0.85);
      _loc2_ = _global.SFRadar.GetBGHudTextHexColor(0.5,0.85);
   }
   RadarModule.Dashboard.Location.TextBox.textColor = _loc2_;
   var _loc4_ = new Color(RadarModule.Radar.MapRotation.RingBorder);
   _loc4_.setRGB(_loc3_);
}
function RadarResize()
{
   m_nRadarScale = _global.GameInterface.GetConvarNumber("cl_hud_radar_scale");
   if(m_nRadarScale < 0.8)
   {
      m_nRadarScale = 0.8;
   }
   else if(m_nRadarScale > 1.3)
   {
      m_nRadarScale = 1.3;
   }
   RadarModule.Radar._xscale = m_nRadarScale * 150;
   RadarModule.Radar._yscale = m_nRadarScale * 150;
   Scaler._xscale = m_nRadarScale * 145;
   Scaler._yscale = m_nRadarScale * 145;
   trace("RADAR: onResize - setting RadarModule.Radar._width to " + RadarModule.Radar._width + ", RadarModule.Radar._height to " + RadarModule.Radar._height);
}
function hidePanel()
{
   if(m_bIsShown)
   {
      RadarModule.gotoAndPlay("StartHide");
      m_bIsShown = false;
   }
}
function hidePanelNow()
{
   if(m_bIsShown)
   {
      RadarModule.gotoAndStop("Hide");
      m_bIsShown = false;
   }
}
function SwitchRadarToRound()
{
   if(m_bIsRound)
   {
      return undefined;
   }
   trace("RADAR: SwitchRadarToRound!");
   if(m_layeredRadar)
   {
      m_layeredRadar.preSwitchRadarType();
   }
   m_nC4SquareShifted = 0;
   m_nMoneySquareShifted = 0;
   onResize(_global.resizeManager);
   RadarModule.Radar.MapRotation._visible = true;
   RadarModule.Radar.MapRotationSq._visible = false;
   RadarModule.Radar.IconRotation._x = RadarModule.Radar.MapRotation._x;
   RadarModule.Radar.IconRotation._y = RadarModule.Radar.MapRotation._y;
   RadarModule.Radar.gotoAndStop("Round");
   m_bIsRound = true;
   if(m_layeredRadar)
   {
      m_layeredRadar.postSwitchRadarType();
   }
}
function SwitchRadarToSquare()
{
   if(!m_bIsRound)
   {
      return undefined;
   }
   trace("RADAR: SwitchRadarToSquare!");
   if(m_layeredRadar)
   {
      m_layeredRadar.preSwitchRadarType();
   }
   m_nC4SquareShifted = 48;
   m_nMoneySquareShifted = 29;
   onResize(_global.resizeManager);
   RadarModule.Radar.MapRotation._visible = false;
   RadarModule.Radar.MapRotationSq._visible = true;
   RadarModule.Radar.IconRotation._x = RadarModule.Radar.MapRotationSq._x;
   RadarModule.Radar.IconRotation._y = RadarModule.Radar.MapRotationSq._y;
   RadarModule.Radar.gotoAndStop("Square");
   m_bIsRound = false;
   if(m_layeredRadar)
   {
      m_layeredRadar.postSwitchRadarType();
   }
}
function clearChildClips(target)
{
   var _loc2_ = [];
   for(var _loc5_ in target)
   {
      var _loc3_ = target[_loc5_];
      if(_loc3_ instanceof MovieClip)
      {
         _loc2_.push(_loc3_);
      }
   }
   var _loc1_ = 0;
   while(_loc1_ < _loc2_.length)
   {
      _loc3_ = _loc2_[_loc1_];
      _loc3_.removeMovieClip();
      _loc1_ = _loc1_ + 1;
   }
}
function loadMap(p_MapName)
{
   loadMap2(p_MapName,p_MapName);
}
function loadMap2()
{
   var _loc8_ = arguments[0];
   var _loc3_ = new Array(arguments.length - 1);
   var _loc2_ = 1;
   while(_loc2_ < arguments.length)
   {
      _loc3_[_loc2_ - 1] = arguments[_loc2_];
      _loc2_ = _loc2_ + 1;
   }
   if(_loc3_.length == 0)
   {
      _loc3_.push(_loc8_);
   }
   trace("RADAR: Loadmap2: " + _loc8_ + " " + _loc3_);
   var _loc9_ = RadarModule.Radar.MapRotation.MapTranslation.MapScale;
   var _loc10_ = RadarModule.Radar.MapRotationSq.MapTranslation.MapScale;
   clearChildClips(_loc9_);
   clearChildClips(_loc10_);
   m_visibleLayer = 0;
   m_mapLayersRnd = new Array(_loc3_.length);
   m_mapLayersSq = new Array(_loc3_.length);
   _loc2_ = 0;
   while(_loc2_ < _loc3_.length)
   {
      var _loc6_ = createRadarLoader("round",_loc2_,_loc9_);
      var _loc5_ = createRadarLoader("square",_loc2_,_loc10_);
      var _loc4_ = "../overviews/" + _loc3_[_loc2_] + "_radar.dds";
      var _loc7_ = _loc4_;
      _loc6_.beginLoad(_loc8_,_loc4_,m_mapLayersRnd);
      _loc5_.beginLoad(_loc8_,_loc7_,m_mapLayersSq);
      _loc2_ = _loc2_ + 1;
   }
}
function setVisibleLayer(p_layer)
{
   trace("RADAR: Set visible layer " + p_layer);
   if(m_layeredRadar)
   {
      m_visibleLayer = p_layer;
      m_layeredRadar.onDesiredLayerChange();
      return undefined;
   }
   var _loc5_ = getLayerClipFromArray(m_mapLayersRnd,m_visibleLayer);
   var _loc4_ = getLayerClipFromArray(m_mapLayersSq,m_visibleLayer);
   var _loc3_ = getLayerClipFromArray(m_mapLayersRnd,p_layer);
   var _loc2_ = getLayerClipFromArray(m_mapLayersSq,p_layer);
   if(_loc5_ != null)
   {
      _loc5_._visible = false;
   }
   if(_loc4_ != null)
   {
      _loc4_._visible = false;
   }
   if(_loc3_ != null)
   {
      _loc3_._visible = true;
   }
   if(_loc2_ != null)
   {
      _loc2_._visible = true;
   }
   m_visibleLayer = p_layer;
}
function onLoaded()
{
   m_bIsShown = true;
   SwitchRadarToRound();
   hidePanelNow();
   gameAPI.OnReady();
}
function onUnload(mc)
{
   delete _global.SFRadar;
   delete _global.SFRadarGameAPI;
   _global.resizeManager.RemoveListener(this);
   _global.tintManager.DeregisterAll(this);
   return true;
}
function onResize(rm)
{
   var _loc5_ = RadarModule.Radar.MapRotation._width;
   var _loc6_ = RadarModule.Radar.MapRotation._height;
   var _loc7_ = RadarModule.Radar.MapRotationSq._width;
   var _loc8_ = RadarModule.Radar.MapRotationSq._height;
   RadarModule.Radar.MapRotation._width = 32;
   RadarModule.Radar.MapRotation._height = 32;
   RadarModule.Radar.MapRotationSq._width = 32;
   RadarModule.Radar.MapRotationSq._height = 32;
   rm.ResetPositionByPixel(RadarModule,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_SAFE_LEFT,0,Lib.ResizeManager.ALIGN_LEFT,Lib.ResizeManager.REFERENCE_SAFE_TOP,0,Lib.ResizeManager.ALIGN_TOP);
   RadarModule.Radar.MapRotation._width = _loc5_;
   RadarModule.Radar.MapRotation._height = _loc6_;
   RadarModule.Radar.MapRotationSq._width = _loc7_;
   RadarModule.Radar.MapRotationSq._height = _loc8_;
   m_flLastC4ResetPos = 0;
   RadarResize();
   ResetC4andHostagePosition(m_bHostagesAreVisible);
   var _loc4_ = _global.TrialTimer;
   if(_loc4_ != undefined && _loc4_ != null)
   {
      _loc4_.setYPositionFromRadar();
   }
   var _loc2_ = _global.Chat;
   if(_loc2_ != undefined && _loc2_ != null)
   {
      _loc2_.setYPositionFromRadar();
   }
   var _loc3_ = _global.MoneyPanel;
   if(_loc3_ != undefined && _loc3_ != null)
   {
      _loc3_.setYPositionFromRadar();
   }
   m_flSafeZoneY = _global.GameInterface.GetConvarNumber("safezoney");
}
function getTrialTimerYPosition()
{
   return RadarModule.scaledHeight * m_nRadarScale + RadarModule._y + 15;
}
function GetMoneyPosition()
{
   m_nCurrentMoneyOffet = 0;
   var _loc6_ = Stage.height * ((1 - m_flSafeZoneY) / 2);
   var _loc3_ = _global.GameInterface.GetConvarNumber("hud_scaling");
   var _loc8_ = Stage.height / 1024;
   var _loc2_ = m_nRadarScale * _loc3_ * (MONEY_OFFSET + _loc6_);
   var _loc4_ = 1;
   trace("GetShiftedMoneyPosition: nMoneyOffset = " + _loc2_ + ", factors = " + _loc4_ + ", flHScale = " + _loc3_);
   var _loc7_ = _loc4_ * _loc8_;
   var _loc5_ = _loc7_ * (_loc2_ + m_nMoneySquareShifted);
   trace("GetMoneyPosition: pos = " + _loc5_ + ", MONEY_OFFSET = " + MONEY_OFFSET + ", Stageheight = " + Stageheight);
   return _loc5_;
}
function GetShiftedMoneyPosition()
{
   m_nCurrentMoneyOffet = 1;
   var _loc7_ = Stage.height * ((1 - m_flSafeZoneY) / 2);
   var _loc3_ = _global.GameInterface.GetConvarNumber("hud_scaling");
   var _loc6_ = Stage.height / 1024;
   var _loc2_ = m_nRadarScale * _loc3_ * (MONEY_OFFSET + _loc7_);
   var _loc4_ = 1;
   trace("GetShiftedMoneyPosition: nMoneyOffset = " + _loc2_ + ", factors = " + _loc4_ + ", flHScale = " + _loc3_);
   var _loc8_ = _loc4_ * _loc6_;
   var _loc5_ = _loc8_ * (_loc2_ + MONEY_SHIFTED_OFFSET + m_nMoneySquareShifted);
   trace("GetShiftedMoneyPosition: pos = " + _loc5_ + ", hostpos = " + hostpos + ", numScreenRatioY = " + _loc6_);
   return _loc5_;
}
function ShowHostages()
{
   RadarModule.C4._visible = true;
   RadarModule.C4.C4Radar._visible = false;
   RadarModule.Hostages._visible = true;
   m_bHostagesAreVisible = true;
}
function ResetC4andHostagePosition(bIsHostageMode)
{
   if(m_bBombIsVisible == false && bIsHostageMode == false)
   {
      return undefined;
   }
   if(m_flLastC4ResetPos > getTimer())
   {
      return undefined;
   }
   m_flLastC4ResetPos = getTimer() + 1000;
   trace("ResetC4andHostagePosition: bIsHostageMode = " + bIsHostageMode + ", m_bBombIsVisible = " + m_bBombIsVisible);
   var _loc8_ = 0;
   var _loc10_ = 1;
   var _loc7_ = Stage.height / 1024;
   var _loc4_ = m_nRadarScale * 0.666 * (MONEY_OFFSET + _loc8_);
   var _loc5_ = 1;
   trace("ResetC4andHostagePosition: nMoneyOffset = " + _loc4_ + ", factors = " + _loc5_ + ", RadarModule.Hostages._visible = " + RadarModule.Hostages._visible + ", numScreenRatioY = " + _loc7_);
   var _loc9_ = _loc5_ * _loc7_;
   var _loc3_ = BOMB_OFFSET;
   if(bIsHostageMode == true)
   {
      _loc3_ = HOSTAGE_SHIFTED_OFFSET;
   }
   var _loc2_ = _loc4_ + m_nC4SquareShifted + _loc3_;
   if(bIsHostageMode == true)
   {
      _loc2_ = _loc4_ + m_nC4SquareShifted + _loc3_;
      trace("bIsHostageMode!!!!!!!!!!!  m_nC4SquareShifted = " + m_nC4SquareShifted);
      RadarModule.Hostages._y = _loc2_;
   }
   else
   {
      RadarModule.C4._y = _loc2_;
   }
   trace("ResetC4andHostagePosition: pos = " + _loc2_ + ", _global.MoneyPanel.MoneyPanel._y = " + _global.MoneyPanel.MoneyPanel._y + ", flScaling = " + _loc9_ + ", offset = " + _loc3_);
}
function ShowC4(bShow)
{
   if(bShow)
   {
      m_bHostagesAreVisible = false;
      RadarModule.C4._visible = true;
      RadarModule.C4.C4Radar._visible = true;
      if(m_bBombIsVisible == false)
      {
         RadarModule.C4.C4Radar.c4anim.gotoAndPlay("Highlight");
         RadarModule.C4.C4Radar.c4anim._visible = true;
         onResize(_global.resizeManager);
      }
      RadarModule.C4.C4Radar.InBombZoneIcon._visible = false;
      if(_global.WeaponModule.HudPanel.WeaponPanel.InBombZoneIcon._visible && RadarModule.C4.C4Radar.c4anim._visible == false)
      {
         RadarModule.C4.C4Radar.InBombZoneIcon._visible = true;
      }
      m_bBombIsVisible = RadarModule.C4.C4Radar._visible;
      ResetC4andHostagePosition(false);
   }
   else
   {
      HideC4();
   }
}
function HideC4()
{
   RadarModule.C4.C4Radar._visible = false;
   RadarModule.C4.C4Radar.InBombZoneIcon._visible = false;
   m_bBombIsVisible = false;
}
function SetPlayerObjectColor(object, nColorIndex)
{
   _global.SetPlayerObjectColor(object,nColorIndex);
}
function SetPlayerColorLetter(text, nColorIndex)
{
   if(!text)
   {
      return undefined;
   }
   var _loc2_ = _global.GetPlayerColorLetter(0,nColorIndex);
   text.Text.htmlText = _loc2_;
}
function GetHudTextHexColor()
{
   var _loc2_ = undefined;
   var _loc3_ = _global.GameInterface.GetConvarNumber("cl_hud_color");
   if(_loc3_ == 1)
   {
      _loc2_ = 16777215;
   }
   else if(_loc3_ == 2)
   {
      _loc2_ = 9881855;
   }
   else if(_loc3_ == 3)
   {
      _loc2_ = 3501823;
   }
   else if(_loc3_ == 4)
   {
      _loc2_ = 13133055;
   }
   else if(_loc3_ == 5)
   {
      _loc2_ = 16722212;
   }
   else if(_loc3_ == 6)
   {
      _loc2_ = 16740644;
   }
   else if(_loc3_ == 7)
   {
      _loc2_ = 16774948;
   }
   else if(_loc3_ == 8)
   {
      _loc2_ = 4128548;
   }
   else if(_loc3_ == 9)
   {
      _loc2_ = 2424720;
   }
   else if(_loc3_ == 10)
   {
      _loc2_ = 16742809;
   }
   else
   {
      _loc2_ = 14017158;
   }
   return _loc2_;
}
function GetBGHudTextHexColor(flBrightness, flSaturation)
{
   var _loc7_ = GetHudTextHexColor();
   var _loc5_ = {r:(_loc7_ & 16711680) >> 16,g:(_loc7_ & 65280) >> 8,b:_loc7_ & 255};
   var _loc2_ = _loc5_.r;
   var _loc3_ = _loc5_.g;
   var _loc1_ = _loc5_.b;
   _loc2_ = _loc2_ * flBrightness;
   _loc3_ = _loc3_ * flBrightness;
   _loc1_ = _loc1_ * flBrightness;
   var _loc6_ = _loc2_ * 0.3086 + _loc3_ * 0.6094 + _loc1_ * 0.082;
   var _loc4_ = flSaturation;
   _loc2_ = _loc2_ * _loc4_ + _loc6_ * (1 - _loc4_);
   _loc3_ = _loc3_ * _loc4_ + _loc6_ * (1 - _loc4_);
   _loc1_ = _loc1_ * _loc4_ + _loc6_ * (1 - _loc4_);
   return _loc2_ << 16 | _loc3_ << 8 | _loc1_;
}
_global.SFRadar = this;
_global.SFRadarGameAPI = gameAPI;
var MAPSIZE = 320;
var MONEY_OFFSET = 345;
var MONEY_SHIFTED_OFFSET = 38;
var HOSTAGE_SHIFTED_OFFSET = 17;
var BOMB_OFFSET = 90;
var m_nCurrentMoneyOffet = 0;
var m_bIsRound = false;
var m_nRadarScale = 1;
var m_nC4SquareShifted = 0;
var m_nMoneySquareShifted = 0;
var m_mapLayersRnd = null;
var m_mapLayersSq = null;
var m_visibleLayer = 0;
var m_layeredRadar = null;
var m_bIsShown = true;
var m_bBombIsVisible = false;
var m_bHostagesAreVisible = false;
var m_flLastC4ResetPos = 0;
var m_flSafeZoneY = 0;
var listenerRnd = new Object();
var listenerSq = new Object();
m_layeredRadar = createLayeredRadar();
listenerRnd = createRadarLoader("round",0,RadarModule.Radar.MapRotation.MapTranslation.MapScale);
listenerSq = createRadarLoader("square",0,RadarModule.Radar.MapRotationSq.MapTranslation.MapScale);
_global.resizeManager.AddListener(this);
stop();
