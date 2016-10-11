function onLevelReset()
{
   AlertPanel.AlertsPanelAnim._visible = false;
   AlertPanel.ArsenalPanel._visible = false;
   AlertPanel.DMBonusWeapon._visible = false;
   AlertPanel.ItemDropListPanel._visible = false;
   AlertsMissionPanel._visible = false;
}
function onLoaded()
{
   onLevelReset();
   gameAPI.OnReady();
}
function onUnload(mc)
{
   _global.resizeManager.RemoveListener(this);
   return true;
}
function onResize(rm)
{
   rm.DisableAdditionalScaling = true;
   rm.ResetPositionByPixel(AlertPanel,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_CENTER_X,0,Lib.ResizeManager.ALIGN_CENTER,Lib.ResizeManager.REFERENCE_CENTER_Y,0,Lib.ResizeManager.ALIGN_CENTER);
   rm.DisableAdditionalScaling = false;
   rm.ResetPositionByPixel(AlertsMissionPanel,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_SAFE_LEFT,0,Lib.ResizeManager.ALIGN_LEFT,Lib.ResizeManager.REFERENCE_TOP,0,Lib.ResizeManager.ALIGN_TOP);
   setYPositionForAlert();
}
function setYPositionForAlert()
{
   var _loc2_ = _global.MoneyPanel.MoneyPanel;
   var _loc4_ = AlertPanel.DMBonusWeapon;
   var _loc5_ = 0;
   var _loc3_ = 0;
   if(_loc2_ != undefined && _loc2_ != null)
   {
      _loc3_ = _loc2_._y + _loc2_._height;
      _loc5_ = _loc2_._x;
      var _loc6_ = _loc2_.getBounds(m_MainClip);
      _loc3_ = _loc6_.yMax;
   }
   trace("ALERTPANEL: GameMode = " + _global.CScaleformComponent_MatchStats.GetGameMode());
   if(_global.CScaleformComponent_MatchStats.GetGameMode() == "deathmatch" && _loc4_ != undefined && _loc4_ != null)
   {
      _loc6_ = _loc4_.getBounds(m_MainClip);
      _loc3_ = _loc6_.yMax;
   }
   AlertsMissionPanel._x = _loc5_;
   AlertsMissionPanel._y = _loc3_;
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
function getWeaponName(itemName)
{
   if(itemName == "")
   {
      return "";
   }
   var _loc3_ = itemName.indexOf("_");
   if(_loc3_ >= 0)
   {
      itemName = itemName.substr(_loc3_ + 1);
   }
   var _loc4_ = _global.GameInterface.GetConvarNumber("player_teamplayedlast") == _global.TeamID_CounterTerrorist;
   if(itemName == "knife" || itemName == "knifegg")
   {
      itemName = "knife";
      if(_loc4_)
      {
         itemName = itemName + "_ct";
      }
   }
   return itemName;
}
function getItemIcon(iconName, isSolid)
{
   if(isSolid)
   {
      iconName = "icon-" + iconName;
   }
   else
   {
      iconName = "outline-icon-" + iconName;
   }
   return iconName;
}
function setAlertTextAndShow(sText)
{
   setAlertsPanelAnimVisible(true);
   AlertPanel.AlertsPanelAnim.AlertText.Text.htmlText = sText;
   AlertPanel.AlertsPanelAnim.gotoAndPlay("StartAnim");
}
function setAlertTextAndShowPause(sText)
{
   setAlertsPanelAnimVisible(true);
   AlertPanel.AlertsPanelAnim.AlertText.Text.htmlText = sText;
   AlertPanel.AlertsPanelAnim.gotoAndPlay("ShowPause");
}
function hideFlash()
{
   AlertPanel.AlertsPanelAnim.gotoAndPlay("HideFlash");
}
function updateAlertText(sText)
{
   AlertPanel.AlertsPanelAnim.AlertText.Text.htmlText = sText;
}
function setAlertsPanelAnimVisible(bVisible)
{
   AlertPanel.AlertsPanelAnim._visible = bVisible;
}
function BonusPanel_SetPosition()
{
   var _loc7_ = 200;
   var _loc3_ = 0;
   var _loc5_ = _global.GameInterface.GetConvarNumber("hud_scaling");
   var _loc4_ = Stage.height / 1024;
   var _loc2_ = m_nRadarScale * _loc5_ * (_loc7_ + _loc3_);
   var _loc6_ = _loc4_ * _loc2_;
   AlertPanel.DMBonusWeapon._y = _loc6_;
}
function BonusPanel_SetBarProgress(progressFrac)
{
   if(progressFrac < 0)
   {
      progressFrac = 0;
   }
   if(progressFrac > 1)
   {
      progressFrac = 1;
   }
   var _loc2_ = DMBONUS_FRAME_EMPTY + progressFrac * (DMBONUS_FRAME_FULL - DMBONUS_FRAME_EMPTY);
   AlertPanel.DMBonusWeapon.Panel.TimerBarParent.TimerBar.gotoAndStop(_loc2_);
}
function showDMBonusWeapon(itemName, itemPrintName, nTime, nPoints, nBonusPoints)
{
   m_nDMBonusPoints = nBonusPoints;
   m_nDMDefaultPoints = nPoints;
   AlertPanel.DMBonusWeapon._visible = true;
   var _loc4_ = _global.GameInterface.Translate("#SFUI_DMPoints_BonusWeapon");
   var _loc6_ = _global.ConstructString(_loc4_,itemPrintName);
   AlertPanel.DMBonusWeapon.Panel.WeaponNameText.Text.htmlText = _loc6_;
   var _loc5_ = "" + nBonusPoints;
   var _loc3_ = _global.GameInterface.Translate("#SFUI_DMPoints_KillAwardBonus");
   var _loc2_ = _global.ConstructString(_loc3_,_loc5_);
   AlertPanel.DMBonusWeapon.Panel.BonusPointsText.Text.htmlText = _loc2_;
   var _loc7_ = getItemIcon(getWeaponName(itemName),false);
   AlertPanel.DMBonusWeapon.Panel.weaponContainer.attachMovie(_loc7_,"Image",0);
   BonusPanel_SetPosition();
   AlertPanel.DMBonusWeapon.Panel.gotoAndPlay("Init");
   AlertPanel.DMBonusWeapon.gotoAndPlay("StartShow");
   m_nDMBonusTime = nTime;
   setDMBonusTimer(nTime);
}
function setDMBonusTimer(nTime)
{
   var _loc3_ = nTime / m_nDMBonusTime;
   var _loc1_ = Math.floor(nTime / 60);
   var _loc6_ = _loc1_ >= 10?_loc1_:"0" + _loc1_.toString();
   var _loc2_ = Math.floor(nTime % 60);
   var _loc7_ = _loc2_ >= 10?_loc2_:"0" + _loc2_.toString();
   var _loc5_ = _loc6_ + ":" + _loc7_;
   AlertPanel.DMBonusWeapon.Panel.Time.Text.htmlText = _loc5_;
   BonusPanel_SetBarProgress(_loc3_);
}
function hideDMBonusWeapon()
{
   AlertPanel.DMBonusWeapon.gotoAndPlay("StartHide");
}
function registerBonusKill()
{
   var _loc3_ = m_nDMDefaultPoints + m_nDMBonusPoints;
   var _loc5_ = "" + _loc3_;
   var _loc4_ = _global.GameInterface.Translate("#SFUI_DMPoints_KillAwardBonus");
   var _loc2_ = _global.ConstructString(_loc4_,_loc5_);
   AlertPanel.DMBonusWeapon.Panel.BonusPointsText.Text.htmlText = _loc2_;
   AlertPanel.DMBonusWeapon.Panel.gotoAndPlay("FlashBonus");
}
function missionUpdateIcon(iconName, solid)
{
   iconName = getItemIcon(iconName,solid);
   if(iconName != m_missionIcon)
   {
      trace("ALERTPANEL: Setting mission icon to \'" + iconName + "\'");
      m_missionIcon = iconName;
      if(m_missionIcon == "")
      {
         AlertsMissionPanel.iconWeapon.removeMovieClip();
      }
      else
      {
         AlertsMissionPanel.iconWeapon.attachMovie(m_missionIcon,"Image",0);
      }
   }
}
function missionUpdateProgress()
{
   var _loc1_ = 0;
   if(m_missionGoalRequired != 0)
   {
      _loc1_ = m_missionGoalCurrent / m_missionGoalRequired * 100;
   }
   if(m_missionGoalRequired != 0 || m_missionGoalCurrent != 0)
   {
      AlertsMissionPanel.ProgText.Text.htmlText = "" + m_missionGoalCurrent;
      AlertsMissionPanel.ProgText.ValueAnim.Text.htmlText = "" + m_missionGoalCurrent;
   }
   else
   {
      AlertsMissionPanel.ProgText.Text.htmlText = "";
      AlertsMissionPanel.ProgText.ValueAnim.Text.htmlText = "";
   }
   if(_loc1_ < 0)
   {
      _loc1_ = 0;
   }
   if(_loc1_ > 100)
   {
      _loc1_ = 100;
   }
   AlertsMissionPanel.ProgBar.Bar._xscale = _loc1_;
}
function missionSetGoal(current, required)
{
   m_missionGoalCurrent = current;
   m_missionGoalRequired = required;
   AlertsMissionPanel.ProgText.ValueAnim._visible = false;
   if(m_missionGoalRequired != 0)
   {
      AlertsMissionPanel.ProgText.TextMax.htmlText = "/" + m_missionGoalRequired;
   }
   else
   {
      AlertsMissionPanel.ProgText.TextMax.htmlText = "";
   }
   missionUpdateProgress();
}
function missionUpdateGoal(current)
{
   if(m_missionGoalCurrent != current)
   {
      m_missionGoalCurrent = current;
      missionUpdateProgress();
      AlertsMissionPanel.ProgText.ValueAnim._visible = true;
      new Lib.Tween(AlertsMissionPanel.ProgText.ValueAnim,"_xscale",mx.transitions.easing.Strong.easeOut,100,200,1,true);
      new Lib.Tween(AlertsMissionPanel.ProgText.ValueAnim,"_yscale",mx.transitions.easing.Strong.easeOut,100,200,1,true);
      new Lib.Tween(AlertsMissionPanel.ProgText.ValueAnim,"_alpha",mx.transitions.easing.Strong.easeOut,100,0,1,true);
   }
   if(!AlertsMissionPanel._visible)
   {
      trace("ALERTPANEL: update goal while not visible??");
   }
}
function missionNotifyProgress(newPoints)
{
}
function missionShowPanel()
{
   setYPositionForAlert();
   AlertsMissionPanel._visible = true;
}
function missionHidePanel()
{
   AlertsMissionPanel._visible = false;
}
function missionSetDescription(questDesc)
{
   AlertsMissionPanel.ObjectiveText.Text.htmlText = questDesc;
   _global.AutosizeTextDown(AlertsMissionPanel.ObjectiveText.Text,8);
}
function missionSetExtraInfo(desc)
{
   AlertsMissionPanel.MoneyText.Text.htmlText = desc;
}
function missionInitGuardian(weaponName, questDesc, killsRequired, weaponCost)
{
   m_guardianWeapon = weaponName;
   missionUpdateIcon(getWeaponName(weaponName),false);
   missionSetGoal(0,killsRequired);
   missionSetDescription(questDesc);
   missionSetExtraInfo("");
}
function missionUpdateGuardian(killsRemaining, money, hasWeapon)
{
   var _loc1_ = m_missionGoalRequired - killsRemaining;
   if(_loc1_ > m_guardianKillsRequired)
   {
      _loc1_ = m_guardianKillsRequired;
   }
   missionUpdateGoal(_loc1_);
   missionUpdateIcon(getWeaponName(m_guardianWeapon),hasWeapon);
}
function setWeaponsIconsAndShow(index, itemName, itemPrintName, bSelected)
{
   var _loc4_ = "InvWeapon0" + index;
   var _loc3_ = "highlight0" + index;
   var _loc1_ = AlertPanel.ArsenalPanel.ArsenalInnerPanel[_loc3_];
   var _loc2_ = AlertPanel.ArsenalPanel.ArsenalInnerPanel[_loc4_];
   _loc2_.TextBoxName.htmlText = itemPrintName;
   if(bSelected)
   {
      _loc1_._visible = true;
      _loc1_.gotoAndPlay("StartBlink");
   }
   else
   {
      _loc1_._visible = false;
   }
   var _loc5_ = getItemIcon(getWeaponName(itemName),bSelected);
   _loc2_.iconSelected.attachMovie(_loc5_,"Image",0);
   AlertPanel.ArsenalPanel._visible = true;
   AlertPanel.ArsenalPanel.gotoAndPlay("ShowAndFadeArsenal");
}
function hideAll()
{
   AlertPanel.ArsenalPanel._visible = false;
}
function ClearAllPlayerReceivedGift()
{
   AlertPanel.ItemDropListPanel.TourneyPanelParent.EventSpec_DropInfo._visible = false;
   m_PlayersWhoGotItemsArray = [];
   m_bLocalPlayerGotGift = false;
   m_bItemDisplayedForLocalPlayer = false;
}
function SetLocalPlayerGotDrop(data)
{
   if(m_PlayersWhoGotItemsArray.length < MAX_PLAYER_GIFT_DROP_DISPLAY)
   {
      m_PlayersWhoGotItemsArray.push(data);
   }
   else
   {
      m_PlayersWhoGotItemsArray[0] = data;
   }
   m_bLocalPlayerGotGift = true;
}
function AddPlayerReceivedGift(steamID, nDefIndex, nNumGifts, bIsLocal)
{
   var _loc1_ = [];
   _loc1_.steamID = steamID;
   _loc1_.nDefIndex = nDefIndex;
   _loc1_.nNumGifts = nNumGifts;
   _loc1_.bIsLocal = bIsLocal;
   if(bIsLocal)
   {
      SetLocalPlayerGotDrop(_loc1_);
   }
   else if(m_PlayersWhoGotItemsArray.length < MAX_PLAYER_GIFT_DROP_DISPLAY)
   {
      m_PlayersWhoGotItemsArray.push(_loc1_);
   }
}
function ShowTourneyAndViewerPanel()
{
   AlertPanel.ItemDropListPanel.TourneyPanelParent.ItemPanel._visible = false;
   m_bItemDropPanelVisible = false;
   m_bItemDisplayedForLocalPlayer = false;
   AlertPanel.ItemDropListPanel._visible = true;
   AlertPanel.ItemDropListPanel.gotoAndPlay("Show");
   m_bGiftParentPanelVisible = true;
}
function HidePanelAndItemNumbers()
{
   if(m_bGiftParentPanelVisible == false || AlertPanel.ItemDropListPanel._visible == false)
   {
      AlertPanel.ItemDropListPanel._visible = false;
      return undefined;
   }
   AlertPanel.ItemDropListPanel.gotoAndPlay("Hide");
   m_bItemDropPanelVisible = false;
   m_bItemDisplayedForLocalPlayer = false;
   m_bGiftParentPanelVisible = false;
}
function ScaleformComponent_FriendsList_NameChanged()
{
   UpdateItemDropPlayerNames();
}
function UpdatePanelAndItemNumbers(nItemsDroppedTotal, nNumPlayersWhoGifted, nSeconds)
{
   if(m_bGiftParentPanelVisible == false || AlertPanel.ItemDropListPanel._visible == false)
   {
      ShowTourneyAndViewerPanel();
   }
   SetPlayersWhoGotDrops(nItemsDroppedTotal,nNumPlayersWhoGifted,nSeconds);
}
function SetPlayersWhoGotDrops(nItemsDroppedTotal, nNumPlayersWhoGifted, nSeconds)
{
   UpdateItemDropPlayerNames();
   AlertPanel.ItemDropListPanel.TourneyPanelParent.ItemPanel._visible = false;
   if(nItemsDroppedTotal > 0)
   {
      if(m_bItemDropPanelVisible == false)
      {
         AlertPanel.ItemDropListPanel.TourneyPanelParent.gotoAndPlay("ShowItemPanel");
         m_bItemDropPanelVisible = true;
      }
      AlertPanel.ItemDropListPanel.TourneyPanelParent.ItemPanel._visible = true;
   }
   var _loc6_ = m_PlayersWhoGotItemsArray.length;
   var _loc4_ = nNumPlayersWhoGifted - MAX_PLAYER_GIFT_DROP_DISPLAY;
   if(_loc4_ > 0)
   {
      AlertPanel.ItemDropListPanel.TourneyPanelParent.ItemPanel.OtherPlayers._visible = true;
      if(_loc4_ > 1)
      {
         AlertPanel.ItemDropListPanel.TourneyPanelParent.ItemPanel.OtherPlayers.Panel.Text.htmlText = _global.ConstructString(_global.GameInterface.Translate("#SFUIHUD_GiftDrop_AndOtherPlayers"),_loc4_);
      }
      else
      {
         AlertPanel.ItemDropListPanel.TourneyPanelParent.ItemPanel.OtherPlayers.Panel.Text.htmlText = _global.GameInterface.Translate("#SFUIHUD_GiftDrop_AndOtherPlayer");
      }
   }
   else
   {
      AlertPanel.ItemDropListPanel.TourneyPanelParent.ItemPanel.OtherPlayers._visible = false;
   }
   var _loc3_ = Math.floor(nSeconds / 60);
   var _loc5_ = Math.floor(_loc3_ / 60);
   AlertPanel.ItemDropListPanel.TourneyPanelParent.ItemPanel.TotalItemsText._visible = true;
   if(_loc5_ > 1)
   {
      if(nItemsDroppedTotal > 1)
      {
         AlertPanel.ItemDropListPanel.TourneyPanelParent.ItemPanel.TotalItemsText.htmlText = _global.ConstructString(_global.GameInterface.Translate("#SFUIHUD_GiftDrop_GiftsGivenLastXHours"),_loc5_,commaFormat(nItemsDroppedTotal));
      }
      else
      {
         AlertPanel.ItemDropListPanel.TourneyPanelParent.ItemPanel.TotalItemsText.htmlText = _global.ConstructString(_global.GameInterface.Translate("#SFUIHUD_GiftDrop_GiftGivenLastXHours"),_loc5_);
      }
   }
   else if(nItemsDroppedTotal > 1)
   {
      AlertPanel.ItemDropListPanel.TourneyPanelParent.ItemPanel.TotalItemsText.htmlText = _global.ConstructString(_global.GameInterface.Translate("#SFUIHUD_GiftDrop_GiftsGivenLastXMinutes"),_loc3_,commaFormat(nItemsDroppedTotal));
   }
   else
   {
      AlertPanel.ItemDropListPanel.TourneyPanelParent.ItemPanel.TotalItemsText.htmlText = _global.ConstructString(_global.GameInterface.Translate("#SFUIHUD_GiftDrop_GiftGivenLastXMinutes"),_loc3_);
   }
}
function UpdateItemDropPlayerNames()
{
   var _loc8_ = m_PlayersWhoGotItemsArray.length;
   var _loc3_ = 1;
   while(_loc3_ <= MAX_PLAYER_GIFT_DROP_DISPLAY)
   {
      var _loc5_ = "Player" + _loc3_;
      var _loc2_ = AlertPanel.ItemDropListPanel.TourneyPanelParent.ItemPanel[_loc5_];
      if(_loc2_)
      {
         if(_loc8_ >= _loc3_)
         {
            var _loc6_ = "#SFUIHUD_GiftDrop_Name_ColorDefault";
            _loc2_._visible = true;
            var _loc7_ = _global.CScaleformComponent_FriendsList.GetFriendName(m_PlayersWhoGotItemsArray[_loc3_ - 1].steamID);
            var _loc4_ = m_PlayersWhoGotItemsArray[_loc3_ - 1].nNumGifts;
            _loc2_.PlayerName.Text.htmlText = _global.ConstructString(_global.GameInterface.Translate("#SFUIHUD_GiftDrop_NameGiftGiverFormat"),_global.GameInterface.Translate(_loc6_),_loc7_);
            if(_loc4_ > 1)
            {
               _loc2_.PlayerName.NumText.htmlText = _global.ConstructString(_global.GameInterface.Translate("#SFUIHUD_GiftDrop_GiftAmountFormat"),_loc4_);
            }
            else
            {
               _loc2_.PlayerName.NumText.htmlText = _global.GameInterface.Translate("#SFUIHUD_GiftDrop_SingleGiftFormat");
            }
            _global.AutosizeTextDown(_loc2_.PlayerName.NumText,8);
         }
         else
         {
            _loc2_._visible = false;
         }
      }
      _loc3_ = _loc3_ + 1;
   }
}
function OnAlertPanelHideAnimEnd()
{
   AlertPanel.AlertPanelAnim._visible = false;
   _global.AlertPanelAPI.OnAlertPanelHideAnimEnd();
}
function OnArsenalPanelFadeOutEnd()
{
   AlertPanel.ArsenalPanel._visible = false;
}
function FlashBonusEnded()
{
   var _loc4_ = "" + m_nDMBonusPoints;
   var _loc3_ = _global.GameInterface.Translate("#SFUI_DMPoints_KillAwardBonus");
   var _loc2_ = _global.ConstructString(_loc3_,_loc4_);
   AlertPanel.DMBonusWeapon.Panel.BonusPointsText.Text.htmlText = _loc2_;
}
function SetTourneyEventPanelHidden()
{
}
_global.AlertPanel = AlertPanel;
_global.AlertPanelAPI = gameAPI;
var DMBONUS_FRAME_EMPTY = 60;
var DMBONUS_FRAME_FULL = 2;
var MAX_PLAYER_GIFT_DROP_DISPLAY = 4;
var m_MainClip = this;
var m_nDMBonusTime = 0;
var m_nDMBonusPoints = 0;
var m_nDMDefaultPoints = 0;
var m_PlayersWhoGotItemsArray = [];
var m_bLocalPlayerGotGift = false;
var m_bItemDropPanelVisible = false;
var m_bGiftParentPanelVisible = false;
var m_bItemDisplayedForLocalPlayer = false;
var m_missionDesc = "";
var m_missionGoalCurrent = 0;
var m_missionGoalRequired = 0;
var m_missionIcon = "";
var m_guardianWeapon = "";
_global.resizeManager.AddListener(this);
stop();
