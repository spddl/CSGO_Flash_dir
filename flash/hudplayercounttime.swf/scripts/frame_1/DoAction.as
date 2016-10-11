function onLoaded()
{
   var _loc3_ = TopPanel.Panel;
   var _loc4_ = _loc3_.Time;
   TopPanel.Panel.PlayerJoinPanel.JoinBot._visible = false;
   TopPanel.Panel.PlayerJoinPanel.JoinCt._visible = false;
   TopPanel.Panel.PlayerJoinPanel.JoinT._visible = false;
   _loc4_.IconTimeGreen._visible = true;
   _loc4_.TimeGreen._visible = true;
   _loc4_.TimeRed._visible = false;
   _loc4_.GlowPulse._visible = false;
   _loc4_.IconTimeRed._visible = false;
   _loc4_.BombPlantedIcon._visible = false;
   _loc4_.BombPlantedIconMedium._visible = false;
   _loc4_.BombPlantedIconFast._visible = false;
   _loc4_.BombPlantedIconDefused._visible = false;
   _loc3_.CTWinning._visible = false;
   _loc3_.TWinning._visible = false;
   _loc3_.GunGameBombCTScore._visible = false;
   _loc3_.GunGameBombTScore._visible = false;
   _loc3_.ProgressiveLeader._visible = false;
   var _loc1_ = 0;
   while(_loc1_ < 10)
   {
      var _loc2_ = _loc3_["Avatar" + _loc1_];
      if(_loc2_)
      {
         _loc2_._visible = false;
      }
      _loc1_ = _loc1_ + 1;
   }
   _loc1_ = 0;
   while(_loc1_ < 24)
   {
      _loc2_ = _loc3_["PAvatar" + _loc1_];
      if(_loc2_)
      {
         _loc2_._visible = false;
      }
      _loc1_ = _loc1_ + 1;
   }
   gameAPI.OnReady();
   TopPanel.Panel.PlayerJoinPanel.gotoAndPlay("Init");
}
function onSetModeNormalTen()
{
   var _loc1_ = TopPanel.Panel;
   m_nMaxPlayers = 10;
   m_bIsGunGame = false;
   _loc1_.gotoAndStop("NormalTen");
   _loc1_.PanelStroke._visible = true;
}
function onSetModeNormal()
{
   var _loc1_ = TopPanel.Panel;
   m_nMaxPlayers = 24;
   m_bIsGunGame = false;
   _loc1_.gotoAndStop("Normal");
   _loc1_.PanelStroke._visible = true;
}
function onSetModeGunGameProgressive()
{
   var _loc1_ = TopPanel.Panel;
   m_nMaxPlayers = 10;
   m_bIsGunGame = true;
   _loc1_.gotoAndStop("GGProg10");
   _loc1_.PanelStroke._visible = false;
   _loc1_.ProgressiveLeader._visible = false;
}
function onSetModeGunGameBomb()
{
   var _loc1_ = TopPanel.Panel;
   m_nMaxPlayers = 24;
   m_bIsGunGame = false;
   _loc1_.gotoAndStop("Normal");
   _loc1_.PanelStroke._visible = true;
   _loc1_.ProgressiveLeader._visible = false;
}
function onSetModeGunGameBombTen()
{
   var _loc1_ = TopPanel.Panel;
   m_nMaxPlayers = 10;
   m_bIsGunGame = false;
   _loc1_.gotoAndStop("NormalTen");
   _loc1_.PanelStroke._visible = true;
   _loc1_.ProgressiveLeader._visible = false;
}
function onUnload(mc)
{
   DisableRemainingPlayerIcons(true,0);
   DisableRemainingPlayerIcons(false,0);
   _global.resizeManager.RemoveListener(this);
   return true;
}
function onResize(rm)
{
   if(m_bPositionIsBottom)
   {
      rm.ResetPositionByPixel(TopPanel,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_CENTER_X,0,Lib.ResizeManager.ALIGN_CENTER,Lib.ResizeManager.REFERENCE_SAFE_BOTTOM,0,Lib.ResizeManager.ALIGN_BOTTOM);
      var _loc2_ = TopPanel._y + 7;
      var _loc1_ = TopPanel.scaledHeight / 1.78;
      TopPanel._y = _loc2_ + _loc1_;
      var _loc4_ = down;
   }
   else
   {
      rm.ResetPositionByPixel(TopPanel,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_CENTER_X,0,Lib.ResizeManager.ALIGN_CENTER,Lib.ResizeManager.REFERENCE_SAFE_TOP,0,Lib.ResizeManager.ALIGN_TOP);
      _loc4_ = up;
   }
   gameAPI.OnFlashResize(TopPanel._height + TopPanel._y);
}
function ShowPanel()
{
   m_bPositionIsBottom = _global.GameInterface.GetConvarNumber("cl_hud_playercount_pos") == 1;
   m_bShowOnlyPlayerCount = _global.GameInterface.GetConvarNumber("cl_hud_playercount_showcount") == 1;
   var _loc2_ = "";
   if(m_bPositionIsBottom)
   {
      _loc2_ = "_bot";
   }
   TopPanel.gotoAndPlay("StartShow" + _loc2_);
   gameAPI.OnFlashResize(TopPanel._height + TopPanel._y);
   onResize(_global.resizeManager);
   if(m_bIsGunGame && m_bIsShowingTimer)
   {
      UpdateTotalProgressivePlayers(m_nLastGGPlayerCount,m_bIsShowingTimer);
   }
   _global.HAmodule.setColorText();
   _global.WeaponModule.setColorText();
   _global.MoneyPanel.setColorText();
   HudBackgroundUpdate();
}
function HidePanel()
{
   var _loc1_ = "";
   if(m_bPositionIsBottom)
   {
      _loc1_ = "_bot";
   }
   TopPanel.gotoAndPlay("StartHide" + _loc1_);
}
function onBeginTimerAlert()
{
   var _loc1_ = TopPanel.Panel.Time;
   _loc1_.TimeGreen._visible = false;
   _loc1_.IconTimeGreen._visible = false;
   _loc1_.IconTimeRed._visible = true;
   _loc1_.TimeRed._visible = true;
   _loc1_.GlowPulse._visible = true;
}
function onBeginTimerNormal()
{
   var _loc1_ = TopPanel.Panel.Time;
   _loc1_.TimeGreen._visible = true;
   _loc1_.IconTimeGreen._visible = true;
   _loc1_.IconTimeRed._visible = false;
   _loc1_.TimeRed._visible = false;
   _loc1_.GlowPulse._visible = false;
   _loc1_.BombPlantedIcon._visible = false;
   _loc1_.BombPlantedIconMedium._visible = false;
   _loc1_.BombPlantedIconFast._visible = false;
   _loc1_.BombPlantedIconDefused._visible = false;
}
function updatePlantedBombState(detProgress)
{
   var _loc1_ = TopPanel.Panel.Time;
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
   var _loc1_ = TopPanel.Panel.Time;
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
function onHideTimer()
{
   var _loc1_ = TopPanel.Panel.Time;
   _loc1_.TimeGreen._visible = false;
   _loc1_.IconTimeGreen._visible = false;
   _loc1_.IconTimeRed._visible = false;
   _loc1_.TimeRed._visible = false;
   _loc1_.GlowPulse._visible = false;
}
function onUpdateBalanceOfPower(nBOP)
{
   var _loc1_ = TopPanel.Panel;
   if(nBOP == 0)
   {
      _loc1_.CTWinning._visible = false;
      _loc1_.TWinning._visible = false;
   }
   else if(nBOP == 2)
   {
      _loc1_.CTWinning._visible = false;
      _loc1_.TWinning._visible = true;
   }
   else if(nBOP == 3)
   {
      _loc1_.CTWinning._visible = true;
      _loc1_.TWinning._visible = false;
   }
}
function onUpdateTeamSelection(team)
{
   var _loc1_ = TopPanel.Panel;
   if(team == 3)
   {
      _loc1_.CTPlayer._visible = true;
      _loc1_.TPlayer._visible = false;
   }
   else if(team == 2)
   {
      _loc1_.TPlayer._visible = true;
      _loc1_.CTPlayer._visible = false;
   }
   else
   {
      _loc1_.CTPlayer._visible = false;
      _loc1_.TPlayer._visible = false;
   }
}
function onSpawnDisplaySelectedTeam(team)
{
   TopPanel.Panel.PlayerJoinPanel.JoinBot._visible = false;
   if(team == 3)
   {
      TopPanel.Panel.PlayerJoinPanel.JoinCt._visible = true;
      TopPanel.Panel.PlayerJoinPanel.JoinT._visible = false;
   }
   else if(team == 2)
   {
      TopPanel.Panel.PlayerJoinPanel.JoinCt._visible = false;
      TopPanel.Panel.PlayerJoinPanel.JoinT._visible = true;
   }
   else
   {
      TopPanel.Panel.PlayerJoinPanel.JoinCt._visible = false;
      TopPanel.Panel.PlayerJoinPanel.JoinT._visible = false;
   }
   TopPanel.Panel.PlayerJoinPanel.gotoAndPlay("FadeIn");
}
function fadeOutSelectedTeam()
{
   TopPanel.Panel.PlayerJoinPanel.gotoAndPlay("FadeOut");
}
function hideDisplayTeamPanels()
{
   TopPanel.Panel.PlayerJoinPanel.JoinCt._visible = false;
   TopPanel.Panel.PlayerJoinPanel.JoinT._visible = false;
   TopPanel.Panel.PlayerJoinPanel.JoinBot._visible = false;
}
function onTakeOverBot(sBotName)
{
   TopPanel.Panel.PlayerJoinPanel.JoinCt._visible = false;
   TopPanel.Panel.PlayerJoinPanel.JoinT._visible = false;
   TopPanel.Panel.PlayerJoinPanel.JoinBot._visible = true;
   TopPanel.Panel.PlayerJoinPanel.JoinBot.BotTextPanel.BotText.htmlText = sBotName;
   TopPanel.Panel.PlayerJoinPanel.gotoAndPlay("FadeIn");
}
function DisableRemainingPlayerIcons(bCT, StartSlot)
{
   var _loc5_ = TopPanel.Panel;
   var _loc2_ = Math.ceil(m_nMaxPlayers / 2);
   var _loc1_ = StartSlot;
   while(_loc1_ < _loc2_)
   {
      DisablePlayerIcon(bCT,_loc1_);
      _loc1_ = _loc1_ + 1;
   }
}
function DisablePlayerIcon(bCT, nSlot)
{
   var _loc5_ = TopPanel.Panel;
   var _loc3_ = Math.ceil(m_nMaxPlayers / 2);
   var _loc1_ = "Avatar";
   if(m_nMaxPlayers > 10)
   {
      _loc1_ = "PAvatar";
   }
   if(bCT)
   {
      _loc1_ = _loc1_ + (_loc3_ - 1 - nSlot);
   }
   else
   {
      _loc1_ = _loc1_ + (_loc3_ + nSlot);
   }
   var _loc2_ = _loc5_[_loc1_];
   var _loc4_ = _loc2_.DynamicAvatar;
   if(_loc4_ != undefined)
   {
      _loc4_.unloadMovie();
   }
   _loc2_.SavedXUID = null;
   _loc2_._visible = false;
}
function SetNumPlayersAlive(nPlayersAlive_CT, nPlayersAlive_T)
{
   m_nPlayersAlive_CT = nPlayersAlive_CT;
   m_nPlayersAlive_T = nPlayersAlive_T;
   NumberCountUpdate();
}
function UpdateTotalProgressivePlayers(NewCount, bShowTimer)
{
   var _loc4_ = TopPanel.Panel;
   var _loc1_ = 0;
   while(_loc1_ < 10)
   {
      var _loc3_ = "Avatar" + _loc1_;
      var _loc2_ = _loc4_[_loc3_];
      _loc2_._visible = true;
      _loc1_ = _loc1_ + 1;
   }
   if(NewCount < 0)
   {
      NewCount = 0;
   }
   else if(NewCount > 10)
   {
      NewCount = 10;
   }
   var _loc7_ = "";
   if(bShowTimer)
   {
      _loc7_ = "T";
   }
   var _loc6_ = "";
   if(m_bPositionIsBottom)
   {
      _loc6_ = "_B_";
   }
   m_nLastGGPlayerCount = NewCount;
   m_bIsShowingTimer = bShowTimer;
   var _loc8_ = "GGProg" + _loc7_ + _loc6_ + NewCount;
   trace("UpdateTotalProgressivePlayers: anim = " + _loc8_);
   _loc4_.gotoAndStop("GGProg" + _loc7_ + _loc6_ + NewCount);
}
function HudBackgroundUpdate()
{
   var _loc10_ = _global.GameInterface.GetConvarNumber("cl_hud_healthammo_style");
   var _loc3_ = _global.GameInterface.GetConvarNumber("cl_hud_background_alpha");
   if(m_nHudBGAlpha != _loc3_)
   {
      var _loc5_ = _global.WeaponModule.HudPanel.WeaponPanel.HUDbg;
      var _loc8_ = _global.HAmodule.HudPanel.HealthArmorPanel.HealthPanelBG;
      var _loc9_ = _global.HAmodule.HudPanel.HealthArmorPanel.HealthPanelBG_small;
      var _loc4_ = _global.HAmodule.HudPanel.HealthArmorPanel.HealthArmorBG;
      var _loc7_ = _global.MoneyPanel.MoneyPanel.InnerMoneyPanel.BGPanelClassic;
      var _loc6_ = _global.SFRadar.RadarModule.Dashboard.LocBG;
      m_nHudBGAlpha = _loc3_;
      var _loc2_ = _loc3_ * 80;
      if(_loc2_ < 0)
      {
         _loc2_ = 0;
      }
      if(_loc2_ > 80)
      {
         _loc2_ = 80;
      }
      _loc5_._alpha = _loc2_;
      _loc4_._alpha = _loc2_;
      _loc7_._alpha = _loc2_;
      _loc8_._alpha = _loc2_;
      _loc9_._alpha = _loc2_;
      _loc6_._alpha = _loc2_;
   }
}
function UpdateAvatarSlot(Slot, Xuid, Flags, playerNameText, playerHealth, playerArmor, forceRefresh, nGunGameLevel, nWeaponName, PlayerIdxForColor, bShowLetter)
{
   if(Slot < 0 || Slot > m_nMaxPlayers - 1)
   {
      trace("INVALID SLOT# :" + Slot + " Passed to UpdateAvatarSlot.  Aborting.");
      return undefined;
   }
   var _loc4_ = (1 & Flags >> 0) != 0;
   var _loc8_ = (1 & Flags >> 1) != 0;
   var _loc5_ = (1 & Flags >> 2) != 0;
   var _loc19_ = (1 & Flags >> 3) != 0;
   var _loc26_ = (1 & Flags >> 4) != 0;
   var _loc20_ = (1 & Flags >> 5) != 0;
   var _loc6_ = (1 & Flags >> 6) != 0;
   var _loc33_ = (1 & Flags >> 7) != 0;
   var _loc14_ = (1 & Flags >> 8) != 0;
   var _loc22_ = (1 & Flags >> 9) != 0;
   if(_loc8_ && !_loc5_)
   {
      PlayerIsCT = _loc4_;
   }
   var _loc9_ = "Avatar";
   if(m_nMaxPlayers > 10)
   {
      _loc9_ = "PAvatar";
   }
   var _loc24_ = Math.ceil(m_nMaxPlayers / 2);
   var _loc10_ = -1;
   if(_loc14_)
   {
      _loc9_ = _loc9_ + Slot;
   }
   else
   {
      if(_loc4_)
      {
         _loc10_ = _loc24_ - 1 - Slot;
      }
      else
      {
         _loc10_ = _loc24_ + Slot;
      }
      _loc9_ = _loc9_ + _loc10_;
   }
   var _loc3_ = TopPanel.Panel[_loc9_];
   if(_loc3_ == undefined)
   {
      trace("Error! We don\'t have a slot for this avatar name  (" + _loc9_ + ")");
      return undefined;
   }
   var _loc28_ = _loc3_.bDead == true;
   _loc3_._visible = true;
   if(forceRefresh)
   {
      _loc3_.SavedXUID = undefined;
   }
   var _loc12_ = false;
   if(PlayerIsCT == _loc4_)
   {
      var _loc17_ = PlayerIdxForColor;
      if(PlayerIdxForColor > -1)
      {
         _loc17_ = PlayerIdxForColor % 5;
      }
      if(_loc17_ != -1 && _loc5_ == false)
      {
         _loc12_ = true;
      }
      if(_loc12_ == true)
      {
         var _loc34_ = new Color(_loc3_.PlayerColor.Inner);
         var _loc37_ = _global.GetPlayerColorObject(_loc17_);
         _loc34_.setTransform(_loc37_);
         if(bShowLetter)
         {
            var _loc30_ = _global.GetPlayerColorLetter(0,_loc17_);
            _loc3_.PlayerNumber.Text.htmlText = _loc30_;
         }
      }
   }
   _loc3_.PlayerColor._visible = _loc12_;
   _loc3_.PlayerNumber._visible = bShowLetter && _loc12_;
   if(m_bShowOnlyPlayerCount && !m_bIsGunGame)
   {
      _loc3_.PlayerColor._visible = false;
      _loc3_.PlayerNumber._visible = false;
   }
   else
   {
      _loc3_.PlayerColor._visible = _loc12_;
      _loc3_.PlayerNumber._visible = bShowLetter && _loc12_;
   }
   var _loc11_ = !_loc4_?IsPlayerCountVisibleForT():IsPlayerCountVisibleForCT();
   if(_loc11_ == true)
   {
      if(m_nMaxPlayers > 10 || _loc10_ != -1 && _loc10_ != 4 && _loc10_ != 5)
      {
         _loc3_._visible = false;
         return undefined;
      }
      _loc3_.PlayerOutline._visible = false;
      _loc8_ = false;
      _loc5_ = false;
      _loc19_ = false;
      _loc26_ = false;
      _loc20_ = false;
      _loc6_ = false;
      _loc33_ = false;
      _loc14_ = false;
   }
   if(_loc3_.SavedXUID != Xuid)
   {
      var _loc25_ = _loc3_.DynamicAvatar;
      if(_loc25_ != undefined)
      {
         _loc25_.unloadMovie();
      }
   }
   _loc3_.PlayerOutline._visible = _loc8_ && !_loc5_ || _loc6_;
   var _loc21_ = 16777215;
   var _loc29_ = new Color(_loc3_.PlayerOutline);
   if(_loc22_ && _loc3_.PlayerOutline._visible == false)
   {
      _loc3_.PlayerOutline._visible = true;
      if(_loc4_)
      {
         _loc21_ = 8313343;
      }
      else
      {
         _loc21_ = 16766061;
      }
   }
   if(_loc3_.PlayerOutline._visible)
   {
      _loc29_.setRGB(_loc21_);
      if(_loc8_ && _loc22_ && _loc14_)
      {
         if(TopPanel.Panel.PlayerJoinPanel.JoinBot._visible == false)
         {
            TopPanel.Panel.PlayerJoinPanel.gotoAndPlay("FadeIn");
         }
         TopPanel.Panel.PlayerJoinPanel.JoinCt._visible = false;
         TopPanel.Panel.PlayerJoinPanel.JoinT._visible = false;
         var _loc31_ = _global.GameInterface.Translate("#SFUI_Player_Is_Leader");
         TopPanel.Panel.PlayerJoinPanel.JoinBot.BotTextPanel.BotText.htmlText = _loc31_;
      }
      if(_loc8_)
      {
         TopPanel.Panel.PlayerJoinPanel.JoinBot._visible = _loc22_ && _loc14_;
      }
   }
   var _loc15_ = undefined;
   var _loc41_ = undefined;
   if(_loc4_)
   {
      _loc15_ = _loc3_.CTPanel;
      invispanel = _loc3_.TPanel;
   }
   else
   {
      _loc15_ = _loc3_.TPanel;
      invispanel = _loc3_.CTPanel;
   }
   _loc15_._visible = !_loc5_;
   _loc15_.HealthBar.gotoAndStop(playerHealth + 1);
   _loc15_.HealthBar._visible = !_loc11_;
   invispanel._visible = false;
   if(_loc3_.SoundIcon != undefined)
   {
      _loc3_.SoundIcon._visible = _loc20_;
      _loc3_.SoundIcon.gotoAndPlay(!_loc20_?"Off":"StartShow1");
   }
   _loc3_.Spectate._visible = false;
   var _loc35_ = _loc3_.Skull._visible;
   _loc3_.Dominated._visible = !_loc5_ && _loc19_;
   _loc3_.Nemesis._visible = !_loc5_ && !_loc19_ && _loc26_;
   _loc3_.Skull._visible = _loc5_ && !_loc6_;
   if(_loc3_.Skull._visible)
   {
      _loc3_.Skull.TeamSkull._visible = false;
      _loc3_.Skull.CTSkull._visible = false;
      _loc3_.Skull.TSkull._visible = false;
      if(PlayerIsCT == _loc4_)
      {
         _loc3_.Skull.TeamSkull._visible = true;
      }
      else
      {
         _loc3_.Skull.CTSkull._visible = _loc4_;
         _loc3_.Skull.TSkull._visible = !_loc4_;
      }
      if(!_loc35_ || !_loc28_)
      {
         _loc3_.Skull.gotoAndPlay("StartFade");
      }
   }
   _loc3_.BotAvatarCT._visible = _loc6_ && _loc4_;
   _loc3_.BotAvatarT._visible = _loc6_ && !_loc4_;
   if(Xuid != "0")
   {
      if(_loc3_.SavedXUID != Xuid)
      {
         var _loc38_ = "img://avatar_" + Xuid;
         var _loc23_ = new MovieClipLoader();
         _loc23_.addListener(this);
         _loc23_.loadClip(_loc38_,_loc3_.DynamicAvatar);
         avatarX = _loc3_.DefaultAvatarCT._x;
         avatarY = _loc3_.DefaultAvatarCT._y;
         avatarWidth = _loc3_.DefaultAvatarCT._width;
         avatarHeight = _loc3_.DefaultAvatarCT._height;
      }
      _loc3_.DynamicAvatar._visible = !_loc11_;
      if(_loc11_)
      {
         _loc3_.DefaultAvatarCT._visible = _loc4_;
         _loc3_.DefaultAvatarT._visible = !_loc4_;
      }
      else
      {
         _loc3_.DefaultAvatarCT._visible = _loc11_;
         _loc3_.DefaultAvatarT._visible = _loc11_;
      }
   }
   else if(Xuid == "0" && _loc8_ && _global.IsPS3())
   {
      if(localPS3AvatarSlot != _loc3_)
      {
         localPS3AvatarSlot.AvatarPS3._visible = false;
         localPS3AvatarSlot.AvatarPS3.removeMovieClip();
      }
      if(_loc3_.AvatarPS3 == undefined)
      {
         _loc3_.attachMovie("DefaultLocalAvatar","AvatarPS3",1);
         _loc3_.AvatarPS3._x = _loc3_.DefaultAvatarT._x;
         _loc3_.AvatarPS3._y = _loc3_.DefaultAvatarT._y;
         _loc3_.AvatarPS3._width = _loc3_.DefaultAvatarT._width;
         _loc3_.AvatarPS3._height = _loc3_.DefaultAvatarT._height;
         _loc3_.AvatarPS3._visible = true;
         localPS3AvatarSlot = _loc3_;
      }
      _loc3_.DynamicAvatar._visible = false;
      _loc3_.DefaultAvatarCT._visible = false;
      _loc3_.DefaultAvatarT._visible = false;
   }
   else
   {
      _loc3_.DynamicAvatar._visible = false;
      _loc3_.DefaultAvatarCT._visible = _loc4_;
      _loc3_.DefaultAvatarT._visible = !_loc4_;
   }
   if(_loc3_.DefaultAvatarCT._visible)
   {
      if(_loc3_.DefaultAvatarCT.transformData == undefined)
      {
         var _loc27_ = new Color(_loc3_.DefaultAvatarCT);
         _loc3_.DefaultAvatarCT.transformData = _loc27_;
      }
      _loc3_.DefaultAvatarCT.transformData.setTransform(!(_loc5_ && !_loc6_)?avatarAliveXform:avatarDeadXform);
   }
   if(_loc3_.DefaultAvatarT._visible)
   {
      if(_loc3_.DefaultAvatarT.transformData == undefined)
      {
         _loc27_ = new Color(_loc3_.DefaultAvatarT);
         _loc3_.DefaultAvatarT.transformData = _loc27_;
      }
      _loc3_.DefaultAvatarT.transformData.setTransform(!(_loc5_ && !_loc6_)?avatarAliveXform:avatarDeadXform);
   }
   if(_loc3_.DynamicAvatar._visible)
   {
      if(_loc3_.DynamicAvatar.transformData == undefined)
      {
         _loc27_ = new Color(_loc3_.DynamicAvatar);
         _loc3_.DynamicAvatar.transformData = _loc27_;
      }
      if(_loc4_)
      {
         _loc3_.DynamicAvatar.transformData.setTransform(!(_loc5_ && !_loc6_)?avatarAliveXform_CT:avatarDeadXform);
      }
      else
      {
         _loc3_.DynamicAvatar.transformData.setTransform(!(_loc5_ && !_loc6_)?avatarAliveXform_T:avatarDeadXform);
      }
   }
   if(_loc3_.AvatarPS3._visible)
   {
      if(_loc3_.AvatarPS3.transformData == undefined)
      {
         _loc27_ = new Color(_loc3_.AvatarPS3);
         _loc3_.AvatarPS3.transformData = _loc27_;
      }
      _loc3_.AvatarPS3.transformData.setTransform(!(_loc5_ && !_loc6_)?avatarAliveXform:avatarDeadXform);
   }
   if(nGunGameLevel == "0")
   {
      _loc3_.ArsenalProgress._visible = false;
      _loc3_.ArsenalProgress_bot._visible = false;
   }
   else
   {
      _loc3_.ArsenalProgress._visible = true;
      if(m_bPositionIsBottom)
      {
         _loc3_.ArsenalProgress._visible = false;
         _loc3_.ArsenalProgress_bot._visible = true;
      }
      else
      {
         _loc3_.ArsenalProgress._visible = true;
         _loc3_.ArsenalProgress_bot._visible = false;
      }
      if(_loc8_)
      {
         _loc3_.ArsenalProgress.ArsenalProgressText.TextNumber.htmlText = "<font color=\'#ffffff\'>" + nGunGameLevel + "</font>";
         _loc3_.ArsenalProgress_bot.ArsenalProgressText.TextNumber.htmlText = "<font color=\'#ffffff\'>" + nGunGameLevel + "</font>";
      }
      else
      {
         _loc3_.ArsenalProgress.ArsenalProgressText.TextNumber.htmlText = "<font color=\'#5c5c5c\'>" + nGunGameLevel + "</font>";
         _loc3_.ArsenalProgress_bot.ArsenalProgressText.TextNumber.htmlText = "<font color=\'#5c5c5c\'>" + nGunGameLevel + "</font>";
      }
      if(nWeaponName != "")
      {
         _loc3_.ArsenalProgress.WeaponIcon.IconText.htmlText = nWeaponName;
         _loc3_.ArsenalProgress_bot.WeaponIcon.IconText.htmlText = nWeaponName;
      }
   }
   _loc3_.SavedXUID = Xuid;
   _loc3_.bDead = _loc5_;
   _loc3_.bWasPlayerBot = _loc6_;
}
function IsPlayerCountVisibleForT()
{
   var _loc3_ = _global.GameInterface.GetConvarNumber("game_mode");
   var _loc2_ = _global.GameInterface.GetConvarNumber("game_type");
   if(_loc2_ == 4 && _loc3_ == 1)
   {
      return true;
   }
   return IsPlayerCountVisible();
}
function IsPlayerCountVisibleForCT()
{
   return IsPlayerCountVisible();
}
function IsPlayerCountVisible()
{
   return m_bIsGunGame == false && m_bShowOnlyPlayerCount == true;
}
function NumberCountUpdate()
{
   if(IsPlayerCountVisibleForT())
   {
      var _loc2_ = TopPanel.Panel.alivet.count;
      _loc2_._alpha = 100;
      _loc2_.box.htmlText = m_nPlayersAlive_T;
      TopPanel.Panel.alivet._visible = true;
      TopPanel.Panel.alivebgT._visible = true;
      TopPanel.Panel.Alive_T._visible = true;
      TopPanel.Panel.alivet.skullanim.gotoAndStop("Init");
      if(m_nPlayersAlive_T == 0)
      {
         TopPanel.Panel.alivet.skullanim.gotoAndStop("dead");
         TopPanel.Panel.Alive_T._visible = false;
         _loc2_._alpha = 0;
      }
   }
   else
   {
      TopPanel.Panel.alivet._visible = false;
      TopPanel.Panel.alivebgT._visible = false;
      TopPanel.Panel.aliveinstructor._visible = false;
      TopPanel.Panel.Alive_T._visible = false;
   }
   if(IsPlayerCountVisibleForCT())
   {
      var _loc1_ = TopPanel.Panel.alivect.count;
      _loc1_._alpha = 100;
      _loc1_.box.htmlText = m_nPlayersAlive_CT;
      TopPanel.Panel.alivect._visible = true;
      TopPanel.Panel.alivebgCT._visible = true;
      TopPanel.Panel.Alive_CT._visible = true;
      TopPanel.Panel.alivect.skullanim.gotoAndStop("Init");
      if(m_nPlayersAlive_CT == 0)
      {
         TopPanel.Panel.alivect.skullanim.gotoAndStop("dead");
         TopPanel.Panel.Alive_CT._visible = false;
         _loc1_._alpha = 0;
      }
   }
   else
   {
      TopPanel.Panel.alivect._visible = false;
      TopPanel.Panel.alivebgCT._visible = false;
      TopPanel.Panel.aliveinstructor._visible = false;
      TopPanel.Panel.Alive_CT._visible = false;
   }
}
function UpdateLeaderWeaponVisibility(Slot, bShowWeapon)
{
   if(Slot < 0 || Slot > 9)
   {
      trace("INVALID SLOT# :" + Slot + " Passed to UpdateAvatarSlot.  Aborting.");
      return undefined;
   }
   var _loc3_ = "Avatar" + Slot;
   var _loc2_ = TopPanel.Panel[_loc3_];
   if(_loc2_ == undefined)
   {
      trace("Error! We don\'t have a slot for this avatar name.  Aborting for slot = " + Slot);
      return undefined;
   }
   _loc2_.ArsenalProgress.WeaponIcon._visible = bShowWeapon;
}
function onLoadInit(mc)
{
   mc._x = avatarX;
   mc._y = avatarY;
   mc._width = avatarWidth;
   mc._height = avatarHeight;
   onResize(_global.resizeManager);
}
var avatarX = 0;
var avatarY = 0;
var avatarWidth = 55;
var avatarHeight = 55;
var m_nMaxPlayers = 24;
var m_bPositionIsBottom = false;
var m_bShowOnlyPlayerCount = false;
var m_nPlayersAlive_CT = 0;
var m_nPlayersAlive_T = 0;
var m_nLastGGPlayerCount = 0;
var m_bIsShowingTimer = 0;
var m_nHudBGAlpha = -1;
var m_bIsGunGame = false;
var avatarAliveXform = new Object();
avatarAliveXform = {ra:"90",rb:"0",ga:"90",gb:"0",ba:"90",bb:"0",aa:"80",ab:"0"};
var avatarAliveXform_T = new Object();
avatarAliveXform_T = {ra:"99",rb:"20",ga:"99",gb:"17",ba:"99",bb:"14",aa:"90",ab:"0"};
var avatarAliveXform_CT = new Object();
avatarAliveXform_CT = {ra:"99",rb:"14",ga:"99",gb:"16",ba:"99",bb:"20",aa:"90",ab:"0"};
var avatarDeadXform = new Object();
avatarDeadXform = {ra:"90",rb:"0",ga:"90",gb:"0",ba:"90",bb:"0",aa:"0",ab:"0"};
var localPS3AvatarSlot = undefined;
var PlayerIsCT = undefined;
_global.resizeManager.AddListener(this);
stop();
