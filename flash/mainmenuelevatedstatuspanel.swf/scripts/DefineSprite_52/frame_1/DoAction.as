function InitElevatedStatusPanel()
{
   var _loc2_ = _global.CScaleformComponent_MyPersona.IsInventoryValid();
   if(!_loc2_)
   {
      HidePanel();
      return undefined;
   }
   SetElevatedInfoText();
   SetStatusPanel(GetPlayerElevatedStatus());
   SetUpBtnClose();
   ShowPanel();
}
function SetUpBtnClose()
{
   this.Close.Action = function()
   {
      HidePanel();
   };
}
function ShowPanel()
{
   var _loc3_ = _global.MainMenuMovie.Panel.TooltipItemPreview;
   _loc3_.ShowHidePreview(false);
   this._visible = true;
   Bg.onRollOver = function()
   {
   };
   _global.MainMenuMovie.Panel.Blog.EnableInput(false);
   new Lib.Tween(this,"_alpha",mx.transitions.easing.Strong.easeOut,0,100,0.5,true);
   LoadImage(Logo,GetIconsImagePath() + "verified.png",64,64);
   Logo._alpha = 25;
   SetUpScrollButtons();
   trace("-------------------------------this--------------------------------" + this);
}
function HidePanel()
{
   _global.MainMenuMovie.Panel.PlayerProfile.SetElevatedStatusPanel();
   var _loc3_ = new Lib.Tween(this,"_alpha",mx.transitions.easing.Strong.easeOut,100,0,0.5,true);
   _loc3_.onMotionFinished = function()
   {
      this._visible = false;
      _global.MainMenuMovie.Panel.Blog.EnableInput(true);
      unloadMovie(_global.MainMenuMovie.Panel.mcElevatedStatus);
   };
}
function SetStatusPanel(strState)
{
   WarningPanel._visible = false;
   StatusPanel.btnActivate._visible = !(strState == "eligible" || strState == "eligible_with_takeover")?false:true;
   StatusPanel.btnOk._visible = !(strState == "awaiting_cooldown" || strState == "not_identifying" || strState == "timeout" || strState == "elevated")?false:true;
   StatusPanel.btnCheckStatus._visible = !(strState == "checkstatus" || strState == "none" || strState == "not_identifying")?false:true;
   if(strState != "loading" && strState != "checkstatus")
   {
      CancelLoading();
   }
   else
   {
      StatusPanel.Loading._visible = strState != "loading"?false:true;
   }
   trace("----------------------------------strState-------------------------------" + strState);
   switch(strState)
   {
      case "loading":
         SetLoadingStatus();
         break;
      case "checkstatus":
         SetCheckStatus();
         break;
      case "elevated":
         SetElevatedStatus();
         break;
      case "eligible":
         SetEligibleStatus();
         break;
      case "eligible_with_takeover":
         SetStatusPanelTakeover();
         break;
      case "none":
         SetFailedStatusNone();
         break;
      case "not_identifying":
         SetFailedStatusError();
         break;
      case "awaiting_cooldown":
         SetFailedStatusCooldown("awaiting_cooldown","#SFUI_Elevated_Status_Cooldown");
         break;
      case "account_cooldown":
         SetFailedStatusCooldown("account_cooldown","#SFUI_Elevated_Status_AccCooldown");
         break;
      case "timeout":
         SetFailedStatus();
         break;
      default:
         SetCheckStatus();
   }
}
function SetLoadingStatus()
{
   StatusPanel.Loading.Loading.Text.htmlText = "#SFUI_Elevated_Status_Loading";
   StatusPanel.Loading.Bg.onRollOver = function()
   {
   };
   StatusPanel.Loading.Loading.Text.autoSize = "left";
   HorizontalCenterObject(StatusPanel.Loading,StatusPanel.Loading.Loading);
   new Lib.Tween(StatusPanel.Loading,"_y",mx.transitions.easing.Strong.easeOut,StatusPanel.Loading._height * 2,0,0.5,true);
   var numLoop = 0;
   StatusPanel.Loading.onEnterFrame = function()
   {
      if(numLoop % 30 == 0)
      {
         if(numLoop >= 450)
         {
            SetStatusPanel("timeout");
         }
      }
      numLoop++;
   };
}
function CancelLoading()
{
   if(StatusPanel.Loading._visible)
   {
      delete StatusPanel.Loading.onEnterFrame;
      var _loc1_ = new Lib.Tween(StatusPanel.Loading,"_y",mx.transitions.easing.Strong.easeOut,0,StatusPanel.Loading._height * 2,0.5,true);
      _loc1_.onMotionFinished = function()
      {
         StatusPanel.Loading._visible = false;
      };
   }
}
function SetCheckStatus()
{
   StatusPanel.btnCheckStatus.dialog = this;
   StatusPanel.btnCheckStatus.SetText("#SFUI_Elevated_Status_Check_Btn");
   StatusPanel.btnCheckStatus.ButtonText.Text.autoSize = "left";
   StatusPanel.btnCheckStatus.ButtonText.Text._x = 15;
   StatusPanel.btnCheckStatus.Action = function()
   {
      GetPlayerElevatedStatus();
      SetStatusPanel("loading");
   };
   LoadImage(StatusPanel.btnCheckStatus.ImageHolder,GetIconsImagePath() + "refresh.png",14,14);
   StatusPanel.Status.Text.htmlText = "#SFUI_Elevated_Status_Commit";
   VerticalCenterText(StatusPanel.Status.Text,StatusPanel.Status);
   LoadImage(StatusPanel.Status.Image,GetIconsImagePath() + "info.png",18,18);
   StatusPanel.Status.transform.colorTransform = Grey_ColorTransform;
}
function SetEligibleStatus()
{
   StatusPanel.btnActivate.dialog = this;
   StatusPanel.btnActivate.SetText("#SFUI_Elevated_Status_Confirm_Btn");
   StatusPanel.btnActivate.Action = function()
   {
      _global.CScaleformComponent_MyPersona.ActionElevate();
      SetStatusPanel("loading");
   };
   StatusPanel.Status.Text.htmlText = "#SFUI_Elevated_Status_Eligable";
   VerticalCenterText(StatusPanel.Status.Text,StatusPanel.Status);
   LoadImage(StatusPanel.Status.Image,GetIconsImagePath() + "info.png",18,18);
   StatusPanel.Status.transform.colorTransform = Grey_ColorTransform;
}
function SetStatusPanelTakeover()
{
   StatusPanel.btnActivate.dialog = this;
   StatusPanel.btnActivate.SetText("#SFUI_Elevated_Status_Switch_Btn");
   StatusPanel.btnActivate.Action = function()
   {
      ShowWarningPanel();
   };
   StatusPanel.Status.Text.htmlText = "#SFUI_Elevated_Status_Different";
   VerticalCenterText(StatusPanel.Status.Text,StatusPanel.Status);
   LoadImage(StatusPanel.Status.Image,GetIconsImagePath() + "warning.png",18,18);
   StatusPanel.Status.transform.colorTransform = Warning_ColorTransform;
}
function SetFailedStatus()
{
   StatusPanel.Status.Text.htmlText = "#SFUI_Elevated_Status_Error";
   VerticalCenterText(StatusPanel.Status.Text,StatusPanel.Status);
   LoadImage(StatusPanel.Status.Image,GetIconsImagePath() + "info.png",18,18);
   StatusPanel.Status.transform.colorTransform = Warning_ColorTransform;
   StatusPanel.btnOk.dialog = this;
   StatusPanel.btnOk.SetText("#vgui_close");
   StatusPanel.btnOk.Action = function()
   {
      HidePanel();
   };
}
function SetFailedStatusNone()
{
   StatusPanel.btnCheckStatus.dialog = this;
   StatusPanel.btnCheckStatus.SetText("#SFUI_Elevated_Status_Add_Btn");
   StatusPanel.btnCheckStatus.ButtonText.Text.autoSize = "left";
   StatusPanel.btnCheckStatus.ButtonText.Text._x = 15;
   StatusPanel.btnCheckStatus.Action = function()
   {
      _global.CScaleformComponent_SteamOverlay.OpenURL(GetSteamUrl());
   };
   LoadImage(StatusPanel.btnCheckStatus.ImageHolder,GetIconsImagePath() + "external_link.png",14,14);
   StatusPanel.Status.Text.htmlText = "#SFUI_Elevated_Status_NoPhone";
   VerticalCenterText(StatusPanel.Status.Text,StatusPanel.Status);
   LoadImage(StatusPanel.Status.Image,GetIconsImagePath() + "info.png",18,18);
   StatusPanel.Status.transform.colorTransform = Warning_ColorTransform;
}
function SetFailedStatusError()
{
   StatusPanel.btnOk.dialog = this;
   StatusPanel.btnOk.SetText("#vgui_close");
   StatusPanel.btnOk.Action = function()
   {
      HidePanel();
   };
   StatusPanel.btnCheckStatus.dialog = this;
   StatusPanel.btnCheckStatus.SetText("#SFUI_Elevated_Status_Update_Btn");
   StatusPanel.btnCheckStatus.ButtonText.Text.autoSize = "left";
   StatusPanel.btnCheckStatus.ButtonText.Text._x = 15;
   StatusPanel.btnCheckStatus.Action = function()
   {
      _global.CScaleformComponent_SteamOverlay.OpenURL(GetSteamUrl());
   };
   LoadImage(StatusPanel.btnCheckStatus.ImageHolder,GetIconsImagePath() + "external_link.png",14,14);
   StatusPanel.Status.Text.htmlText = "#SFUI_Elevated_Status_Invalid";
   VerticalCenterText(StatusPanel.Status.Text,StatusPanel.Status);
   LoadImage(StatusPanel.Status.Image,GetIconsImagePath() + "info.png",18,18);
   StatusPanel.Status.transform.colorTransform = Warning_ColorTransform;
}
function SetFailedStatusCooldown(strType, strWarningText)
{
   var _loc5_ = _global.CScaleformComponent_MyPersona.GetElevatedTime(strType);
   if(_loc5_ <= 0)
   {
      SetStatusPanel("timeout");
      return undefined;
   }
   var _loc4_ = Math.floor(_loc5_ / 604800);
   trace("-------------------------------------weeks-------------------------------" + _loc4_);
   var _loc3_ = "";
   if(_loc4_ >= 2)
   {
      _loc3_ = _loc4_ <= 1?_global.GameInterface.Translate("#SFUI_Store_Timer_Week"):_global.GameInterface.Translate("#SFUI_Store_Timer_Weeks");
      _loc3_ = _global.ConstructString(_loc3_,_loc4_);
      trace("-------------------------------------strTime-------------------------------" + _loc3_);
   }
   else
   {
      _loc3_ = _global.FormatSecondsToDaysHourString(Number(_loc5_),true,false);
   }
   var _loc6_ = _global.GameInterface.Translate(strWarningText);
   _loc6_ = _global.ConstructString(_loc6_,_loc3_);
   StatusPanel.Status.Text.htmlText = _loc6_;
   VerticalCenterText(StatusPanel.Status.Text,StatusPanel.Status);
   LoadImage(StatusPanel.Status.Image,GetIconsImagePath() + "info.png",18,18);
   StatusPanel.Status.transform.colorTransform = Warning_ColorTransform;
   StatusPanel.btnOk.dialog = this;
   StatusPanel.btnOk.SetText("#vgui_close");
   StatusPanel.btnOk.Action = function()
   {
      HidePanel();
   };
}
function SetElevatedStatus()
{
   StatusPanel.Status.Text.htmlText = "#SFUI_Elevated_Status_Verified";
   VerticalCenterText(StatusPanel.Status.Text,StatusPanel.Status);
   LoadImage(StatusPanel.Status.Image,GetIconsImagePath() + "checkmark.png",18,18);
   StatusPanel.Status.transform.colorTransform = Ok_ColorTransform;
   StatusPanel.btnOk.dialog = this;
   StatusPanel.btnOk.SetText("#vgui_ok");
   StatusPanel.btnOk.Action = function()
   {
      HidePanel();
   };
}
function GetSteamUrl()
{
   if(_global.CScaleformComponent_SteamOverlay.GetAppID() == "710")
   {
      return "https://store.beta.steampowered.com/phone/add";
   }
   return "https://store.steampowered.com/phone/add";
}
function ShowWarningPanel()
{
   WarningPanel._visible = true;
   new Lib.Tween(WarningPanel,"_alpha",mx.transitions.easing.Strong.easeOut,0,100,0.5,true);
   SetUpWarningPanel();
}
function HideWarningPanel()
{
   var _loc1_ = new Lib.Tween(WarningPanel,"_alpha",mx.transitions.easing.Strong.easeOut,100,0,0.5,true);
   _loc1_.onMotionFinished = function()
   {
      WarningPanel._visible = false;
   };
}
function SetUpWarningPanel()
{
   WarningPanel.btnActivate.dialog = this;
   WarningPanel.btnActivate.SetText("#SFUI_Elevated_Status_Switch_Btn");
   WarningPanel.btnActivate.Action = function()
   {
      HideWarningPanel();
      SetStatusPanel("loading");
      _global.CScaleformComponent_MyPersona.ActionElevate("takeover");
   };
   WarningPanel.Close.Action = function()
   {
      HidePanel();
   };
   WarningPanel.Panel.Text.htmlText = "#SFUI_Elevated_Status_Warning";
   VerticalCenterText(WarningPanel.Panel.Text,WarningPanel.Panel);
   LoadImage(WarningPanel.Panel.Image,GetIconsImagePath() + "warning.png",24,24);
   WarningPanel.Panel.transform.colorTransform = Warning_ColorTransform;
   WarningPanel.Bg.onRollOver = function()
   {
   };
}
function UpdateEleveatedStatusPanel()
{
   trace("-------------------------------CALLBACK-ELEVATE--------------------------------");
   SetStatusPanel(GetPlayerElevatedStatus());
}
function GetPlayerElevatedStatus()
{
   return _global.CScaleformComponent_MyPersona.GetElevatedState();
}
function GetEleveatedTime()
{
   return _global.CScaleformComponent_MyPersona.GetElevatedTime();
}
function GetIconsImagePath()
{
   return "images/ui_icons/";
}
function SetElevatedInfoText()
{
   var _loc2_ = _global.GameInterface.Translate("#SFUI_Elevated_Status_Desc");
   var _loc3_ = _global.GameInterface.Translate("#SFUI_Elevated_Status_Faq");
   Text.Desc.htmlText = _loc2_;
   Text.Faq.htmlText = _loc3_;
   Text.FaqHeader.htmlText = "#SFUI_Elevated_Status_Faq_Title";
   Text.Desc.autoSize = "left";
   Text.Faq.Text.autoSize = "left";
   Text.FaqHeader.Text.autoSize = "left";
   Text.FaqHeader._y = Text.Desc._height + 30;
   Text.Line._y = Text.Desc._height + 15;
   Text.Faq._y = Text.FaqHeader._height + Text.FaqHeader._y + 10;
   ResetScroll();
}
function LoadImage(objMap, ImagePath, numWidth, numHeight)
{
   var _loc2_ = new Object();
   _loc2_.onLoadInit = function(target_mc)
   {
      target_mc._width = numWidth;
      target_mc._height = numHeight;
      target_mc.forceSmoothing = true;
   };
   var _loc3_ = ImagePath;
   var _loc1_ = new MovieClipLoader();
   _loc1_.addListener(_loc2_);
   _loc1_.loadClip(_loc3_,objMap);
}
function VerticalCenterText(objText, objBounds)
{
   _global.AutosizeTextDown(objText,8);
   objText.autoSize = "left";
   if(objText._height > objBounds._height)
   {
      objText._height = objBounds._height;
   }
   objText._y = (objBounds._height - objText._height) * 0.5;
}
function HorizontalCenterObject(objBounds, objChild)
{
   objChild._x = (objBounds._width - objChild._width) * 0.5;
}
function SetUpScrollButtons()
{
   ButtonDown.dialog = this;
   ButtonDown.Action = function()
   {
      onDownButton();
   };
   ButtonUp.dialog = this;
   ButtonUp.Action = function()
   {
      onUpButton();
   };
}
function ResetScroll()
{
   Text._y = m_StartPosTExt;
   EnableDisableScrolButtons();
}
function EnableDisableScrolButtons()
{
   trace("-------------------------------------Text._height-----------------------------" + Text._height);
   trace("-------------------------------------Text._height/m_numAmountToScroll -----------------------------" + Text._height / m_numAmountToScroll);
   trace("-------------------------------------m_Page-----------------------------" + m_Page);
   if(m_Page <= 1)
   {
      ButtonUp.setDisabled(true);
   }
   else
   {
      ButtonUp.setDisabled(false);
   }
   if(m_Page >= Math.ceil(Text._height / m_numAmountToScroll))
   {
      ButtonDown.setDisabled(true);
   }
   else
   {
      ButtonDown.setDisabled(false);
   }
}
function onDownButton()
{
   var _loc1_ = new Lib.Tween(Text,"_y",mx.transitions.easing.Strong.easeOut,Text._y,Text._y - m_numAmountToScroll,0.5,true);
   _loc1_.onMotionFinished = function()
   {
      m_Page++;
      EnableDisableScrolButtons();
   };
   ButtonDown.setDisabled(true);
}
function onUpButton()
{
   var _loc1_ = new Lib.Tween(Text,"_y",mx.transitions.easing.Strong.easeOut,Text._y,Text._y + m_numAmountToScroll,0.5,true);
   _loc1_.onMotionFinished = function()
   {
      m_Page--;
      EnableDisableScrolButtons();
   };
   ButtonUp.setDisabled(true);
}
var OkColor = "0x73A332";
var WarningColor = "0xFF9900";
var GreyColor = "0xCCCCCC";
var m_StartPosTExt = 140;
var m_numAmountToScroll = 380;
var m_Page = 1;
var Warning_ColorTransform = new flash.geom.ColorTransform();
Warning_ColorTransform.rgb = parseInt(WarningColor);
var Ok_ColorTransform = new flash.geom.ColorTransform();
Ok_ColorTransform.rgb = parseInt(OkColor);
var Grey_ColorTransform = new flash.geom.ColorTransform();
Grey_ColorTransform.rgb = parseInt(GreyColor);
stop();
