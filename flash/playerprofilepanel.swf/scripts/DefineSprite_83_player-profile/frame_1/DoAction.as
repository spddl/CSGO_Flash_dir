function InitPlayerProfile(xuid)
{
   if(xuid == "" || xuid == undefined || xuid == null)
   {
      m_PlayerXuid = _global.CScaleformComponent_MyPersona.GetXuid();
      m_bIsSelf = true;
   }
   else
   {
      m_PlayerXuid = xuid;
      m_bIsSelf = false;
   }
   SetPlayerData();
   SetupFlairScrollButtons();
   SetEloBracketInfo();
   SetXpLevelInfo();
   SetCommendationsInfo();
   SetTeamPanel();
   SetElevatedStatusPanel();
}
function RefreshAvatarImage()
{
   if(m_PlayerXuid == "" || m_PlayerXuid == undefined || m_PlayerXuid == null)
   {
      m_PlayerXuid = _global.CScaleformComponent_MyPersona.GetXuid();
   }
   Avatar._visible = true;
   Avatar.ShowAvatar(3,m_PlayerXuid,true,false);
   var _loc2_ = Avatar.GetFlairItemName(m_PlayerXuid);
   SetMedalText(_loc2_);
   SetFlairItems();
}
function SetPlayerData()
{
   if(m_PlayerXuid == "")
   {
      m_PlayerXuid = _global.CScaleformComponent_MyPersona.GetXuid();
   }
   var _loc2_ = _global.CScaleformComponent_FriendsList.GetFriendName(m_PlayerXuid);
   PlayerNameBox.SetText(_loc2_);
   _global.AutosizeTextDown(PlayerNameBox.Text,10);
   RefreshAvatarImage();
}
function SetMedalText(text)
{
   trace("#######  SetMedalText : text = " + text);
   if(text != undefined && text != null && text != "")
   {
      MedalTextPanel._visible = true;
      MedalTextPanel.MedalDescription.MedalDescriptionText.SetText(text);
   }
   else
   {
      MedalTextPanel._visible = false;
   }
}
function SetCommendationsInfo()
{
   var _loc13_ = _global.CScaleformComponent_FriendsList.GetFriendCommendations(m_PlayerXuid,"friendly");
   var _loc15_ = _global.CScaleformComponent_FriendsList.GetFriendCommendations(m_PlayerXuid,"teaching");
   var _loc14_ = _global.CScaleformComponent_FriendsList.GetFriendCommendations(m_PlayerXuid,"leader");
   var _loc6_ = new Array("friendly","teaching","leader");
   var _loc9_ = new Array(_loc13_,_loc15_,_loc14_);
   var _loc8_ = 0;
   var _loc4_ = 0;
   while(_loc4_ < _loc6_.length)
   {
      var _loc7_ = "commend" + _loc6_[_loc4_];
      var _loc5_ = "Commend" + _loc4_;
      if(Commendations.IconCommendHolder[_loc5_])
      {
         Commendations.IconCommendHolder[_loc5_].removeMovieClip();
      }
      if(_loc9_[_loc4_] != 0)
      {
         Commendations.IconCommendHolder.attachMovie(_loc7_,_loc5_,_loc4_);
         var _loc3_ = Commendations.IconCommendHolder[_loc5_];
         _loc3_.dialog = this;
         _loc3_.Text.htmlText = _loc9_[_loc4_];
         _loc3_._y = _loc3_._y + (_loc3_._height + 2) * _loc8_;
         var _loc12_ = {x:_loc3_._x,y:_loc3_._y};
         trace("----------------------------------------------mcCommendIcon._y" + _loc3_._y);
         if(_loc6_[_loc4_] == "friendly")
         {
            _loc3_.onRollOver = function()
            {
               rollOverToolTipCommendations(this,true,"#SFUI_MainMenu_CommendTooltip_friendly");
            };
            _loc3_.onRollOut = function()
            {
               rollOverToolTipCommendations(this,false,"#SFUI_MainMenu_CommendTooltip_friendly");
            };
         }
         else if(_loc6_[_loc4_] == "teaching")
         {
            _loc3_.onRollOver = function()
            {
               rollOverToolTipCommendations(this,true,"#SFUI_MainMenu_CommendTooltip_teaching");
            };
            _loc3_.onRollOut = function()
            {
               rollOverToolTipCommendations(this,false,"#SFUI_MainMenu_CommendTooltip_teaching");
            };
         }
         else if(_loc6_[_loc4_] == "leader")
         {
            _loc3_.onRollOver = function()
            {
               rollOverToolTipCommendations(this,true,"#SFUI_MainMenu_CommendTooltip_leader");
            };
            _loc3_.onRollOut = function()
            {
               rollOverToolTipCommendations(this,false,"#SFUI_MainMenu_CommendTooltip_leader");
            };
         }
         _loc8_ = _loc8_ + 1;
      }
      _loc4_ = _loc4_ + 1;
   }
}
function SetFlairItems()
{
   for(var _loc5_ in MedalsContainer.Medals.IconMedalContainer)
   {
      removeMovieClip(MedalsContainer.Medals.IconMedalContainer[_loc5_]);
   }
   var _loc4_ = Math.min(MAX_FLAIR_SLOTS,_global.CScaleformComponent_FriendsList.GetFriendDisplayItemDefCount(m_PlayerXuid));
   m_nLastFlairItem = 0;
   m_nCurFlairIndexPos = 0;
   if(m_bSetFlairContainerDefaultX == false)
   {
      m_nFlairContainerDefaultX = MedalsContainer._x;
      m_bSetFlairContainerDefaultX = true;
   }
   trace("SetFlairItems: nNumItems = " + _loc4_ + ", GetFriendDisplayItemDefCount = " + _loc4_);
   var _loc2_ = 0;
   while(_loc2_ < _loc4_)
   {
      var _loc3_ = _global.CScaleformComponent_FriendsList.GetFriendDisplayItemDefByIndex(m_PlayerXuid,_loc2_);
      LoadFlairImage(_loc2_,_loc3_);
      m_nLastFlairItem = _loc2_ + 1;
      _loc2_ = _loc2_ + 1;
   }
   GetMedalsInfo();
}
function LoadFlairImage(numMedalIndex, ItemDef)
{
   if(ItemDef != "0" && ItemDef != "" && ItemDef != undefined)
   {
      var _loc7_ = "RankIcon" + numMedalIndex;
      MedalsContainer.Medals.IconMedalContainer.attachMovie("icon-flair-container",_loc7_,numMedalIndex);
      var _loc3_ = MedalsContainer.Medals.IconMedalContainer[_loc7_];
      _loc3_._x = m_nLastFlairItem * (nMedalWidth + nMedalWidth / 3.5) - (nMedalFlairWidth - nMedalWidth) / 2;
      var strToolTipHint = _global.CScaleformComponent_ItemData.GetItemName(ItemDef);
      var _loc12_ = {x:_loc3_._x + 66,y:_loc3_._height + 50};
      _loc3_.onRollOver = function()
      {
         rollOverToolTipMedals(this,true,strToolTipHint);
      };
      _loc3_.onRollOut = function()
      {
         rollOverToolTipMedals(this,false,strToolTipHint);
      };
      trace("SetFlairItems:LoadFlairImage: strToolTipHint = " + strToolTipHint);
      var _loc4_ = new Object();
      _loc4_.onLoadInit = function(target_mc)
      {
         target_mc._width = nMedalFlairWidth;
         target_mc._height = nMedalFlairHeight;
         trace("SetFlairItems:LoadFlairImage:mclListener.onLoadInit    target_mc._x = " + target_mc._x);
      };
      _loc4_.onLoadError = function(target_mc, errorCode, status)
      {
         trace("Error loading image: " + errorCode + " [" + status + "] ----- You probably forgot to author a small version of your flair item (needs to end with _small).");
      };
      var _loc8_ = _global.CScaleformComponent_ItemData.GetItemInventoryImage(ItemDef) + "_small.png";
      trace("SetFlairItems:LoadFlairImage: image = " + _loc8_);
      var _loc6_ = new MovieClipLoader();
      _loc6_.addListener(_loc4_);
      _loc3_.createEmptyMovieClip("flair",0);
      _loc6_.loadClip(_loc8_,_loc3_.flair);
   }
   else
   {
      trace("!!!!!+++++++++++++++++++++++++  LoadFlairImage:   Medal._visible = false;");
   }
}
function GetMedalsInfo()
{
   var _loc6_ = _global.CScaleformComponent_Medals.GetAchievementMedalTypesCount();
   trace("GetMedalsInfo: numMedalTypesCount = " + _loc6_);
   var _loc5_ = m_nLastFlairItem;
   trace("SetFlairItems:LoadFlairImage:GetMedalsInfo m_nLastFlairItem = " + m_nLastFlairItem);
   var _loc3_ = 0;
   while(_loc3_ < _loc6_)
   {
      var _loc4_ = _global.CScaleformComponent_Medals.GetMedalTypeByIndex(_loc3_);
      var _loc2_ = _global.CScaleformComponent_FriendsList.GetFriendMedalRankByType(m_PlayerXuid,_loc4_);
      trace("GetMedalsInfo: numRank = " + _loc2_);
      if(!(_loc2_ == 0 || _loc2_ == undefined))
      {
         DisplayMedals(_loc4_,_loc3_,_loc2_,_loc5_);
         _loc5_ = _loc5_ + 1;
      }
      _loc3_ = _loc3_ + 1;
   }
   m_nTotalFlairItems = _loc5_ + 1;
   ButtonNext._visible = m_nTotalFlairItems - 1 > FLAIR_SLOTS_PER_PAGE;
}
function DisplayMedals(strMedalType, numMedalIndex, numRank, idxAttachMedal)
{
   if(idxAttachMedal >= MAX_FLAIR_SLOTS)
   {
      trace("DisplayMedals: ( idxAttachMedal >= MAX_FLAIR_SLOTS ) : idxAttachMedal =" + idxAttachMedal);
      return undefined;
   }
   var _loc9_ = "Rank_" + numMedalIndex + "_0" + numRank;
   var _loc5_ = "RankIcon" + idxAttachMedal;
   MedalsContainer.Medals.IconMedalContainer.attachMovie(_loc9_,_loc5_,idxAttachMedal);
   var _loc3_ = MedalsContainer.Medals.IconMedalContainer[_loc5_];
   _loc3_._width = nMedalWidth;
   _loc3_._height = nMedalWidth;
   _loc3_._x = idxAttachMedal * (nMedalWidth + nMedalWidth / 3.5);
   _loc3_._y = 2;
   var strToolTipHint = _global.CScaleformComponent_Medals.GetMedalDescriptionByType(strMedalType,numRank);
   trace("DisplayMedals: Adding achievement medal! : idxAttachMedal =" + idxAttachMedal + ", strMedalType = " + strMedalType + ", numRank = " + numRank);
   if(m_PlayerXuid == _global.CScaleformComponent_MyPersona.GetXuid())
   {
      var _loc6_ = _global.CScaleformComponent_MyPersona.GetMyMedalAdditionalInfo(strMedalType);
      if(_loc6_ != "")
      {
         strToolTipHint = _global.GameInterface.Translate(strToolTipHint);
         strToolTipHint = strToolTipHint + "\n";
         strToolTipHint = strToolTipHint + _loc6_;
      }
   }
   var _loc12_ = {x:_loc3_._x + 60,y:_loc3_._height + 50};
   _loc3_.onRollOver = function()
   {
      rollOverToolTipMedals(this,true,strToolTipHint);
   };
   _loc3_.onRollOut = function()
   {
      rollOverToolTipMedals(this,false,strToolTipHint);
   };
}
function SetEloBracketInfo()
{
   var _loc3_ = _global.CScaleformComponent_FriendsList.GetFriendCompetitiveRank(m_PlayerXuid);
   var _loc2_ = _global.CScaleformComponent_FriendsList.GetFriendCompetitiveWins(m_PlayerXuid);
   var _loc5_ = _global.CScaleformComponent_MyPersona.GetMyOfficialTournamentName();
   var _loc4_ = EloRankPanel.IconRank;
   var TooltipLoc = {x:EloRankPanel._x + 40,y:EloRankPanel._height + EloRankPanel._y};
   EloRankPanel.HelpText._visible = false;
   EloRankPanel.RankName._visible = false;
   EloRankPanel.CompWins._visible = false;
   _loc4_._visible = false;
   if(_loc4_ != undefined)
   {
      _loc4_.unloadMovie();
   }
   if(_loc5_ != "" && _loc5_ != undefined)
   {
      return undefined;
   }
   if(_loc3_ < 1 && _loc2_ >= 10)
   {
      EloRankPanel.HelpText.htmlText = "#SFUI_MainMenu_Wins_Title";
      EloRankPanel.HelpText._visible = true;
      SetCompWins(_loc2_);
      if(m_bIsSelf)
      {
         EloRankPanel.EloHitbox.onRollOver = function()
         {
            rollOverToolTipXp(TooltipLoc,true,"#SFUI_Scoreboard_CompWins_Skill_Group_Expired");
         };
         EloRankPanel.EloHitbox.onRollOut = function()
         {
            rollOverToolTipXp(TooltipLoc,false,"#SFUI_Scoreboard_CompWins_Skill_Group_Expired");
         };
      }
      else
      {
         InspectEloTooltips(TooltipLoc);
      }
      return undefined;
   }
   if(_loc3_ < 1)
   {
      EloRankPanel.EloHitbox.onRollOver = function()
      {
         "";
      };
      EloRankPanel.EloHitbox.onRollOut = function()
      {
         "";
      };
      if(_loc2_ > 0)
      {
         var _loc6_ = 10;
         var _loc7_ = _loc6_ - _loc2_;
         var strToolTipText = _global.GameInterface.Translate("#SFUI_Scoreboard_CompWins_No_Skill_Group");
         strToolTipText = _global.ConstructString(strToolTipText,_loc7_);
         EloRankPanel.HelpText.htmlText = "#SFUI_MainMenu_Wins_Title";
         EloRankPanel.HelpText._visible = true;
         SetCompWins(_loc2_);
         if(m_bIsSelf)
         {
            EloRankPanel.EloHitbox.onRollOver = function()
            {
               rollOverToolTipXp(TooltipLoc,true,strToolTipText);
            };
            EloRankPanel.EloHitbox.onRollOut = function()
            {
               rollOverToolTipXp(TooltipLoc,false,strToolTipText);
            };
         }
      }
      return undefined;
   }
   if(_loc3_ >= 1)
   {
      _loc4_._visible = true;
      EloRankPanel.RankName._visible = true;
      EloRankPanel.RankName.htmlText = _global.GameInterface.Translate(aRankNames[_loc3_]);
      _global.AutosizeTextDown(EloRankPanel.RankName,8);
      EloRankPanel.RankName.autoSize = "left";
      EloRankPanel.RankName._y = (EloRankPanel._height - EloRankPanel.RankName._height) / 2 - 3;
      SetCompWins(_loc2_);
      if(m_bIsSelf)
      {
         EloRankPanel.EloHitbox.onRollOver = function()
         {
            rollOverToolTipXp(TooltipLoc,true,"#SFUI_MainMenu_SkillTooltip");
         };
         EloRankPanel.EloHitbox.onRollOut = function()
         {
            rollOverToolTipXp(TooltipLoc,false,"#SFUI_MainMenu_SkillTooltip");
         };
      }
      else
      {
         InspectEloTooltips(TooltipLoc);
      }
      LoadEloIcon(60,24,"econ/status_icons/skillgroup" + _loc3_ + ".png",_loc4_);
   }
}
function InspectEloTooltips(TooltipLoc)
{
   EloRankPanel.EloHitbox.onRollOver = function()
   {
      rollOverToolTipXp(TooltipLoc,true,"#SFUI_MainMenu_SkillTooltip");
   };
   EloRankPanel.EloHitbox.onRollOut = function()
   {
      rollOverToolTipXp(TooltipLoc,false,"#SFUI_MainMenu_SkillTooltip");
   };
}
function IsPlayerDetailsVisible(bIsShown)
{
   m_bPlayerDetailsVisible = bIsShown;
   trace("--------------------------------m_bPlayerDetailsVisible---------------------------" + m_bPlayerDetailsVisible);
}
function LoadEloIcon(numWidth, numHeight, MovieName, objIcon)
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
function SetCompWins(numWins)
{
   EloRankPanel.CompWins._visible = true;
   EloRankPanel.CompWins.Text.htmlText = numWins;
   EloRankPanel.CompWins.autoSize = "right";
   EloRankPanel.CompWins.WinsIcon._x = - EloRankPanel.CompWins.Text.textWidth + EloRankPanel.CompWins.WinsIcon._width * 1.8;
   var TooltipLoc = {x:EloRankPanel.CompWins._x + (EloRankPanel.CompWins.WinsIcon._x - 14),y:EloRankPanel._height + EloRankPanel._y - 3};
   EloRankPanel.CompWins.onRollOver = function()
   {
      rollOverToolTipXp(TooltipLoc,true,"#SFUI_MainMenu_CommendTooltip_Wins");
   };
   EloRankPanel.CompWins.onRollOut = function()
   {
      rollOverToolTipXp(TooltipLoc,false,"#SFUI_MainMenu_CommendTooltip_Wins");
   };
}
function SetXpLevelInfo()
{
   var _loc5_ = _global.CScaleformComponent_FriendsList.GetFriendLevel(m_PlayerXuid);
   var _loc10_ = _global.CScaleformComponent_FriendsList.GetFriendXp(m_PlayerXuid);
   var _loc14_ = _global.CScaleformComponent_MyPersona.GetXpPerLevel();
   var _loc13_ = _global.CScaleformComponent_MyPersona.GetActiveXpBonuses();
   var _loc11_ = _global.CScaleformComponent_Inventory.GetMaxLevel();
   var _loc19_ = XpPanel.XpBar._width;
   var _loc8_ = false;
   var TooltipLoc = {x:XpPanel._x - 6,y:XpPanel._height + XpPanel._y + 10};
   var _loc12_ = false;
   ServiceBtn._visible = false;
   trace("---------------------------numLevel------------------------" + _loc5_);
   trace("---------------------------numXp---------------------------" + _loc10_);
   trace("---------------------------numXpNeededForNextLevel---------" + _loc14_);
   trace("---------------------------strActiveBonuses----------------" + _loc13_);
   trace("---------------------------numLevelForServiceMedal----------------" + _loc11_);
   var _loc7_ = _global.CScaleformComponent_GameTypes.GetActiveSeasionIndexValue();
   _loc7_ = _loc7_ + 1;
   var _loc17_ = _global.CScaleformComponent_MyPersona.GetMyMedalRankByType(_loc7_ + "Operation$OperationCoin");
   if(_loc17_ <= 1)
   {
      _loc7_ = 0;
   }
   if(_loc5_ == undefined || _loc5_ == 0 || _loc5_ == undefined || _loc10_ == undefined)
   {
      XpPanel._visible = false;
      return undefined;
   }
   XpPanel._visible = true;
   if(_loc5_ >= _loc11_)
   {
      _loc5_ = _loc11_;
      _loc12_ = true;
   }
   var _loc4_ = _loc13_.split(",");
   var _loc9_ = "";
   var _loc6_ = "";
   var _loc15_ = _loc5_ + 1;
   var _loc3_ = 0;
   while(_loc3_ < _loc4_.length)
   {
      if(_loc4_[_loc3_] == 2)
      {
         _loc8_ = true;
      }
      _loc3_ = _loc3_ + 1;
   }
   _loc9_ = _global.GameInterface.Translate("#SFUI_XP_RankName_" + _loc5_);
   _loc6_ = _global.GameInterface.Translate("#SFUI_XP_RankName_Display");
   _loc9_ = _global.ConstructString(_loc6_,_loc5_,_loc9_);
   if(m_bIsSelf)
   {
      if(!_loc8_)
      {
         _loc6_ = _global.GameInterface.Translate("#SFUI_XP_RankName_Display");
         _loc6_ = _global.ConstructString(_loc6_,_loc15_,_global.GameInterface.Translate("#SFUI_XP_RankName_" + _loc15_));
      }
      else
      {
         _loc6_ = _global.GameInterface.Translate("#SFUI_XP_RankName_Next_Drop");
         var _loc16_ = "";
         if(_loc7_ > 0)
         {
            _loc16_ = " " + _global.GameInterface.Translate("#SFUI_mapgroup_op_op0" + _loc7_ + "_Short");
         }
         _loc6_ = _global.ConstructString(_loc6_,_loc15_,_loc16_);
      }
      if(_loc12_)
      {
         XpPanel.NextLevelName._visible = false;
         ServiceBtn.dialog = this;
         ServiceBtn.SetText("#SFUI_Redeem_Service_Medal");
         _global.AutosizeTextDown(ServiceBtn.ButtonText.Text,8);
         ServiceBtn.Action = function()
         {
            this.dialog.RequestServiceMedal();
         };
         ServiceBtn._visible = true;
      }
      else
      {
         ServiceBtn._visible = false;
         XpPanel.NextLevelName._visible = true;
         XpPanel.NextLevelName.htmlText = _loc6_;
         XpPanel.NextLevelName.autoSize = "right";
      }
   }
   else
   {
      XpPanel.NextLevelName._visible = false;
   }
   XpPanel.LevelName.htmlText = _loc9_;
   XpPanel.LevelName.autoSize = "left";
   var _loc18_ = _loc10_ / _loc14_ * 100;
   XpPanel.XpBar.Bar._xscale = _loc18_;
   LoadEloIcon(28,28,"econ/status_icons/level" + _loc5_ + ".png",XpPanel.XpIcon);
   var strBonuses = GetXpReasonsText(_loc4_,_loc7_,_loc13_,_loc10_,_loc14_,_loc5_,_loc12_);
   XpPanel.onRollOver = function()
   {
      rollOverToolTipXp(TooltipLoc,true,strBonuses);
   };
   XpPanel.onRollOut = function()
   {
      rollOverToolTipXp(TooltipLoc,false,strBonuses);
   };
}
function GetXpReasonsText(aReason, CurrentOpOwned, strActiveBonuses, numXp, numXpNeededForNextLevel, numLevel, bMaxLevel)
{
   var _loc13_ = _global.FormatNumberToString(numXp);
   var _loc11_ = _global.FormatNumberToString(numXpNeededForNextLevel - numXp);
   if(m_bPlayerDetailsVisible && !m_bIsSelf)
   {
      if(bMaxLevel)
      {
         var _loc15_ = _global.GameInterface.Translate("#SFUI_Scoreboard_XPBar_TooltipInspectProfileMax");
      }
      else
      {
         _loc15_ = _global.GameInterface.Translate("#SFUI_Scoreboard_XPBar_TooltipInspectProfile");
      }
      _loc15_ = _global.ConstructString(_loc15_,_loc13_,_loc11_);
      return _loc15_;
   }
   if(bMaxLevel)
   {
      var _loc2_ = 0;
      while(_loc2_ < aReason.length)
      {
         if(aReason[_loc2_] == 2)
         {
            aReason.splice(_loc2_,1);
         }
         _loc2_ = _loc2_ + 1;
      }
   }
   if(aReason.length < 1 || strActiveBonuses == "" || strActiveBonuses == undefined || strActiveBonuses == null)
   {
      if(bMaxLevel)
      {
         _loc15_ = _global.GameInterface.Translate("#SFUI_Scoreboard_XPBar_TooltipNoBonusesMax");
      }
      else
      {
         _loc15_ = _global.GameInterface.Translate("#SFUI_Scoreboard_XPBar_TooltipNoBonuses");
      }
      _loc15_ = _global.ConstructString(_loc15_,_loc13_,_loc11_);
      if(bMaxLevel && m_bIsSelf)
      {
         _loc15_ = _global.GameInterface.Translate("#SFUI_Redeem_Service_XpBarToolTip") + "\n\n" + _loc15_;
      }
      return _loc15_;
   }
   var _loc10_ = new Array();
   if(bMaxLevel)
   {
      var _loc12_ = _global.GameInterface.Translate("#SFUI_Scoreboard_XpBar_TooltipMax");
   }
   else
   {
      _loc12_ = _global.GameInterface.Translate("#SFUI_Scoreboard_XpBar_Tooltip");
   }
   var _loc4_ = "";
   _loc2_ = 0;
   while(_loc2_ < aReason.length)
   {
      if(bMaxLevel && _loc2_ == 0)
      {
         _loc4_ = _global.GameInterface.Translate("#SFUI_Redeem_Service_XpBarToolTip") + "\n\n";
      }
      if(aReason[_loc2_] == 2)
      {
         var _loc5_ = "";
         var _loc6_ = "";
         if(CurrentOpOwned > 0)
         {
            _loc5_ = " " + _global.GameInterface.Translate("#SFUI_mapgroup_op_op0" + CurrentOpOwned + "_Short");
            _loc6_ = "_op0" + CurrentOpOwned;
         }
         _loc4_ = _global.GameInterface.Translate("#SFUI_XP_Bonus_" + aReason[_loc2_] + _loc6_);
         _loc4_ = _global.ConstructString(_loc4_,_loc5_);
         _loc4_ = _loc4_ + "\n\n";
      }
      else
      {
         var _loc7_ = _global.GameInterface.Translate("#SFUI_XP_Bonus_" + aReason[_loc2_]);
         _loc10_.push(_loc7_);
      }
      _loc2_ = _loc2_ + 1;
   }
   _loc15_ = _loc10_.join("\n +");
   _loc12_ = _global.ConstructString(_loc12_,_loc13_,_loc11_,_loc4_,_loc15_);
   return _loc12_;
}
function RequestServiceMedal()
{
   _global.CScaleformComponent_Inventory.RequestPrestigeCoin();
   SetXpLevelInfo();
}
function SetupFlairScrollButtons()
{
   m_nFlairContainerPage = 0;
   trace("SetupFlairScrollButtons, m_nFlairContainerPage = 0, m_nFlairContainerDefaultX =" + m_nFlairContainerDefaultX);
   ButtonNext.dialog = this;
   ButtonNext.Action = function()
   {
      this.dialog.MoveFlairLeft(this);
   };
   ButtonPrev.dialog = this;
   ButtonPrev.Action = function()
   {
      this.dialog.MoveFlairRight(this);
   };
   ButtonPrev._visible = false;
   var _loc2_ = MedalsContainer;
   if(_loc2_)
   {
      _loc2_._x = m_nFlairContainerDefaultX;
   }
}
function MoveFlairLeft()
{
   m_nFlairContainerPage++;
   trace("MoveFlairLeft: m_nFlairContainerPage =" + m_nFlairContainerPage);
   var LoopCount = 0;
   var mcMovie = MedalsContainer;
   var SpeedOut = 0.4;
   var _loc2_ = 1;
   mcMovie.onEnterFrame = function()
   {
      var _loc1_ = m_nFlairContainerDefaultX - m_nFlairContainerPage * 6 * (nMedalWidth + nMedalWidth / 3.5);
      if(LoopCount < 1)
      {
         mcMovie._x = mcMovie._x + (_loc1_ + 1 - mcMovie._x) * SpeedOut;
      }
      if(mcMovie._x < _loc1_)
      {
         LoopCount++;
         mcMovie._x = _loc1_;
         delete mcMovie.onEnterFrame;
      }
   };
   ButtonNext._visible = m_nTotalFlairItems - m_nFlairContainerPage * FLAIR_SLOTS_PER_PAGE > FLAIR_SLOTS_PER_PAGE;
   ButtonPrev._visible = true;
}
function MoveFlairRight()
{
   m_nFlairContainerPage--;
   trace("MoveFlairRight: m_nFlairContainerPage =" + m_nFlairContainerPage);
   var LoopCount = 0;
   var mcMovie = MedalsContainer;
   var SpeedOut = 0.4;
   var _loc2_ = 1;
   mcMovie.onEnterFrame = function()
   {
      var _loc1_ = m_nFlairContainerDefaultX - m_nFlairContainerPage * 6 * (nMedalWidth + nMedalWidth / 3.5);
      if(LoopCount < 1)
      {
         mcMovie._x = mcMovie._x + (_loc1_ + 1 - mcMovie._x) * SpeedOut;
      }
      if(mcMovie._x > _loc1_)
      {
         LoopCount++;
         mcMovie._x = _loc1_;
         delete mcMovie.onEnterFrame;
      }
   };
   ButtonPrev._visible = m_nFlairContainerPage >= 1;
   ButtonNext._visible = m_nTotalFlairItems - m_nFlairContainerPage * FLAIR_SLOTS_PER_PAGE > FLAIR_SLOTS_PER_PAGE;
}
function rollOverToolTipCommendations(objToolTipLoc, bShow, strToolTip)
{
   trace("rollOverToolTip: strToolTip = " + strToolTip);
   var _loc1_ = {x:objToolTipLoc._parent._parent._x - 16,y:objToolTipLoc._y + 45};
   ToolTipPlayerProfile.TooltipPlayerProfileShowHide(bShow);
   ToolTipPlayerProfile.TooltipPlayerProfileLayout(strToolTip,_loc1_);
}
function rollOverToolTipMedals(objToolTipLoc, bShow, strToolTip)
{
   trace("rollOverToolTip: strToolTip = " + strToolTip);
   var _loc1_ = {x:objToolTipLoc._x + (64 - m_nFlairContainerPage * 149),y:objToolTipLoc._y + 64};
   ToolTipPlayerProfile.TooltipPlayerProfileShowHide(bShow);
   ToolTipPlayerProfile.TooltipPlayerProfileLayout(strToolTip,_loc1_);
}
function rollOverToolTipXp(objToolTipLoc, bShow, strToolTip)
{
   trace("rollOverToolTip: strToolTip = " + strToolTip);
   ToolTipPlayerProfile.TooltipPlayerProfileShowHide(bShow);
   ToolTipPlayerProfile.TooltipPlayerProfileLayout(strToolTip,objToolTipLoc);
}
function rollOverToolTipElevatedStatus(objToolTipLoc, bShow, strToolTip)
{
   trace("rollOverToolTip: strToolTip = " + strToolTip);
   ToolTipPlayerProfile.TooltipPlayerProfileShowHide(bShow);
   ToolTipPlayerProfile.TooltipPlayerProfileLayout(strToolTip,objToolTipLoc);
}
function SetTeamPanel()
{
   if(!_global.CScaleformComponent_MyPersona.IsInventoryValid())
   {
      return undefined;
   }
   var _loc6_ = _global.CScaleformComponent_MyPersona.GetMyOfficialTeamName();
   var _loc2_ = _global.CScaleformComponent_MyPersona.GetMyOfficialTournamentName();
   if(_loc6_ == "" || _loc2_ == "" || _loc2_ == undefined || !m_bIsSelf)
   {
      TeamPanel._visible = false;
      return undefined;
   }
   var _loc4_ = _global.CScaleformComponent_MyPersona.GetMyOfficialTeamTag();
   trace("-------------strTeamTag---------" + _loc4_);
   var _loc7_ = "econ/tournaments/teams/" + _loc4_ + ".png";
   var _loc5_ = new Object();
   _loc5_.onLoadInit = function(target_mc)
   {
      target_mc._width = 25;
      target_mc._height = 25;
   };
   var _loc3_ = new MovieClipLoader();
   _loc3_.addListener(_loc5_);
   _loc3_.loadClip(_loc7_,TeamPanel.Logo.Image);
   TeamPanel.TeamName.htmlText = _loc6_;
   TeamPanel.TournamentName.htmlText = _loc2_;
   TeamPanel._visible = true;
}
function SetElevatedStatusPanel()
{
   var _loc6_ = _global.CScaleformComponent_MyPersona.HasPrestige();
   if(!_global.CScaleformComponent_MyPersona.IsInventoryValid() || m_bPlayerDetailsVisible)
   {
      return undefined;
   }
   var _loc5_ = _global.CScaleformComponent_PartyList.GetFriendPrimeEligible(m_PlayerXuid);
   var _loc7_ = _global.CScaleformComponent_MyPersona.GetElevatedState();
   if(_loc5_)
   {
      ElevatedStatusPanel._visible = true;
      ElevatedStatusPanel.ElevatedVerified._visible = true;
      ElevatedStatusPanel.btnOpenPanel._visible = false;
      ElevatedStatusPanel.MedalsBg._visible = false;
      ElevatedStatusPanel.NewMapTag._visible = false;
      ElevatedStatusPanel.Desc._visible = false;
      var _loc8_ = "images/ui_icons/verified.png";
      var TooltipLoc = {x:ElevatedStatusPanel._x + 9,y:ElevatedStatusPanel._height + ElevatedStatusPanel._y};
      var _loc4_ = new Object();
      _loc4_.onLoadInit = function(target_mc)
      {
         target_mc._width = 28;
         target_mc._height = 28;
      };
      var _loc3_ = new MovieClipLoader();
      _loc3_.addListener(_loc4_);
      _loc3_.loadClip(_loc8_,ElevatedStatusPanel.ElevatedVerified.Logo);
      ElevatedStatusPanel.ElevatedVerified.onRollOver = function()
      {
         rollOverToolTipElevatedStatus(TooltipLoc,true,"#SFUI_Elevated_Status_Desc_Tooltip");
      };
      ElevatedStatusPanel.ElevatedVerified.onRollOut = function()
      {
         rollOverToolTipElevatedStatus(TooltipLoc,false,"#SFUI_Elevated_Status_Desc_Tooltip");
      };
   }
   else
   {
      if(_loc7_ == "loading")
      {
         ElevatedStatusPanel._visible = false;
         return undefined;
      }
      if(_loc6_ || _global.CScaleformComponent_FriendsList.GetFriendLevel(m_PlayerXuid) > 20)
      {
         ElevatedStatusPanel._visible = true;
         ElevatedStatusPanel.ElevatedVerified._visible = false;
         ElevatedStatusPanel.btnOpenPanel._visible = true;
         ElevatedStatusPanel.MedalsBg._visible = true;
         ElevatedStatusPanel.NewMapTag._visible = true;
         ElevatedStatusPanel.Desc._visible = true;
         ElevatedStatusPanel.Desc.htmlText = "#SFUI_Elevated_Status_Title";
         _global.AutosizeTextDown(ElevatedStatusPanel.Desc,8);
         ElevatedStatusPanel.btnOpenPanel.dialog = this;
         ElevatedStatusPanel.btnOpenPanel.SetText("#SFUI_Elevated_Status_Btn");
         _global.AutosizeTextDown(ElevatedStatusPanel.btnOpenPanel.ButtonText.Text,8);
         ElevatedStatusPanel.btnOpenPanel.Action = function()
         {
            this.dialog.OpenElevatedStatusMessageBox();
         };
         ElevatedStatusPanel._visible = true;
      }
   }
}
function OpenElevatedStatusMessageBox()
{
   var objDialog = _global.MainMenuMovie.Panel;
   objDialog.createEmptyMovieClip("mcElevatedStatus",objDialog.getNextHighestDepth());
   var _loc3_ = new Object();
   _loc3_.onLoadInit = function()
   {
      objDialog.mcElevatedStatus.Panel.InitElevatedStatusPanel();
   };
   var _loc2_ = new MovieClipLoader();
   _loc2_.addListener(_loc3_);
   _loc2_.loadClip("MainMenuElevatedStatusPanel.swf",objDialog.mcElevatedStatus);
}
var _avatarCache = undefined;
var numMedals = 0;
var aRankNames = new Array();
var m_PlayerXuid = "";
var nMedalFlairWidth = 28;
var nMedalFlairHeight = 21;
var nMedalWidth = 19;
var m_nLastFlairItem = 0;
var m_nTotalFlairItems = 0;
var m_nCurFlairIndexPos = 0;
var m_idxAttachMedal = 0;
var MAX_FLAIR_SLOTS = 99;
var FLAIR_SLOTS_PER_PAGE = 6;
var m_bSetFlairContainerDefaultX = false;
var m_nFlairContainerDefaultX = 0;
var m_nFlairContainerPage = 0;
var m_bIsSelf = false;
var m_bPlayerDetailsVisible = false;
var NUM_CAMPAIGN_1_DEFINDEX = 1321;
var NUM_CAMPAIGN_2_DEFINDEX = 1319;
var NUM_CAMPAIGN_3_DEFINDEX = 1320;
var NUM_CAMPAIGN_4_DEFINDEX = 1312;
ToolTipPlayerProfile._visible = false;
ElevatedStatusPanel._visible = false;
TeamPanel._visible = false;
i = 1;
while(i <= 18)
{
   aRankNames[i] = "#SFUI_ELO_RankName_" + i;
   i++;
}
this.stop();
