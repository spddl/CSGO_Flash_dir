function onResize(rm)
{
   rm.DisableAdditionalScaling = true;
   rm.ResetPositionByPixel(Panel,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_CENTER_X,0,Lib.ResizeManager.ALIGN_CENTER,Lib.ResizeManager.REFERENCE_CENTER_Y,0,Lib.ResizeManager.ALIGN_CENTER);
}
function changeUIDevice()
{
   Panel.setUIDevice();
}
function showErrorText(err)
{
   Panel.NavPanel.ErrorBar.AddError(err);
}
function setTeamsFull(bCTFull, bTFull)
{
   Panel.setCTFull(bCTFull);
   Panel.setTFull(bTFull);
}
function showPreMatchOverlay(team)
{
   if(_global.TeamSelectAPI.IsQueuedMatchmaking())
   {
      return undefined;
   }
   Panel.showPreMatchOverlay(team);
}
function showPanel(bInstantShow, preassignedTeam)
{
   if(!bVisible)
   {
      Panel.setUIDevice();
      Panel.showPanel(bInstantShow,preassignedTeam);
      if(!_global.TeamSelectAPI.IsQueuedMatchmaking())
      {
         _global.TeamSelectInterval = setInterval(_global.TeamSelectAPI.OnTimer,1000);
      }
      bVisible = true;
   }
}
function hidePanel()
{
   if(bVisible)
   {
      Panel.hidePanel();
      clearInterval(_global.TeamSelectInterval);
      delete _global.TeamSelectInterval;
      bVisible = false;
   }
}
function hidePanelAndRemove()
{
   if(bVisible || _global.TeamSelectAPI.IsQueuedMatchmaking() || _global.GameInterface.GetConvarNumber("sv_disable_show_team_select_menu"))
   {
      _global.RemoveChooseTeam = true;
      Panel.hidePanel();
      clearInterval(_global.TeamSelectInterval);
      delete _global.TeamSelectInterval;
      bVisible = false;
   }
}
function ShowSpectatorButton(showButton)
{
   Panel.NavPanel.NavigationMaster.PCButtons.SpectatorButton._visible = showButton;
}
function selectCounterTerrorists()
{
   Panel.selectCounterTerrorists();
}
function selectTerrorists()
{
   Panel.selectTerrorists();
}
function SetBackgroundJpg(infoThumbPath)
{
   trace("============ setLoadingThumbnail : " + infoThumbPath);
   var _loc4_ = new Object();
   _loc4_.onLoadInit = function(target_mc)
   {
      var _loc2_ = 0;
      if(target_mc._width <= 1000)
      {
         _loc2_ = 12;
      }
      target_mc._x = thumbnailSize.x;
      target_mc._y = thumbnailSize.y;
      target_mc._width = thumbnailSize.width;
      target_mc._height = thumbnailSize.height;
      Panel.NavPanel.MapHolder.ImageThumbnail._visible = true;
      var _loc3_ = new flash.filters.BlurFilter(_loc2_,_loc2_,2);
      target_mc.filters = [_loc3_];
   };
   var _loc7_ = "../../" + infoThumbPath;
   var _loc1_ = Panel.NavPanel.MapHolder.ImageThumbnail;
   if(_loc1_ != undefined)
   {
      _loc1_.unloadMovie();
      trace("!!!!!! unloading thumbnail!");
   }
   if(infoThumbPath)
   {
      var _loc3_ = new MovieClipLoader();
      _loc3_.addListener(_loc4_);
      _loc3_.loadClip(_loc7_,_loc1_);
   }
}
function onUnload(mc)
{
   hidePanel();
   delete _global.TeamSelectMovie;
   delete _global.TeamSelectAPI;
   _global.RemoveChooseTeam = null;
   bVisible = false;
   _global.resizeManager.RemoveListener(this);
   _global.tintManager.DeregisterAll(this);
   Panel.onUnload();
   return true;
}
function SetAvatar(bCT, Index, Xuid, PlayerName, bIsLocalPlayer)
{
   var _loc9_ = (!bCT?"AvatarT":"AvatarCT") + Index;
   var _loc3_ = Panel.NavPanel[_loc9_];
   if(_loc3_ != undefined)
   {
      if(_loc3_.SavedXUID != Xuid)
      {
         if(_global.IsPS3() && Xuid == "0" && bIsLocalPlayer)
         {
            _loc3_.attachMovie("DefaultLocalAvatar","DynamicAvatar",0);
            _loc3_._visible = true;
            _loc3_.TPanel._visible = !bCT;
            _loc3_.CTPanel._visible = bCT;
            _loc3_.SavedXUID = -1;
         }
         else
         {
            var _loc7_ = _loc3_.DynamicAvatar;
            if(_loc7_ != undefined)
            {
               _loc7_.unloadMovie();
            }
            var _loc8_ = "img://avatar_" + Xuid;
            if(Xuid == "0")
            {
               _loc3_._visible = false;
            }
            else
            {
               var _loc6_ = new MovieClipLoader();
               _loc6_.addListener(this);
               _loc6_.loadClip(_loc8_,_loc3_.DynamicAvatar);
               _loc3_._visible = true;
               _loc3_.TPanel._visible = !bCT;
               _loc3_.CTPanel._visible = bCT;
            }
            _loc3_.Name.text.htmlText = PlayerName;
            _loc3_.SavedXUID = Xuid;
         }
      }
   }
}
function setTeamHintText(szHint_CT, szHint_T, nObjective)
{
   Panel.NavPanel.CtHelpText.TextBox.htmlText = szHint_CT;
   Panel.NavPanel.THelpText.TextBox.htmlText = szHint_T;
}
function onLoadInit(mc)
{
   var _loc1_ = Panel.NavPanel.AvatarCT0.DefaultAvatar;
   mc._x = _loc1_._x;
   mc._y = _loc1_._y;
   mc._width = _loc1_._width;
   mc._height = _loc1_._height;
   mc._visible = true;
   _loc1_._visible = false;
}
function onLoaded()
{
   var _loc1_ = 0;
   while(_loc1_ < 12)
   {
      var _loc3_ = (!bCT?"AvatarT":"AvatarCT") + _loc1_;
      var _loc2_ = Panel.NavPanel[_loc3_];
      _loc2_._visible = false;
      _loc1_ = _loc1_ + 1;
   }
   var _loc4_ = Panel.NavPanel.MapHolder.ImageThumbnail;
   thumbnailSize = new flash.geom.Rectangle(_loc4_._x,_loc4_._y,_loc4_._width,_loc4_._height);
   Panel.onLoaded();
   gameAPI.OnReady();
   Panel.setUIDevice();
}
_global.TeamSelectMovie = this;
_global.TeamSelectAPI = gameAPI;
var bVisible = false;
var thumbnailSize;
var bSecondsToHoldLastError = 4;
var bSecondsToHoldErrorWhenOthersArePending = 2;
_global.RemoveChooseTeam = false;
_global.resizeManager.AddListener(this);
stop();
