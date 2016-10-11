function onResize(rm)
{
   rm.ResetPosition(Panel,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.POSITION_CENTER,Lib.ResizeManager.POSITION_CENTER,Lib.ResizeManager.ALIGN_CENTER,Lib.ResizeManager.ALIGN_CENTER);
}
function showPanel()
{
   m_bShowingMaps = false;
   m_bShowCurrentMap = false;
   m_bShowingPlayers = false;
   m_bShowBackups = false;
   HideTargetList();
   Panel._visible = true;
   _global.navManager.PushLayout(voteNav,"voteNav");
   EnableMainVoteButtons(true);
}
function hidePanel()
{
   _global.navManager.RemoveLayout(voteNav);
   Panel._visible = false;
   _global.RemoveElement(_global.CallVoteMovie);
   Panel.Scroll._visible = false;
}
function onUnload(mc)
{
   _global.CallVoteMovie = null;
   _global.CallVoteAPI = null;
   _global.resizeManager.RemoveListener(this);
   _global.tintManager.DeregisterAll(this);
   return true;
}
function onLoaded()
{
   Panel.KickPlayer.ButtonText.SetText("#SFUI_Vote_KickPlayer");
   Panel.NextMap.ButtonText.SetText("#SFUI_Vote_NextMap");
   Panel.ChangeMap.ButtonText.SetText("#SFUI_Vote_ChangeMap");
   Panel.SwapTeams.ButtonText.SetText("#SFUI_Vote_TeamSwitch");
   Panel.ScrambleTeams.ButtonText.SetText("#SFUI_Vote_ScrambleTeams");
   Panel.RestartMatch.ButtonText.SetText("#SFUI_Vote_RestartMatch");
   Panel.Surrender.ButtonText.SetText("#SFUI_Vote_Surrender");
   Panel.Cancel.ButtonText.SetText("#SFUI_Vote_CancelSubselection");
   Panel.LoadBackup.ButtonText.SetText("#SFUI_Vote_loadbackup");
   Panel.StartTimeout.ButtonText.SetText("#SFUI_Vote_StartTimeout");
   Panel.StartTimeoutTournament.ButtonText.SetText("#SFUI_Vote_StartTimeoutTournament");
   Panel.Cancel.setDisabled(false);
   Panel.Cancel._visible = true;
   Panel.Cancel.Action = hidePanel;
   Panel.KickPlayer.Action = ShowKickTargets;
   Panel.NextMap.Action = ShowNextMapTargets;
   Panel.ChangeMap.Action = ShowMapTargets;
   Panel.SwapTeams.Action = CallSwapTeamsVote;
   Panel.ScrambleTeams.Action = CallScrambleTeamsVote;
   Panel.RestartMatch.Action = CallRestartmatchVote;
   Panel.Surrender.Action = CallSurrenderVote;
   Panel.LoadBackup.Action = ShowBackupTargets;
   Panel.StartTimeout.Action = CallStartTimeoutVote;
   Panel.StartTimeoutTournament.Action = CallStartTimeoutVote;
   Panel.Scroll.Init();
   Panel.Scroll.m_bNotifyWhileMoving = true;
   Panel.Scroll.NotifyValueChange = this.SliderValueChanged;
   gameAPI.OnReady();
}
function GoToVoteSubSelection()
{
   _global.navManager.PushLayout(voteSubNav,"voteSubNav");
   EnableMainVoteButtons(false);
   Panel.gotoAndStop("VoteSubSelection");
   Panel.Cancel.Action = CancelVoteSubSelection;
}
function CancelVoteSubSelection()
{
   _global.navManager.RemoveLayout(voteSubNav);
   EnableMainVoteButtons(true);
   Panel.gotoAndStop("VoteMainSelection");
   HideTargetList();
   Panel.Cancel.Action = hidePanel;
}
function EnableMainVoteButtons(enable)
{
   var _loc11_ = gameAPI.GetNumberOfValidKickTargets();
   Panel.KickPlayer.setDisabled(_loc11_.count == 0 || !enable);
   var _loc3_ = gameAPI.IsQueuedMatchmaking();
   var _loc10_ = _global.CScaleformComponent_MatchStats.IsTournamentMatch();
   var _loc4_ = _global.CScaleformComponent_FriendsList.IsGameInWarmup();
   var _loc5_ = _global.CScaleformComponent_FriendsList.IsGamePaused();
   var _loc8_ = gameAPI.IsEndMatchMapVoteEnabled();
   var _loc9_ = gameAPI.GetNumberOfValidMapsInGroup(true);
   var _loc6_ = _global.CScaleformComponent_MatchStats.GetGameMode();
   Panel.NextMap.setDisabled(_loc8_ || _loc3_ || _loc9_.count == 0 || !enable);
   var _loc7_ = gameAPI.GetNumberOfValidMapsInGroup(false);
   Panel.ChangeMap.setDisabled(_loc3_ || _loc7_.count == 0 || !enable);
   Panel.SwapTeams.setDisabled(_loc3_ || !enable);
   Panel.ScrambleTeams.setDisabled(_loc3_ || !enable);
   Panel.RestartMatch.setDisabled(_loc3_ || !enable);
   Panel.Surrender.setDisabled(!_loc3_ || !enable);
   if(_loc6_ == "competitive")
   {
      Panel.StartTimeout.setDisabled(!enable);
   }
   else
   {
      Panel.StartTimeout.setDisabled(true);
   }
   Panel.KickPlayer._visible = true;
   Panel.NextMap._visible = true;
   Panel.ChangeMap._visible = true;
   Panel.SwapTeams._visible = true;
   Panel.ScrambleTeams._visible = true;
   Panel.RestartMatch._visible = true;
   Panel.Surrender._visible = true;
   Panel.StartTimeout._visible = true;
   if(!_loc10_ || !_loc3_)
   {
      Panel.Pause._visible = false;
      Panel.Unpause._visible = false;
      Panel.LoadBackup._visible = false;
      Panel.StartTimeoutTournament._visible = false;
      return undefined;
   }
   Panel.KickPlayer.setDisabled(true);
   Panel.NextMap.setDisabled(true);
   Panel.ChangeMap.setDisabled(true);
   Panel.SwapTeams.setDisabled(true);
   Panel.ScrambleTeams.setDisabled(true);
   Panel.RestartMatch.setDisabled(true);
   Panel.Surrender.setDisabled(true);
   Panel.StartTimeout.setDisabled(true);
   Panel.KickPlayer._visible = false;
   Panel.NextMap._visible = false;
   Panel.ChangeMap._visible = false;
   Panel.SwapTeams._visible = false;
   Panel.ScrambleTeams._visible = false;
   Panel.RestartMatch._visible = false;
   Panel.Surrender._visible = false;
   Panel.StartTimeout._visible = false;
   if(_loc4_)
   {
      Panel.Pause.ButtonText.SetText("#SFUI_Vote_not_ready_for_match");
      Panel.Unpause.ButtonText.SetText("#SFUI_Vote_ready_for_match");
      Panel.Pause.Action = CallNotReadyVote;
      Panel.Unpause.Action = CallReadyVote;
   }
   else
   {
      Panel.Pause.ButtonText.SetText("#SFUI_Vote_pause_match");
      Panel.Unpause.ButtonText.SetText("#SFUI_Vote_unpause_match");
      Panel.Pause.Action = CallPauseVote;
      Panel.Unpause.Action = CallUnpauseVote;
   }
   Panel.Pause.setDisabled(_loc5_ || !enable);
   Panel.Unpause.setDisabled(!_loc5_ || !enable);
   Panel.LoadBackup.setDisabled(_loc4_ || !enable);
   Panel.StartTimeoutTournament.setDisabled(_loc4_ || !enable);
   Panel.Pause._visible = true;
   Panel.Unpause._visible = true;
   Panel.LoadBackup._visible = true;
   Panel.StartTimeoutTournament._visible = true;
}
function ShowKickTargets()
{
   GoToVoteSubSelection();
   HideTargetList();
   m_bShowingMaps = false;
   m_bShowCurrentMap = false;
   m_bShowingPlayers = true;
   m_bShowBackups = false;
   RefreshTargetList();
}
function RefreshTargetList()
{
   if(m_bShowingMaps)
   {
      var _loc4_ = gameAPI.PopulateMapTargets(m_bShowCurrentMap);
      TotalTargets = _loc4_.count;
      var _loc6_ = Math.min(TotalTargets,NumButtons);
      var _loc2_ = 0;
      while(_loc2_ < _loc6_)
      {
         var _loc3_ = Panel["Target" + _loc2_];
         _loc3_.ButtonText.SetText(_loc4_.friendlyNames[_loc2_ + TopTargetOffset]);
         _loc3_._visible = true;
         _loc3_.mapName = _loc4_.names[_loc2_ + TopTargetOffset];
         _loc3_.Action = function()
         {
            CallChangeNextMapVote(this.mapName);
         };
         _loc2_ = _loc2_ + 1;
      }
   }
   else
   {
      var _loc5_ = gameAPI.PopulatePlayerTargets();
      TotalTargets = _loc5_.count;
      _loc6_ = Math.min(TotalTargets,NumButtons);
      _loc2_ = 0;
      while(_loc2_ < _loc6_)
      {
         _loc3_ = Panel["Target" + _loc2_];
         _loc3_.buttonIdx = _loc2_;
         _loc3_.ButtonText.SetText(_loc5_.names[_loc2_ + TopTargetOffset]);
         _loc3_._visible = true;
         _loc3_.playerId = _loc5_.ids[_loc2_ + TopTargetOffset];
         _loc3_.Action = function()
         {
            CallKickPlayerVote(this.playerId);
         };
         _loc2_ = _loc2_ + 1;
      }
   }
   UpdateSliderPip();
}
function UpdateFriendCount()
{
   m_bShowingMaps = false;
   m_bShowCurrentMap = false;
   m_bShowingPlayers = true;
   m_bShowBackups = false;
   TotalFriends = _global.LobbyAPI.GetNumFriends();
   if(TotalFriends <= NumButtons)
   {
      SliderControl._visible = false;
   }
   else
   {
      SliderControl._visible = true;
      SliderControl.m_nIncrementAmount = 100 / Math.min(2,TotalFriends / NumButtons);
   }
}
function UpdateSliderPip()
{
   Panel.Scroll.m_nIncrementAmount = 100 / Math.max(2,TotalTargets - NumButtons);
   Panel.Scroll._visible = TotalTargets > NumButtons;
   if(Panel.Scroll._visible)
   {
      var _loc2_ = _global.navManager._highlightedObject.buttonIdx;
      if(_loc2_ != undefined)
      {
         LastButton = _loc2_;
         Panel.Scroll.SetValue(TopTargetOffset / (TotalTargets - NumButtons) * 100);
      }
   }
}
function SliderValueChanged()
{
   TopTargetOffset = Math.floor(Panel.Scroll.GetValue() / 100 * (TotalTargets - NumButtons));
   _global.navManager.SetHighlightedObject(Panel["Target" + Math.floor(Panel.Scroll.GetValue() / 100)]);
   RefreshTargetList();
}
function ShowNextMapTargets()
{
   m_bShowingMaps = true;
   m_bShowCurrentMap = true;
   m_bShowingPlayers = false;
   m_bShowBackups = false;
   GoToVoteSubSelection();
   HideTargetList();
   var _loc4_ = gameAPI.PopulateMapTargets(true);
   var _loc2_ = 0;
   while(_loc2_ < _loc4_.count)
   {
      var _loc3_ = Panel["Target" + _loc2_];
      _loc3_.ButtonText.SetText(_loc4_.friendlyNames[_loc2_ + TopTargetOffset]);
      _loc3_._visible = true;
      _loc3_.mapName = _loc4_.names[_loc2_ + TopTargetOffset];
      _loc3_.Action = function()
      {
         CallChangeNextMapVote(this.mapName);
      };
      _loc2_ = _loc2_ + 1;
   }
   if(_loc4_.count <= NumButtons)
   {
      UpdateSliderPip();
   }
}
function ShowMapTargets()
{
   m_bShowingMaps = true;
   m_bShowCurrentMap = false;
   m_bShowingPlayers = false;
   m_bShowBackups = false;
   GoToVoteSubSelection();
   HideTargetList();
   var _loc4_ = gameAPI.PopulateMapTargets(false);
   var _loc2_ = 0;
   while(_loc2_ < _loc4_.count)
   {
      var _loc3_ = Panel["Target" + _loc2_];
      _loc3_.ButtonText.SetText(_loc4_.friendlyNames[_loc2_ + TopTargetOffset]);
      _loc3_._visible = true;
      _loc3_.mapName = _loc4_.names[_loc2_ + TopTargetOffset];
      _loc3_.Action = function()
      {
         CallChangeMapVote(this.mapName);
      };
      _loc2_ = _loc2_ + 1;
   }
   if(_loc4_.count <= NumButtons)
   {
      UpdateSliderPip();
   }
}
function ShowBackupTargets()
{
   m_bShowingMaps = false;
   m_bShowCurrentMap = false;
   m_bShowingPlayers = false;
   m_bShowBackups = true;
   GoToVoteSubSelection();
   HideTargetList();
   trace("-------------------------------------ShowBackupTargets()---------------------------------");
   gameAPI.PopulateBackupFilenames();
}
function RefreshBackupList(BackupEntries, BackupEntriesDesc)
{
   var _loc3_ = 0;
   while(_loc3_ < BackupEntries.length)
   {
      var _loc4_ = Panel["Target" + _loc3_];
      _loc4_.ButtonText.SetText(BackupEntriesDesc[_loc3_ + TopTargetOffset]);
      _loc4_._visible = true;
      _loc4_.backupName = BackupEntries[_loc3_ + TopTargetOffset];
      _loc4_.Action = function()
      {
         CallLoadBackupVote(this.backupName);
      };
      _global.AutosizeTextDown(_loc4_.ButtonText.Text,16);
      _loc3_ = _loc3_ + 1;
   }
   if(BackupEntries.length <= NumButtons)
   {
      UpdateSliderPip();
   }
}
function CallLoadBackupVote(backupName)
{
   trace("---------------------------------------backupName------------------------" + backupName);
   _global.GameInterface.ConsoleCommand("callvote LoadBackup " + backupName);
   CancelVoteSubSelection();
   hidePanel();
}
function CallKickPlayerVote(playerIndex)
{
   _global.GameInterface.ConsoleCommand("callvote Kick " + playerIndex);
   CancelVoteSubSelection();
   hidePanel();
}
function CallChangeNextMapVote(mapName)
{
   _global.GameInterface.ConsoleCommand("callvote NextLevel " + mapName);
   CancelVoteSubSelection();
   hidePanel();
}
function CallChangeMapVote(mapName)
{
   _global.GameInterface.ConsoleCommand("callvote ChangeLevel " + mapName);
   CancelVoteSubSelection();
   hidePanel();
}
function CallScrambleTeamsVote()
{
   _global.GameInterface.ConsoleCommand("callvote ScrambleTeams");
   hidePanel();
}
function CallRestartmatchVote()
{
   _global.GameInterface.ConsoleCommand("callvote RestartGame");
   hidePanel();
}
function CallSurrenderVote()
{
   _global.GameInterface.ConsoleCommand("callvote Surrender");
   hidePanel();
}
function CallSwapTeamsVote()
{
   _global.GameInterface.ConsoleCommand("callvote SwapTeams");
   hidePanel();
}
function CallPauseVote()
{
   _global.GameInterface.ConsoleCommand("callvote PauseMatch");
   hidePanel();
}
function CallUnpauseVote()
{
   _global.GameInterface.ConsoleCommand("callvote UnpauseMatch");
   hidePanel();
}
function CallReadyVote()
{
   _global.GameInterface.ConsoleCommand("callvote ReadyForMatch");
   hidePanel();
}
function CallNotReadyVote()
{
   _global.GameInterface.ConsoleCommand("callvote NotReadyForMatch");
   hidePanel();
}
function CallStartTimeoutVote()
{
   _global.GameInterface.ConsoleCommand("callvote starttimeout");
   hidePanel();
}
function HideTargetList()
{
   var _loc1_ = 0;
   while(Panel["Target" + _loc1_] != undefined)
   {
      Panel["Target" + _loc1_]._visible = false;
      Panel["Target" + _loc1_].Action = function()
      {
      };
      _loc1_ = _loc1_ + 1;
   }
}
function PopulateBackupFilenames_Callback(BackupEntries, BackupEntriesDesc)
{
   trace("---------------------------------------BackupEntries------------------------" + BackupEntries);
   trace("---------------------------------------BackupEntriesDesc------------------------" + BackupEntriesDesc);
   var _loc1_ = BackupEntries.split(",");
   var _loc2_ = BackupEntriesDesc.split(",");
   RefreshBackupList(_loc1_,_loc2_);
}
_global.CallVoteMovie = this;
_global.CallVoteAPI = gameAPI;
var voteNav = new Lib.NavLayout();
var voteSubNav = new Lib.NavLayout();
voteNav.DenyInputToGame(true);
voteNav.ShowCursor(true);
voteSubNav.DenyInputToGame(true);
voteSubNav.ShowCursor(true);
var TopTargetOffset = 0;
var TotalTargets = 0;
var NumButtons = 10;
var LastButton = 0;
var m_bShowingMaps;
var m_bShowCurrentMap;
var m_bShowingPlayers;
var m_bShowBackups;
voteNav.AddKeyHandlerTable({CANCEL:{onDown:function(button, control, keycode)
{
   hidePanel();
}}});
voteSubNav.AddKeyHandlerTable({CANCEL:{onDown:function(button, control, keycode)
{
   CancelVoteSubSelection();
}}});
voteNav.AddTabOrder([Panel.KickPlayer,Panel.NextMap,Panel.ChangeMap,Panel.SwapTeams,Panel.ScrambleTeams,Panel.RestartMatch,Panel.Surrender,Panel.StartTimeout,Panel.Pause,Panel.Unpause,Panel.LoadBackup]);
voteNav.SetInitialHighlight(Panel.KickPlayer);
voteSubNav.SetInitialHighlight(Panel.Target0);
voteNav.AddNavForObject(Panel.KickPlayer,{UP:Panel.LoadBackup,DOWN:Panel.NextMap});
voteNav.AddNavForObject(Panel.NextMap,{UP:Panel.KickPlayer,DOWN:Panel.ChangeMap});
voteNav.AddNavForObject(Panel.ChangeMap,{UP:Panel.NextMap,DOWN:Panel.SwapTeams});
voteNav.AddNavForObject(Panel.SwapTeams,{UP:Panel.ChangeMap,DOWN:Panel.ScrambleTeams});
voteNav.AddNavForObject(Panel.ScrambleTeams,{UP:Panel.SwapTeams,DOWN:Panel.RestartMatch});
voteNav.AddNavForObject(Panel.RestartMatch,{UP:Panel.ScrambleTeams,DOWN:Panel.Surrender});
voteNav.AddNavForObject(Panel.Surrender,{UP:Panel.RestartMatch,DOWN:Panel.StartTimeout});
voteNav.AddNavForObject(Panel.StartTimeout,{UP:Panel.Surrender,DOWN:Panel.Pause});
voteNav.AddNavForObject(Panel.Pause,{UP:Panel.RestartMatch,DOWN:Panel.Unpause});
voteNav.AddNavForObject(Panel.Unpause,{UP:Panel.Pause,DOWN:Panel.LoadBackup});
voteNav.AddNavForObject(Panel.LoadBackup,{UP:Panel.Unpause,DOWN:Panel.KickPlayer});
voteSubNav.AddTabOrder([Panel.Target0,Panel.Target1,Panel.Target2,Panel.Target3,Panel.Target4,Panel.Target5,Panel.Target6,Panel.Target7,Panel.Target8,Panel.Target9]);
voteSubNav.AddNavForObject(Panel.Target0,{UP:Panel.Target9,DOWN:Panel.Target1});
voteSubNav.AddNavForObject(Panel.Target1,{UP:Panel.Target0,DOWN:Panel.Target2});
voteSubNav.AddNavForObject(Panel.Target2,{UP:Panel.Target1,DOWN:Panel.Target3});
voteSubNav.AddNavForObject(Panel.Target3,{UP:Panel.Target2,DOWN:Panel.Target4});
voteSubNav.AddNavForObject(Panel.Target4,{UP:Panel.Target3,DOWN:Panel.Target5});
voteSubNav.AddNavForObject(Panel.Target5,{UP:Panel.Target4,DOWN:Panel.Target6});
voteSubNav.AddNavForObject(Panel.Target6,{UP:Panel.Target5,DOWN:Panel.Target7});
voteSubNav.AddNavForObject(Panel.Target7,{UP:Panel.Target6,DOWN:Panel.Target8});
voteSubNav.AddNavForObject(Panel.Target8,{UP:Panel.Target7,DOWN:Panel.Target9});
voteSubNav.AddNavForObject(Panel.Target9,{UP:Panel.Target8,DOWN:Panel.Target0});
voteSubNav.AddKeyHandlerTable({DOWN:{onDown:function(button, control, keycode)
{
   if(_global.navManager._highlightedObject.buttonIdx == NumButtons - 1)
   {
      if(TotalTargets > NumButtons)
      {
         if(TopTargetOffset + NumButtons < TotalTargets)
         {
            TopTargetOffset++;
            RefreshTargetList();
            return true;
         }
         if(TopTargetOffset + NumButtons == TotalTargets)
         {
            TopTargetOffset = 0;
            _global.navManager.SetHighlightedObject(Panel.Target0);
            RefreshTargetList();
            return true;
         }
      }
   }
   UpdateSliderPip();
   return false;
}},UP:{onDown:function(button, control, keycode)
{
   if(_global.navManager._highlightedObject.buttonIdx == 0)
   {
      if(TotalTargets > NumButtons)
      {
         if(TopTargetOffset > 0)
         {
            TopTargetOffset--;
            RefreshTargetList();
            return true;
         }
         TopTargetOffset = TotalTargets - NumButtons;
         _global.navManager.SetHighlightedObject(Panel["Target" + (NumButtons - 1)]);
         RefreshTargetList();
         return true;
      }
   }
   UpdateSliderPip();
   return false;
}}});
_global.resizeManager.AddListener(this);
stop();
