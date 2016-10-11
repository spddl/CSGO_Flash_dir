class MainUI.StartSinglePlayerDialog.SinglePlayerDialog
{
   var curGameTypeIndex = 0;
   var curGameModeIndex = 0;
   var curMapIndex = 0;
   var curBotDifficultyIndex = 0;
   var numAnyTypeMode = 0;
   var botDiffEnabled = false;
   var bChooseModePanelEnabled = false;
   var bErrorPanelEnabled = false;
   var usingMatchmaking = false;
   var teamLobbyMode = false;
   var trainingMode = false;
   var updateNavLayout = true;
   var bModeSelectEnabled = false;
   var lockNavText = false;
   var m_bPendingInvites = false;
   var m_numPrimeSetting = 1;
   var objSelectedButton = undefined;
   var objSelectedWorkshopButton = undefined;
   var singlePlayerInitialVars = {curMapIndex:"player_maplast_s",curGameTypeIndex:"player_gametypelast_s",curGameModeIndex:"player_gamemodelast_s",curBotDifficultyIndex:"player_botdifflast_s"};
   var multiPlayerInitialVars = {curMapIndex:"player_maplast_m",curGameTypeIndex:"player_gametypelast_m",curGameModeIndex:"player_gamemodelast_m"};
   var initialVars = "singlePlayerInitialVars";
   var ButtonToHighlight = undefined;
   var WorkshopButtonToHighlight = undefined;
   var mcButtonLastFocus = undefined;
   function SinglePlayerDialog(thePanel)
   {
      this.m_bPendingInvites = _global.GameInterface.GetConvarBoolean("cl_invitation_pending");
      this.dialogData = _global.GameInterface.LoadKVFile("GameModes.txt");
      trace(" getting new dialog data!");
      this.CreateOrder(this.dialogData.gameTypes);
      var _loc3_ = 0;
      while(_loc3_ < this.dialogData.gameTypes.order.length)
      {
         this.CreateOrder(this.dialogData.gameTypes.order[_loc3_].gameModes);
         var _loc4_ = 0;
         while(_loc4_ < this.dialogData.gameTypes.order[_loc3_].gameModes.order.length)
         {
            this.CreateOrderMapGroups(this.dialogData.gameTypes.order[_loc3_].gameModes.order[_loc4_].mapgroupsSP,false);
            _loc4_ = _loc4_ + 1;
         }
         _loc4_ = 0;
         while(_loc4_ < this.dialogData.gameTypes.order[_loc3_].gameModes.order.length)
         {
            this.CreateOrderMapGroups(this.dialogData.gameTypes.order[_loc3_].gameModes.order[_loc4_].mapgroupsMP,true);
            _loc4_ = _loc4_ + 1;
         }
         _loc3_ = _loc3_ + 1;
      }
      this.CreateOrder(this.dialogData.botDifficulty);
      this.panel = thePanel;
   }
   function CreateOrderMapGroups(o, bMultiplayer)
   {
      if(bMultiplayer == undefined)
      {
         bMultiplayer = false;
      }
      if(typeof o == "object")
      {
         o.order = new Array();
         o.ordername = new Array();
         for(var _loc3_ in o)
         {
            var _loc1_ = o[_loc3_];
            if(_loc1_ != undefined && typeof _loc1_ != "function" && _loc3_ != "order" && _loc3_ != "ordername")
            {
               o.order[_loc1_] = _loc1_;
               o.ordername[_loc1_] = _loc3_;
            }
         }
      }
   }
   function CreateOrder(o)
   {
      if(typeof o == "object")
      {
         o.order = new Array();
         o.ordername = new Array();
         o.ordernameToIndex = new Array();
         for(var _loc3_ in o)
         {
            var _loc2_ = o[_loc3_];
            if(_loc2_ && typeof _loc2_ == "object")
            {
               o.order[o[_loc3_].value] = _loc2_;
               o.ordername[o[_loc3_].value] = _loc3_;
               o.ordernameToIndex[_loc3_] = o[_loc3_].value;
            }
         }
      }
   }
   function SaveInitConvars()
   {
      var _loc4_ = this[this.initialVars];
      for(var _loc5_ in _loc4_)
      {
         var _loc3_ = _loc4_[_loc5_];
         if(_loc3_ && typeof _loc3_ == "string")
         {
            _global.GameInterface.SetConvar(_loc3_,this[_loc5_]);
         }
      }
   }
   function InitDialogData(initUsingMatchmaking, initTeamLobbyMode, initTrainingMode)
   {
      this.usingMatchmaking = initUsingMatchmaking;
      this.UpdateMapGroupForPermissions();
      this.teamLobbyMode = initTeamLobbyMode;
      this.trainingMode = initTrainingMode;
      if(this.usingMatchmaking)
      {
         this.initialVars = "multiPlayerInitialVars";
      }
      this.EnableDisablePlayButton();
      this.LoadInitConvars();
   }
   function UpdateMapGroupForPermissions()
   {
      var _loc3_ = 0;
      while(_loc3_ < this.dialogData.gameTypes.order.length)
      {
         var _loc2_ = 0;
         while(_loc2_ < this.dialogData.gameTypes.order[_loc3_].gameModes.order.length)
         {
            var _loc4_ = undefined;
            if(this.usingMatchmaking)
            {
               if(_loc3_ == 0 && _loc2_ == 1)
               {
                  _loc4_ = this.dialogData.gameTypes.order[_loc3_].gameModes.order[_loc2_].mapgroupsMP;
               }
               else
               {
                  _loc4_ = this.dialogData.gameTypes.order[_loc3_].gameModes.order[_loc2_].mapgroupsMP;
               }
            }
            else
            {
               _loc4_ = this.dialogData.gameTypes.order[_loc3_].gameModes.order[_loc2_].mapgroupsSP;
            }
            this.dialogData.gameTypes.order[_loc3_].gameModes.order[_loc2_].activeMapGroups = _loc4_;
            _loc2_ = _loc2_ + 1;
         }
         _loc3_ = _loc3_ + 1;
      }
   }
   function DoesPreferredMaplistContainOperationMaps()
   {
      var _loc3_ = new Array("mg_de_cache","mg_de_ali","mg_cs_agency","mg_de_seaside","mg_de_favela","mg_cs_motel","mg_cs_downtown","mg_cs_thunder","mg_op_phoenix");
      var _loc6_ = _global.SinglePlayerAPI.GetQueuedMatchmakingPreferredMaplist();
      var _loc5_ = _loc6_.split(",");
      var _loc2_ = false;
      var _loc4_ = 0;
      while(_loc4_ < _loc5_.length)
      {
         switch(_loc5_[_loc4_])
         {
            case _loc3_[0]:
               _loc2_ = true;
               break;
            case _loc3_[1]:
               _loc2_ = true;
               break;
            case _loc3_[2]:
               _loc2_ = true;
               break;
            case _loc3_[3]:
               _loc2_ = true;
               break;
            case _loc3_[4]:
               _loc2_ = true;
               break;
            case _loc3_[5]:
               _loc2_ = true;
               break;
            case _loc3_[6]:
               _loc2_ = true;
               break;
            case _loc3_[7]:
               _loc2_ = true;
               break;
            case _loc3_[8]:
               _loc2_ = true;
         }
         _loc4_ = _loc4_ + 1;
      }
      trace("----------------------------MapFound----------------------" + _loc2_);
      return _loc2_;
   }
   function LoadInitConvars()
   {
      var _loc4_ = this[this.initialVars];
      for(var _loc5_ in _loc4_)
      {
         var _loc3_ = _loc4_[_loc5_];
         if(_loc3_ && typeof _loc3_ == "string")
         {
            this[_loc5_] = _global.GameInterface.GetConvarNumber(_loc3_);
         }
      }
   }
   function UpdateMapImage()
   {
      this.panel.arrImagePaths = [];
      this.panel.arrMapNames = [];
      this.UpdateMapGroupForPermissions();
      var _loc7_ = this.dialogData.gameTypes.order[this.curGameTypeIndex].gameModes.order[this.curGameModeIndex];
      var _loc8_ = _loc7_.activeMapGroups.order.length;
      var _loc9_ = _global.SinglePlayerMovie.Panel.Panel.dialog.GetUsingMatchmaking();
      var _loc3_ = 0;
      while(_loc3_ < _loc8_)
      {
         var _loc4_ = undefined;
         var _loc6_ = _loc7_.activeMapGroups.ordername[_loc3_];
         _loc4_ = this.dialogData.mapgroups[_loc6_].imagename;
         this.panel.arrImagePaths.push(_loc4_);
         var _loc5_ = _loc7_.activeMapGroups.ordername[_loc3_];
         this.panel.arrMapNames.push(_loc5_);
         _loc3_ = _loc3_ + 1;
      }
      this.panel.ResetMapData();
      this.EnableDisablePlayButton();
      this.panel.UpdateTiles();
   }
   function UpdateDialog()
   {
      if(this.curGameTypeIndex < 0 || this.curGameTypeIndex >= this.dialogData.gameTypes.order.length)
      {
         this.curGameTypeIndex = 0;
      }
      if(this.curGameModeIndex < 0 || this.curGameModeIndex >= this.dialogData.gameTypes.order[this.curGameTypeIndex].gameModes.order.length)
      {
         this.curGameModeIndex = 0;
      }
      var _loc3_ = this.dialogData.gameTypes.order[this.curGameTypeIndex].gameModes.order[this.curGameModeIndex];
      if(this.curBotDifficultyIndex < 0 || this.curBotDifficultyIndex >= this.dialogData.botDifficulty.order.length)
      {
         this.curBotDifficultyIndex = 0;
      }
      this.panel.BotDiffPanel.BotDifficultyChooser.MiddleButton.gotoAndStop(this.curBotDifficultyIndex + 3);
      this.panel.BotDiffPanel.BotDifficultyLabel.SetText(this.dialogData.botDifficulty.order[this.curBotDifficultyIndex].nameID);
      if(this.dialogData.botDifficulty.order[this.curBotDifficultyIndex].awardProgressDisabled == "1")
      {
         this.panel.BotDiffPanel.BotDifficultyNotice.SetText("#SFUI_AwardProgressDisabledBotDifficulty");
      }
      else
      {
         this.panel.BotDiffPanel.BotDifficultyNotice.SetText("");
      }
      var _loc6_ = _loc3_.activeMapGroups.ordername[this.curMapIndex];
      if(!this.usingMatchmaking && _loc3_.descID_SP)
      {
         this.panel.ModeChooser.TabDefault.GameModeDesc.SetText(_loc3_.descID_SP);
         this.panel.ModeChooser.TabDefault.GameModeDescList.SetText(_loc3_.descID_SPList);
      }
      else
      {
         this.panel.ModeChooser.TabDefault.GameModeDesc.SetText(_loc3_.descID);
         this.panel.ModeChooser.TabDefault.GameModeDescList.SetText(_loc3_.descID_List);
      }
      var _loc5_ = _global.GameInterface.Translate(this.dialogData.gameTypes.order[this.curGameTypeIndex].nameID);
      var _loc4_ = _global.GameInterface.Translate(_loc3_.nameID);
      if(!this.usingMatchmaking && _loc3_.nameID_SP)
      {
         _loc4_ = _global.GameInterface.Translate(_loc3_.nameID_SP);
      }
      this.panel.GameModeCategory.SetText(_loc5_ + " " + _loc4_);
      this.panel.Disclaimer._visible = _loc3_.showdisclaimer == 1;
      this.UpdateNavText();
   }
   function UpdateNavText()
   {
      if(this.lockNavText)
      {
         return undefined;
      }
      var _loc5_ = this.panel.NavigationMaster.PCButtons.PlayButton;
      var _loc6_ = this.panel.NavigationMaster.ControllerNav;
      var _loc4_ = this.panel.BotDiffPanel.NavigationMasterAI.ControllerNav;
      if(this.m_bPendingInvites)
      {
         _loc4_.SetText(_global.GameInterface.Translate("#SFUI_SinglePlayer_BotDiffNav") + (!this.usingMatchmaking?"":"\t" + _global.GameInterface.Translate("#SFUI_SinglePlayer_Invite_On")));
      }
      else
      {
         _loc4_.SetText(_global.GameInterface.Translate("#SFUI_SinglePlayer_BotDiffNav") + (!this.usingMatchmaking?"":"\t" + _global.GameInterface.Translate("#SFUI_SinglePlayer_Invite_Off")));
      }
      var _loc3_ = undefined;
      if(this.teamLobbyMode)
      {
         _loc3_ = "#SFUI_SinglePlayer_TeamLobbyNav";
      }
      else if(this.bModeSelectEnabled)
      {
         _loc3_ = "#SFUI_SinglePlayer_MapSelect";
      }
      else
      {
         _loc3_ = "#SFUI_SinglePlayer_ModeSelect";
      }
   }
   function Init()
   {
      this.panel.ModeChooser.TabDefault.ModeDeathmatch.dialog = this;
      this.panel.ModeChooser.TabDefault.ModeProgressive.dialog = this;
      this.panel.ModeChooser.TabDefault.ModeDemo.dialog = this;
      this.panel.ModeChooser.TabDefault.ModeCasual.dialog = this;
      this.panel.ModeChooser.TabDefault.ModeCompetitive.dialog = this;
      this.panel.ModeChooser.TabWorkshop.ModeAll.dialog = this;
      this.panel.ModeChooser.TabWorkshop.ModeAll.SetText("#SFUI_GameModeAll");
      this.panel.ModeChooser.TabWorkshop.ModeAll.Action = function()
      {
         this.dialog.OnSelectWorkshopMode(this);
      };
      this.panel.ModeChooser.TabWorkshop.ModeDeathmatch.dialog = this;
      this.panel.ModeChooser.TabWorkshop.ModeProgressive.dialog = this;
      this.panel.ModeChooser.TabWorkshop.ModeDemo.dialog = this;
      this.panel.ModeChooser.TabWorkshop.ModeClassic.dialog = this;
      this.panel.ModeChooser.TabWorkshop.ModeCustom.dialog = this;
      this.AttachTypeAndMode("gungame","deathmatch",this.panel.ModeChooser.TabWorkshop.ModeDeathmatch);
      this.AttachTypeAndMode("gungame","gungameprogressive",this.panel.ModeChooser.TabWorkshop.ModeProgressive);
      this.AttachTypeAndMode("gungame","gungametrbomb",this.panel.ModeChooser.TabWorkshop.ModeDemo);
      this.AttachTypeAndMode("classic","casual",this.panel.ModeChooser.TabWorkshop.ModeClassic);
      this.AttachTypeAndMode("custom","custom",this.panel.ModeChooser.TabWorkshop.ModeCustom);
      this.AttachTypeAndMode("gungame","deathmatch",this.panel.ModeChooser.TabDefault.ModeDeathmatch);
      this.AttachTypeAndMode("gungame","gungameprogressive",this.panel.ModeChooser.TabDefault.ModeProgressive);
      this.AttachTypeAndMode("gungame","gungametrbomb",this.panel.ModeChooser.TabDefault.ModeDemo);
      this.AttachTypeAndMode("classic","casual",this.panel.ModeChooser.TabDefault.ModeCasual);
      this.AttachTypeAndMode("classic","competitive",this.panel.ModeChooser.TabDefault.ModeCompetitive);
      this.panel.ShowGlobalMissionAlert();
      this.panel.BotDiffPanel.BotDifficultyChooser.dialog = this;
      this.panel.BotDiffPanel.BotDifficultyChooser.MoveLeft = function()
      {
         this.dialog.BotDifficultyChooserScroll(-1);
      };
      this.panel.BotDiffPanel.BotDifficultyChooser.MoveRight = function()
      {
         this.dialog.BotDifficultyChooserScroll(1);
      };
      this.panel.BotDiffPanel.BotDifficultyChooser.FocusPanel = this.panel.Focus3;
      var _loc2_ = 0;
      while(_loc2_ < 6)
      {
         var _loc3_ = this.panel.BotDiffPanel.BotDifficultyChooser.MiddleButton["Slot" + _loc2_];
         _loc3_.dialog = this;
         _loc3_.slotNumber = _loc2_;
         _loc3_.Action = function()
         {
            this.dialog.OnPressedBotDifficultySlot(this.slotNumber);
         };
         _loc2_ = _loc2_ + 1;
      }
      this.panel.NavigationMaster.PCButtons.PlayButton.dialog = this;
      this.panel.NavigationMaster.PCButtons.PlayButton.Action = function()
      {
         this.dialog.OnPressedPlay();
      };
      this.panel.NavigationMaster.PCButtons.BackButton.dialog = this;
      this.panel.NavigationMaster.PCButtons.BackButton.SetText("#SFUI_Back");
      this.panel.NavigationMaster.PCButtons.BackButton.Action = function()
      {
         this.dialog.OnPressedBack();
      };
      this.panel.NavigationMaster.PCButtons.ToLobbyButton.dialog = this;
      this.panel.NavigationMaster.PCButtons.ToLobbyButton.Action = function()
      {
         this.dialog.OnPressedBack();
      };
      this.panel.NavigationMaster.PCButtons.ToLobbyButton.ButtonText.Text.autoSize = "left";
      this.panel.NavigationMaster.PCButtons.ToLobbyButton.ButtonText.Text._x = 15;
      this.LoadImage("images/ui_icons/back.png",this.panel.NavigationMaster.PCButtons.ToLobbyButton.ImageHolder,28,28,false);
      this.panel.NavigationMaster.PCButtons.PrimeStatus.dialog = this;
      this.panel.NavigationMaster.PCButtons.PrimeStatus.SetText("#SFUI_Lobby_PrimeStatus");
      this.panel.NavigationMaster.PCButtons.PrimeStatus.Action = function()
      {
         this.dialog.OnPressedPrime();
      };
      this.panel.NavigationMaster.PCButtons.PrimeStatus.ButtonText.Text.autoSize = "left";
      this.panel.NavigationMaster.PCButtons.PrimeStatus.ButtonText.Text._x = 15;
      this.LoadImage("images/ui_icons/verified.png",this.panel.NavigationMaster.PCButtons.PrimeStatus.ImageHolder,28,28,false);
      this.panel.NavigationMaster.PCButtons.PrimeTooltip.Text.htmlText = "#SFUI_Elevated_Status_Not_Enrolled_Tooltip";
      this.panel.NavigationMaster.PCButtons.PrimeTooltip.Text.autoSize = "left";
      this.panel.NavigationMaster.PCButtons.PrimeTooltip.Bg._height = this.panel.NavigationMaster.PCButtons.PrimeTooltip.Text._height + 20;
      this.panel.NavigationMaster.PCButtons.PrimeTooltip.Bg._width = this.panel.NavigationMaster.PCButtons.PrimeTooltip.Text._width + 20;
      this.panel.NavigationMaster.PCButtons.PrimeTooltip.LeftArrow._y = this.panel.NavigationMaster.PCButtons.PrimeTooltip.Bg._height - 5;
      this.panel.NavigationMaster.PCButtons.PrimeTooltip._visible = false;
      this.panel.NavigationMaster.PCButtons.PrimeTooltip._y = this.panel.NavigationMaster.PCButtons.PrimeStatus._y - this.panel.NavigationMaster.PCButtons.PrimeTooltip._height;
      this.UpdatePrimeText();
      this.OnSelectWorkshopMode(this.panel.ModeChooser.TabWorkshop.ModeAll);
      this.OnSelectMode(this.ButtonToHighlight);
   }
   function ShowHidePrimeTooltip(bShow)
   {
      this.panel.NavigationMaster.PCButtons.PrimeTooltip._visible = bShow;
      this.panel.NavigationMaster.PCButtons.PrimeTooltip._alpha = 100;
   }
   function LoadImage(imagePath, objImage, numWidth, numHeight)
   {
      var _loc1_ = new Object();
      _loc1_.onLoadInit = function(target_mc)
      {
         target_mc._width = numWidth;
         target_mc._height = numHeight;
      };
      _loc1_.onLoadError = function(target_mc, errorCode, status)
      {
         trace("Error loading item image: " + errorCode + " [" + status + "] ----- ");
      };
      var _loc3_ = imagePath;
      var _loc2_ = new MovieClipLoader();
      _loc2_.addListener(_loc1_);
      _loc2_.loadClip(_loc3_,objImage.Image);
   }
   function AttachTypeAndMode(strType, strMode, mcButton)
   {
      var _loc2_ = this.dialogData.gameTypes.ordernameToIndex[strType];
      var _loc3_ = this.dialogData.gameTypes.order[_loc2_].gameModes.ordernameToIndex[strMode];
      if(!this.usingMatchmaking && this.dialogData.gameTypes.order[_loc2_].gameModes.order[_loc3_].nameID_SP)
      {
         mcButton.SetText(this.dialogData.gameTypes.order[_loc2_].gameModes.order[_loc3_].nameID_SP);
      }
      else
      {
         mcButton.SetText(this.dialogData.gameTypes.order[_loc2_].gameModes.order[_loc3_].nameID);
      }
      mcButton.Selected._visible = false;
      var _loc4_ = mcButton.toString();
      if(_loc4_.indexOf("TabWorkshop") != -1)
      {
         if(strType == "classic")
         {
            mcButton.SetText("#SFUI_GameModeClassic");
         }
         mcButton.Action = function()
         {
            this.dialog.mcButtonLastFocus = mcButton;
            this.dialog.OnSelectWorkshopMode(this);
         };
         this.WorkshopButtonToHighlight = mcButton;
      }
      else
      {
         mcButton.Action = function()
         {
            this.dialog.mcButtonLastFocus = mcButton;
            this.dialog.OnSelectMode(this);
         };
         if(strMode == this.dialogData.gameTypes.order[this.curGameTypeIndex].gameModes.ordername[this.curGameModeIndex])
         {
            this.ButtonToHighlight = mcButton;
         }
         mcButton._GameMode = strMode;
      }
      mcButton.TypeIndex = _loc2_;
      mcButton.ModeIndex = _loc3_;
   }
   function OnPressedPlay()
   {
      if(this.bModeSelectEnabled)
      {
         this.OnOk(true,false);
      }
      else if(this.bChooseModePanelEnabled)
      {
         this.OnOk(false,true);
      }
      else if(this.botDiffEnabled)
      {
         this.OnOk(false,false);
      }
   }
   function OnPressedBack()
   {
      if(this.bModeSelectEnabled)
      {
         _global.SinglePlayerMovie.hidePanel(true);
      }
      else if(this.botDiffEnabled)
      {
         this.OnCancelBotSelect();
      }
   }
   function OnPressedPrime()
   {
      this.m_numPrimeSetting = this.m_numPrimeSetting != 0?0:1;
      this.UpdatePrimeText();
   }
   function UpdatePrimeText()
   {
      var _loc3_ = this.panel.NavigationMaster.PCButtons.PrimeText;
      var _loc4_ = _global.CScaleformComponent_PartyList.GetFriendPrimeEligible(_global.CScaleformComponent_MyPersona.GetXuid());
      if(!_loc4_)
      {
         _loc3_.Text.htmlText = "#SFUI_Lobby_Prime_Not_Enrolled";
      }
      else if(this.m_numPrimeSetting == 1)
      {
         _loc3_.Text.htmlText = "#SFUI_Lobby_Prime_Active";
      }
      else
      {
         _loc3_.Text.htmlText = "#SFUI_Lobby_Prime_InActive";
      }
   }
   function ShowHidePrimeButton(bIsWorkshop)
   {
      var _loc4_ = _global.CScaleformComponent_PartyList.GetFriendPrimeEligible(_global.CScaleformComponent_MyPersona.GetXuid());
      var _loc5_ = this.panel.NavigationMaster.PCButtons.PrimeText;
      var _loc3_ = this.panel.NavigationMaster.PCButtons.PrimeStatus;
      _loc5_._visible = !(this.curGameTypeIndex == 0 && this.curGameModeIndex == 1 && this.usingMatchmaking && !bIsWorkshop && !this.teamLobbyMode)?false:true;
      _loc3_._visible = !(this.curGameTypeIndex == 0 && this.curGameModeIndex == 1 && this.usingMatchmaking && !bIsWorkshop && !this.teamLobbyMode)?false:true;
      if(!_loc4_)
      {
         _loc3_.setDisabled(true);
         this.panel.NavigationMaster.PCButtons.PrimeStatus.onRollOver = function()
         {
            this.dialog.ShowHidePrimeTooltip(true);
         };
         this.panel.NavigationMaster.PCButtons.PrimeStatus.onRollOut = function()
         {
            this.dialog.ShowHidePrimeTooltip(false);
         };
      }
      else
      {
         _loc3_.setDisabled(false);
         this.panel.NavigationMaster.PCButtons.PrimeStatus.RolledOut = function()
         {
         };
         this.panel.NavigationMaster.PCButtons.PrimeStatus.RolledOver = function()
         {
         };
      }
      this.panel.MapChooser.PageNumber._alpha = !_loc3_._visible?100:0;
   }
   function OnPressedBotDifficultySlot(slotNumber)
   {
      var _loc2_ = slotNumber - this.curBotDifficultyIndex;
      this.BotDifficultyChooserScroll(_loc2_);
   }
   function OnCancelBotSelect()
   {
      if(this.panel.bIsWorkshopmap)
      {
         this.UpdateNavSelection("Workshop");
      }
      else
      {
         this.UpdateNavSelection("Default");
      }
   }
   function OnCancelModePanel()
   {
      if(this.panel.bIsWorkshopmap)
      {
         this.UpdateNavSelection("Workshop");
      }
      else
      {
         this.UpdateNavSelection("Default");
      }
   }
   function OnCancelNoSteamError()
   {
      this.panel.SetDefaultTab();
      this.UpdateNavSelection("Default");
   }
   function BotDifficultyChooserScroll(delta)
   {
      while(delta != 0)
      {
         if(delta < 0)
         {
            this.curBotDifficultyIndex = this.DecFromOrder(this.curBotDifficultyIndex,this.dialogData.botDifficulty.order);
            delta = delta + 1;
         }
         else if(delta > 0)
         {
            this.curBotDifficultyIndex = this.IncFromOrder(this.curBotDifficultyIndex,this.dialogData.botDifficulty.order);
            delta = delta - 1;
         }
      }
      this.UpdateDialog();
   }
   function IncFromOrder(o, order)
   {
      o = o + 1;
      if(o >= order.length)
      {
         o = 0;
      }
      return o;
   }
   function DecFromOrder(o, order)
   {
      o = o - 1;
      if(o < 0)
      {
         o = order.length - 1;
      }
      return o;
   }
   function GetCurrentMode()
   {
      return this.objSelectedButton._GameMode;
   }
   function OnSelectWorkshopMode(button)
   {
      this.UnselectWorkshopButton();
      button.Selected._visible = true;
      this.objSelectedWorkshopButton = button;
      this.SetGameTypeAndMode(this.objSelectedWorkshopButton);
      this.ShowHidePrimeButton(true);
      this.panel.ModeChooser.TabWorkshop.FilterPanel.ClearExecuteFilter();
      this.panel.strFilterUserInputText = "";
      switch(this.objSelectedWorkshopButton)
      {
         case this.panel.ModeChooser.TabWorkshop.ModeAll:
            this.panel.SendWorkshopFilterData("",this.panel.strFilterUserInputText);
            break;
         case this.panel.ModeChooser.TabWorkshop.ModeDeathmatch:
            this.panel.SendWorkshopFilterData("deathmatch",this.panel.strFilterUserInputText);
            break;
         case this.panel.ModeChooser.TabWorkshop.ModeProgressive:
            this.panel.SendWorkshopFilterData("armsrace",this.panel.strFilterUserInputText);
            break;
         case this.panel.ModeChooser.TabWorkshop.ModeDemo:
            this.panel.SendWorkshopFilterData("demolition",this.panel.strFilterUserInputText);
            break;
         case this.panel.ModeChooser.TabWorkshop.ModeClassic:
            this.panel.SendWorkshopFilterData("classic",this.panel.strFilterUserInputText);
            break;
         case this.panel.ModeChooser.TabWorkshop.ModeCustom:
            this.panel.SendWorkshopFilterData("custom",this.panel.strFilterUserInputText);
      }
   }
   function UnselectWorkshopButton()
   {
      if(this.objSelectedWorkshopButton != undefined)
      {
         this.objSelectedWorkshopButton.Selected._visible = false;
      }
      this.WorkshopButtonToHighlight.Selected._visible = false;
   }
   function OnSelectMode(button)
   {
      this.UnselectButton();
      this.objSelectedButton = button;
      this.SetGameTypeAndMode(this.objSelectedButton);
      button.Selected._visible = true;
      this.UpdateDialog();
      this.UpdateMapImage();
      this.ShowHidePrimeButton();
   }
   function UnselectButton()
   {
      if(this.objSelectedButton != undefined)
      {
         this.objSelectedButton.Selected._visible = false;
      }
      this.ButtonToHighlight.Selected._visible = false;
   }
   function OnSelectedFromGameModePanel(button, numOfModes)
   {
      var _loc2_ = 0;
      _loc2_ = 0;
      while(_loc2_ <= numOfModes)
      {
         this.panel.ChooseModePanel["BtnMode" + _loc2_].Selected._visible = false;
         _loc2_ = _loc2_ + 1;
      }
      if(button.type == "anymode")
      {
         this.numAnyTypeMode = 1;
      }
      else
      {
         this.numAnyTypeMode = 0;
      }
      button.Selected._visible = true;
      this.SetGameTypeAndMode(button);
      this.panel.ChooseModePanel.NavigationMasterAI.PCButtons.PlayButton.setDisabled(false);
   }
   function SetGameTypeAndMode(button)
   {
      this.curGameTypeIndex = button.TypeIndex;
      this.curGameModeIndex = button.ModeIndex;
   }
   function setUIDevice()
   {
      if(_global.wantControllerShown)
      {
         this.UnlockNavText();
         this.UpdateNavText();
         this.panel.NavigationMaster.gotoAndStop("ShowController");
         this.panel.NavigationMasterAI.gotoAndStop("ShowController");
      }
      else
      {
         this.panel.NavigationMaster.gotoAndStop("HideController");
         this.panel.NavigationMasterAI.gotoAndStop("HideController");
      }
   }
   function changeUIDevice()
   {
      if(_global.wantControllerShown)
      {
         this.UnlockNavText();
         this.UpdateNavText();
         this.panel.NavigationMaster.gotoAndPlay("StartShowController");
         this.panel.NavigationMasterAI.gotoAndPlay("StartShowController");
      }
      else
      {
         this.LockNavText();
         this.panel.NavigationMaster.gotoAndPlay("StartHideController");
         this.panel.NavigationMasterAI.gotoAndPlay("StartHideController");
      }
   }
   function LockNavText()
   {
      this.lockNavText = true;
   }
   function UnlockNavText()
   {
      this.lockNavText = false;
   }
   function EnableDisablePlayButton()
   {
      if(this.bModeSelectEnabled)
      {
         if(this.usingMatchmaking && this.GetIsGameModeCompetitive() && _global.SinglePlayerMovie.arrCheckedMapNames.length != 0)
         {
            this.panel.NavigationMaster.PCButtons.PlayButton.setDisabled(false);
            return undefined;
         }
         if(this.usingMatchmaking && !this.GetIsGameModeCompetitive() && this.panel.strSelectedMapName != "")
         {
            this.panel.NavigationMaster.PCButtons.PlayButton.setDisabled(false);
            return undefined;
         }
         if(!this.usingMatchmaking && this.panel.strSelectedMapName != "")
         {
            this.panel.NavigationMaster.PCButtons.PlayButton.setDisabled(false);
            return undefined;
         }
         this.panel.NavigationMaster.PCButtons.PlayButton.setDisabled(true);
      }
      else
      {
         this.panel.NavigationMaster.PCButtons.PlayButton.setDisabled(true);
      }
   }
   function UpdateNavSelection(strNavToUse)
   {
      this.botDiffEnabled = false;
      this.bModeSelectEnabled = false;
      this.bChooseModePanelEnabled = false;
      this.bErrorPanelEnabled = false;
      switch(strNavToUse)
      {
         case "Workshop":
            this.bModeSelectEnabled = true;
            break;
         case "Default":
            this.bModeSelectEnabled = true;
            break;
         case "BotUi":
            removeMovieClip(this.panel.objSelectedButton._parent.btnOpenMapOverlay);
            this.botDiffEnabled = true;
            break;
         case "GameModePanel":
            this.bChooseModePanelEnabled = true;
            break;
         case "ErrorPanel":
            this.bErrorPanelEnabled = true;
      }
      this.panel.BotDiffPanel._visible = this.botDiffEnabled;
      this.panel.ChooseModePanel._visible = this.bChooseModePanelEnabled;
      this.panel.ErrorPanel._visible = this.bErrorPanelEnabled;
      this.panel.RemoveOpenMapInOverlayBtn();
      this.panel.ModeChooser.TabDefaultBtn.setDisabled(!this.bModeSelectEnabled);
      this.panel.ModeChooser.TabWorkshopBtn.setDisabled(!this.bModeSelectEnabled);
      this.panel.ModeChooser.TabWorkshop.RefreshWorkshop.setDisabled(!this.bModeSelectEnabled);
      this.panel.ModeChooser.TabWorkshop.OpenWorkshop.setDisabled(!this.bModeSelectEnabled);
      this.panel.ModeChooser.TabWorkshop.ModeAll.setDisabled(!this.bModeSelectEnabled);
      this.panel.ModeChooser.TabWorkshop.ModeDeathmatch.setDisabled(!this.bModeSelectEnabled);
      this.panel.ModeChooser.TabWorkshop.ModeDemo.setDisabled(!this.bModeSelectEnabled);
      this.panel.ModeChooser.TabWorkshop.ModeClassic.setDisabled(!this.bModeSelectEnabled);
      this.panel.ModeChooser.TabWorkshop.ModeProgressive.setDisabled(!this.bModeSelectEnabled);
      this.panel.ModeChooser.TabWorkshop.ModeCustom.setDisabled(!this.bModeSelectEnabled);
      this.panel.ModeChooser.TabDefault.ModeDeathmatch.setDisabled(!this.bModeSelectEnabled);
      this.panel.ModeChooser.TabDefault.ModeProgressive.setDisabled(!this.bModeSelectEnabled);
      this.panel.ModeChooser.TabDefault.ModeDemo.setDisabled(!this.bModeSelectEnabled);
      this.panel.ModeChooser.TabDefault.ModeCasual.setDisabled(!this.bModeSelectEnabled);
      this.panel.ModeChooser.TabDefault.ModeCompetitive.setDisabled(!this.bModeSelectEnabled);
      this.panel.NavigationMaster.PCButtons.BackButton.setDisabled(!this.bModeSelectEnabled);
      this.panel.NavigationMaster.PCButtons.PlayButton.setDisabled(!this.bModeSelectEnabled);
      this.panel.MapChooser.TabDefault.ModeCompetitive.setDisabled(!this.bModeSelectEnabled);
      this.EnableDisablePlayButton();
      var _loc2_ = 0;
      while(_loc2_ <= this.panel.MapTilesInfo._TotalTiles)
      {
         var _loc3_ = this.panel.MapChooser.MapButtonContainer["mcButtonMap" + _loc2_];
         _loc3_.setDisabled(!this.bModeSelectEnabled);
         _loc3_.Selected._visible = false;
         this.panel.objSelectedButton.Selected._visible = true;
         _loc2_ = _loc2_ + 1;
      }
   }
   function OnOk(bFromMapChooser, bFromSelectModePanel)
   {
      if(bFromMapChooser && this.panel.bIsWorkshopmap && (this.panel.strFilterGameMode == "" || this.panel.strFilterUserInputText != ""))
      {
         this.InitWorkshopModeSelectPanel(false);
         return undefined;
      }
      if(bFromMapChooser && this.panel.bIsWorkshopmap && this.panel.strFilterGameMode == "classic")
      {
         this.InitWorkshopModeSelectPanel(true);
         return undefined;
      }
      if((bFromMapChooser || bFromSelectModePanel) && !this.usingMatchmaking && this.panel.strFilterGameMode != "custom")
      {
         this.InitAISelection();
         return undefined;
      }
      this.SaveInitConvars();
      _global.navManager.PlayNavSound("ButtonAction");
      var _loc5_ = this.dialogData.gameTypes.order[this.curGameTypeIndex].gameModes.order[this.curGameModeIndex];
      var _loc3_ = "";
      var _loc10_ = "";
      _loc3_ = this.panel.GetMapsToLaunch();
      if(_loc3_.indexOf("random") != -1)
      {
         this.curMapIndex = Math.floor(Math.random() * (_loc5_.activeMapGroups.order.length - 1));
         _loc3_ = _loc5_.activeMapGroups.ordername[this.curMapIndex];
      }
      var _loc7_ = this.dialogData.gameTypes.ordername[this.curGameTypeIndex];
      var _loc6_ = this.dialogData.gameTypes.order[this.curGameTypeIndex].gameModes.ordername[this.curGameModeIndex];
      if(!this.usingMatchmaking)
      {
         _global.SinglePlayerAPI.SetCustomBotDifficulty(this.curBotDifficultyIndex);
      }
      var _loc4_ = undefined;
      if(this.usingMatchmaking)
      {
         _loc4_ = "System {\n access public\n network LIVE \n}\n" + "Game {\n" + " type " + _loc7_ + "\n" + " mode " + _loc6_ + "\n" + " mapgroupname " + _loc3_ + "\n" + " prime " + this.m_numPrimeSetting + "\n" + "}\n" + "Options {\n" + " action custommatch " + "\n" + " bypasslobby 1 " + "\n" + " anytypemode " + this.numAnyTypeMode + " " + "\n" + "}\n" + "Contexts {\n" + "\n" + "}\n" + "Properties {\n" + "\n" + "}\n";
      }
      else
      {
         _loc4_ = "System {\n network offline \n}\n" + "Game {\n" + " type " + _loc7_ + "\n" + " mode " + _loc6_ + "\n" + " mapgroupname " + _loc3_ + "\n" + "}\n" + "Options {\n" + " action create " + "\n" + " anytypemode " + this.numAnyTypeMode + " " + "\n" + "}\n" + "Contexts {\n" + "\n" + "}\n" + "Properties {\n" + "\n" + "}\n";
      }
      var _loc9_ = _global.SinglePlayerAPI.CheckGameSettingsRequirements(_loc4_);
      if(_loc9_ <= 0)
      {
         return undefined;
      }
      _global.SinglePlayerAPI.SetMatchmakingQuery(_loc4_);
      if(this.teamLobbyMode)
      {
         _global.SinglePlayerAPI.UpdatedSelections(this.dialogData.gameTypes.order[this.curGameTypeIndex].value,_loc5_.value,this.panel.GetMapsToLaunch(),this.numAnyTypeMode);
         _global.SinglePlayerMovie.hidePanel(true);
         return undefined;
      }
      _global.SinglePlayerAPI.OnOk();
      _global.SinglePlayerMovie.hidePanel(false);
   }
   function InitAISelection()
   {
      this.UpdateNavSelection("BotUi");
      this.panel.BotDiffPanel.Bg.onRollOver = function()
      {
         "";
      };
      this.panel.BotDiffPanel.NavigationMasterAI.PCButtons.PlayButton.dialog = this;
      this.panel.BotDiffPanel.NavigationMasterAI.PCButtons.PlayButton.SetText("#SFUI_GO");
      this.panel.BotDiffPanel.NavigationMasterAI.PCButtons.PlayButton.Action = function()
      {
         this.dialog.OnPressedPlay();
      };
      this.panel.BotDiffPanel.NavigationMasterAI.PCButtons.BackButton.dialog = this;
      this.panel.BotDiffPanel.NavigationMasterAI.PCButtons.BackButton.Action = function()
      {
         this.dialog.OnCancelBotSelect();
      };
   }
   function InitWorkshopModeSelectPanel(bIsClassicFilter)
   {
      var _loc9_ = "";
      var arr = [];
      var _loc8_ = 6;
      var _loc3_ = "";
      var _loc4_ = "";
      var _loc5_ = 0;
      this.numAnyTypeMode = 0;
      this.panel.ChooseModePanel.NavigationMasterAI.PCButtons.PlayButton.dialog = this;
      this.panel.ChooseModePanel.NavigationMasterAI.PCButtons.PlayButton.SetText("#SFUI_GO");
      this.panel.ChooseModePanel.NavigationMasterAI.PCButtons.PlayButton.Action = function()
      {
         this.dialog.OnPressedPlay();
      };
      this.panel.ChooseModePanel.NavigationMasterAI.PCButtons.PlayButton.setDisabled(true);
      this.panel.ChooseModePanel.NavigationMasterAI.PCButtons.BackButton.dialog = this;
      this.panel.ChooseModePanel.NavigationMasterAI.PCButtons.BackButton.Action = function()
      {
         this.dialog.OnCancelModePanel();
      };
      this.panel.ChooseModePanel.Bg.onRollOver = function()
      {
         "";
      };
      if(bIsClassicFilter)
      {
         arr.splice(0,0,"Classic","Competitive");
      }
      else
      {
         arr = this.panel.GetGameModes();
      }
      var _loc2_ = 0;
      while(_loc2_ <= _loc8_)
      {
         if(arr[_loc2_] == "AnyMode")
         {
            if(arr[_loc2_ + 1] == "Custom")
            {
               _loc3_ = "custom";
               _loc4_ = "custom";
            }
            else if(arr[_loc2_ + 1] == "Classic")
            {
               _loc3_ = "classic";
               _loc4_ = "casual";
            }
            else if(arr[_loc2_ + 1] == "Demolition")
            {
               _loc3_ = "gungame";
               _loc4_ = "gungametrbomb";
            }
            else if(arr[_loc2_ + 1] == "Arms Race" || arr[_loc2_ + 1] == "Armsrace")
            {
               _loc3_ = "gungame";
               _loc4_ = "gungameprogressive";
            }
            _loc5_ = 1;
         }
         else if(arr[_loc2_] == "Custom")
         {
            _loc3_ = "custom";
            _loc4_ = "custom";
            _loc5_ = 0;
         }
         else if(arr[_loc2_] == "Classic")
         {
            _loc3_ = "classic";
            _loc4_ = "casual";
            _loc5_ = 0;
         }
         else if(arr[_loc2_] == "Competitive")
         {
            _loc3_ = "classic";
            _loc4_ = "competitive";
            _loc5_ = 0;
         }
         else if(arr[_loc2_] == "Demolition")
         {
            _loc3_ = "gungame";
            _loc4_ = "gungametrbomb";
            _loc5_ = 0;
         }
         else if(arr[_loc2_] == "Arms Race")
         {
            _loc3_ = "gungame";
            _loc4_ = "gungameprogressive";
            _loc5_ = 0;
         }
         else if(arr[_loc2_] == "Deathmatch")
         {
            _loc3_ = "gungame";
            _loc4_ = "deathmatch";
            _loc5_ = 0;
         }
         if(_loc2_ < arr.length && arr.length > 0)
         {
            var _loc6_ = this.dialogData.gameTypes.ordernameToIndex[_loc3_];
            var _loc7_ = this.dialogData.gameTypes.order[_loc6_].gameModes.ordernameToIndex[_loc4_];
            this.panel.ChooseModePanel["BtnMode" + _loc2_].dialog = this;
            this.panel.ChooseModePanel["BtnMode" + _loc2_].Action = function()
            {
               this.dialog.OnSelectedFromGameModePanel(this,arr.length);
            };
            this.panel.ChooseModePanel["BtnMode" + _loc2_].TypeIndex = _loc6_;
            this.panel.ChooseModePanel["BtnMode" + _loc2_].ModeIndex = _loc7_;
            this.panel.ChooseModePanel["BtnMode" + _loc2_]._visible = true;
            this.panel.ChooseModePanel["BtnMode" + _loc2_].Selected._visible = false;
            if(_loc5_ == 1)
            {
               this.panel.ChooseModePanel["BtnMode" + _loc2_].SetText("#SFUI_GameModeAny");
               this.panel.ChooseModePanel["BtnMode" + _loc2_].type = "anymode";
               this.panel.ChooseModePanel["BtnMode" + _loc2_].Selected._visible = true;
               this.SetGameTypeAndMode(this.panel.ChooseModePanel["BtnMode" + _loc2_]);
               this.panel.ChooseModePanel.NavigationMasterAI.PCButtons.PlayButton.setDisabled(false);
               this.numAnyTypeMode = 1;
            }
            else if(!this.usingMatchmaking && this.dialogData.gameTypes.order[_loc6_].gameModes.order[_loc7_].nameID_SP)
            {
               this.panel.ChooseModePanel["BtnMode" + _loc2_].SetText(this.dialogData.gameTypes.order[_loc6_].gameModes.order[_loc7_].nameID_SP);
            }
            else
            {
               this.panel.ChooseModePanel["BtnMode" + _loc2_].SetText(this.dialogData.gameTypes.order[_loc6_].gameModes.order[_loc7_].nameID);
            }
         }
         else
         {
            this.panel.ChooseModePanel["BtnMode" + _loc2_]._visible = false;
         }
         if(arr.length == 1)
         {
            this.SetGameTypeAndMode(this.panel.ChooseModePanel["BtnMode" + _loc2_]);
            this.OnOk(false,true);
            return undefined;
         }
         _loc2_ = _loc2_ + 1;
      }
      this.UpdateNavSelection("GameModePanel");
   }
   function InitErrorPanel(ErrorCode)
   {
      this.UpdateNavSelection("ErrorPanel");
      trace("---------->InitErrorPanel");
      this.panel.ErrorPanel.BackButton.dialog = this;
      this.panel.ErrorPanel.Bg.onRollOver = function()
      {
         "";
      };
      if(ErrorCode == 0)
      {
         this.panel.ErrorPanel.Text.htmlText = "#SFUI_Workshop_Error_Overlay_Disabled";
         this.panel.ErrorPanel.BackButton.Action = function()
         {
            this.dialog.OnCancelModePanel();
         };
      }
      if(ErrorCode == 1)
      {
         this.panel.ErrorPanel.Text.htmlText = "#SFUI_Workshop_Error_NoSteam";
         this.panel.ErrorPanel.BackButton.Action = function()
         {
            this.dialog.OnCancelNoSteamError();
         };
      }
   }
   function handlePendingInvites(bPendingInvite)
   {
      if(this.m_bPendingInvites != bPendingInvite)
      {
         this.m_bPendingInvites = bPendingInvite;
         this.UnlockNavText();
         this.UpdateNavText();
         this.LockNavText();
      }
   }
   function GetDialogDataUI(gameTypeIndex, gameModeIndex)
   {
      var _loc2_ = undefined;
      if(this.usingMatchmaking)
      {
         _loc2_ = this.dialogData.gameTypes.order[gameTypeIndex].gameModes.order[gameModeIndex].ui_mp;
      }
      if(_loc2_ == undefined)
      {
         _loc2_ = this.dialogData.gameTypes.order[gameTypeIndex].gameModes.order[gameModeIndex].ui;
      }
      return _loc2_;
   }
   function GetDialogDataConvars(gameTypeIndex, gameModeIndex)
   {
      var _loc2_ = undefined;
      if(this.usingMatchmaking)
      {
         _loc2_ = this.dialogData.gameTypes.order[gameTypeIndex].gameModes.order[gameModeIndex].convars_mp;
      }
      if(_loc2_ == undefined)
      {
         _loc2_ = this.dialogData.gameTypes.order[gameTypeIndex].gameModes.order[gameModeIndex].convars;
      }
      return _loc2_;
   }
   function GetIsGameModeCompetitive()
   {
      if(this.curGameTypeIndex == 0 && this.curGameModeIndex == 1)
      {
         return true;
      }
      return false;
   }
   function GetIsGameModeClassic()
   {
      if(this.curGameTypeIndex == 0 && this.curGameModeIndex == 0)
      {
         return true;
      }
      return false;
   }
   function GetUsingMatchmaking()
   {
      return this.usingMatchmaking;
   }
   function GetInTeamMode()
   {
      return this.teamLobbyMode;
   }
   function GetInTrainingMode()
   {
      return this.trainingMode;
   }
}
