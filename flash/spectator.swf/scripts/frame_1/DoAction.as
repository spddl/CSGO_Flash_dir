function SetMedalRankIcon(imedal, rank)
{
   return undefined;
}
function SetMedalText(text)
{
   if(text != undefined && text != null && text != "")
   {
      SpectatorMode.Panel.MedalTextPanel._visible = true;
      SpectatorMode.Panel.MedalTextPanel.MedalDescription.MedalDescriptionText.SetText(text);
   }
   else
   {
      SpectatorMode.Panel.MedalTextPanel._visible = false;
   }
}
function SetShouldShowFollowPlayerColor(nPlayerIndex)
{
   SpectatorMode.Panel.AvatarContainer.SetShouldShowPlayerColor(nPlayerIndex > -1,nPlayerIndex);
}
function SetTeamLogo(nTeamID, bIsSwapped, logoString, flagString)
{
   var _loc8_ = 3;
   var _loc2_ = 2;
   var _loc14_ = m_CTTeamNameStartPos;
   var _loc7_ = 0;
   if(bIsSwapped)
   {
      _loc8_ = 2;
      _loc2_ = 3;
   }
   var _loc6_ = Scoreboard.Panel.CTLogo;
   var _loc5_ = Scoreboard.Panel.CTFlag;
   var _loc12_ = Scoreboard.Panel.CT_TeamName;
   if(nTeamID == _loc2_)
   {
      _loc6_ = Scoreboard.Panel.TLogo;
      _loc5_ = Scoreboard.Panel.TFlag;
      _loc12_ = Scoreboard.Panel.T_TeamName;
      _loc14_ = m_TTeamNameStartPos;
   }
   _loc6_._visible = false;
   _loc5_._visible = false;
   if(logoString != undefined && logoString != "")
   {
      _loc7_ = -50;
      if(nTeamID == _loc2_)
      {
         _loc7_ = 50;
      }
      _loc6_._visible = true;
      if(nTeamID == _loc8_ && m_teamLogo_CT != logoString || nTeamID == _loc2_ && m_teamLogo_T != logoString)
      {
         if(nTeamID == _loc8_)
         {
            m_teamLogo_CT = logoString;
         }
         else if(nTeamID == _loc2_)
         {
            m_teamLogo_T = logoString;
         }
         logoString = "econ/tournaments/teams/" + logoString;
         if(_loc6_ != undefined)
         {
            _loc6_.unloadMovie();
         }
         var _loc9_ = new Object();
         _loc9_.onLoadInit = function(target_mc)
         {
            target_mc._width = m_nTeamLogoSize;
            target_mc._height = m_nTeamLogoSize;
         };
         _loc9_.onLoadError = function(target_mc, errorCode, status)
         {
            trace("Error loading item image: " + errorCode + " [" + status + "] ----- ");
         };
         var _loc11_ = new MovieClipLoader();
         _loc11_.addListener(_loc9_);
         _loc11_.loadClip(logoString,_loc6_);
         trace("SetTeamLogo to: " + logoString);
      }
   }
   if(flagString != undefined && flagString != "")
   {
      _loc7_ = -68;
      if(nTeamID == _loc2_)
      {
         _loc7_ = 68;
      }
      _loc5_._visible = true;
      if(nTeamID == _loc8_ && m_teamFlag_CT != flagString || nTeamID == _loc2_ && m_teamFlag_T != flagString)
      {
         if(nTeamID == _loc8_)
         {
            m_teamFlag_CT = flagString;
         }
         else if(nTeamID == _loc2_)
         {
            m_teamFlag_T = flagString;
         }
         if(_loc5_ != undefined)
         {
            _loc5_.unloadMovie();
         }
         flagString = "images/flags/" + flagString + ".png";
         var _loc10_ = new Object();
         _loc10_.onLoadInit = function(target_mc)
         {
            target_mc._width = m_nTeamFlagSizeW;
            target_mc._height = m_nTeamFlagSizeH;
         };
         _loc10_.onLoadError = function(target_mc, errorCode, status)
         {
            trace("Error loading item image: " + errorCode + " [" + status + "] ----- ");
         };
         var _loc13_ = new MovieClipLoader();
         _loc13_.addListener(_loc10_);
         _loc13_.loadClip(flagString,_loc5_);
         trace("SetTeamLogo FLAG to: " + flagString);
      }
   }
   _loc12_._x = _loc14_ + _loc7_;
}
function ShowAvatar(nTeamID, xuid, playerNameText)
{
   HideIcons();
   if(_global.SFMapOverview.IsGraphVisible())
   {
      SpectatorMode.Panel._visible = false;
      SpectatorMode.Nav_Text._visible = false;
   }
   else
   {
      SpectatorMode.Panel._visible = true;
      SpectatorMode.Nav_Text._visible = true;
      ShowSpectatorStatsPanel(xuid);
   }
   SpectatorMode.Panel.AvatarContainer.ShowAvatar(nTeamID,xuid,true,false);
   var _loc2_ = SpectatorMode.Panel.AvatarContainer.GetFlairItemName(xuid);
   if(_loc2_)
   {
      SetMedalText(_loc2_);
   }
   SpectatorMode.Panel.AvatarContainer.SetHealthBar(-1);
   TintSpectatorPanelBg(nTeamID);
}
function TintSpectatorPanelBg(nTeamID)
{
   var _loc1_ = new Color(SpectatorMode.Panel.TargetName.Bg);
   var _loc2_ = new Color(SpectatorMode.Panel.StatsPanel.Bg);
   var _loc3_ = new Color(SpectatorMode.Panel.MedalTextPanel.MedalDescription.DamageTakenbg);
   if(nTeamID == 2)
   {
      _loc1_.setTransform(T_ColorTransform_ScoreboardDark);
      _loc2_.setTransform(T_ColorTransform_ScoreboardDark);
      _loc3_.setTransform(T_ColorTransform_ScoreboardDark);
   }
   else
   {
      _loc1_.setTransform(CT_ColorTransform_ScoreboardDark);
      _loc2_.setTransform(CT_ColorTransform_ScoreboardDark);
      _loc3_.setTransform(CT_ColorTransform_ScoreboardDark);
   }
}
function ShowClanAvatar(nTeamID, xuid, bIs2ndHalf)
{
   var _loc4_ = 46;
   var _loc3_ = 3;
   var _loc2_ = 2;
   if(bIs2ndHalf)
   {
      _loc3_ = 2;
      _loc2_ = 3;
   }
   if(nTeamID == _loc2_)
   {
      Scoreboard.Panel.TAvatar._visible = true;
      Scoreboard.Panel.TAvatar.ShowAvatar(nTeamID,xuid,false,false);
      Scoreboard.Panel.T_TeamName._x = m_TTeamNameStartPos + _loc4_;
   }
   if(nTeamID == _loc3_)
   {
      Scoreboard.Panel.CTAvatar._visible = true;
      Scoreboard.Panel.CTAvatar.ShowAvatar(nTeamID,xuid,false,false);
      Scoreboard.Panel.CT_TeamName._x = m_CTTeamNameStartPos + (- _loc4_);
   }
}
function HideClanAvatar(nTeamID, bIs2ndHalf)
{
   var _loc2_ = 3;
   var _loc1_ = 2;
   if(bIs2ndHalf)
   {
      _loc2_ = 2;
      _loc1_ = 3;
   }
   if(nTeamID == _loc1_)
   {
      Scoreboard.Panel.TAvatar._visible = false;
      Scoreboard.Panel.T_TeamName._x = m_TTeamNameStartPos;
   }
   if(nTeamID == _loc2_)
   {
      Scoreboard.Panel.CTAvatar._visible = false;
      Scoreboard.Panel.CT_TeamName._x = m_CTTeamNameStartPos;
   }
}
function HideIcons()
{
   SpectatorMode.Panel._visible = false;
   SpectatorMode.Panel.MedalTextPanel._visible = false;
}
function DisableSpectatorToggles(disable)
{
   LShoulderButton._visible = disable != true;
   RShoulderButton._visible = disable != true;
   bSpectatorTogglesDisabled = disable;
}
function onLoadInit(movieClip)
{
   movieClip._width = avatarWidth;
   movieClip._height = avatarHeight;
   trace("<<<<<< Spectator::onLoadInit");
}
function setUIDevice()
{
   updateUIDevice();
}
function changeUIDevice()
{
   updateUIDevice();
}
function updateUIDevice()
{
   var _loc5_ = _global.IsPC();
   var _loc4_ = _global.IsXbox();
   var _loc3_ = _global.IsPS3();
   var _loc2_ = SpectatorMode.Panel;
   _loc2_.LBButton._visible = false;
   _loc2_.RBButton._visible = false;
   _loc2_.L1Button._visible = false;
   _loc2_.R1Button._visible = false;
   _loc2_.PC_LButton._visible = false;
   _loc2_.PC_RButton._visible = false;
   if(!_global.wantControllerShown)
   {
      LShoulderButton = _loc2_.PC_LButton;
      RShoulderButton = _loc2_.PC_RButton;
   }
   else if(_loc3_)
   {
      LShoulderButton = _loc2_.L1Button;
      RShoulderButton = _loc2_.R1Button;
   }
   else
   {
      LShoulderButton = _loc2_.LBButton;
      RShoulderButton = _loc2_.RBButton;
   }
   LShoulderButton._visible = true;
   RShoulderButton._visible = true;
}
function onLoaded()
{
   FollowingPanel._visible = false;
   SpectatorMode._visible = false;
   CT_Spectator._visible = false;
   T_Spectator._visible = false;
   Scoreboard._visible = false;
   OverviewBg._visible = false;
   EventSpecPanel._visible = false;
   TooltipItemPreview._visible = false;
   _global.SFMapOverview.hidePanelNow();
   previewSpectatorItem(false);
   Scoreboard.Panel.TeamPrediction._visible = false;
   Scoreboard.Panel.TeamMatchStat._visible = false;
   FollowingPanel.gotoAndStop("StartShow");
   SpectatorMode.gotoAndStop("StartShow");
   CT_Spectator.gotoAndStop("StartShow");
   T_Spectator.gotoAndStop("StartShow");
   InitStatsPanel();
   updateUIDevice();
   trace("<<<<<< Spectator::onLoaded");
   m_MatchStatDefaultWidth = Scoreboard.Panel.TeamMatchStat.TeamMatchStatPanel.TeamValueBG._width;
   m_MatchStatDefaultCT_X = Scoreboard.Panel.TeamMatchStat.TeamMatchStatPanel.TeamValueBG_L._x;
   m_MatchStatDefaultCTtxt_X = Scoreboard.Panel.TeamMatchStat.TeamMatchStatPanel.CT_Value_Number._x;
   m_MatchStatDefaultT_X = Scoreboard.Panel.TeamMatchStat.TeamMatchStatPanel.TeamValueBG_R._x;
   m_MatchStatDefaultTtxt_X = Scoreboard.Panel.TeamMatchStat.TeamMatchStatPanel.T_Value_Number._x;
   var _loc2_ = Scoreboard.Panel.Time;
   _loc2_.BombPlantedIcon._visible = false;
   _loc2_.BombPlantedIconMedium._visible = false;
   _loc2_.BombPlantedIconFast._visible = false;
   _loc2_.BombPlantedIconDefused._visible = false;
   gameAPI.OnReady();
}
function updatePlantedBombState(detProgress)
{
   var _loc1_ = Scoreboard.Panel.Time;
   _loc1_.TimeGreen._visible = false;
   _loc1_.IconTimeGreen._visible = false;
   _loc1_.IconTimeRed._visible = false;
   _loc1_.TimeRed._visible = false;
   _loc1_.GlowPulse._visible = false;
   if(detProgress > 60)
   {
      _loc1_.BombPlantedIcon._visible = true;
      _loc1_.BombPlantedIconMedium._visible = false;
      _loc1_.BombPlantedIconFast._visible = false;
      _loc1_.BombPlantedIconDefused._visible = false;
   }
   else if(detProgress > 30)
   {
      _loc1_.BombPlantedIcon._visible = false;
      _loc1_.BombPlantedIconMedium._visible = true;
      _loc1_.BombPlantedIconFast._visible = false;
      _loc1_.BombPlantedIconDefused._visible = false;
   }
   else if(detProgress > 0)
   {
      _loc1_.BombPlantedIcon._visible = false;
      _loc1_.BombPlantedIconMedium._visible = false;
      _loc1_.BombPlantedIconFast._visible = true;
      _loc1_.BombPlantedIconDefused._visible = false;
   }
   else
   {
      _loc1_.BombPlantedIcon._visible = false;
      _loc1_.BombPlantedIconMedium._visible = false;
      _loc1_.BombPlantedIconFast._visible = false;
      _loc1_.BombPlantedIconDefused._visible = false;
   }
}
function setBombDefused()
{
   var _loc1_ = Scoreboard.Panel.Time;
   _loc1_.TimeGreen._visible = false;
   _loc1_.IconTimeGreen._visible = false;
   _loc1_.IconTimeRed._visible = false;
   _loc1_.TimeRed._visible = false;
   _loc1_.GlowPulse._visible = false;
   _loc1_.BombPlantedIcon._visible = false;
   _loc1_.BombPlantedIconMedium._visible = false;
   _loc1_.BombPlantedIconFast._visible = false;
   _loc1_.BombPlantedIconDefused._visible = true;
}
function onUnload(mc)
{
   delete _global.SpectatorMovie;
   _global.resizeManager.RemoveListener(this);
   _global.tintManager.DeregisterAll(this);
   if(specVisible)
   {
      _global.navManager.RemoveLayout(navSpectator);
   }
   FollowingPanel._visible = false;
   SpectatorMode._visible = false;
   CT_Spectator._visible = false;
   T_Spectator._visible = false;
   Scoreboard._visible = false;
   OverviewBg._visible = false;
   EventSpecPanel._visible = false;
   TooltipItemPreview._visible = false;
   TintedList.length = 0;
   trace("<<<<<< Spectator::onUnload");
   return true;
}
function onResize(rm)
{
   rm.ResetPositionByPixel(SpectatorMode,Lib.ResizeManager.SCALE_USING_VERTICAL,Lib.ResizeManager.REFERENCE_CENTER_X,27,Lib.ResizeManager.ALIGN_CENTER,Lib.ResizeManager.REFERENCE_SAFE_BOTTOM,- Stage.height / 2 / 100,Lib.ResizeManager.ALIGN_BOTTOM);
   rm.ResetPositionByPixel(FollowingPanel,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_CENTER_X,0,Lib.ResizeManager.ALIGN_CENTER,Lib.ResizeManager.REFERENCE_SAFE_TOP,75,Lib.ResizeManager.ALIGN_TOP);
   rm.ResetXYPositionByPixel(TopGradient,Lib.ResizeManager.SCALE_BIGGEST,true,Lib.ResizeManager.SCALE_BIGGEST,false,Lib.ResizeManager.REFERENCE_CENTER_X,0,Lib.ResizeManager.ALIGN_CENTER,Lib.ResizeManager.REFERENCE_TOP,0,Lib.ResizeManager.ALIGN_TOP);
   rm.ResetXYPositionByPixel(BottomGradient,Lib.ResizeManager.SCALE_BIGGEST,true,Lib.ResizeManager.SCALE_BIGGEST,false,Lib.ResizeManager.REFERENCE_CENTER_X,0,Lib.ResizeManager.ALIGN_CENTER,Lib.ResizeManager.REFERENCE_BOTTOM,0,Lib.ResizeManager.ALIGN_TOP);
   rm.ResetPositionByPixel(CT_Spectator,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_SAFE_LEFT,0,Lib.ResizeManager.ALIGN_LEFT,Lib.ResizeManager.REFERENCE_SAFE_TOP,Stage.height / 2 + Stage.height / 9,Lib.ResizeManager.ALIGN_TOP);
   rm.ResetPositionByPixel(T_Spectator,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_SAFE_RIGHT,0,Lib.ResizeManager.ALIGN_LEFT,Lib.ResizeManager.REFERENCE_SAFE_TOP,Stage.height / 2 + Stage.height / 9,Lib.ResizeManager.ALIGN_TOP);
   rm.ResetPositionByPixel(Scoreboard,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_CENTER_X,0,Lib.ResizeManager.ALIGN_CENTER,Lib.ResizeManager.REFERENCE_SAFE_TOP,0,Lib.ResizeManager.ALIGN_TOP);
   rm.ResetPositionByPixel(EventSpecPanel,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_RIGHT,0,Lib.ResizeManager.ALIGN_RIGHT,Lib.ResizeManager.REFERENCE_TOP,0,Lib.ResizeManager.ALIGN_TOP);
   rm.ResetPosition(TooltipItemPreview,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.POSITION_CENTER,Lib.ResizeManager.POSITION_CENTER,Lib.ResizeManager.ALIGN_CENTER,Lib.ResizeManager.ALIGN_CENTER);
   rm.DisableAdditionalScaling = true;
   rm.ResetPositionByPixel(OverviewBg,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_CENTER_X,0,Lib.ResizeManager.ALIGN_CENTER,Lib.ResizeManager.REFERENCE_CENTER_Y,0,Lib.ResizeManager.ALIGN_CENTER);
   rm.DisableAdditionalScaling = false;
   rm.DisableAdditionalScaling = true;
   rm.ResetPositionByPixel(ReplayOverlay,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_CENTER_X,0,Lib.ResizeManager.ALIGN_CENTER,Lib.ResizeManager.REFERENCE_CENTER_Y,0,Lib.ResizeManager.ALIGN_CENTER);
   rm.DisableAdditionalScaling = false;
   rm.DisableAdditionalScaling = true;
   rm.ResetPositionByPercentage(ReplayPlayerTag,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_CENTER_X,0,Lib.ResizeManager.ALIGN_CENTER,Lib.ResizeManager.REFERENCE_CENTER_Y,0,Lib.ResizeManager.ALIGN_NONE);
   rm.DisableAdditionalScaling = false;
   rm.ResetPositionByPixel(ServerImage,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_CENTER_X,0,Lib.ResizeManager.ALIGN_CENTER,Lib.ResizeManager.REFERENCE_SAFE_BOTTOM,0,Lib.ResizeManager.ALIGN_TOP);
}
function ShowReplayUi(bShow)
{
   ReplayOverlay._visible = bShow;
   ReplayOverlay.Text.htmlText = "#SFUI_Spectator_Replay_tag";
   _global.AutosizeTextDown(ReplayOverlay.Text,20);
   ReplayPlayerTag.Text.htmlText = "#SFUI_Spectator_Replay_Player_tag";
   _global.AutosizeTextDown(ReplayPlayerTag.Text,20);
}
function ShowReplaySkull(bShow)
{
   ReplayPlayerTag.Skull._visible = bShow;
   ReplayPlayerTag.Text._visible = !bShow;
}
function ShowPanel(bShowScoreboard)
{
   if(!specVisible)
   {
      SetKeyNumbers();
      updateUIDevice();
      previewSpectatorItem(false);
      HideTourneyViewerAndItemNumbers();
      var _loc2_ = _global.GameInterface.GetConvarNumber("joy_movement_stick") == 0;
      navSpectator.AddKeyHandlers({onDown:function(button, control, keycode)
      {
         if(_global.SpectatorMovie != undefined && _global.SpectatorMovie != null && _global.SpectatorMovie.specVisible && !_global.SpectatorMovie.bSpectatorTogglesDisabled)
         {
            gameAPI.SwitchTarget(false);
            LShoulderButton.gotoAndPlay("StartOver");
         }
         return true;
      },onUp:function(button, control, keycode)
      {
         if(_global.SpectatorMovie != undefined && _global.SpectatorMovie != null && _global.SpectatorMovie.specVisible && !_global.SpectatorMovie.bSpectatorTogglesDisabled)
         {
            LShoulderButton.gotoAndPlay("StartUp");
         }
         return true;
      }},!_loc2_?"KEY_XSTICK2_LEFT":"KEY_XSTICK1_LEFT",!_global.wantControllerShown?"KEY_LEFT":"KEY_XBUTTON_LEFT_SHOULDER");
      navSpectator.AddKeyHandlers({onDown:function(button, control, keycode)
      {
         if(_global.SpectatorMovie != undefined && _global.SpectatorMovie != null && _global.SpectatorMovie.specVisible && !_global.SpectatorMovie.bSpectatorTogglesDisabled)
         {
            gameAPI.SwitchTarget(true);
            RShoulderButton.gotoAndPlay("StartOver");
         }
         return true;
      },onUp:function(button, control, keycode)
      {
         if(_global.SpectatorMovie != undefined && _global.SpectatorMovie != null && _global.SpectatorMovie.specVisible && !_global.SpectatorMovie.bSpectatorTogglesDisabled)
         {
            RShoulderButton.gotoAndPlay("StartUp");
         }
         return true;
      }},!_loc2_?"KEY_XSTICK2_RIGHT":"KEY_XSTICK1_RIGHT",!_global.wantControllerShown?"KEY_RIGHT":"KEY_XBUTTON_RIGHT_SHOULDER");
      FollowingPanel._visible = true;
      SpectatorMode._visible = true;
      CT_Spectator._visible = true;
      T_Spectator._visible = true;
      FollowingPanel.gotoAndPlay("StartShow");
      SpectatorMode.gotoAndPlay("StartShow");
      CT_Spectator.gotoAndPlay("StartShow");
      T_Spectator.gotoAndPlay("StartShow");
      Scoreboard._visible = bShowScoreboard;
      specVisible = true;
      _global.navManager.PushLayout(navSpectator,"navSpectator");
   }
   ShowServerImage();
}
function HidePanel()
{
   if(specVisible)
   {
      FollowingPanel.gotoAndPlay("StartHide");
      SpectatorMode.gotoAndPlay("StartHide");
      CT_Spectator.gotoAndPlay("StartHide");
      T_Spectator.gotoAndPlay("StartHide");
      specVisible = false;
      _global.navManager.RemoveLayout(navSpectator);
      previewSpectatorItem(false);
      HideTourneyViewerAndItemNumbers();
   }
}
function ShowServerImage()
{
   var _loc2_ = "img://stringtables:(360x60):" + _global.CScaleformComponent_MatchStats.GetServerGraphic1Name();
   if(_loc2_ == "" || _loc2_ == null || _loc2_ == undefined)
   {
      ServerImage._visible = false;
      return undefined;
   }
   ServerImage._visible = true;
   var _loc4_ = new Object();
   _loc4_.onLoadInit = function(target_mc)
   {
      target_mc._width = 360;
      target_mc._height = 60;
   };
   _loc4_.onLoadError = function(target_mc, errorCode, status)
   {
      trace("Error loading item image: " + errorCode + " [" + status + "] ----- ");
   };
   var _loc5_ = new MovieClipLoader();
   _loc5_.addListener(_loc4_);
   _loc5_.loadClip(_loc2_,ServerImage.Image);
   var _loc3_ = "img://stringtables:(220x45):" + _global.CScaleformComponent_MatchStats.GetServerGraphic2Name();
   if(_loc3_ == "" || _loc3_ == null || _loc3_ == undefined)
   {
      T_Spectator.Panel.ServerImage2._visible = false;
      return undefined;
   }
   T_Spectator.Panel.ServerImage2._visible = true;
   _loc4_ = new Object();
   _loc4_.onLoadInit = function(target_mc)
   {
      target_mc._width = 220;
      target_mc._height = 45;
   };
   _loc4_.onLoadError = function(target_mc, errorCode, status)
   {
      trace("Error loading item image: " + errorCode + " [" + status + "] ----- ");
   };
   _loc5_ = new MovieClipLoader();
   _loc5_.addListener(_loc4_);
   _loc5_.loadClip(_loc3_,T_Spectator.Panel.ServerImage2.Image);
}
function ShowWeaponInfoPanel()
{
   if(specVisible)
   {
      SpectatorMode.Panel.ItemPanelContainer.gotoAndPlay("StartShow");
   }
   SizeStatsPanelBg(true);
}
function HideWeaponInfoPanel()
{
   if(specVisible)
   {
      SpectatorMode.Panel.ItemPanelContainer.gotoAndStop("StartHide");
   }
   SizeStatsPanelBg(false);
}
function HidePanelImmediate()
{
   if(specVisible)
   {
      FollowingPanel.gotoAndStop("Hide");
      SpectatorMode.gotoAndStop("Hide");
      CT_Spectator.gotoAndPlay("Hide");
      T_Spectator.gotoAndPlay("Hide");
      specVisible = false;
      _global.navManager.RemoveLayout(navSpectator);
   }
}
function onBeginTimerAlert()
{
   var _loc1_ = Scoreboard.Panel.Time;
   _loc1_.TimeGreen._visible = false;
   _loc1_.TimeRed._visible = true;
}
function onBeginTimerNormal()
{
   var _loc1_ = Scoreboard.Panel.Time;
   _loc1_.TimeGreen._visible = true;
   _loc1_.TimeRed._visible = false;
   trace("PTime.TimeRed = " + _loc1_.TimeRed._visible);
   _loc1_.BombPlantedIcon._visible = false;
   _loc1_.BombPlantedIconMedium._visible = false;
   _loc1_.BombPlantedIconFast._visible = false;
   _loc1_.BombPlantedIconDefused._visible = false;
}
function onHideTimer()
{
   var _loc1_ = Scoreboard.Panel.Time;
   _loc1_.TimeGreen._visible = false;
   _loc1_.TimeRed._visible = false;
}
function SetHealthBar(nHealthPercent)
{
   SpectatorMode.Panel.HealthBar.HealthPanel.gotoAndStop(nHealthPercent);
}
function SetArmorBar(nArmorPercent)
{
   SpectatorMode.Panel.ArmorBar.ArmorPanel.gotoAndStop(nArmorPercent);
}
function RegisterForTeamTint(Obj)
{
   TintedList[TintedList.length] = new Color(Obj);
}
function SetTeamSettings(nLocalTeamID, nTeamID, bShowScoreboard, bSwapPlayerNames)
{
   var _loc1_ = 0;
   while(_loc1_ < TintedList.length)
   {
      switch(nTeamID)
      {
         case 2:
            TintedList[_loc1_].setTransform(T_ColorTransform);
            break;
         case 3:
            TintedList[_loc1_].setTransform(CT_ColorTransform);
            break;
         default:
            TintedList[_loc1_].setTransform(Default_ColorTransform);
      }
      _loc1_ = _loc1_ + 1;
   }
   switch(nLocalTeamID)
   {
      case 2:
         CT_Spectator.Panel._visible = bSwapPlayerNames && bShowScoreboard;
         T_Spectator.Panel._visible = !bSwapPlayerNames && bShowScoreboard;
         CT_Spectator.Panel_Avatar._visible = bShowScoreboard;
         T_Spectator.Panel_Avatar._visible = bShowScoreboard;
         break;
      case 3:
         CT_Spectator.Panel._visible = !bSwapPlayerNames && bShowScoreboard;
         T_Spectator.Panel._visible = bSwapPlayerNames && bShowScoreboard;
         CT_Spectator.Panel_Avatar._visible = bShowScoreboard;
         T_Spectator.Panel_Avatar._visible = bShowScoreboard;
         break;
      default:
         CT_Spectator.Panel._visible = bShowScoreboard;
         T_Spectator.Panel._visible = bShowScoreboard;
         CT_Spectator.Panel_Avatar._visible = bShowScoreboard;
         T_Spectator.Panel_Avatar._visible = bShowScoreboard;
   }
   Scoreboard._visible = bShowScoreboard;
}
function updateScoreAndTeamNameColors(bIs2ndHalf)
{
   var _loc2_ = new Color(Scoreboard.Panel.CT_Score);
   var _loc1_ = new Color(Scoreboard.Panel.T_Score);
   if(bIs2ndHalf)
   {
      _loc2_.setTransform(T_ColorTransform_Scoreboard);
      _loc1_.setTransform(CT_ColorTransform_Scoreboard);
   }
   else
   {
      _loc2_.setTransform(CT_ColorTransform_Scoreboard);
      _loc1_.setTransform(T_ColorTransform_Scoreboard);
   }
}
function UpdatePlayerSlot(Slot, Xuid, Flags, playerNameText, playerHealth, playerArmor, itemName, bIsPrimarySelected, nRoundKills, iconString, nPlayerColorIndex)
{
   var _loc22_ = 10;
   if(Slot < 0 || Slot > _loc22_ - 1)
   {
      trace("INVALID SLOT# :" + Slot + " Passed to UpdateAvatarSlot.  Aborting.");
      return undefined;
   }
   var _loc15_ = (1 & Flags >> 0) != 0;
   var _loc3_ = (1 & Flags >> 1) != 0;
   var _loc18_ = (1 & Flags >> 2) != 0;
   var _loc8_ = (1 & Flags >> 3) != 0;
   var _loc26_ = (1 & Flags >> 4) != 0;
   var _loc33_ = (1 & Flags >> 5) != 0;
   var _loc12_ = (1 & Flags >> 6) != 0;
   var _loc20_ = (1 & Flags >> 7) != 0;
   var _loc30_ = (1 & Flags >> 8) != 0;
   var _loc13_ = (1 & Flags >> 9) != 0;
   if(bIsPlayer && !_loc8_)
   {
      PlayerIsCT = _loc3_;
   }
   var _loc11_ = "CT_Spectator";
   var _loc6_ = "CT_AvatarBox";
   if(!_loc15_)
   {
      _loc11_ = "T_Spectator";
      _loc6_ = "T_AvatarBox";
   }
   var _loc32_ = Math.ceil(_loc22_ / 2);
   _loc11_ = _loc11_ + Slot;
   _loc6_ = _loc6_ + Slot;
   var _loc1_ = CT_Spectator.Panel[_loc11_];
   var _loc2_ = CT_Spectator.Panel_Avatar[_loc6_];
   if(!_loc15_)
   {
      _loc1_ = T_Spectator.Panel[_loc11_];
      _loc2_ = T_Spectator.Panel_Avatar[_loc6_];
   }
   if(_loc1_ == undefined || _loc2_ == undefined)
   {
      trace("Error! We don\'t have a slot for this avatar name  (" + _loc6_ + ")");
      return undefined;
   }
   var _loc29_ = _loc2_.bDead == true;
   _loc1_._visible = true;
   _loc2_._visible = true;
   if(!T_Spectator.Panel.ServerImage2._visible)
   {
      T_Spectator.Panel.ServerImage2._visible = true;
   }
   _loc1_.PlayerOutline._visible = bIsPlayer && !_loc8_ || _loc12_;
   _loc1_.PlayerName.Text.htmlText = playerNameText;
   _loc1_.Health.Text.htmlText = playerHealth;
   _loc1_.Armor.Text.htmlText = playerArmor;
   _loc1_.Health_Bar_CT.gotoAndStop(50 - playerHealth / 2);
   _loc1_.Health_Bar_T.gotoAndStop(50 - playerHealth / 2);
   _loc1_.Highlight._visible = _loc20_;
   _loc2_.Highlight._visible = _loc20_;
   _loc1_.Icon_Defuse._visible = _loc18_ && _loc3_;
   _loc1_.Icon_Bomb._visible = _loc18_ && !_loc3_;
   var _loc34_ = _loc2_.Icon_Skull._visible;
   _loc2_.Icon_Skull._visible = _loc8_ && !_loc12_;
   _loc1_.DeadState._visible = _loc8_ && !_loc12_;
   _loc1_.Icon_Armor._visible = playerArmor > 0 && _loc13_;
   _loc1_.Icon_ArmorHelmet._visible = _loc26_ && _loc13_;
   _loc1_.Icon_Health._visible = !_loc2_.Icon_Skull._visible;
   _loc1_.Panel_bg._visible = !_loc2_.Icon_Skull._visible;
   _loc1_.Health._visible = !_loc2_.Icon_Skull._visible;
   _loc1_.Health_Bar_CT._visible = !_loc2_.Icon_Skull._visible && _loc3_;
   _loc1_.Health_Bar_T._visible = !_loc2_.Icon_Skull._visible && !_loc3_;
   _loc2_.Avatar_bg._visible = !_loc2_.Icon_Skull._visible;
   _loc2_.AvatarHolder._visible = !_loc2_.Icon_Skull._visible;
   _loc2_.Default_Avatar_CT._visible = !_loc2_.Icon_Skull._visible && _loc3_;
   _loc2_.Default_Avatar_T._visible = !_loc2_.Icon_Skull._visible && !_loc3_;
   _loc2_.KeyNumber._visible = !_loc2_.Icon_Skull._visible && _loc13_;
   _loc2_.AvatarHolder.SetShowFlairItem(false);
   if(itemName == "" || _loc2_.DeadState._visible == true)
   {
      _loc1_.Icon_Weapon._visible = false;
   }
   else
   {
      if(itemName == "knife" || itemName == "knifegg")
      {
         if(_loc3_)
         {
            itemName = "knife_ct";
         }
         else
         {
            itemName = "knife_t";
         }
      }
      itemName = "icon-" + itemName;
      _loc1_.Icon_Weapon._visible = true;
      if(_loc1_.Icon_Weapon.itemName != itemName)
      {
         trace("itemName = " + itemName);
         _loc1_.Icon_Weapon.attachMovie(itemName,"Image",0);
         var _loc16_ = new Color(_loc1_.Icon_Weapon.Image);
         var _loc27_ = "0x000000";
         var _loc25_ = new Number(_loc27_);
         var _loc9_ = _loc1_.Icon_Weapon.filters[0];
         _loc9_.color = _loc25_;
         _loc9_.inner = false;
         if(bIsPrimarySelected)
         {
            _loc16_.setTransform(ColorTransform_WeaponSelected);
            _loc9_.alpha = 1;
         }
         else
         {
            _loc16_.setTransform(ColorTransform_WeaponNotselected);
            _loc9_.alpha = 0;
         }
         _loc1_.Icon_Weapon.filters = new Array(_loc9_);
      }
      _loc1_.Icon_Weapon.itemName = itemName;
   }
   _loc1_.WeaponIcons.Text.htmlText = iconString;
   _loc1_.GrenadeSlot0._visible = false;
   _loc1_.GrenadeSlot1._visible = false;
   _loc1_.GrenadeSlot2._visible = false;
   _loc1_.GrenadeSlot3._visible = false;
   var _loc7_ = _loc1_.Kill_Icon_1;
   var _loc21_ = _loc1_.Kill_Icon_2;
   var _loc10_ = _loc1_.KillCount;
   if(nRoundKills <= 0)
   {
      _loc7_._visible = false;
      _loc21_._visible = false;
      _loc10_._visible = false;
   }
   else if(nRoundKills > 1)
   {
      _loc7_.gotoAndPlay("Start");
      _loc7_._visible = true;
      _loc10_._visible = true;
      if(_loc15_)
      {
         _loc10_.Text.htmlText = nRoundKills + "x";
      }
      else
      {
         _loc10_.Text.htmlText = "x" + nRoundKills;
      }
   }
   else
   {
      _loc10_._visible = false;
      _loc21_._visible = false;
      if(_loc7_._visible == false)
      {
         _loc7_._visible = true;
         _loc7_.gotoAndPlay("Start");
      }
   }
   var _loc17_ = 2;
   if(_loc3_)
   {
      _loc17_ = 3;
   }
   _loc2_.AvatarHolder.SetShouldShowPlayerColor(nPlayerColorIndex != -1,nPlayerColorIndex);
   if(_loc2_.SavedXUID != Xuid)
   {
      _loc2_.AvatarHolder.ShowAvatar(_loc17_,Xuid,true,false);
   }
   _loc2_.SavedXUID = Xuid;
   _loc2_.bDead = _loc8_;
   _loc2_.bWasPlayerBot = _loc12_;
}
function WeaponNameUpdate(weapontext, localXuid, originalOwnerXuid)
{
   var _loc3_ = weapontext;
   if(originalOwnerID != "0" && localXuid != originalOwnerXuid)
   {
      var _loc2_ = _global.CScaleformComponent_FriendsList.GetFriendName(originalOwnerXuid);
      var _loc4_ = "";
      if(_loc2_ != undefined && _loc2_ != "")
      {
         _loc2_ = _global.TruncateText(_loc2_,15);
         _loc4_ = "<font color=\'#adadad\'>" + _loc2_ + "\'s  </font>";
      }
      _loc3_ = _loc4_ + _loc3_;
   }
   SpectatorMode.Panel.TargetName.WeaponInfo_Text.Text.htmlText = _loc3_;
   _global.AutosizeTextDown(SpectatorMode.Panel.TargetName.WeaponInfo_Text.Text,8);
}
function TogglePreviewSpectatorItem()
{
   if(m_bWeaponDisplayScreenVisible)
   {
      m_bWeaponDisplayScreenVisible = false;
      previewSpectatorItem(false);
   }
   else
   {
      m_bWeaponDisplayScreenVisible = true;
      previewSpectatorItem(true);
   }
}
function HidePreviewSpectatorItem()
{
   m_bWeaponDisplayScreenVisible = false;
   previewSpectatorItem(false);
}
function ShowAllExtraData()
{
   CT_Spectator.Panel.CT_Spectator0.ExtraData.gotoAndPlay("Show");
   CT_Spectator.Panel.CT_Spectator1.ExtraData.gotoAndPlay("Show");
   CT_Spectator.Panel.CT_Spectator2.ExtraData.gotoAndPlay("Show");
   CT_Spectator.Panel.CT_Spectator3.ExtraData.gotoAndPlay("Show");
   CT_Spectator.Panel.CT_Spectator4.ExtraData.gotoAndPlay("Show");
   T_Spectator.Panel.T_Spectator0.ExtraData.gotoAndPlay("Show");
   T_Spectator.Panel.T_Spectator1.ExtraData.gotoAndPlay("Show");
   T_Spectator.Panel.T_Spectator2.ExtraData.gotoAndPlay("Show");
   T_Spectator.Panel.T_Spectator3.ExtraData.gotoAndPlay("Show");
   T_Spectator.Panel.T_Spectator4.ExtraData.gotoAndPlay("Show");
   CT_Spectator.Panel.CT_Spectator0.ExtraData._visible = true;
   CT_Spectator.Panel.CT_Spectator1.ExtraData._visible = true;
   CT_Spectator.Panel.CT_Spectator2.ExtraData._visible = true;
   CT_Spectator.Panel.CT_Spectator3.ExtraData._visible = true;
   CT_Spectator.Panel.CT_Spectator4.ExtraData._visible = true;
   T_Spectator.Panel.T_Spectator0.ExtraData._visible = true;
   T_Spectator.Panel.T_Spectator1.ExtraData._visible = true;
   T_Spectator.Panel.T_Spectator2.ExtraData._visible = true;
   T_Spectator.Panel.T_Spectator3.ExtraData._visible = true;
   T_Spectator.Panel.T_Spectator4.ExtraData._visible = true;
}
function HideAllExtraData()
{
   CT_Spectator.Panel.CT_Spectator0.ExtraData.gotoAndPlay("Hide");
   CT_Spectator.Panel.CT_Spectator1.ExtraData.gotoAndPlay("Hide");
   CT_Spectator.Panel.CT_Spectator2.ExtraData.gotoAndPlay("Hide");
   CT_Spectator.Panel.CT_Spectator3.ExtraData.gotoAndPlay("Hide");
   CT_Spectator.Panel.CT_Spectator4.ExtraData.gotoAndPlay("Hide");
   T_Spectator.Panel.T_Spectator0.ExtraData.gotoAndPlay("Hide");
   T_Spectator.Panel.T_Spectator1.ExtraData.gotoAndPlay("Hide");
   T_Spectator.Panel.T_Spectator2.ExtraData.gotoAndPlay("Hide");
   T_Spectator.Panel.T_Spectator3.ExtraData.gotoAndPlay("Hide");
   T_Spectator.Panel.T_Spectator4.ExtraData.gotoAndPlay("Hide");
}
function HideAllExtraDataImmediate()
{
   CT_Spectator.Panel.CT_Spectator0.ExtraData._visible = false;
   CT_Spectator.Panel.CT_Spectator1.ExtraData._visible = false;
   CT_Spectator.Panel.CT_Spectator2.ExtraData._visible = false;
   CT_Spectator.Panel.CT_Spectator3.ExtraData._visible = false;
   CT_Spectator.Panel.CT_Spectator4.ExtraData._visible = false;
   T_Spectator.Panel.T_Spectator0.ExtraData._visible = false;
   T_Spectator.Panel.T_Spectator1.ExtraData._visible = false;
   T_Spectator.Panel.T_Spectator2.ExtraData._visible = false;
   T_Spectator.Panel.T_Spectator3.ExtraData._visible = false;
   T_Spectator.Panel.T_Spectator4.ExtraData._visible = false;
}
function SetPlayerExtraData(nSlot, bLeft, bIsCT, nMoney, nMoneySpent, nKills, nAssists, nDeaths)
{
   var _loc2_ = 10;
   var _loc4_ = Math.ceil(_loc2_ / 2);
   var _loc1_ = CT_Spectator.Panel["CT_Spectator" + nSlot];
   if(!bLeft)
   {
      _loc1_ = T_Spectator.Panel["T_Spectator" + nSlot];
   }
   _loc1_.ExtraData.Panel.Money.htmlText = "$" + nMoney;
   if(_loc1_.ExtraData.Panel.MoneySpent)
   {
      if(nMoneySpent == 0)
      {
         _loc1_.ExtraData.Panel.MoneySpent._visible = false;
      }
      else
      {
         _loc1_.ExtraData.Panel.MoneySpent._visible = true;
         _loc1_.ExtraData.Panel.MoneySpent.htmlText = "-$" + nMoneySpent;
      }
   }
   _loc1_.ExtraData.Panel.Kills.htmlText = nKills;
   _loc1_.ExtraData.Panel.Assists.htmlText = nAssists;
   _loc1_.ExtraData.Panel.Deaths.htmlText = nDeaths;
}
function NameTextUpdated()
{
   _global.AutosizeTextDown(SpectatorMode.Panel.TargetName.Name_Text.Text,20);
}
function NavTextUpdated()
{
   var _loc7_ = SpectatorMode.Nav_Text.Text.htmlText;
   var _loc9_ = SpectatorMode.Panel.Navbg;
   var _loc6_ = SpectatorMode.Nav_Text.Text._width;
   var _loc10_ = SpectatorMode.Nav_Text.Text._height;
   var _loc4_ = false;
   var _loc1_ = _loc7_;
   var _loc5_ = 3;
   var _loc3_ = 0;
   var _loc2_ = -1;
   trace("------------------------Text1-------------------------" + _loc1_);
   while(SpectatorMode.Nav_Text.Text.textWidth > _loc6_ && _loc3_ < _loc5_)
   {
      _loc2_ = _loc1_.lastIndexOf("[");
      if(_loc2_ >= 0)
      {
         iLastIndexStart = _loc2_ - 1;
         _loc1_ = _loc1_.substr(0,_loc2_);
         SpectatorMode.Nav_Text.Text.htmlText = _loc1_;
         _loc4_ = true;
      }
      _loc3_ = _loc3_ + 1;
   }
   if(_loc4_)
   {
      var _loc8_ = _loc7_.slice(_loc2_);
      SpectatorMode.Nav_Text.Text.htmlText = _loc1_ + "\n" + _loc8_;
      SpectatorMode.Panel.Navbg._height = m_nDefaultNavBGHeight * 2;
      SpectatorMode.Panel.Navbg._y = m_nDefaultNavBGPos_Y + m_nDefaultNavBGHeight;
   }
   else
   {
      SpectatorMode.Panel.Navbg._height = m_nDefaultNavBGHeight;
      SpectatorMode.Panel.Navbg._y = m_nDefaultNavBGPos_Y;
   }
   SpectatorMode.Nav_Text._x = 0;
}
function SetTeamValues(nValue_T, nValue_CT, bShow, bSwapped)
{
   if(bShow == false && Scoreboard.Panel.TeamValue._visible == true)
   {
      if(Scoreboard.Panel.TeamValue._isHiding == false)
      {
         Scoreboard.Panel.TeamValue.gotoAndPlay("Hide");
         Scoreboard.Panel.TeamValue._visible = false;
      }
   }
   else if(bShow == true && Scoreboard.Panel.TeamValue._visible == false)
   {
      Scoreboard.Panel.TeamValue.gotoAndPlay("Show");
      Scoreboard.Panel.TeamValue._visible = true;
   }
   else
   {
      Scoreboard.Panel.TeamValue._visible = bShow;
   }
   if(bShow == false)
   {
      return undefined;
   }
   var _loc2_ = nValue_T;
   var _loc1_ = nValue_CT;
   if(bSwapped)
   {
      _loc2_ = nValue_CT;
      _loc1_ = nValue_T;
   }
   var _loc4_ = 50 - _loc2_ / (_loc2_ + _loc1_) * 50;
   var _loc5_ = 50 - _loc1_ / (_loc2_ + _loc1_) * 50;
   if(_loc2_ == 0 && _loc1_ == 0)
   {
      _loc4_ = 25;
      _loc5_ = 25;
   }
   var _loc8_ = new Color(Scoreboard.Panel.TeamValue.TeamValuePanel.CT_Value_Number);
   var _loc7_ = new Color(Scoreboard.Panel.TeamValue.TeamValuePanel.T_Value_Number);
   if(bSwapped)
   {
      _loc8_.setTransform(T_ColorTransform_TeamValueMoney);
      _loc7_.setTransform(CT_ColorTransform_TeamValueMoney);
   }
   else
   {
      _loc8_.setTransform(CT_ColorTransform_TeamValueMoney);
      _loc7_.setTransform(T_ColorTransform_TeamValueMoney);
   }
   Scoreboard.Panel.TeamValue.TeamValuePanel.T_Value_Number.Text.htmlText = "$" + _loc2_;
   Scoreboard.Panel.TeamValue.TeamValuePanel.CT_Value_Number.Text.htmlText = "$" + _loc1_;
   Scoreboard.Panel.TeamValue.TeamValuePanel.Prog_Bar_T.gotoAndStop(_loc4_);
   Scoreboard.Panel.TeamValue.TeamValuePanel.Prog_Bar_CT.gotoAndStop(_loc5_);
   Scoreboard.Panel.TeamValue.TeamValuePanel.Prog_Bar_T_L.gotoAndStop(_loc5_);
   Scoreboard.Panel.TeamValue.TeamValuePanel.Prog_Bar_CT_L.gotoAndStop(_loc4_);
   Scoreboard.Panel.TeamValue.TeamValuePanel.Prog_Bar_T._visible = !bSwapped;
   Scoreboard.Panel.TeamValue.TeamValuePanel.Prog_Bar_CT._visible = !bSwapped;
   Scoreboard.Panel.TeamValue.TeamValuePanel.Prog_Bar_T_L._visible = bSwapped;
   Scoreboard.Panel.TeamValue.TeamValuePanel.Prog_Bar_CT_L._visible = bSwapped;
}
function SetTeamPredictionsPct(strTitle, nPercent, bShow, bSwapped)
{
   if(bShow == false && Scoreboard.Panel.TeamPrediction._visible == true)
   {
      if(Scoreboard.Panel.TeamPrediction._isHiding == false)
      {
         Scoreboard.Panel.TeamPrediction.gotoAndPlay("Hide");
      }
   }
   else if(bShow == true && Scoreboard.Panel.TeamPrediction._visible == false)
   {
      Scoreboard.Panel.TeamPrediction.gotoAndPlay("Show");
      Scoreboard.Panel.TeamPrediction._visible = bShow;
   }
   else
   {
      Scoreboard.Panel.TeamPrediction._visible = bShow;
   }
   if(bShow == false)
   {
      return undefined;
   }
   var _loc2_ = 100 - nPercent;
   var _loc1_ = nPercent;
   if(bSwapped)
   {
      _loc2_ = nPercent;
      _loc1_ = 100 - nPercent;
   }
   var _loc3_ = 50 - _loc2_ / (_loc2_ + _loc1_) * 50;
   var _loc5_ = 50 - _loc1_ / (_loc2_ + _loc1_) * 50;
   if(_loc2_ == 0 && _loc1_ == 0)
   {
      _loc3_ = 25;
      _loc5_ = 25;
   }
   Scoreboard.Panel.TeamPrediction.TeamPredictionPanel.TeamPredictions_Title.Text.htmlText = strTitle;
   Scoreboard.Panel.TeamPrediction.TeamPredictionPanel.T_Value_Number.Text.htmlText = _loc2_ + "%";
   Scoreboard.Panel.TeamPrediction.TeamPredictionPanel.CT_Value_Number.Text.htmlText = _loc1_ + "%";
   Scoreboard.Panel.TeamPrediction.TeamPredictionPanel.Prog_Bar_T.gotoAndStop(_loc3_);
   Scoreboard.Panel.TeamPrediction.TeamPredictionPanel.Prog_Bar_CT.gotoAndStop(_loc5_);
   Scoreboard.Panel.TeamPrediction.TeamPredictionPanel.Prog_Bar_T_L.gotoAndStop(_loc5_);
   Scoreboard.Panel.TeamPrediction.TeamPredictionPanel.Prog_Bar_CT_L.gotoAndStop(_loc3_);
   Scoreboard.Panel.TeamPrediction.TeamPredictionPanel.Prog_Bar_T._visible = !bSwapped;
   Scoreboard.Panel.TeamPrediction.TeamPredictionPanel.Prog_Bar_CT._visible = !bSwapped;
   Scoreboard.Panel.TeamPrediction.TeamPredictionPanel.Prog_Bar_T_L._visible = bSwapped;
   Scoreboard.Panel.TeamPrediction.TeamPredictionPanel.Prog_Bar_CT_L._visible = bSwapped;
}
function SetTeamMatchStats(strTitle, strText_T, strText_CT, bShow, bSwapped)
{
   var _loc2_ = Scoreboard.Panel.TeamMatchStat.TeamMatchStatPanel;
   _loc2_.TeamValue_Title.Text.htmlText = strTitle;
   _global.AutosizeTextDown(_loc2_.TeamValue_Title.Text,14);
   if(bSwapped)
   {
      var _loc10_ = strText_T;
      strText_T = strText_CT;
      strText_CT = _loc10_;
   }
   _loc2_.T_Value_Number.Text.htmlText = strText_T;
   _loc2_.CT_Value_Number.Text.htmlText = strText_CT;
   if(bShow == false && Scoreboard.Panel.TeamMatchStat._visible == true)
   {
      if(Scoreboard.Panel.TeamMatchStat._isHiding == false)
      {
         Scoreboard.Panel.TeamMatchStat.gotoAndPlay("Hide");
      }
   }
   else if(bShow == true && Scoreboard.Panel.TeamMatchStat._visible == false)
   {
      Scoreboard.Panel.TeamMatchStat.gotoAndPlay("Show");
      Scoreboard.Panel.TeamMatchStat._visible = bShow;
   }
   else
   {
      Scoreboard.Panel.TeamMatchStat._visible = bShow;
   }
   if(bShow == false)
   {
      return undefined;
   }
   var _loc12_ = 3;
   var _loc11_ = 11;
   var _loc5_ = _loc2_.TeamValue_Title.Text.textWidth + 20;
   if(_loc5_ < MATCHSTAT_TITLE_WIDTH_MIN)
   {
      _loc5_ = MATCHSTAT_TITLE_WIDTH_MIN;
   }
   var _loc3_ = _loc2_.T_Value_Number.Text.textWidth + 40;
   if(_loc3_ < _loc2_.CT_Value_Number.Text.textWidth + 40)
   {
      _loc3_ = _loc2_.CT_Value_Number.Text.textWidth + 50;
   }
   if(_loc3_ < MATCHSTAT_STAT_WIDTH_MIN)
   {
      _loc3_ = MATCHSTAT_STAT_WIDTH_MIN;
   }
   _loc2_.TeamValueBG_R._width = _loc3_;
   _loc2_.TeamValueBG_L._width = _loc3_;
   _loc2_.TeamValueBG_R._visible = strText_T != "";
   _loc2_.TeamValueBG_L._visible = strText_CT != "";
   var _loc9_ = new Color(_loc2_.CT_Value_Number);
   var _loc7_ = new Color(_loc2_.T_Value_Number);
   if(bSwapped)
   {
      _loc9_.setTransform(T_ColorTransform_TeamValueMoney);
      _loc7_.setTransform(CT_ColorTransform_TeamValueMoney);
   }
   else
   {
      _loc9_.setTransform(CT_ColorTransform_TeamValueMoney);
      _loc7_.setTransform(T_ColorTransform_TeamValueMoney);
   }
}
function previewSpectatorItem(bShow)
{
   var _loc1_ = SpectatorMode.Panel.ItemPanelContainer.ItemPanel;
   var _loc2_ = TooltipItemPreview;
   if(_loc1_.GetName() == null || _loc1_.GetName() == undefined)
   {
      return undefined;
   }
   _loc2_.ShowHidePreview(bShow,_loc1_.GetName(),_loc1_.GetRarityColor());
   if(bShow == false)
   {
      return undefined;
   }
   if(_loc1_.GetItemType() == "default")
   {
      _loc2_.SetModel(_loc1_.GetDefaultItemModelPath());
   }
   else
   {
      _loc2_.SetModel(_loc1_.GetImagePath());
   }
}
function setNumberKills(nRoundKills, nSide)
{
   var _loc3_ = HudPanel.WeaponPanel.Kill_Icon_1;
   var _loc4_ = HudPanel.WeaponPanel.Kill_Icon_2;
   var _loc5_ = HudPanel.WeaponPanel.Kill_Icon_3;
   var _loc2_ = HudPanel.WeaponPanel.Kill_Icon_4;
   var _loc6_ = HudPanel.WeaponPanel.KillCount;
   if(!_loc3_)
   {
      trace("Did not find HudPanel.WeaponPanel.Kill_Icon_1!!!!!!!");
   }
   if(nRoundKills <= 0)
   {
      _loc3_._visible = false;
      _loc4_._visible = false;
      _loc5_._visible = false;
      _loc2_._visible = false;
      _loc6_._visible = false;
   }
   if(m_nLastNumRoundKills == nRoundKills)
   {
      return undefined;
   }
   if(nRoundKills > 0)
   {
      if(nRoundKills > 3 && _loc2_._visible == false)
      {
         _loc2_._visible = true;
         _loc2_.gotoAndPlay("Start");
      }
      if(nRoundKills > 4)
      {
         _loc3_._visible = false;
         _loc4_._visible = false;
         _loc5_._visible = false;
         _loc6_._visible = true;
         _loc2_._visible = true;
         _loc2_.gotoAndPlay("Start");
         _loc6_.Text.htmlText = "x" + nRoundKills;
      }
      else
      {
         if(_loc3_._visible == false)
         {
            _loc3_._visible = true;
            _loc3_.gotoAndPlay("Start");
         }
         if(nRoundKills > 1 && _loc4_._visible == false)
         {
            _loc4_._visible = true;
            _loc4_.gotoAndPlay("Start");
         }
         if(nRoundKills > 2 && _loc5_._visible == false)
         {
            _loc5_._visible = true;
            _loc5_.gotoAndPlay("Start");
         }
      }
   }
   m_nLastNumRoundKills = nRoundKills;
}
function DisablePlayerIcons(bLeftSide, StartSlot)
{
   var _loc9_ = 10;
   var _loc7_ = Math.ceil(_loc9_ / 2);
   if(T_Spectator.Panel.ServerImage2._visible)
   {
      T_Spectator.Panel.ServerImage2._visible = false;
   }
   var _loc3_ = StartSlot;
   while(_loc3_ < _loc7_)
   {
      var _loc1_ = "CT_Spectator";
      var _loc2_ = "CT_AvatarBox";
      if(!bLeftSide)
      {
         _loc1_ = "T_Spectator";
         _loc2_ = "T_AvatarBox";
      }
      if(bLeftSide)
      {
         _loc2_ = _loc2_ + _loc3_;
         _loc1_ = _loc1_ + _loc3_;
      }
      else
      {
         _loc2_ = _loc2_ + _loc3_;
         _loc1_ = _loc1_ + _loc3_;
      }
      var _loc5_ = CT_Spectator.Panel[_loc1_];
      var _loc4_ = CT_Spectator.Panel_Avatar[_loc2_];
      if(!bLeftSide)
      {
         _loc5_ = T_Spectator.Panel[_loc1_];
         _loc4_ = T_Spectator.Panel_Avatar[_loc2_];
      }
      if(_loc4_.AvatarHolder.DynamicAvatar != undefined)
      {
      }
      _loc4_.SavedXUID = undefined;
      _loc4_._visible = false;
      _loc5_._visible = false;
      _loc3_ = _loc3_ + 1;
   }
}
function SetKeyNumbers()
{
   CT_Spectator.Panel_Avatar.CT_AvatarBox4.KeyNumber.Text.htmlText = 1;
   CT_Spectator.Panel_Avatar.CT_AvatarBox3.KeyNumber.Text.htmlText = 2;
   CT_Spectator.Panel_Avatar.CT_AvatarBox2.KeyNumber.Text.htmlText = 3;
   CT_Spectator.Panel_Avatar.CT_AvatarBox1.KeyNumber.Text.htmlText = 4;
   CT_Spectator.Panel_Avatar.CT_AvatarBox0.KeyNumber.Text.htmlText = 5;
   T_Spectator.Panel_Avatar.T_AvatarBox0.KeyNumber.Text.htmlText = 6;
   T_Spectator.Panel_Avatar.T_AvatarBox1.KeyNumber.Text.htmlText = 7;
   T_Spectator.Panel_Avatar.T_AvatarBox2.KeyNumber.Text.htmlText = 8;
   T_Spectator.Panel_Avatar.T_AvatarBox3.KeyNumber.Text.htmlText = 9;
   T_Spectator.Panel_Avatar.T_AvatarBox4.KeyNumber.Text.htmlText = 0;
}
function GetGrenadeIconString(nType)
{
   switch(nType)
   {
      case -1:
         return "";
      case 0:
         return "hegrenade";
      case 1:
         return "flashbang";
      case 2:
         return "smokegrenade";
      case 3:
         return "decoy";
      case 4:
         return "molotov";
      case 5:
         return "incgrenade";
      default:
   }
}
function ShowSpectatorStatsPanel(Xuid)
{
   if(_global.CScaleformComponent_MatchStats.ShouldShowSpecStats())
   {
      SetStatsPanelData(Xuid);
      SpectatorMode.Panel.StatsPanel._visible = true;
      SpectatorMode.Nav_Text._y = SpectatorMode.Panel._y + SpectatorMode.Panel.TargetName._height + SpectatorMode.Panel.StatsPanel._height;
   }
   else
   {
      SpectatorMode.Panel.StatsPanel._visible = false;
      SpectatorMode.Nav_Text._y = SpectatorMode.Panel._y + SpectatorMode.Panel.TargetName._height;
   }
}
function InitStatsPanel()
{
   var _loc4_ = _global.CScaleformComponent_MatchStats.GetSpecStatCount();
   var _loc2_ = 0;
   while(_loc2_ < _loc4_)
   {
      var _loc3_ = _global.CScaleformComponent_MatchStats.GetSpecStatNameByIndex(_loc2_);
      m_aStatNames.push(_loc3_);
      _loc2_ = _loc2_ + 1;
   }
   SpectatorMode.Panel.StatsPanel.Halves.First.htmlText = "#SFUI_SpecStat_First_Half";
   SpectatorMode.Panel.StatsPanel.Halves.Second.htmlText = "#SFUI_SpecStat_Second_Half";
}
function SetStatsPanelData(Xuid)
{
   var _loc9_ = _global.CScaleformComponent_MatchStats.GetPlayerCount();
   var _loc8_ = _global.CScaleformComponent_MatchStats.GetPlayerByIndex(3);
   var _loc6_ = _global.CScaleformComponent_MatchStats.GetDataSeriesPointCount(m_aStatNames[0],_loc8_);
   var _loc10_ = false;
   if(_loc6_ <= 14)
   {
      SpectatorMode.Panel.StatsPanel.Halves.First._alpha = 100;
      SpectatorMode.Panel.StatsPanel.Halves.Second._alpha = 30;
   }
   else if(_loc6_ < 30)
   {
      SpectatorMode.Panel.StatsPanel.Halves.First._alpha = 40;
      SpectatorMode.Panel.StatsPanel.Halves.Second._alpha = 100;
   }
   else
   {
      SpectatorMode.Panel.StatsPanel.Halves.First._alpha = 40;
      SpectatorMode.Panel.StatsPanel.Halves.Second._alpha = 40;
   }
   var _loc7_ = m_aStatNames.length;
   var _loc2_ = 0;
   while(_loc2_ < _loc7_)
   {
      var _loc3_ = SpectatorMode.Panel.StatsPanel["column" + _loc2_];
      _loc3_.StatName.htmlText = "#SFUI_SpecStat_type_" + m_aStatNames[_loc2_];
      _loc3_._visible = true;
      if(_loc6_ <= 14)
      {
         var _loc4_ = _global.CScaleformComponent_MatchStats.GetSpecStatValueForCurrentTarget(m_aStatNames[_loc2_],_loc6_);
         if(m_aStatNames[_loc2_] == "hsp" && _loc4_ != 0)
         {
            _loc4_ = _loc4_ + "%";
         }
         if(_loc4_ == 0)
         {
            _loc4_ = "-";
         }
         _loc3_.FirstHalf.Text.htmlText = _loc4_;
         _loc3_.SecondHalf.Text.htmlText = "";
         _loc3_.FirstHalf.Text._alpha = 100;
         _loc3_.SecondHalf.Text._alpha = 100;
      }
      else if(_loc6_ > 14)
      {
         _loc4_ = _global.CScaleformComponent_MatchStats.GetSpecStatValueForCurrentTarget(m_aStatNames[_loc2_],14);
         if(_loc6_ > 29)
         {
            var _loc5_ = _global.CScaleformComponent_MatchStats.GetSpecStatValueForCurrentTarget(m_aStatNames[_loc2_],29);
         }
         else
         {
            _loc5_ = _global.CScaleformComponent_MatchStats.GetSpecStatValueForCurrentTarget(m_aStatNames[_loc2_],_loc6_);
         }
         if(m_aStatNames[_loc2_] == "hsp" && _loc4_ != 0)
         {
            _loc4_ = _loc4_ + "%";
         }
         if(m_aStatNames[_loc2_] == "hsp" && _loc5_ != 0)
         {
            _loc5_ = _loc5_ + "%";
         }
         if(_loc4_ == 0)
         {
            _loc4_ = "-";
         }
         if(_loc5_ == 0)
         {
            _loc5_ = "-";
         }
         _loc3_.FirstHalf.Text.htmlText = _loc4_;
         _loc3_.SecondHalf.Text.htmlText = _loc5_;
         _loc3_.FirstHalf.Text._alpha = 40;
         if(_loc6_ > 29)
         {
            _loc3_.SecondHalf.Text._alpha = 40;
         }
      }
      _loc2_ = _loc2_ + 1;
   }
}
function commaFormat(number)
{
   var _loc1_ = number + "";
   var _loc3_ = "";
   while(_loc1_.length > 3)
   {
      var _loc2_ = _loc1_.substr(-3);
      _loc1_ = _loc1_.substr(0,_loc1_.length - 3);
      _loc3_ = "," + _loc2_ + _loc3_;
   }
   if(_loc1_.length > 0)
   {
      _loc3_ = _loc1_ + _loc3_;
   }
   return _loc3_;
}
function ClearAllPlayerReceivedTourneyDrop()
{
   EventSpecPanel.TourneyPanelParent.EventSpec_DropInfo._visible = false;
   m_PlayersWhoGotItemsArray = [];
   trace("<<<<<< Spectator::ClearAllPlayerReceivedTourneyDrop");
}
function SetLocalPlayerGotDrop(data)
{
   if(m_PlayersWhoGotItemsArray.length < 5)
   {
      m_PlayersWhoGotItemsArray.push(data);
   }
   else
   {
      m_PlayersWhoGotItemsArray[0] = data;
   }
}
function AddPlayerReceivedTourneyDrop(steamID, nDefIndex, bIsLocal)
{
   var _loc1_ = [];
   _loc1_.steamID = steamID;
   _loc1_.nDefIndex = nDefIndex;
   _loc1_.bIsLocal = bIsLocal;
   if(bIsLocal)
   {
      SetLocalPlayerGotDrop(_loc1_);
   }
   else if(m_PlayersWhoGotItemsArray.length < 5)
   {
      m_PlayersWhoGotItemsArray.push(_loc1_);
   }
   trace("<<<<<< AddPlayerReceivedTourneyDrop:: steamID = " + steamID);
}
function ShowTourneyAndViewerPanel(szTourneyName)
{
   EventSpecPanel.TourneyPanelParent.EventSpec_Title._visible = false;
   EventSpecPanel.TourneyPanelParent.EventSpec_DropInfo._visible = false;
   EventSpecPanel.TourneyPanelParent.ItemPanel._visible = false;
   m_bTourneyItemDropPanelVisible = false;
   m_bTourneyItemDisplayedForLocalPlayer = false;
   EventSpecPanel._visible = true;
   if(szTourneyName)
   {
      if(szTourneyName.indexOf("DreamHack") != -1 && szTourneyName.indexOf("2013") != -1)
      {
         LoadTournamentImage("econ/tournaments/tournament_logo_1.png",EventSpecPanel.TourneyPanelParent.EventSpec_Title.TournamentLogo,80,30);
      }
      else if(szTourneyName.indexOf("Valve") != -1)
      {
         LoadTournamentImage("econ/tournaments/tournament_logo_2.png",EventSpecPanel.TourneyPanelParent.EventSpec_Title.TournamentLogo,80,30);
      }
      else if(szTourneyName.indexOf("EMS") != -1 && szTourneyName.indexOf("2014") != -1)
      {
         LoadTournamentImage("econ/tournaments/tournament_logo_3.png",EventSpecPanel.TourneyPanelParent.EventSpec_Title.TournamentLogo,80,30);
      }
      else if(szTourneyName.indexOf("Cologne") != -1 && szTourneyName.indexOf("2014") != -1)
      {
         LoadTournamentImage("econ/tournaments/tournament_logo_4.png",EventSpecPanel.TourneyPanelParent.EventSpec_Title.TournamentLogo,30,30);
      }
      else if(szTourneyName.indexOf("DreamHack") != -1 && szTourneyName.indexOf("2014") != -1)
      {
         LoadTournamentImage("econ/tournaments/tournament_logo_5.png",EventSpecPanel.TourneyPanelParent.EventSpec_Title.TournamentLogo,80,30);
      }
      else if(szTourneyName.indexOf("Katowice") != -1 && szTourneyName.indexOf("2015") != -1)
      {
         LoadTournamentImage("econ/tournaments/tournament_logo_6.png",EventSpecPanel.TourneyPanelParent.EventSpec_Title.TournamentLogo,30,30);
      }
      else if(szTourneyName.indexOf("Cologne") != -1 && szTourneyName.indexOf("2015") != -1)
      {
         LoadTournamentImage("econ/tournaments/tournament_logo_7.png",EventSpecPanel.TourneyPanelParent.EventSpec_Title.TournamentLogo,30,30);
      }
      else if(szTourneyName.indexOf("DreamHack") != -1 && szTourneyName.indexOf("2015") != -1)
      {
         LoadTournamentImage("econ/tournaments/tournament_logo_8.png",EventSpecPanel.TourneyPanelParent.EventSpec_Title.TournamentLogo,30,30);
      }
      else if(szTourneyName.indexOf("Columbus") != -1 && szTourneyName.indexOf("2016") != -1)
      {
         LoadTournamentImage("econ/tournaments/tournament_logo_9.png",EventSpecPanel.TourneyPanelParent.EventSpec_Title.TournamentLogo,80,30);
      }
      else if(szTourneyName.indexOf("Cologne") != -1 && szTourneyName.indexOf("2016") != -1)
      {
         LoadTournamentImage("econ/tournaments/tournament_logo_10.png",EventSpecPanel.TourneyPanelParent.EventSpec_Title.TournamentLogo,30,30);
      }
      EventSpecPanel.TourneyPanelParent.EventSpec_Title._visible = true;
   }
   EventSpecPanel.gotoAndPlay("Show");
   trace("<<<<<< ShowTourneyAndViewerPanel");
   m_bTourneyEventPanelVisible = true;
}
function SetDropItemImageAndText()
{
   var _loc2_ = _global.CScaleformComponent_MyPersona.GetXuid();
   var _loc5_ = m_PlayersWhoGotItemsArray[0].nDefIndex;
   var _loc3_ = _global.CScaleformComponent_Inventory.GetFauxItemIDFromDefAndPaintIndex(_loc5_,0);
   var _loc6_ = _global.CScaleformComponent_Inventory.GetItemName(_loc2_,_loc3_);
   var _loc4_ = _global.CScaleformComponent_Inventory.GetItemInventoryImage(_loc2_,_loc3_);
   EventSpecPanel.TourneyPanelParent.ItemPanel.Image.htmlText = strCase;
   EventSpecPanel.TourneyPanelParent.ItemPanel.ItemName.htmlText = _loc6_;
   LoadTournamentImage(_loc4_ + ".png",EventSpecPanel.TourneyPanelParent.ItemPanel.ItemImage,60,40);
}
function LoadTournamentImage(imagePath, objImage, numWidth, numHeight)
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
   objImage.Flare._visible = false;
}
function HideTourneyViewerAndItemNumbers()
{
   if(m_bTourneyEventPanelVisible == false || EventSpecPanel._visible == false)
   {
      EventSpecPanel._visible = false;
      return undefined;
   }
   EventSpecPanel.gotoAndPlay("Hide");
   m_bTourneyItemDropPanelVisible = false;
   m_bTourneyItemDisplayedForLocalPlayer = false;
}
function SetTourneyEventPanelHidden()
{
   m_bTourneyEventPanelVisible = false;
   EventSpecPanel._visible = false;
   trace("<<<<<<  SetTourneyEventPanelHidden::!!! ");
}
function ScaleformComponent_FriendsList_NameChanged()
{
   UpdateTourneyItemDropPlayerNames();
}
function UpdateTourneyViewerAndItemNumbers(nViewers, nItemsDroppedThisRound, nItemsDroppedTotal, szTourneyName)
{
   EventSpecPanel.TourneyPanelParent.EventSpec_Viewers._visible = false;
   if(nViewers > 0)
   {
      EventSpecPanel.TourneyPanelParent.EventSpec_Viewers._visible = true;
      EventSpecPanel.TourneyPanelParent.EventSpec_Viewers.Text.htmlText = _global.ConstructString(_global.GameInterface.Translate("#SFUI_Scoreboard_Viewers"),commaFormat(nViewers));
   }
   if(m_bTourneyEventPanelVisible == false || EventSpecPanel._visible == false)
   {
      ShowTourneyAndViewerPanel(szTourneyName);
   }
   SetPlayersWhoGotDrops(nItemsDroppedThisRound,nItemsDroppedTotal);
}
function SetPlayersWhoGotDrops(nItemsDroppedThisRound, nItemsDroppedTotal)
{
   UpdateTourneyItemDropPlayerNames();
   EventSpecPanel.TourneyPanelParent.ItemPanel._visible = false;
   if(nItemsDroppedThisRound > 0)
   {
      if(m_bTourneyItemDropPanelVisible == false)
      {
         trace("<<<<<< SetPlayersWhoGotDrops::  EventSpecPanel.TourneyPanelParent.gotoAndPlay(  ShowItemPanel  )");
         EventSpecPanel.TourneyPanelParent.gotoAndPlay("ShowItemPanel");
         m_bTourneyItemDropPanelVisible = true;
      }
      EventSpecPanel.TourneyPanelParent.ItemPanel._visible = true;
      SetDropItemImageAndText();
   }
   var _loc2_ = m_PlayersWhoGotItemsArray.length;
   trace("<<<<<< SetPlayersWhoGotDrops:: nNumPlayersWhoGotItems = " + _loc2_);
   if(nItemsDroppedThisRound > 0 && _loc2_ >= 0)
   {
      EventSpecPanel.TourneyPanelParent.ItemPanel.OtherPlayers._visible = true;
      EventSpecPanel.TourneyPanelParent.ItemPanel.OtherPlayers.Panel.Text.htmlText = _global.ConstructString(_global.GameInterface.Translate("#SFUIHUD_Spec_Event_DroppingItemsRewarded"),commaFormat(nItemsDroppedThisRound));
   }
   else
   {
      EventSpecPanel.TourneyPanelParent.ItemPanel.OtherPlayers._visible = false;
   }
   EventSpecPanel.TourneyPanelParent.ItemPanel.TotalItemsText._visible = true;
   EventSpecPanel.TourneyPanelParent.ItemPanel.TotalItemsText.htmlText = _global.ConstructString(_global.GameInterface.Translate("#SFUIHUD_Spec_Event_DroppingItemsTotalDropped"),commaFormat(nItemsDroppedTotal));
}
function UpdateTourneyItemDropPlayerNames()
{
   trace("<<<<<< UpdateTourneyItemDropPlayerNames:: nNumPlayersWhoGotItems = " + nNumPlayersWhoGotItems);
}
function SizeStatsPanelBg(bIsWide)
{
   if(bIsWide)
   {
      SpectatorMode.Panel.TargetName.WeaponInfo_Text._x = 331.6;
      SpectatorMode.Panel.TargetName.ItemNameBg._x = 331.6;
   }
   else
   {
      SpectatorMode.Panel.TargetName.WeaponInfo_Text._x = 438.2;
      SpectatorMode.Panel.TargetName.ItemNameBg._x = 438.2;
   }
}
_global.SpectatorMovie = this;
var navSpectator = new Lib.NavLayout();
var specVisible = false;
var m_nDefaultNavBGPos_Y = SpectatorMode.Panel.Navbg._y;
var m_nDefaultNavBGHeight = SpectatorMode.Panel.Navbg._height;
var CT_ColorTransform = _global.tintManager.Tints[_global.tintManager.TintIndex(Lib.TintManager.Tint_CounterTerrorist)];
var T_ColorTransform = _global.tintManager.Tints[_global.tintManager.TintIndex(Lib.TintManager.Tint_Terrorist)];
var Default_ColorTransform = _global.tintManager.Tints[0];
var m_aStatNames = [];
var m_aSelectedXuidForStats;
var m_PlayersWhoGotItemsArray = [];
var m_bTourneyItemDropPanelVisible = false;
var m_bTourneyEventPanelVisible = false;
var m_bTourneyItemDisplayedForLocalPlayer = false;
var m_nTeamLogoSize = Scoreboard.Panel.TLogo._width;
var m_nTeamFlagSizeW = Scoreboard.Panel.TFlag._width;
var m_nTeamFlagSizeH = Scoreboard.Panel.TFlag._height;
var m_teamLogo_CT = "";
var m_teamLogo_T = "";
var m_teamFlag_CT = "";
var m_teamFlag_T = "";
var CT_ColorTransform_ScoreboardAdd = new Object();
CT_ColorTransform_ScoreboardAdd = {ra:"0",rb:"97",ga:"0",gb:"123",ba:"0",bb:"153",aa:"100",ab:"0"};
var T_ColorTransform_ScoreboardAdd = new Object();
T_ColorTransform_ScoreboardAdd = {ra:"0",rb:"125",ga:"0",gb:"99",ba:"0",bb:"36",aa:"100",ab:"0"};
var CT_ColorTransform_Scoreboard = new Object();
CT_ColorTransform_Scoreboard = {ra:"0",rb:"146",ga:"0",gb:"194",ba:"0",bb:"235",aa:"100",ab:"0"};
var T_ColorTransform_Scoreboard = new Object();
T_ColorTransform_Scoreboard = {ra:"0",rb:"223",ga:"0",gb:"192",ba:"0",bb:"98",aa:"100",ab:"0"};
var CT_ColorTransform_ScoreboardDark = new Object();
CT_ColorTransform_ScoreboardDark = {ra:"0",rb:"32",ga:"0",gb:"41",ba:"0",bb:"51",aa:"100",ab:"0"};
var T_ColorTransform_ScoreboardDark = new Object();
T_ColorTransform_ScoreboardDark = {ra:"0",rb:"48",ga:"0",gb:"37",ba:"0",bb:"12",aa:"100",ab:"0"};
var ColorTransform_WeaponSelected = new Object();
ColorTransform_WeaponSelected = {ra:"100",rb:"0",ga:"100",gb:"0",ba:"100",bb:"0",aa:"100",ab:"0"};
var ColorTransform_WeaponNotselected = new Object();
ColorTransform_WeaponNotselected = {ra:"70",rb:"0",ga:"70",gb:"0",ba:"70",bb:"0",aa:"100",ab:"0"};
var CT_ColorTransform_TeamValueMoney = new Object();
CT_ColorTransform_TeamValueMoney = {ra:"0",rb:"97",ga:"0",gb:"123",ba:"0",bb:"153",aa:"100",ab:"0"};
var T_ColorTransform_TeamValueMoney = new Object();
T_ColorTransform_TeamValueMoney = {ra:"0",rb:"221",ga:"0",gb:"196",ba:"0",bb:"136",aa:"100",ab:"0"};
var CT_ColorTransform_SpentMoney = new Object();
CT_ColorTransform_SpentMoney = {ra:"0",rb:"142",ga:"0",gb:"176",ba:"0",bb:"214",aa:"100",ab:"0"};
var T_ColorTransform_SpentMoney = new Object();
T_ColorTransform_SpentMoney = {ra:"0",rb:"221",ga:"0",gb:"196",ba:"0",bb:"136",aa:"100",ab:"0"};
var ColorTransform_TourneyDropNameNormal = new Object();
ColorTransform_TourneyDropNameNormal = {ra:"100",rb:"0",ga:"100",gb:"0",ba:"100",bb:"0",aa:"100",ab:"0"};
var ColorTransform_TourneyDropNameLocal = new Object();
ColorTransform_TourneyDropNameLocal = {ra:"0",rb:"237",ga:"0",gb:"228",ba:"0",bb:"122",aa:"100",ab:"0"};
var TintedList = new Array();
var avatarX = 0;
var avatarY = 0;
var avatarWidth = 43;
var avatarHeight = 43;
var LShoulderButton = undefined;
var RShoulderButton = undefined;
var bSpectatorTogglesDisabled = false;
var m_bWeaponDisplayScreenVisible = false;
var m_TTeamNameStartPos = Scoreboard.Panel.T_TeamName._x;
var m_CTTeamNameStartPos = Scoreboard.Panel.CT_TeamName._x;
var m_SpectatorModeXPos = Stage.width / 2 - SpectatorMode._width / 2 + 27;
var MATCHSTAT_TITLE_WIDTH_MIN = 135;
var MATCHSTAT_STAT_WIDTH_MIN = 60;
var m_MatchStatDefaultWidth = 1;
var m_MatchStatDefaultCT_X = 1;
var m_MatchStatDefaultCTtxt_X = 1;
var m_MatchStatDefaultT_X = 1;
var m_MatchStatDefaultTtxt_X = 1;
Scoreboard.Panel.CT_Avatar._visible = false;
Scoreboard.Panel.T_Avatar._visible = false;
ReplayOverlay._visible = false;
ReplayPlayerTag._visible = false;
navSpectator.AddKeyHandlers({onDown:function(button, control, keycode)
{
   if(_global.SpectatorMovie != undefined && _global.SpectatorMovie != null && _global.SpectatorMovie.specVisible)
   {
      gameAPI.ShowGamerCard();
   }
   return true;
}},"KEY_XBUTTON_Y","KEY_P");
navSpectator.AddKeyHandlerTable({KEY_F1:{onDown:function(button, control, keycode)
{
   if(!_global.wantControllerShown)
   {
      _global.VotePanelAPI.VoteYes();
   }
   return true;
}},KEY_F2:{onDown:function(button, control, keycode)
{
   if(!_global.wantControllerShown)
   {
      _global.VotePanelAPI.VoteNo();
   }
   return true;
}}});
navSpectator.AddKeyHandlerTable({KEY_ESCAPE:{onDown:function(button, control, keycode)
{
   gameAPI.ShowPauseMenu();
}}});
navSpectator.ShowCursor(false);
_global.resizeManager.AddListener(this);
Lib.TintManager.StaticRegisterForTint(PanelStroke,Lib.TintManager.TintRegister_All);
stop();
