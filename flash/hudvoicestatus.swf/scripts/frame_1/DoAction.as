function AddPanel()
{
   nDepthOffset++;
   var _loc2_ = Panel.StatusPanel.Notice.AlertText1.attachMovie("alert-text","NoticePanel" + nDepthOffset,this.getNextHighestDepth() + nDepthOffset);
   _loc2_._visible = false;
   return _loc2_;
}
function SetPanelText(notice, text)
{
   notice.Text.wordWrap = true;
   notice.Text.autoSize = true;
   notice.Text.htmlText = text;
   notice._visible = false;
   notice._y = 0;
   notice.BGShape._height = notice.Text.textHeight;
   return notice.Text.textHeight;
}
function RemovePanel(movieClip)
{
   Panel.StatusPanel.Notice.AlertText1[movieClip._name].removeMovieClip();
}
function onLoaded()
{
   Panel.VoicePanel0.gotoAndStop("Hide");
   Panel.VoicePanel1.gotoAndStop("Hide");
   Panel.VoicePanel2.gotoAndStop("Hide");
   nDepthOffset = 0;
   gameAPI.SetConfig(nNumberOfNotices * Panel.StatusPanel.Notice._height,nScrollInTime,nFadeOutTime,nNoticeLifetime);
   setYOffset(10);
   gameAPI.OnReady();
}
function onUnload(mc)
{
   _global.VoiceStatusMovie = null;
   _global.resizeManager.RemoveListener(this);
   return true;
}
function RefreshAvatarImage()
{
   avatarXuid = undefined;
}
function ShowVoiceNotice(slot, NewNotice, NewTeamNum, IsAlive, SpeakerState, xuid, playerNameText, bIsLocal)
{
   if(slot >= 3)
   {
      return undefined;
   }
   var _loc11_ = "VoicePanel" + slot;
   var _loc3_ = Panel[_loc11_];
   if(!_loc3_)
   {
      return undefined;
   }
   var _loc7_ = false;
   var _loc4_ = xuid != "0";
   if(_loc4_ || _loc7_)
   {
      var _loc10_ = "img://avatar_" + xuid;
      if(_loc7_)
      {
         _loc10_ = _global.GameInterface.GetPAXAvatarFromName(playerNameText);
      }
      if(_loc3_.VoiceAnim.DynamicAvatar != undefined)
      {
         _loc3_.VoiceAnim.DynamicAvatar.unloadMovie();
      }
      var _loc6_ = new MovieClipLoader();
      _loc6_.addListener(this);
      _loc6_.loadClip(_loc10_,_loc3_.VoiceAnim.DynamicAvatar);
      _loc3_.VoiceAnim.DynamicAvatar._visible = true;
      _loc3_.VoiceAnim.DefaultAvatarCT._visible = false;
      _loc3_.VoiceAnim.DefaultAvatarT._visible = false;
      avatarXuid = xuid;
   }
   else if(_global.IsPS3() && xuid == "0" && bIsLocal)
   {
      if(_loc3_.VoiceAnim.AvatarPS3 == undefined)
      {
         var _loc5_ = _loc3_.VoiceAnim.attachMovie("DefaultLocalAvatar","AvatarPS3",1);
         _loc5_._x = _loc3_.VoiceAnim.DynamicAvatar._x;
         _loc5_._y = _loc3_.VoiceAnim.DynamicAvatar._y;
         _loc5_._width = _loc3_.VoiceAnim.DynamicAvatar._width;
         _loc5_._height = _loc3_.VoiceAnim.DynamicAvatar._height;
      }
      _loc3_.VoiceAnim.DynamicAvatar._visible = false;
      _loc3_.VoiceAnim.DefaultAvatarCT._visible = false;
      _loc3_.VoiceAnim.DefaultAvatarT._visible = false;
      _loc4_ = true;
      avatarXuid = "-1";
   }
   else
   {
      _loc3_.VoiceAnim.DynamicAvatar._visible = false;
      if(_loc3_.VoiceAnim.AvatarPS3 != undefined)
      {
         _loc3_.VoiceAnim.AvatarPS3.removeMovieClip();
         _loc3_.VoiceAnim.AvatarPS3 = undefined;
      }
   }
   switch(NewTeamNum)
   {
      case 2:
         if(!_loc4_)
         {
            _loc3_.VoiceAnim.DefaultAvatarCT._visible = false;
            _loc3_.VoiceAnim.DefaultAvatarT._visible = true;
         }
         break;
      case 3:
         if(!_loc4_)
         {
            _loc3_.VoiceAnim.DefaultAvatarCT._visible = true;
            _loc3_.VoiceAnim.DefaultAvatarT._visible = false;
         }
         break;
      default:
         if(!_loc4_)
         {
            _loc3_.VoiceAnim.DefaultAvatarCT._visible = false;
            _loc3_.VoiceAnim.DefaultAvatarT._visible = false;
         }
   }
   if(NewTeamNum != 2 && NewTeamNum != 3)
   {
      _loc3_.VoiceAnim.Skull._visible = false;
   }
   else
   {
      _loc3_.VoiceAnim.Skull._visible = !IsAlive;
   }
   switch(SpeakerState)
   {
      case 0:
         _loc3_.VoiceAnim.SoundIcon.gotoAndPlay("StartShow1");
         break;
      case 1:
         _loc3_.VoiceAnim.SoundIcon.gotoAndStop("StartShow2");
         break;
      case 2:
         _loc3_.VoiceAnim.SoundIcon.gotoAndStop("StartShow3");
         break;
      default:
         _loc3_.VoiceAnim.SoundIcon.gotoAndStop("Off");
   }
   if(!bVoicePanelRaised[slot])
   {
      bVoicePanelRaised[slot] = true;
      _loc3_.gotoAndPlay("StartShow");
   }
   _loc3_.VoiceAnim.VoiceText.SetText(NewNotice);
}
function HideVoiceNotice(slot)
{
   if(slot >= 3)
   {
      return undefined;
   }
   var _loc3_ = "VoicePanel" + slot;
   var _loc1_ = Panel[_loc3_];
   if(!_loc1_)
   {
      return undefined;
   }
   if(bVoicePanelRaised[slot])
   {
      _loc1_.gotoAndPlay("StartHide");
      bVoicePanelRaised[slot] = false;
   }
}
function onLoadInit(movieClip)
{
   movieClip._x = avatarX;
   movieClip._y = avatarY;
   movieClip._width = avatarWidth;
   movieClip._height = avatarHeight;
}
function VoicePanelRaised()
{
}
function VoicePanelLowered()
{
}
function onResize(rm)
{
   rm.ResetPositionByPixel(Panel,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_SAFE_LEFT,0,Lib.ResizeManager.ALIGN_LEFT,Lib.ResizeManager.REFERENCE_SAFE_BOTTOM,PixelOffsetBottom,Lib.ResizeManager.ALIGN_BOTTOM);
}
function setYOffset(nOffset)
{
   PixelOffsetBottom = nOffset;
   onResize(_global.resizeManager);
}
function resizeRelative(healthArmorModule)
{
   _global.resizeManager.ResetPositionByPixel(Panel,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_SAFE_LEFT,0,Lib.ResizeManager.ALIGN_LEFT,Lib.ResizeManager.REFERENCE_SAFE_BOTTOM,(- healthArmorModule._height / 2) * _global.resizeManager.ScalingFactors[Lib.ResizeManager.SCALE_BIGGEST],Lib.ResizeManager.ALIGN_BOTTOM);
}
_global.VoiceStatusMovie = this;
var PixelOffsetBottom = 0;
var nNumberOfNotices = 4;
var nScrollInTime = 0.1;
var nFadeOutTime = 0.5;
var nNoticeLifetime = 15;
var nDepthOffset;
var bVoicePanelRaised = new Array();
bVoicePanelRaised[0] = false;
bVoicePanelRaised[1] = false;
bVoicePanelRaised[2] = false;
var avatarX = VoicePanel1.VoiceAnim.DefaultAvatarCT._x;
var avatarY = Panel.VoicePanel1.VoiceAnim.DefaultAvatarCT._y;
var avatarWidth = Panel.VoicePanel1.VoiceAnim.DefaultAvatarCT._width;
var avatarHeight = Panel.VoicePanel1.VoiceAnim.DefaultAvatarCT._height;
var avatarXuid = undefined;
_global.resizeManager.AddListener(this);
stop();
