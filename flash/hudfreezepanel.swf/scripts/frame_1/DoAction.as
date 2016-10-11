function onLoaded()
{
   gameAPI.OnReady();
   FreezePanel._visible = false;
   FreezeCancel._visible = false;
   ScreenBorder._visible = false;
}
function onUnload(mc)
{
   _global.resizeManager.RemoveListener(this);
   _global.tintManager.DeregisterAll(this);
   return true;
}
function onResize(rm)
{
   rm.DisableAdditionalScaling = false;
   rm.ResetPositionByPixel(FreezeCancel,Lib.ResizeManager.SCALE_USING_VERTICAL,Lib.ResizeManager.REFERENCE_CENTER_X,0,Lib.ResizeManager.ALIGN_CENTER,Lib.ResizeManager.REFERENCE_SAFE_BOTTOM,-100,Lib.ResizeManager.ALIGN_BOTTOM);
   rm.DisableAdditionalScaling = true;
   rm.ResetPositionByPercentage(FreezePanel,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_CENTER_X,0,Lib.ResizeManager.ALIGN_CENTER,Lib.ResizeManager.REFERENCE_CENTER_Y,-0.35,Lib.ResizeManager.ALIGN_NONE);
   rm.DisableAdditionalScaling = false;
}
function hide()
{
   FreezePanel.gotoAndPlay("StartHide");
   FreezePanel.FreezePanel.Navigation._y = numPostitionStart;
   HideFreezeFrameBorder();
}
function show()
{
   var _loc1_ = FreezePanel.FreezePanel.GamerPic;
   avatarSize = new flash.geom.Rectangle(_loc1_.DefaultCT._x,_loc1_.DefaultCT._y,_loc1_.DefaultCT._width,_loc1_.DefaultCT._height);
   FreezePanel._visible = true;
   FreezePanel.gotoAndPlay("StartShow");
}
function ShowCancelText()
{
   FreezeCancel._visible = true;
}
function HideCancelText()
{
   FreezeCancel._visible = false;
}
function setKillerHealth(health)
{
   FreezePanel.FreezePanel.Avatar.SetHealthBar(health);
}
function SetKillerItem(bShow, itemID, fauxItemId, xuid)
{
   var _loc2_ = new TextFormat();
   if(bShow == false)
   {
      FreezePanel.FreezePanel.ItemPanelContainer._visible = false;
      _loc2_.align = "left";
      FreezePanel.FreezePanel.DescriptionText.Text.setTextFormat(_loc2_);
      _global.AutosizeTextDown(FreezePanel.FreezePanel.DescriptionText.Text,5);
      _global.AutosizeTextDown(FreezePanelSS.DescriptionText.Text,5);
      FreezePanelSS.ItemPanelContainerSS._visible = false;
      return undefined;
   }
   _loc2_.align = "right";
   FreezePanel.FreezePanel.DescriptionText.Text.setTextFormat(_loc2_);
   FreezePanelSS.DescriptionText.Text.setTextFormat(_loc2_);
   _global.AutosizeTextDown(FreezePanel.FreezePanel.DescriptionText.Text,5);
   _global.AutosizeTextDown(FreezePanelSS.DescriptionText.Text,5);
   FreezePanel.FreezePanel.ItemPanelContainer._visible = true;
   FreezePanel.FreezePanel.ItemPanelContainer.ItemPanel.SetInfoForHudDropItem(itemID,fauxItemId,xuid);
   FreezePanelSS.ItemPanelContainerSS._visible = true;
   FreezePanelSS.ItemPanelContainerSS.ItemPanel.SetInfoForHudDropItem(itemID,fauxItemId,xuid);
}
function SetMedalText(text)
{
   trace("#######  SetMedalText : text = " + text);
   if(text != undefined && text != null && text != "")
   {
      FreezePanel.FreezePanel.MedalTextPanel._visible = true;
      FreezePanel.FreezePanel.MedalTextPanel.MedalDescription.MedalDescriptionText.SetText(text);
      FreezePanelSS.SSMedal._visible = true;
      FreezePanelSS.SSMedal.SSMedalDescription.SSMedalDescriptionText.SetText(text);
   }
   else
   {
      FreezePanel.FreezePanel.MedalTextPanel._visible = false;
      FreezePanelSS.SSMedal._visible = false;
   }
}
function RefreshAvatarImage()
{
   cachedXuid = undefined;
}
function showAvatar(xuidAsText, isCT, playerNameText, numDamageTaken, numHitsTaken, numDamageGiven, numHitsGiven, nHealth)
{
   FreezePanel.FreezePanel.MedalTextPanel._visible = false;
   FreezePanelSS.SSMedal._visible = false;
   var _loc2_ = !isCT?2:3;
   FreezePanel.FreezePanel.Avatar.ShowAvatar(_loc2_,xuidAsText,true,false);
   FreezePanelSS.Avatar.SetUseSmallFlair(false);
   FreezePanelSS.Avatar.ShowAvatar(_loc2_,xuidAsText,true,false);
   FreezePanelSS.Avatar.SetFlairPosition("topright");
   var _loc4_ = FreezePanel.FreezePanel.Avatar.GetFlairItemName(xuidAsText);
   SetMedalText(_loc4_);
   cachedXuid = xuidAsText;
   nameText = playerNameText;
   SetDamageTaken(numDamageTaken,numHitsTaken,playerNameText);
   SetDamageGiven(numDamageGiven,numHitsGiven,playerNameText);
   FreezePanel.FreezePanel.Avatar.SetHealthBar(nHealth);
}
function SetDamageTaken(numDamageTaken, numHitsTaken, srtKillerName)
{
   if(numDamageTaken == 0 || numDamageTaken == null || numDamageTaken == undefined)
   {
      FreezePanel.FreezePanel.DamageTaken._visible = false;
   }
   else
   {
      var _loc3_ = FreezePanel.FreezePanel.DamageTaken.DamageTakenText.Text;
      trace("numHitsTaken" + numHitsTaken);
      if(numHitsTaken > 1)
      {
         srtDamageTaken = _global.GameInterface.Translate("#FreezePanel_DamageTaken_Multi");
      }
      else
      {
         srtDamageTaken = _global.GameInterface.Translate("#FreezePanel_DamageTaken");
      }
      srtDamageTaken = _global.ConstructString(srtDamageTaken,numDamageTaken,numHitsTaken,srtKillerName);
      LobbyPanel.Panels.SearchInfoPanel.AverageWaitTime.Text.htmlText = srtPlayersSearching;
      _loc3_.htmlText = srtDamageTaken;
      FreezePanel.FreezePanel.DamageTaken._visible = true;
   }
}
function ShowFreezeFrameBorder(nIndex)
{
   var _loc2_ = new Object();
   _loc2_.onLoadError = function(target_mc, errorCode, status)
   {
      trace("Error loading image: " + errorCode + " [" + status + "]");
   };
   _loc2_.onLoadStart = function(target_mc)
   {
      trace("onLoadStart: " + target_mc);
   };
   _loc2_.onLoadProgress = function(target_mc, numBytesLoaded, numBytesTotal)
   {
      var _loc1_ = numBytesLoaded / numBytesTotal * 100;
      trace("onLoadProgress: " + target_mc + " is " + _loc1_ + "% loaded");
   };
   _loc2_.onLoadInit = function(target_mc)
   {
      target_mc._x = 0;
      target_mc._y = 0;
      target_mc._width = Stage.width;
      target_mc._height = Stage.height;
      trace("!!!!!!onLoadInit : " + Stage.width + " x " + Stage.height);
   };
   if(nIndex == 0)
   {
      m_nBorderIndex = _global.RandomInt(1,3);
   }
   else
   {
      m_nBorderIndex = nIndex;
   }
   var _loc5_ = "FreezeCam/holiday_border_" + m_nBorderIndex + ".png";
   if(ScreenBorder != undefined)
   {
      ScreenBorder.unloadMovie();
   }
   var _loc3_ = new MovieClipLoader();
   _loc3_.addListener(_loc2_);
   _loc3_.loadClip(_loc5_,ScreenBorder);
   ScreenBorder._visible = true;
}
function HideFreezeFrameBorder()
{
   ScreenBorder._visible = false;
}
function SetDamageGiven(numDamageGiven, numHitsGiven, srtKillerName)
{
   if(numDamageGiven == 0 || numDamageGiven == null || numDamageGiven == undefined)
   {
      FreezePanel.FreezePanel.DamageGiven._visible = false;
      if(!FreezePanel.FreezePanel.DamageTaken._visible)
      {
         FreezePanel.FreezePanel.Navigation._y = FreezePanel.FreezePanel.Navigation._y - 44;
      }
      else
      {
         FreezePanel.FreezePanel.Navigation._y = FreezePanel.FreezePanel.Navigation._y - 22;
      }
   }
   else
   {
      var _loc4_ = FreezePanel.FreezePanel.DamageGiven.DamageGivenText.Text;
      trace("numHitsGiven" + numHitsGiven);
      if(numHitsGiven > 1)
      {
         srtDamageGiven = _global.GameInterface.Translate("#FreezePanel_DamageGiven_Multi");
      }
      else
      {
         srtDamageGiven = _global.GameInterface.Translate("#FreezePanel_DamageGiven");
      }
      srtDamageGiven = _global.ConstructString(srtDamageGiven,numDamageGiven,numHitsGiven,srtKillerName);
      LobbyPanel.Panels.SearchInfoPanel.AverageWaitTime.Text.htmlText = srtPlayersSearching;
      _loc4_.htmlText = srtDamageGiven;
      FreezePanel.FreezePanel.DamageGiven._visible = true;
   }
}
function NameTextUpdated()
{
   _global.AutosizeTextDown(FreezePanel.FreezePanel.NameText.WinDescription,16);
   _global.AutosizeTextDown(FreezePanelSS.NameText.WinDescription,16);
}
function onLoadInit(movieClip)
{
   movieClip._x = avatarSize.x;
   movieClip._y = avatarSize.y;
   movieClip._width = avatarSize.width;
   movieClip._height = avatarSize.height;
}
function positionDeathPanel(freezePanel)
{
}
function positionScreenshotPanel(screenshotPanel)
{
}
var avatarSize;
var cachedXuid = undefined;
var numPostitionStart = FreezePanel.FreezePanel.Navigation._y;
var m_nBorderIndex = 0;
_global.resizeManager.AddListener(this);
stop();
