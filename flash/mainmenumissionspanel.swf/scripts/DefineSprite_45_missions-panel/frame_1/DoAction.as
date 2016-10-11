function InitMissionsPanel()
{
   var _loc1_ = DoesPlayerOwnOperation();
   if(_loc1_ && !IsLobby())
   {
      ShowMissionsPanel();
      if(_loc1_)
      {
         SetUpCampaignPanel();
      }
      SetUpGlobalMission();
      SetFriendsPanelPos(3);
      MissionsPanel.Background.Bg.Rect._height = DEFAULT_PANEL_HEIGHT;
      StartUpdateTimer(12);
   }
   SetFriendsPanelPos(0);
   MissionsPanel._visible = false;
   return undefined;
}
function DoesPlayerOwnOperation()
{
   var _loc2_ = GetActiveSeasonNumber();
   if(_loc2_ == -1)
   {
      return false;
   }
   var _loc3_ = _global.CScaleformComponent_MyPersona.GetMyMedalRankByType(_loc2_ + 1 + "Operation$OperationCoin");
   if(_loc3_ >= 2)
   {
      return true;
   }
   return false;
}
function CheckIfGlobalMissionIsActive()
{
   var _loc2_ = _global.CScaleformComponent_Inventory.GetQuestEventCount();
   if(_loc2_ > 0)
   {
      return true;
   }
}
function GetActiveSeasonNumber()
{
   return _global.CScaleformComponent_GameTypes.GetActiveSeasionIndexValue();
}
function ShowMissionsPanel()
{
   MissionsPanel._visible = true;
   MissionPanel.GlobalMission._visible = false;
   MissionsPanel.CampaignPanel._visible = false;
}
function HideMissionsPanel()
{
   StopUpdateTimer();
   MissionsPanel._y = StartPos;
   MissionsPanel._visible = false;
}
function SetUpGlobalMission()
{
   var _loc9_ = false;
   var _loc6_ = _global.CScaleformComponent_Inventory.GetActiveQuest();
   var _loc7_ = _global.CScaleformComponent_Inventory.GetUpcomingQuestEvents(1);
   var _loc5_ = new Array();
   var _loc4_ = new Array();
   if(_loc6_ != "" && _loc6_ != null && _loc6_ != undefined)
   {
      var _loc8_ = _loc6_.split(",",2);
      if(Number(_loc8_[1]) > 1)
      {
         _loc5_.push(_loc8_[0]);
         _loc4_.push(_loc8_[1]);
         _loc9_ = true;
      }
      UpdateGlobalMissionTile(_loc9_,_loc5_,_loc4_,bIslsInLobby);
      return undefined;
   }
   if(_loc7_ != "" && _loc7_ != null && _loc7_ != undefined)
   {
      var _loc3_ = _loc7_.split(",");
      var _loc2_ = 0;
      while(_loc2_ < _loc3_.length)
      {
         if(_loc2_ % 2)
         {
            _loc4_.push(_loc3_[_loc2_]);
         }
         else
         {
            _loc5_.push(_loc3_[_loc2_]);
         }
         _loc2_ = _loc2_ + 1;
      }
      UpdateGlobalMissionTile(_loc9_,_loc5_,_loc4_,bIslsInLobby);
   }
}
function UpdateGlobalMissionTile(bHasActiveGlobalMission, aGlobalMissionsId, aGlobalMissionsDate, bIslsInLobby)
{
   var _loc4_ = _global.CScaleformComponent_Inventory.GetQuestItemIDFromQuestID(Number(aGlobalMissionsId[0]));
   var _loc9_ = SeperateName(_global.CScaleformComponent_Inventory.GetItemName(m_PlayerXuid,_loc4_));
   var _loc6_ = _global.CScaleformComponent_Inventory.GetItemDescription(m_PlayerXuid,_loc4_,"default,-detailedinfo");
   var _loc7_ = _global.CScaleformComponent_Inventory.GetItemDescription(m_PlayerXuid,_loc4_,"detailedinfo");
   var strToolTipText = _global.GameInterface.Translate("#SFUI_Missions_Global_ToolTip");
   var _loc5_ = "";
   var srtTooltip = "";
   var _loc8_ = false;
   MissionsPanel.Calender._alpha = 100;
   MissionsPanel.Calender.onRollOver = function()
   {
      RollOverScheduleToolTip(this,true);
   };
   MissionsPanel.Calender.onRollOut = function()
   {
      RollOverScheduleToolTip(this,false);
   };
   var _loc3_ = MissionsPanel.Global;
   _loc3_._visible = true;
   _loc3_.Journal._visible = false;
   _loc3_._MeetsRankRestriction = false;
   if(!MeetsRankRestriction())
   {
      _loc3_._MeetsRankRestriction = true;
      _loc3_.RankWarning._visible = true;
      _loc3_.Active._visible = false;
      _loc3_.Icon._alpha = 30;
      LoadImage(_loc3_.Icon.Image,"images/ui_icons/global.png",28,28);
      strToolTipText = strToolTipText + "\n\n" + _global.GameInterface.Translate("#SFUI_Stirke_Xp_Info");
      _loc3_.Hitbox.onRollOver = function()
      {
         RollOverMissionToolTip(this,true,strToolTipText);
      };
      _loc3_.Hitbox.onRollOut = function()
      {
         RollOverMissionToolTip(this,false,"");
      };
      _global.AutosizeTextDown(_loc3_.RankWarning.Title,6);
      _global.AutosizeTextDown(_loc3_.RankWarning.Status,6);
      _loc3_.gotoAndStop("RankWarning");
      return undefined;
   }
   _loc3_.Active._ItemID = _loc4_;
   _loc3_.Active._GameMode = _global.CScaleformComponent_Inventory.GetQuestGameMode(m_PlayerXuid,_loc4_);
   _loc3_.Active._Map = _global.CScaleformComponent_Inventory.GetQuestMap(m_PlayerXuid,_loc4_);
   _loc3_.Active._MapGroup = _global.CScaleformComponent_Inventory.GetQuestMapGroup(m_PlayerXuid,_loc4_);
   _loc3_.Icon._alpha = 100;
   _global.AutosizeTextDown(_loc3_.Info.Title.Text,10);
   if(bHasActiveGlobalMission)
   {
      _loc5_ = _global.GameInterface.Translate("#SFUI_Missions_Title_Global_Time_Left");
      _loc5_ = _global.ConstructString(_loc5_,aGlobalMissionsDate[0]);
      _loc3_.Info.Status.htmlText = "<font color=\'#98C840\'>" + _loc5_ + "</font>";
      srtTooltip = strToolTipText + "\n\n" + "<b>" + _loc5_ + "</b>\n" + _loc6_ + "\n" + _loc7_;
      _loc3_.Info.Title.htmlText = "#SFUI_Missions_Title_Global_Active";
      _loc3_.Active.dialog = this;
      _loc3_.Active.Action = function()
      {
         this.dialog.onPlay(this);
      };
      _loc3_.Active.setDisabled(false);
      _loc3_.Active._visible = true;
      _loc3_.Active.onRollOver = function()
      {
         RollOverMissionToolTip(this,true,srtTooltip);
      };
      _loc3_.Active.onRollOut = function()
      {
         RollOverMissionToolTip(this,false,"");
      };
      _loc3_.Icon._alpha = 25;
      _loc3_.gotoAndStop("Active");
   }
   else
   {
      _loc3_.Active.setDisabled(true);
      _loc3_.Active._visible = false;
      _loc3_.Icon._alpha = 100;
      _loc3_.Info.Title.htmlText = "#SFUI_Missions_Title_Global_Upcoming";
      srtTooltip = strToolTipText;
      _loc3_.gotoAndStop("ShowInfo");
      _loc3_.Hitbox.onRollOver = function()
      {
         RollOverMissionToolTip(this,true,srtTooltip);
      };
      _loc3_.Hitbox.onRollOut = function()
      {
         RollOverMissionToolTip(this,false,"");
      };
   }
   LoadMissionIcon(_loc3_.Active,_loc3_.ModeIcon);
   _loc3_.Desc.Text.htmlText = _loc6_;
   _global.AutosizeTextDown(_loc3_.Desc.Text,6);
   _global.AutosizeTextDown(_loc3_.Info.Status,6);
   LoadImage(_loc3_.Icon.Image,"images/ui_icons/global.png",28,28);
   _loc3_._alpha = 100;
}
function MeetsRankRestriction()
{
   var _loc2_ = _global.CScaleformComponent_MyPersona.HasPrestige();
   var _loc3_ = _global.CScaleformComponent_FriendsList.GetFriendLevel(m_PlayerXuid);
   if(_loc2_ || _loc3_ >= 3)
   {
      return true;
   }
   return false;
}
function StartUpdateTimer(numTimeForLoop, bIsActive)
{
   var numCount = 0;
   UpdateGlobalMissionTimer();
   MissionsPanel.onEnterFrame = function()
   {
      var _loc2_ = MissionsPanel.Global;
      if(numCount == numTimeForLoop)
      {
         var _loc3_ = 2;
         if(!_loc2_._MeetsRankRestriction)
         {
            if(!_loc2_.Active._visible)
            {
               UpdateGlobalMissionTimer();
            }
            SetUpGlobalMission();
         }
         var _loc1_ = 0;
         while(_loc1_ < _loc3_)
         {
            _loc2_ = MissionsPanel["Tile" + _loc1_];
            if(_loc2_._ShowOutOfMissionsTimer)
            {
               if(IsOutOfMissions())
               {
                  UpdateOutOfMissionsTimer(_loc2_);
               }
               else
               {
                  SetUpCampaignPanel();
               }
            }
            _loc1_ = _loc1_ + 1;
         }
         numCount = 0;
      }
      numCount++;
   };
}
function UpdateGlobalMissionTimer()
{
   var _loc4_ = _global.CScaleformComponent_Inventory.GetUpcomingQuestEvents(1);
   var _loc3_ = _loc4_.split(",");
   var _loc2_ = 0;
   while(_loc2_ < _loc3_.length)
   {
      if(_loc2_ % 2)
      {
         SetUpcomingGlobalMissionTimerText(_loc3_[_loc2_]);
      }
      _loc2_ = _loc2_ + 1;
   }
}
function SetUpcomingGlobalMissionTimerText(Time)
{
   var _loc3_ = MissionsPanel.Global;
   var _loc2_ = "";
   _loc2_ = _global.GameInterface.Translate("#quest_event_timer");
   _loc2_ = _global.ConstructString(_loc2_,"<b>" + _global.FormatSecondsToDaysHourString(Number(Time),true,true) + "</b>");
   _loc3_.Info.Status.htmlText = "<font color=\'#6B92AD\'>" + _loc2_ + "</font>";
}
function UpdateOutOfMissionsTimer(objTile)
{
   var _loc2_ = "";
   var _loc3_ = _global.CScaleformComponent_Inventory.GetSecondsUntilNextMission();
   _loc2_ = _global.GameInterface.Translate("#CSGO_Journal_Mission_Timer_hr");
   _loc2_ = _global.ConstructString(_loc2_,"<b>" + _global.FormatSecondsToDaysHourString(_loc3_,true,true) + "</b>");
   objTile.Info.Status.htmlText = "<font color=\'#6B92AD\'>" + _loc2_ + "</font>";
   _global.AutosizeTextDown(objTile.Info.Status,7);
}
function IsOutOfMissions()
{
   var _loc3_ = _global.CScaleformComponent_Inventory.GetMissionBacklog();
   var _loc2_ = _global.CScaleformComponent_Inventory.GetSecondsUntilNextMission();
   var _loc4_ = false;
   if(_loc3_ <= 0 && _loc2_ > 0)
   {
      return true;
   }
   return false;
}
function StopUpdateTimer()
{
   delete this.MissionsPanel.onEnterFrame;
}
function SetUpCampaignPanel()
{
   var _loc8_ = GetActionMissionID();
   var _loc18_ = 2;
   var _loc17_ = false;
   var _loc19_ = _global.GameInterface.Translate("#CSGO_Journal_Mission_Timer_day_hr");
   _loc17_ = IsOutOfMissions();
   var _loc4_ = 0;
   while(_loc4_ < _loc18_)
   {
      var _loc16_ = FindNumMissionsThatMatchState(m_aCampaignIndex[_loc4_],"active");
      var _loc3_ = MissionsPanel["Tile" + _loc4_];
      _loc3_._visible = true;
      _loc3_.Journal._visible = false;
      _loc3_.RankWarning._visible = false;
      _loc3_._ShowOutOfMissionsTimer = false;
      var _loc7_ = _global.GameInterface.Translate("#csgo_campaign_" + m_aCampaignIndex[_loc4_] + "_desc");
      _loc3_.Journal._visible = true;
      _loc3_.Journal.dialog = this;
      _loc3_.Journal._CampaignIndex = "campaign" + m_aCampaignIndex[_loc4_];
      _loc3_.Journal.Action = function()
      {
         this.dialog.AssignContextMenuAction(this._CampaignIndex);
      };
      if(_loc8_ != 0 && _loc8_ != null && _loc8_ != undefined && _loc16_ >= 1)
      {
         var _loc12_ = _global.CScaleformComponent_Inventory.GetCampaignFromQuestID(_loc8_);
         var _loc13_ = _global.CScaleformComponent_Inventory.GetCampaignNodeFromQuestID(_loc8_);
         var _loc5_ = _global.CScaleformComponent_Inventory.GetAQuestItemIDGivenCampaignNodeID(_loc13_,_loc12_);
         var _loc14_ = SeperateName(_global.CScaleformComponent_Inventory.GetItemName(m_PlayerXuid,_loc5_));
         var _loc10_ = _global.CScaleformComponent_Inventory.GetItemDescription(m_PlayerXuid,_loc5_,"default,-detailedinfo");
         var _loc11_ = _global.CScaleformComponent_Inventory.GetItemDescription(m_PlayerXuid,_loc5_);
         _loc7_ = _loc7_ + "\n\n<b>" + _loc14_ + "</b>\n" + _loc11_;
         _loc3_.Active.setDisabled(false);
         _loc3_.Active._visible = true;
         _loc3_.Active.dialog = this;
         _loc3_.Active._index = m_aCampaignIndex[_loc4_];
         _loc3_.Active._ItemID = _loc5_;
         _loc3_.Active._GameMode = _global.CScaleformComponent_Inventory.GetQuestGameMode(m_PlayerXuid,_loc5_);
         _loc3_.Active._Map = _global.CScaleformComponent_Inventory.GetQuestMap(m_PlayerXuid,_loc5_);
         _loc3_.Active._MapGroup = _global.CScaleformComponent_Inventory.GetQuestMapGroup(m_PlayerXuid,_loc5_);
         _loc3_.Active.Action = function()
         {
            this.dialog.onPlay(this);
         };
         _loc3_.Active._Tooltip = _loc7_;
         _loc3_.Icon._alpha = 10;
         _loc3_.Active.RolledOver = function()
         {
            RollOverMissionToolTip(this._parent,true,this._Tooltip);
         };
         _loc3_.Active.RolledOut = function()
         {
            RollOverMissionToolTip(this._parent,false,"");
         };
         _loc3_.gotoAndStop("Active");
         _loc3_.ModeIcon._visible = true;
         LoadMissionIcon(_loc3_.Active,_loc3_.ModeIcon);
         _loc3_.Desc.Text.htmlText = _loc10_;
         _loc3_.Desc._visible = true;
         _loc3_.Info.Status.htmlText = "<font color=\'#98C840\'>#SFUI_Missions_Play_Active</font>";
         _loc3_.Hitbox._Tooltip = _loc7_;
         _loc3_.Hitbox.onRollOver = function()
         {
            RollOverMissionToolTip(this._parent,true,this._Tooltip);
         };
         _loc3_.Hitbox.onRollOut = function()
         {
            RollOverMissionToolTip(this._parent,false,"");
         };
      }
      else
      {
         var _loc9_ = FindNumMissionsThatMatchState(m_aCampaignIndex[_loc4_],"accessible");
         var _loc6_ = "";
         _loc3_.Active.setDisabled(true);
         _loc3_.Active._visible = false;
         _loc3_.Icon._alpha = 100;
         _loc3_.ModeIcon._visible = false;
         _loc3_.Desc.Text.htmlText = _loc10_;
         if(_loc9_ > 0 && !_loc17_)
         {
            if(_loc9_ > 1)
            {
               _loc6_ = _global.GameInterface.Translate("#CSGO_Journal_Missions_Accessible");
            }
            else
            {
               _loc6_ = _global.GameInterface.Translate("#CSGO_Journal_Mission_Accessible");
            }
            _loc6_ = _global.ConstructString(_loc6_,_loc9_);
            _loc3_.Info.Status.htmlText = "<font color=\'#6B92AD\'>" + _loc6_ + "</font>";
            _global.AutosizeTextDown(_loc3_.Info.Status,7);
         }
         else if(_loc17_)
         {
            _loc3_._ShowOutOfMissionsTimer = true;
         }
         else
         {
            _loc6_ = "#CSGO_Journal_Campaign_Complete";
            _loc3_.Info.Status.htmlText = "<font color=\'#6B92AD\'>" + _loc6_ + "</font>";
            _global.AutosizeTextDown(_loc3_.Info.Status,7);
         }
         _loc3_.gotoAndStop("Choose");
         _loc3_.Journal._Tooltip = _loc7_;
         _loc3_.Journal.RolledOver = function()
         {
            RollOverMissionToolTip(this._parent,true,this._Tooltip);
         };
         _loc3_.Journal.RolledOut = function()
         {
            RollOverMissionToolTip(this._parent,false,"");
         };
      }
      _loc3_.Info.Title.htmlText = "#csgo_campaign_" + m_aCampaignIndex[_loc4_];
      var _loc15_ = "images/journal/campaign/logo_" + m_aCampaignIndex[_loc4_] + "_small" + ".png";
      LoadImage(_loc3_.Icon.Image,_loc15_,28,28);
      _loc3_.Icon._y = _loc3_.Info._y + 2;
      _global.AutosizeTextDown(_loc3_.Desc.Text,6);
      _global.AutosizeTextDown(_loc3_.Info.Status,6);
      _loc3_._alpha = 100;
      _loc3_.Journal.setDisabled(false);
      _loc4_ = _loc4_ + 1;
   }
}
function LoadMissionIcon(objMission, objImageHolder)
{
   var _loc3_ = _global.CScaleformComponent_Inventory.GetQuestIcon(m_PlayerXuid,objMission._ItemID);
   if(_loc3_ == "" || _loc3_ == undefined)
   {
      if(objMission._GameMode == "casual" || objMission._GameMode == "competitive")
      {
         if(!HasMapSpecified(objMission._Map))
         {
            _loc3_ = _global.GameInterface.Translate(_global.CScaleformComponent_GameTypes.GetMapGroupAttribute(objMission._MapGroup,"icontag"));
         }
         else
         {
            _loc3_ = _global.GameInterface.Translate(_global.CScaleformComponent_GameTypes.GetMapGroupAttribute("mg_" + objMission._Map,"icontag"));
         }
      }
      else
      {
         _loc3_ = objMission._GameMode;
      }
   }
   objImageHolder.attachMovie("icon-" + _loc3_,"missionicon",1000000);
   var _loc5_ = 25;
   if(objImageHolder.missionicon._height > objImageHolder.missionicon._width)
   {
      var _loc6_ = objImageHolder.missionicon._height / objImageHolder.missionicon._width;
      objImageHolder.missionicon._width = _loc5_ / _loc6_;
      objImageHolder.missionicon._height = _loc5_;
   }
   else
   {
      _loc6_ = objImageHolder.missionicon._width / objImageHolder.missionicon._height;
      objImageHolder.missionicon._width = _loc5_;
      objImageHolder.missionicon._height = _loc5_ / _loc6_;
   }
   objImageHolder.missionicon._x = objImageHolder.missionicon._x - _loc5_ / 2;
   objImageHolder.missionicon._y = objImageHolder.missionicon._y - objImageHolder.missionicon._height / 2;
}
function HasMapSpecified(strMap)
{
   if(strMap == "" || strMap == undefined || strMap == null || strMap == " ")
   {
      return false;
   }
   return true;
}
function VerticalCenterText(objText, objBounds)
{
   objText.autoSize = "left";
   if(objText._height > objBounds._height)
   {
      objText._height = objBounds._height;
   }
   objText._y = (objBounds._height - objText._height) * 0.5;
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
function OpenJournal(ItemID, Page, bOpenToPage)
{
   var _loc2_ = _global.CScaleformComponent_Inventory.GetItemAttributeValue(m_PlayerXuid,ItemID,"season access");
   _global.MainMenuMovie.Panel.JournalPanel._visible = true;
   _global.MainMenuMovie.Panel.JournalPanel.Journal.ShowPanel(Page,ItemID,_loc2_,bOpenToPage);
}
function IsLobby()
{
   if(_global.LobbyMovie && !_global.MainMenuMovie.Panel.MissionsPanel._visible)
   {
      return true;
   }
   return false;
}
function GetActionMissionID()
{
   var _loc2_ = _global.CScaleformComponent_Inventory.GetActiveSeasonCoinItemId(m_PlayerXuid);
   var _loc3_ = _global.CScaleformComponent_Inventory.GetItemAttributeValue(m_PlayerXuid,_loc2_,"quest id");
   return _loc3_;
}
function SeperateName(strName)
{
   if(strName.indexOf("|  ") != -1)
   {
      var _loc2_ = strName.split("|  ",2);
   }
   else if(strName.indexOf("| ") != -1)
   {
      _loc2_ = strName.split("| ",2);
   }
   else
   {
      _loc2_ = new Array(strName);
   }
   if(_loc2_.length == 1)
   {
      return _loc2_[0];
   }
   return _loc2_[1];
}
function FormatDate(strData)
{
   if(strData.indexOf("\n") != -1)
   {
      var _loc1_ = strData.split("\n",2);
   }
   else
   {
      _loc1_ = new Array(strData);
   }
   if(_loc1_.length <= 1)
   {
      return _loc1_[0];
   }
   var _loc2_ = "<font size=\'8\'>" + _loc1_[0] + "</font>\n<b>" + _loc1_[1] + "</b>";
   return _loc2_;
}
function OpenContextMenu(objTile)
{
   if(IsLobby())
   {
      return undefined;
   }
   var _loc11_ = _global.MainMenuMovie.Panel.TooltipContextMenu;
   var _loc14_ = {x:objTile._x + objTile._width,y:objTile._y};
   var _loc8_ = [];
   var _loc9_ = [];
   _loc8_.push("toc");
   _loc9_.push("#SFUI_InvContextMenu_Journal");
   var _loc3_ = m_aCampaignIndex.length - 1;
   while(_loc3_ >= 0)
   {
      var _loc4_ = FindNumMissionsThatMatchState(m_aCampaignIndex[_loc3_],"accessible");
      if(_loc4_ > 0)
      {
         _loc8_.push("campaign" + m_aCampaignIndex[_loc3_]);
         var _loc6_ = _global.CScaleformComponent_Inventory.GetCampaignName(m_aCampaignIndex[_loc3_]);
         if(_loc4_ > 1)
         {
            var _loc5_ = _global.GameInterface.Translate("#SFUI_Missions_Switch_multi");
         }
         else
         {
            _loc5_ = _global.GameInterface.Translate("#SFUI_Missions_Switch");
         }
         var _loc7_ = _global.GameInterface.Translate(_loc6_);
         _loc5_ = _global.ConstructString(_loc5_,_loc7_,_loc4_);
         _loc9_.push(_loc5_);
      }
      _loc3_ = _loc3_ - 1;
   }
   _loc8_.push("faq");
   _loc9_.push("#SFUI_InvContextMenu_Journal_Faq");
   _loc11_.TooltipShowHide(objTile);
   _loc11_.TooltipLayout(_loc8_,_loc9_,objTile,this.AssignContextMenuAction);
   _global.MainMenuMovie.Panel.TooltipItem.TooltipItemShowHide();
}
function FindNumMissionsThatMatchState(CampaignIndex, strState)
{
   var _loc7_ = 0;
   var _loc8_ = _global.CScaleformComponent_Inventory.GetCampaignNodeCount(CampaignIndex);
   var _loc2_ = 0;
   while(_loc2_ < _loc8_)
   {
      var _loc3_ = _global.CScaleformComponent_Inventory.GetCampaignNodeIDbyIndex(CampaignIndex,_loc2_);
      var _loc5_ = _global.CScaleformComponent_Inventory.GetCampaignNodeState(CampaignIndex,_loc3_);
      var _loc6_ = _global.CScaleformComponent_Inventory.GetCampaignNodeContentFile(CampaignIndex,_loc3_);
      if(_loc5_ == strState && _loc6_.indexOf("comic") == -1)
      {
         _loc7_ = _loc7_ + 1;
      }
      _loc2_ = _loc2_ + 1;
   }
   return _loc7_;
}
function AssignContextMenuAction(strMenuItem)
{
   trace("-------------------------------AssignContextMenuAction----------------------" + strMenuItem);
   var _loc2_ = _global.CScaleformComponent_Inventory.GetActiveSeasonCoinItemId(m_PlayerXuid);
   switch(strMenuItem)
   {
      case "toc":
         OpenJournal(_loc2_,0,false);
         break;
      case "campaign7":
         OpenJournal(_loc2_,4,true);
         break;
      case "campaign8":
         OpenJournal(_loc2_,2,true);
         break;
      case "faq":
         OpenJournal(_loc2_,18,true);
   }
}
function OpenJournal(ItemID, Page, bOpenToPage)
{
   var _loc2_ = _global.CScaleformComponent_Inventory.GetItemAttributeValue(m_PlayerXuid,ItemID,"season access");
   _global.MainMenuMovie.Panel.JournalPanel._visible = true;
   _global.MainMenuMovie.Panel.JournalPanel.Journal.ShowPanel(Page,ItemID,_loc2_,bOpenToPage);
}
function onPlay(objTargetTile)
{
   RollOverMissionToolTip(null,false,"");
   RollOverScheduleToolTip(null,false);
   if(objTargetTile._GameMode == "competitive")
   {
      var _loc3_ = "lobby";
   }
   else
   {
      _loc3_ = "search";
   }
   if(objTargetTile._Map != "" && objTargetTile._Map != undefined && objTargetTile._Map != null && objTargetTile._Map != " ")
   {
      var _loc4_ = "mg_" + objTargetTile._Map;
   }
   else
   {
      _loc4_ = objTargetTile._MapGroup;
   }
   _global.MainMenuMovie.Panel.SelectPanel.CloseAnyOpenMenus();
   _global.MainMenuMovie.Panel.SelectPanel.MainMenuTopBar.QuitButton.setDisabled(true);
   _global.CScaleformComponent_CompetitiveMatch.ActionMatchmaking(objTargetTile._GameMode,_loc4_,_loc3_);
}
function RollOverMissionToolTip(objButton, bShow, strToolTip, bPosRight)
{
   trace("rollOverToolTip: strToolTip = " + strToolTip);
   if(bPosRight)
   {
      var _loc1_ = {x:217,y:objButton._y + 40};
   }
   else
   {
      _loc1_ = {x:3,y:objButton._y + 65};
   }
   MissionsPanel.ToolTipMissionPanel.TooltipPlayerProfileShowHide(bShow);
   MissionsPanel.ToolTipMissionPanel.TooltipPlayerProfileLayout(strToolTip,_loc1_);
}
function RollOverScheduleToolTip(objButton, bShow)
{
   trace("rollOverToolTip: strToolTip = " + strToolTip);
   var _loc1_ = {x:260,y:objButton._y - 20};
   MissionsPanel.ToolTipSchedule.TooltipScheduleShowHide(bShow);
   MissionsPanel.ToolTipSchedule.TooltipScheduleLayout(_loc1_);
}
function SetFriendsPanelPos(Pos)
{
   if(IsPauseMenuActive())
   {
      _global.PauseMenuMovie.Panel.MainMenuNav.PlaceMissionPanel(Pos);
      return undefined;
   }
   if(_global.SinglePlayerMovie)
   {
      _global.SinglePlayerMovie.Panel.Friends.SetPanelPosAndSize(Pos);
   }
   else if(_global.LobbyMovie)
   {
      _global.LobbyMovie.LobbyPanel.Panels.FriendsListerPanel.SetPanelPosAndSize(Pos);
   }
   else
   {
      _global.MainMenuMovie.Panel.FriendsListerPanel.SetPanelPosAndSize(Pos);
   }
}
function StartScrollTimer()
{
   if(Bg.hitTest(_root._xmouse,_root._ymouse,true))
   {
      return undefined;
   }
   clearInterval(ScrollTimeInterval);
   ScrollTimeInterval = setInterval(onTimerScrollForward,40000);
}
function PauseScrollTimer()
{
   if(Bg.hitTest(_root._xmouse,_root._ymouse,true))
   {
      clearInterval(ScrollTimeInterval);
   }
}
stop();
MissionsPanel._visible = false;
var m_PlayerXuid = _global.CScaleformComponent_MyPersona.GetXuid();
var DEFAULT_PANEL_HEIGHT = 183;
var DEFAULT_PANEL_WIDTH = MissionsPanel.Background._width;
var MINIMIZE_PANEL_HEIGHT = 22;
var HALF_PANEL_HEIGHT = 67;
var objSelectedTile = null;
var objRightClick = null;
var m_aCampaignIndex = new Array(7,8);
MissionsPanel.ToolTipMissionPanel._visible = false;
MissionsPanel.ToolTipSchedule._visible = false;
MissionsPanel.Tile0._visible = false;
MissionsPanel.Tile1._visible = false;
MissionsPanel.Global._visible = false;
