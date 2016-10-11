function InitOverwatchPanel()
{
   var _loc5_ = _global.CScaleformComponent_CompetitiveMatch.HasOngoingMatch();
   var _loc6_ = _global.CScaleformComponent_MyPersona.IsVacBanned();
   var _loc4_ = _global.CScaleformComponent_CompetitiveMatch.GetCooldownSecondsRemaining();
   var _loc3_ = _global.CScaleformComponent_MyPersona.GetMyNotifications();
   var _loc2_ = "";
   if(_loc5_ || _loc6_ || _loc4_ != 0)
   {
      HideOverwatchPanel();
      return undefined;
   }
   if(_loc3_ != "" && _loc3_ != undefined)
   {
      HideOverwatchPanel();
      return undefined;
   }
   _loc2_ = _global.CScaleformComponent_Overwatch.GetAssignedCaseDescription();
   if(_loc2_ == "" || _loc2_ == undefined)
   {
      HideOverwatchPanel();
      return undefined;
   }
   ShowOverwatchPanel();
}
function ShowOverwatchPanel(strCaseDesc)
{
   OverwatchPanel._visible = true;
   OverwatchPanel.DownloadPanel._visible = true;
   OverwatchPanel.WatchPanel._visible = false;
   OverwatchPanel.ProgressPanel._visible = false;
   OverwatchPanel.DownloadPanel.Download.Action = function()
   {
      onDownloadPress();
   };
   OverwatchPanel.DownloadPanel.Download.SetText("#SFUI_Overwatch_Download");
   OverwatchPanel.DownloadPanel.Download.onRollOver = function()
   {
      OverwatchPanel.Tooltip._visible = true;
   };
   OverwatchPanel.DownloadPanel.Download.onRollOut = function()
   {
      OverwatchPanel.Tooltip._visible = false;
   };
   OverwatchPanel.WatchPanel.Watch.Action = function()
   {
      onWatchPress();
   };
   OverwatchPanel.WatchPanel.Watch.SetText("#SFUI_Overwatch_Investigate");
   OverwatchPanel.MoreInfoBtn.Action = function()
   {
      onInfoPress();
   };
   OverwatchPanel.MoreInfoBtn.SetText("#SFUI_Overwatch_Faq_Link");
   ToolTip();
   var _loc4_ = _global.CScaleformComponent_Overwatch.GetAssignedCaseDescription();
   var _loc3_ = _global.GameInterface.Translate("#SFUI_Overwatch_Case_Number");
   _loc3_ = _global.GameInterface.Translate("#SFUI_Overwatch_Case_Number") + " " + _loc4_;
   OverwatchPanel.CaseNumberText.htmlText = _loc3_;
   var _loc2_ = _global.CScaleformComponent_Overwatch.GetEvidencePreparationError();
   if(_loc2_ != "" && _loc2_ != undefined)
   {
      OverwatchPanel.DownloadPanel.Text.htmlText = _loc2_;
      OverwatchPanel.DownloadPanel.Text.textColor = 15187981;
      OverwatchPanel.DownloadPanel.ErrorIcon._visible = true;
      OverwatchPanel.DownloadPanel.Text._x = OverwatchPanel.DownloadPanel.ErrorIcon._x + OverwatchPanel.DownloadPanel.ErrorIcon._width;
   }
   else
   {
      OverwatchPanel.DownloadPanel.Text.htmlText = "#SFUI_Overwatch_Download_Desc";
      OverwatchPanel.WatchPanel.Text.htmlText = "#SFUI_Overwatch_Watch_Desc";
      OverwatchPanel.DownloadPanel.Text.textColor = 9155285;
      OverwatchPanel.DownloadPanel.ErrorIcon._visible = false;
      OverwatchPanel.DownloadPanel.Text._x = OverwatchPanel.DownloadPanel.ErrorIcon._x;
      UpdateProgressBar();
   }
}
function ToolTip()
{
   OverwatchPanel.Tooltip.Text.htmlText = "#SFUI_Overwatch_Tooltip";
   OverwatchPanel.Tooltip.Text.autoSize = true;
   OverwatchPanel.Tooltip.Background._height = OverwatchPanel.Tooltip.Text._height + 30;
}
function onDownloadPress()
{
   _global.CScaleformComponent_Overwatch.StartDownloadingCaseEvidence();
}
function onWatchPress()
{
   _global.CScaleformComponent_Overwatch.PlaybackEvidence();
}
function onInfoPress()
{
   _global.CScaleformComponent_SteamOverlay.OpenURL("http://blog.counter-strike.net/index.php/overwatch/");
}
function UpdateProgressBar()
{
   var _loc2_ = _global.CScaleformComponent_Overwatch.GetEvidencePreparationPercentage();
   var _loc4_ = _global.CScaleformComponent_Overwatch.GetEvidencePreparationError();
   if(_loc2_ == 100)
   {
      OverwatchPanel.DownloadPanel._visible = false;
      OverwatchPanel.WatchPanel._visible = true;
      OverwatchPanel.ProgressPanel._visible = false;
      return undefined;
   }
   if(_loc2_ > 0)
   {
      OverwatchPanel.DownloadPanel._visible = false;
      OverwatchPanel.WatchPanel._visible = false;
      OverwatchPanel.ProgressPanel._visible = true;
      var _loc3_ = Math.floor(_loc2_ / 10 * 3);
      OverwatchPanel.ProgressPanel.ProgressBar.gotoAndStop(_loc3_);
   }
}
function HideOverwatchPanel()
{
   OverwatchPanel._visible = false;
}
OverwatchPanel.Tooltip._visible = false;
OverwatchPanel._visible = false;
this.stop();
