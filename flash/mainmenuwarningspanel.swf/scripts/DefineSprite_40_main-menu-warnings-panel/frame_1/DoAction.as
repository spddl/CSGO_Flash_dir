function GetWarnings()
{
   if(m_bIsFadingOut)
   {
      return undefined;
   }
   this._alpha = 100;
   var _loc4_ = false;
   var _loc7_ = false;
   var _loc5_ = 0;
   var _loc3_ = "";
   _loc4_ = _global.CScaleformComponent_CompetitiveMatch.HasOngoingMatch();
   _loc7_ = _global.CScaleformComponent_MyPersona.IsVacBanned();
   _loc5_ = _global.CScaleformComponent_CompetitiveMatch.GetCooldownSecondsRemaining();
   _loc3_ = _global.CScaleformComponent_MyPersona.GetMyNotifications();
   var _loc6_ = false;
   if(_loc3_ != "" && _loc3_ != undefined)
   {
      _loc6_ = true;
   }
   if(!_loc4_)
   {
      _global.MainMenuMovie.Panel.SelectPanel.EnableDisablePlayCatagory(false);
   }
   if(!_loc4_ && !_loc7_ && _loc5_ == 0 && !_loc6_)
   {
      HideWarningsPanel();
      return undefined;
   }
   if(_loc4_)
   {
      ShowReconnect();
      return undefined;
   }
   if(_loc7_)
   {
      ShowVacBanned();
      return undefined;
   }
   if(_loc5_ != 0)
   {
      ShowMMBan();
      return undefined;
   }
   if(_loc6_)
   {
      var _loc8_ = _loc3_.split(",");
      ShowMessages(_loc8_);
      return undefined;
   }
}
function ShowReconnect()
{
   _global.MainMenuMovie.Panel.SelectPanel.EnableDisablePlayCatagory(true);
   Title.htmlText = "#SFUI_MainMenu_Reconnect_Info";
   Bar.transform.colorTransform = this.YELLOW;
   ReconnectPanel.ResumeButton.Action = function()
   {
      onResumeButton();
   };
   ReconnectPanel.ResumeButton.SetText("#SFUI_MainMenu_Reconnect");
   ReconnectPanel.AbandonButton.Action = function()
   {
      onAbandonButton();
   };
   ReconnectPanel.AbandonButton.SetText("#SFUI_MainMenu_Abandon");
   ShowWarningsPanel(0);
}
function ShowVacBanned()
{
   Bar.transform.colorTransform = this.YELLOW;
   Title.htmlText = "#SFUI_MainMenu_Vac_Title";
   InfoPanel.Info.htmlText = "#SFUI_MainMenu_Vac_Info";
   InfoPanel.Info.textColor = 14795025;
   ShowWarningsPanel(1);
}
function CenterText()
{
   if(m_CenteredText == false)
   {
      _global.AutosizeTextDown(InfoPanel.Info,8);
      InfoPanel.Info.autoSize = true;
      InfoPanel.Info._y = InfoPanel._height * 0.5 - InfoPanel._height * 0.5;
      m_CenteredText = true;
   }
}
function ShowMMBan()
{
   var _loc6_ = _global.CScaleformComponent_CompetitiveMatch.GetCooldownSecondsRemaining();
   var _loc3_ = _global.CScaleformComponent_CompetitiveMatch.GetCooldownType();
   var _loc5_ = _global.CScaleformComponent_CompetitiveMatch.GetCooldownReason();
   var _loc4_ = false;
   trace("----------------------------------------------------------------strReason: " + _loc5_);
   trace("----------------------------------------------------------------strType: " + _loc3_);
   if(!m_bSetText)
   {
      InfoPanel.Info.htmlText = _loc5_;
      _global.AutosizeTextDown(InfoPanel.Info,8);
      InfoPanel.Info.autoSize = "left";
      InfoPanel.Info._y = (InfoPanel._height - InfoPanel.Info._height) / 2;
      if(_loc3_ == "global")
      {
         Bar.transform.colorTransform = this.RED;
         InfoPanel.Info.textColor = 12451840;
         _loc4_ = true;
         Title.htmlText = "#SFUI_MainMenu_Global_Ban_Title";
      }
      if(_loc3_ == "green")
      {
         Bar.transform.colorTransform = this.GREEN;
         InfoPanel.Info.textColor = 9547593;
         _loc4_ = false;
         Title.htmlText = "#SFUI_MainMenu_Temporary_Ban_Title";
         InfoPanel.Info.autoSize = true;
         InfoPanel.Info._y = InfoPanel._height * 0.5 - InfoPanel.Info._height * 0.5;
      }
      if(_loc3_ == "competitive")
      {
         Bar.transform.colorTransform = this.YELLOW;
         InfoPanel.Info.textColor = 14795025;
         _loc4_ = false;
         Title.htmlText = "#SFUI_MainMenu_Competitive_Ban_Title";
      }
   }
   if(_loc6_ < 0)
   {
      Bar.transform.colorTransform = this.YELLOW;
      _loc4_ = false;
      if(!m_bSetText)
      {
         Title.htmlText = "#SFUI_MainMenu_Competitive_Ban_Confirm_Title";
         BanTime.htmlText = "";
         AcknowlegePanel.Info.htmlText = _global.GameInterface.Translate("#SFUI_CooldownExplanationReason_Expired_Cooldown") + _global.GameInterface.Translate(_loc5_);
         AcknowlegePanel.Info.textColor = 14795025;
         _global.AutosizeTextDown(AcknowlegePanel.Info,8);
         AcknowlegePanel.Info.autoSize = "left";
         AcknowlegePanel.Info._y = Math.floor((AcknowlegePanel._height - AcknowlegePanel.Info._height) / 2);
         AcknowlegePanel.AcknowlegeButton._visible = true;
         AcknowlegePanel.AcknowlegeButtonBlue._visible = false;
         AcknowlegePanel.AcknowlegeButton.Action = function()
         {
            AnimHidePanel(onConfirmButton());
         };
         AcknowlegePanel.AcknowlegeButton.SetText("#SFUI_MainMenu_ConfirmBan");
      }
   }
   else
   {
      BanTime.htmlText = _global.FormatSecondsToDaysHourString(_loc6_,true);
   }
   ShowWarningsPanel(2,_loc6_);
}
function ShowMessages(aNotifications)
{
   var _loc4_ = false;
   if(!m_bSetText)
   {
      AcknowlegePanel.AcknowlegeButton._visible = false;
      AcknowlegePanel.AcknowlegeButtonBlue._visible = false;
      OverwatchIcon._visible = false;
      AcknowlegePanel.Info.htmlText = "#SFUI_PersonaNotification_Msg_" + aNotifications[0];
      _global.AutosizeTextDown(AcknowlegePanel.Info,8);
      AcknowlegePanel.Info.autoSize = "left";
      AcknowlegePanel.Info._y = Math.ceil((AcknowlegePanel._height - AcknowlegePanel.Info._height) / 2);
      if(aNotifications[0] == 6)
      {
         Bar.transform.colorTransform = this.YELLOW;
         AcknowlegePanel.Info.textColor = 14795025;
         AcknowlegePanel.AcknowlegeButton._visible = true;
         AcknowlegePanel.AcknowlegeButton.Action = function()
         {
            AnimHidePanel(onActionAcknowledgeNotifications());
         };
         AcknowlegePanel.AcknowlegeButton.SetText("#SFUI_MainMenu_ConfirmBan");
      }
      else
      {
         Bar.transform.colorTransform = this.BLUE;
         AcknowlegePanel.Info.textColor = 9155285;
         OverwatchIcon._visible = true;
         AcknowlegePanel.AcknowlegeButtonBlue._visible = true;
         AcknowlegePanel.AcknowlegeButtonBlue.Action = function()
         {
            AnimHidePanel(onActionAcknowledgeNotifications());
         };
         AcknowlegePanel.AcknowlegeButtonBlue.SetText("#SFUI_MainMenu_ConfirmBan");
      }
      Title.htmlText = "#SFUI_PersonaNotification_Title_" + aNotifications[0];
   }
   ShowWarningsPanel(3,0);
}
function LoadIcon(numWidth, numHeight, MovieName, objIcon)
{
   var _loc2_ = new Object();
   _loc2_.onLoadInit = function(target_mc)
   {
      target_mc._width = numWidth;
      target_mc._height = numHeight;
      target_mc.forceSmoothing = true;
   };
   var _loc1_ = new MovieClipLoader();
   _loc1_.addListener(_loc2_);
   _loc1_.loadClip(MovieName,objIcon);
}
function ShowWarningsPanel(numPanelToShow, numBanSec)
{
   InfoIcon._visible = false;
   WarningIcon._visible = false;
   AcknowlegePanel._visible = false;
   m_bSetText = true;
   switch(numPanelToShow)
   {
      case 0:
         ReconnectPanel._visible = true;
         InfoPanel._visible = false;
         BanTime._visible = false;
         OverwatchIcon._visible = false;
         break;
      case 1:
         ReconnectPanel._visible = false;
         InfoPanel._visible = true;
         BanTime._visible = false;
         WarningIcon._visible = true;
         OverwatchIcon._visible = false;
         break;
      case 2:
         ReconnectPanel._visible = false;
         OverwatchIcon._visible = false;
         InfoPanel._visible = true;
         var _loc1_ = Math.floor(numBanSec / 86400);
         if(_loc1_ > 49)
         {
            BanTime._visible = false;
         }
         else
         {
            BanTime._visible = true;
         }
         InfoIcon._visible = true;
         if(numBanSec < 0)
         {
            InfoPanel._visible = false;
            AcknowlegePanel._visible = true;
         }
         break;
      case 3:
         ReconnectPanel._visible = false;
         InfoPanel._visible = false;
         BanTime._visible = false;
         InfoIcon._visible = !OverwatchIcon._visible;
         AcknowlegePanel._visible = true;
   }
   Bg._visible = true;
   Title._visible = true;
   Bar._visible = true;
}
function onResumeButton()
{
   _global.CScaleformComponent_CompetitiveMatch.ActionReconnectToOngoingMatch();
}
function onAbandonButton()
{
   _global.CScaleformComponent_CompetitiveMatch.ActionAbandonOngoingMatch();
}
function onConfirmButton()
{
   _global.CScaleformComponent_CompetitiveMatch.ActionAcknowledgePenalty();
}
function onActionAcknowledgeNotifications()
{
   _global.CScaleformComponent_MyPersona.ActionAcknowledgeNotifications();
}
function HideWarningsPanel()
{
   InfoIcon._visible = false;
   WarningIcon._visible = false;
   Title._visible = false;
   InfoPanel._visible = false;
   ReconnectPanel._visible = false;
   Bar._visible = false;
   Bg._visible = false;
   BanTime._visible = false;
   AcknowlegePanel._visible = false;
   OverwatchIcon._visible = false;
   m_bSetText = false;
}
function AnimHidePanel(FunctionToCall)
{
   m_bIsFadingOut = true;
   this.onEnterFrame = function()
   {
      if(this._alpha > 0)
      {
         this._alpha = this._alpha - 18;
      }
      else
      {
         FunctionToCall;
         this._alpha = 100;
         m_bIsFadingOut = false;
         HideWarningsPanel();
         delete this.onEnterFrame;
      }
   };
}
var strColorRed = "0xBE0000";
var strColorYellow = "0xE1C111";
var strColorGreen = "0x91AF49";
var strColorBlue = "0x417ca9";
var RED = new flash.geom.ColorTransform();
RED.rgb = parseInt(strColorRed);
var YELLOW = new flash.geom.ColorTransform();
YELLOW.rgb = parseInt(strColorYellow);
var GREEN = new flash.geom.ColorTransform();
GREEN.rgb = parseInt(strColorGreen);
var BLUE = new flash.geom.ColorTransform();
BLUE.rgb = parseInt(strColorBlue);
var m_CenteredText = false;
var m_bSetText = false;
var m_bIsFadingOut = false;
HideWarningsPanel();
this.stop();
