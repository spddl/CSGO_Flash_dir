function onLoaded()
{
   AvatarShortcut = WinPanel.InnerWinPanel.AvatarContainer;
   AvatarRunnerup1 = WinPanel.InnerWinPanel.ArsenalPanel.AvatarContainer1.AvatarContainer;
   AvatarRunnerup2 = WinPanel.InnerWinPanel.ArsenalPanel.AvatarContainer2.AvatarContainer;
   WinPanel.InnerWinPanel.Surrender.SetText("");
   WinPanel.InnerWinPanel.MVPText.InnerText.verticalAlign = "center";
   WinPanel.InnerWinPanel.MVPText.InnerText.wordWrap = true;
   WinPanel.InnerWinPanel.ArsenalPanel._visible = false;
   gameAPI.OnReady();
   WinPanel._visible = false;
   WinTitleColor = new Color(WinPanel.InnerWinPanel.WinnerText.WinnerText);
   AvatarFrameColor = new Color(AvatarShortcut.Frame);
}
function onUnload(mc)
{
   _global.WinPanelRoot = null;
   _global.resizeManager.RemoveListener(this);
   return true;
}
function onResize(rm)
{
   rm.DisableAdditionalScaling = true;
   rm.ResetPositionByPixel(WinPanel,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_CENTER_X,0,Lib.ResizeManager.ALIGN_CENTER,Lib.ResizeManager.REFERENCE_CENTER_Y,0,Lib.ResizeManager.ALIGN_CENTER);
   rm.DisableAdditionalScaling = false;
}
function setResultConstants(drawConstant, ctConstant, tConstant)
{
   CTWinResultConstant = ctConstant;
   TWinResultConstant = tConstant;
   DrawResultConstant = drawConstant;
}
function hide()
{
   if(winPanelVisible)
   {
      WinPanel.gotoAndPlay("StartHide");
      winPanelVisible = false;
   }
}
function showArsenalWin()
{
   WinPanel.InnerWinPanel.gotoAndPlay("StartShow");
   WinPanel._visible = true;
   WinPanel.gotoAndPlay("StartShow");
   winPanelVisible = true;
   onResize(_global.resizeManager);
   WinPanel.InnerWinPanel.WinPanelBg._visible = false;
   WinPanel.InnerWinPanel.MVPText._visible = false;
   WinPanel.InnerWinPanel.WinnerText._visible = false;
   WinPanel.InnerWinPanel.Surrender._visible = false;
   WinPanel.InnerWinPanel.ArsenalPanel._visible = true;
   WinPanel.InnerWinPanel.EloPanel._visible = false;
   WinPanel.InnerWinPanel.RankPanel._visible = false;
   WinPanel.InnerWinPanel.MedalPanel._visible = false;
   WinPanel.InnerWinPanel.NextWeaponPanel._visible = false;
   WinPanel.InnerWinPanel.FunFact._visible = false;
   WinPanel.InnerWinPanel.ProgressText.ProgressNumText._visible = false;
   WinPanel.InnerWinPanel.ProgressText.ProgressDescText._visible = false;
   WinPanel.InnerWinPanel.ProgressText.ProgressBarBg._visible = false;
   WinPanel.InnerWinPanel.MedalProgess._visible = false;
}
function showTeamWin(result, logoString)
{
   if(!winPanelVisible)
   {
      WinPanel.InnerWinPanel.gotoAndPlay("StartShow");
      WinPanel._visible = true;
      WinPanel.gotoAndPlay("StartShow");
      winPanelVisible = true;
      onResize(_global.resizeManager);
      WinPanel.InnerWinPanel.WinPanelBg.CTLogo._visible = false;
      WinPanel.InnerWinPanel.WinPanelBg.TLogo._visible = false;
      var _loc3_ = WinPanel.InnerWinPanel.WinPanelBg.CTLogo;
      var _loc6_ = WinPanel.InnerWinPanel.WinPanelBg.CTIcon.Logo;
      if(result == CTWinResultConstant)
      {
         WinPanel.InnerWinPanel.WinPanelBg._visible = true;
         WinPanel.InnerWinPanel.WinPanelBg.CTIcon._visible = true;
         WinPanel.InnerWinPanel.WinPanelBg.TIcon._visible = false;
         WinPanel.InnerWinPanel.ArsenalPanel._visible = false;
      }
      else if(result == TWinResultConstant)
      {
         _loc3_ = WinPanel.InnerWinPanel.WinPanelBg.TLogo;
         _loc6_ = WinPanel.InnerWinPanel.WinPanelBg.TIcon.Logo;
         WinPanel.InnerWinPanel.WinPanelBg._visible = true;
         WinPanel.InnerWinPanel.WinPanelBg.TIcon._visible = true;
         WinPanel.InnerWinPanel.WinPanelBg.CTIcon._visible = false;
         WinPanel.InnerWinPanel.ArsenalPanel._visible = false;
      }
      else if(result == DrawResultConstant)
      {
         SetLocalTint(Default_ColorTransform);
      }
      WinPanel.InnerWinPanel.EloPanel._visible = false;
      WinPanel.InnerWinPanel.ItemPanel._visible = false;
      WinPanel.InnerWinPanel.RankPanel._visible = false;
      WinPanel.InnerWinPanel.MedalPanel._visible = false;
      WinPanel.InnerWinPanel.NextWeaponPanel._visible = false;
      WinPanel.InnerWinPanel.FunFact._visible = false;
      WinPanel.InnerWinPanel.ProgressText.ProgressNumText._visible = false;
      WinPanel.InnerWinPanel.ProgressText.ProgressDescText._visible = false;
      WinPanel.InnerWinPanel.ProgressText.ProgressBarBg._visible = false;
      _loc3_._visible = false;
      _loc6_._visible = true;
      if(logoString != undefined && logoString != "")
      {
         _loc3_._visible = true;
         _loc6_._visible = false;
         logoString = "econ/tournaments/teams/" + logoString;
         if(logoPanel != undefined)
         {
            logoPanel.unloadMovie();
         }
         var _loc2_ = new Object();
         _loc2_.onLoadInit = function(target_mc)
         {
            target_mc._width = m_nTeamLogoSize;
            target_mc._height = m_nTeamLogoSize;
         };
         _loc2_.onLoadError = function(target_mc, errorCode, status)
         {
            trace("Error loading item image: " + errorCode + " [" + status + "] ----- ");
         };
         var _loc5_ = new MovieClipLoader();
         _loc5_.addListener(_loc2_);
         _loc5_.loadClip(logoString,_loc3_);
      }
   }
}
function showTeamWinDataPanel(nExtraPanelType)
{
   if(winPanelVisible)
   {
      if(nExtraPanelType == 1)
      {
         WinPanel.InnerWinPanel.MedalPanel._visible = true;
         WinPanel.InnerWinPanel.MedalPanel.gotoAndPlay("StartAnim");
      }
      else if(nExtraPanelType == 2)
      {
         WinPanel.InnerWinPanel.RankPanel._visible = true;
         WinPanel.InnerWinPanel.RankPanel.gotoAndPlay("StartAnim");
      }
      else if(nExtraPanelType == 3)
      {
         WinPanel.InnerWinPanel.EloPanel._visible = true;
         WinPanel.InnerWinPanel.EloPanel.gotoAndPlay("StartAnim");
      }
      else if(nExtraPanelType == 4)
      {
         WinPanel.InnerWinPanel.NextWeaponPanel._visible = true;
      }
      else if(nExtraPanelType == 6)
      {
         WinPanel.InnerWinPanel.ItemPanel._visible = true;
      }
   }
}
function SetLocalTint(colorTransform)
{
   WinTitleColor.setTransform(colorTransform);
   AvatarFrameColor.setTransform(colorTransform);
}
function setYOffset(nOffset)
{
   DynamicYPosition = nOffset;
   onResize(_global.resizeManager);
}
function RefreshAvatarImage()
{
   WinPanel.InnerWinPanel.xuid = undefined;
   WinPanel.InnerWinPanel.ArsenalPanel.xuid1 = undefined;
   WinPanel.InnerWinPanel.ArsenalPanel.xuid2 = undefined;
}
function ShowAvatar(xuid, playerNameText, teamNumber, bIsLocal, numStatTrak)
{
   AvatarShortcut._visible = true;
   AvatarShortcut.SetFlairPosition("bottomleft");
   AvatarShortcut.ShowAvatar(teamNumber,xuid,true,false);
   WinPanel.InnerWinPanel.MVPText.Star._visible = true;
   WinPanel.InnerWinPanel.xuid = xuid;
   WinPanel.InnerWinPanel.MVPText._y = 190.5;
   WinPanel.InnerWinPanel.ArsenalPanel.WinnerName._y = 33.2;
   DisplayMusicKit(xuid,numStatTrak);
}
function DisplayMusicKit(xuid, numStatTrak)
{
   var _loc2_ = WinPanel.InnerWinPanel.MusicKit;
   var _loc4_ = xuid;
   _loc2_.MusicImage._visible = false;
   trace("----------------------------------------XuidMVP-----------------------------------" + _global.CScaleformComponent_MatchStats.GetMVPXuid());
   trace("-------------------------------------numStatTrak----------------------------:" + numStatTrak);
   if(_loc4_ == null || _loc4_ == undefined || _loc4_ == "")
   {
      return undefined;
   }
   var _loc3_ = _global.CScaleformComponent_Inventory.GetMusicIDForPlayer(_loc4_);
   if(_loc3_ == null || _loc3_ == undefined || _loc3_ == "" || _loc3_ == 0 || _loc3_ == 1)
   {
      return undefined;
   }
   var _loc5_ = _global.CScaleformComponent_Inventory.GetMusicNameFromMusicID(_loc3_);
   if(_loc5_ == null || _loc5_ == undefined || _loc5_ == "")
   {
      return undefined;
   }
   var _loc12_ = _global.CScaleformComponent_Inventory.GetItemInventoryImageFromMusicID(_loc3_) + ".png";
   _loc2_.MusicImage._visible = true;
   _loc2_.MusicImage.DefaultItemImage._visible = false;
   _loc2_.MusicImage.DynamicItemImage._visible = true;
   if(_loc2_.MusicImage.DynamicItemImage.Image != undefined)
   {
      _loc2_.MusicImage.DynamicItemImage.Image.unloadMovie();
   }
   var _loc8_ = new Object();
   _loc8_.onLoadInit = function(target_mc)
   {
      target_mc._width = 31;
      target_mc._height = 25.5;
   };
   _loc8_.onLoadError = function(target_mc, errorCode, status)
   {
      trace("Error loading item image: " + errorCode + " [" + status + "] ----- ");
   };
   var _loc13_ = _loc12_;
   var _loc10_ = new MovieClipLoader();
   _loc10_.addListener(_loc8_);
   _loc10_.loadClip(_loc13_,_loc2_.MusicImage.DynamicItemImage.Image);
   var _loc11_ = _global.CScaleformComponent_FriendsList.GetFriendName(_loc4_);
   if(_loc4_ == _global.CScaleformComponent_MyPersona.GetXuid())
   {
      var _loc6_ = _global.GameInterface.Translate("#SFUI_WinPanel_Playing_MVP_MusicKit_Yours");
   }
   else
   {
      _loc6_ = _global.GameInterface.Translate("#SFUI_WinPanel_Playing_MVP_MusicKit");
      _loc6_ = _global.ConstructString(_loc6_,_loc11_);
   }
   _loc2_._visible = true;
   if(numStatTrak <= 0 || numStatTrak == null || numStatTrak == undefined)
   {
      _loc2_.StatTrak._visible = false;
   }
   else
   {
      _loc2_.StatTrak._visible = true;
      var _loc7_ = _global.GameInterface.Translate("#SFUI_WinPanel_Playing_MVP_MusicKit_StatTrak");
      _loc7_ = _global.ConstructString(_loc7_,numStatTrak);
      _loc2_.StatTrak.Text.htmlText = _loc7_;
   }
   _loc2_.MusicTextKitName.Text.htmlText = _loc5_;
   _loc2_.MusicText.Text.htmlText = _loc6_;
   _loc2_.gotoAndPlay("StartAnim");
   WinPanel.InnerWinPanel.MVPText._y = 174.2;
   WinPanel.InnerWinPanel.ArsenalPanel.WinnerName._y = 19.2;
}
function ShowGGRunnerUpAvatars(sWinnerNameText, xuid1, xuid2, teamNumber1, teamNumber2)
{
   AvatarRunnerup1._visible = true;
   AvatarRunnerup2._visible = true;
   AvatarRunnerup1.SetFlairPosition("bottomleft");
   AvatarRunnerup1.ShowAvatar(teamNumber1,xuid1,true,false);
   AvatarRunnerup2.SetFlairPosition("bottomleft");
   AvatarRunnerup2.ShowAvatar(teamNumber2,xuid2,true,false);
   WinPanel.InnerWinPanel.ArsenalPanel.WinnerName.Text.htmlText = sWinnerNameText;
   _global.AutosizeTextDown(WinPanel.InnerWinPanel.ArsenalPanel.WinnerName.Text,16);
   WinPanel.InnerWinPanel.ArsenalPanel.xuid1 = xuid1;
   WinPanel.InnerWinPanel.ArsenalPanel.xuid2 = xuid2;
}
function HideAvatar()
{
   AvatarShortcut._visible = false;
   WinPanel.InnerWinPanel.MVPText.Star._visible = false;
   WinPanel.InnerWinPanel.Coin._visible = false;
   WinPanel.InnerWinPanel.MusicKit._visible = false;
}
function SetWinPanelItemDrops(index, bShow, nTotal, nTotalLocal, strId, PlayerXuid, bIsLocalPlayerItem)
{
   WinPanel.InnerWinPanel.MedalProgess._visible = false;
   WinPanel.InnerWinPanel.ItemPanel.ShowItem(index,bShow,nTotal,nTotalLocal,strId,PlayerXuid,bIsLocalPlayerItem);
}
function SetWinPanelAwardIcon(index, medalName)
{
   var _loc5_ = "MedalIcon0" + index;
   var _loc1_ = WinPanel.InnerWinPanel.MedalPanel[_loc5_];
   if(_loc1_ != undefined)
   {
      _loc1_._visible = false;
      _loc1_.unloadMovie();
   }
   if(medalName != "")
   {
      medalName = "images/achievements/" + medalName + ".jpg";
      var _loc4_ = new Object();
      _loc4_.onLoadInit = function(target_mc)
      {
         target_mc.forceSmoothing = true;
         trace("Loaded achievement icon!");
      };
      _loc1_._visible = true;
      var _loc3_ = new MovieClipLoader();
      _loc3_.addListener(_loc4_);
      _loc3_.loadClip(medalName,_loc1_);
      trace("Loading achievement icon: " + medalName);
   }
}
function SetWinPanelStatProgress(medalName, currentCount, maxCount, numGainedThisRound, medalCategory, displayString)
{
   WinPanel.InnerWinPanel.MedalProgess.MedalProgressText.text.htmlText = displayString;
   WinPanel.InnerWinPanel.MedalProgess._visible = true;
   WinPanel.InnerWinPanel.FunFact._visible = false;
   WinPanel.InnerWinPanel.ProgressText.ProgressNumText._visible = false;
   WinPanel.InnerWinPanel.ProgressText.ProgressDescText._visible = false;
   WinPanel.InnerWinPanel.ProgressText.ProgressBarBg._visible = true;
   var _loc1_ = WinPanel.InnerWinPanel.MedalProgess.MedalIconProgress;
   if(_loc1_ != undefined)
   {
      _loc1_._visible = false;
      _loc1_.unloadMovie();
   }
   if(medalName != "")
   {
      medalName = "images/achievements/" + medalName + ".jpg";
      var _loc4_ = new Object();
      _loc4_.onLoadInit = function(target_mc)
      {
         target_mc._width = 15;
         target_mc._height = 15;
         target_mc.forceSmoothing = true;
         trace("Loaded achievement icon!");
         WinPanel.InnerWinPanel.MedalProgess.MedalIconProgress._visible = true;
      };
      var _loc3_ = new MovieClipLoader();
      _loc3_.addListener(_loc4_);
      _loc3_.loadClip(medalName,_loc1_);
      trace("Loading achievement icon: " + medalName);
   }
}
function SetRankUpText(sAnnounceText, sRankNameText)
{
   WinPanel.InnerWinPanel.RankPanel.RankEarned.Text.htmlText = sAnnounceText;
   WinPanel.InnerWinPanel.RankPanel.RankName.Text.htmlText = sRankNameText;
}
function SetRankUpIcon(nCatagory, nRank)
{
   var _loc1_ = WinPanel.InnerWinPanel.RankPanel.RankIcon;
   if(_loc1_ && _loc1_.Image != undefined)
   {
      _loc1_.removeMovieClip();
   }
   var _loc2_ = "rank_" + nCatagory + "_0" + nRank;
   if(_loc2_ != "")
   {
      _loc1_.attachMovie(_loc2_,"Image",_loc1_.getDepth() + 1);
   }
}
function SetEloBracketInfo(nBracket, message)
{
   var _loc1_ = WinPanel.InnerWinPanel.EloPanel.EloIcon;
   if(_loc1_ && _loc1_.Image != undefined)
   {
      _loc1_.removeMovieClip();
   }
   var _loc2_ = "elo0" + nBracket;
   if(_loc2_ != "")
   {
      _loc1_.attachMovie(_loc2_,"Image",_loc1_.getDepth() + 1);
   }
   WinPanel.InnerWinPanel.EloPanel.EloChangedText.Text.htmlText = message;
}
function SetProgressText(sAmount, sDescription)
{
   WinPanel.InnerWinPanel.ProgressText.ProgressDescText.Text.htmlText = sDescription;
   WinPanel.InnerWinPanel.FunFact._visible = false;
   WinPanel.InnerWinPanel.MedalProgess._visible = false;
   WinPanel.InnerWinPanel.ProgressText.ProgressDescText._visible = true;
   WinPanel.InnerWinPanel.ProgressText.ProgressBarBg._visible = true;
}
function SetFunFactText(sDescription)
{
   WinPanel.InnerWinPanel.FunFact.FunFact.htmlText = sDescription;
   WinPanel.InnerWinPanel.FunFact._visible = true;
   WinPanel.InnerWinPanel.MedalProgess._visible = false;
   WinPanel.InnerWinPanel.ProgressText.ProgressNumText._visible = false;
   WinPanel.InnerWinPanel.ProgressText.ProgressDescText._visible = false;
   if(sDescription != "")
   {
      WinPanel.InnerWinPanel.ProgressText.ProgressBarBg._visible = true;
   }
}
function SetGunGamePanelData(sTitle, sWeaponName, sWeaponClass, sGrenadeClass)
{
   WinPanel.InnerWinPanel.NextWeaponPanel.TitlePanel.htmlText = sTitle;
   WinPanel.InnerWinPanel.NextWeaponPanel.WepNameText.htmlText = sWeaponName;
   var _loc4_ = sWeaponClass.indexOf("_");
   if(_loc4_ >= 0)
   {
      sWeaponClass = sWeaponClass.substr(_loc4_ + 1);
   }
   if(sWeaponClass == "")
   {
      sWeaponClass = "weapon_mp7";
   }
   var _loc6_ = _global.GameInterface.GetConvarNumber("player_teamplayedlast") == _global.TeamID_CounterTerrorist;
   if(sWeaponClass == "knife" || sWeaponClass == "knifegg")
   {
      sWeaponClass = "knife";
      if(_loc6_)
      {
         sWeaponClass = sWeaponClass + "-ct";
      }
   }
   sWeaponClass = "icon-" + sWeaponClass;
   var _loc5_ = sGrenadeClass.indexOf("_");
   if(_loc5_ >= 0)
   {
      sGrenadeClass = sGrenadeClass.substr(_loc5_ + 1);
      WinPanel.InnerWinPanel.NextWeaponPanel.iconWeapon._visible = true;
      sGrenadeClass = "icon-" + sGrenadeClass;
      WinPanel.InnerWinPanel.NextWeaponPanel.iconWeapon.attachMovie(sGrenadeClass,"Image",0);
      WinPanel.InnerWinPanel.NextWeaponPanel.iconWeapon2._visible = true;
      WinPanel.InnerWinPanel.NextWeaponPanel.iconWeapon2.attachMovie(sWeaponClass,"Image",0);
   }
   else
   {
      WinPanel.InnerWinPanel.NextWeaponPanel.iconWeapon.attachMovie(sWeaponClass,"Image",0);
      WinPanel.InnerWinPanel.NextWeaponPanel.iconWeapon2._visible = false;
   }
}
function onLoadInit(movieClip)
{
   movieClip._width = avatarWidth;
   movieClip._height = avatarHeight;
}
var DynamicYPosition = 0;
var winPanelVisible = false;
var AvatarShortcut;
var AvatarRunnerup1;
var AvatarRunnerup2;
var CTWinResultConstant;
var TWinResulConstant;
var DrawResultConstant;
var CT_ColorTransform = _global.tintManager.Tints[_global.tintManager.TintIndex(Lib.TintManager.Tint_CounterTerrorist)];
var T_ColorTransform = _global.tintManager.Tints[_global.tintManager.TintIndex(Lib.TintManager.Tint_Terrorist)];
var Default_ColorTransform = _global.tintManager.Tints[0];
var m_nTeamLogoSize = WinPanel.InnerWinPanel.WinPanelBg.TIcon.TLogo._width;
var WinTitleColor;
var AvatarFrameColor;
_global.resizeManager.AddListener(this);
_global.WinPanelRoot = WinPanel;
stop();
