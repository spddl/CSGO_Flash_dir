function SetUpPage(numSeason, ItemId)
{
   LoadOperationIcon(numSeason);
   LoadMedalIcon(ItemId);
   LoadAvatar();
   SetRank();
   SetName();
   SetMissions(ItemId);
   SetText(numSeason);
   SetPayGrade(ItemId);
   DeployDate(ItemId,numSeason);
   Sheen.gotoAndPlay("StartAnim");
}
function LoadAvatar()
{
   Avatar.m_bShowFlair = false;
   Avatar._visible = true;
   Avatar._alpha = 100;
   Avatar.ShowAvatar(3,m_PlayerXuid,true,false);
   Avatar.SetFlairItem(m_PlayerXuid);
}
function SetName()
{
   Name.htmlText = _global.CScaleformComponent_FriendsList.GetFriendName(m_PlayerXuid);
}
function SetPayGrade(ItemId)
{
   var _loc3_ = _global.CScaleformComponent_MyPersona.GetMyMedalRankByType("4OpBreakout$Community Season Four Summer 2014");
   var _loc2_ = "";
   TitleId.htmlText = "#CSGO_Journal_Badge_Id";
   if(_loc3_ == 3)
   {
      _loc2_ = "O-10 ";
   }
   else if(_loc3_ == 2)
   {
      _loc2_ = "O-2 ";
   }
   else
   {
      _loc3_ == 1;
   }
   _loc2_ = "E-2 ";
   ItemId = ItemId.slice(0,6);
   PayGrade.htmlText = _loc2_ + ItemId;
}
function SetMissions(ItemId)
{
   var _loc2_ = _global.CScaleformComponent_Inventory.GetItemAttributeValue(m_PlayerXuid,ItemId,"quests_complete");
   if(_loc2_ == null || _loc2_ == undefined || _loc2_ == "")
   {
      MissionsComplete.htmlText = "N/A";
   }
   else
   {
      MissionsComplete.htmlText = _loc2_;
   }
   TitleMissionComplete.htmlText = "#CSGO_Journal_Badge_MissionTitle";
}
function DeployDate(ItemId, numSeason)
{
   TitleDeploy.htmlText = "#CSGO_Journal_Badge_Deploy_Title";
   var _loc2_ = _global.CScaleformComponent_Inventory.GetItemAttributeValue(m_PlayerXuid,ItemId,"deployment_date");
   if(_loc2_ == undefined || _loc2_ == null || _loc2_ == "")
   {
      Deploy.htmlText = "#CSGO_Journal_Badge_EndDate_" + numSeason;
   }
   else
   {
      Deploy.htmlText = _global.CScaleformComponent_Inventory.GetItemAttributeValue(m_PlayerXuid,ItemId,"deployment_date");
   }
   _global.AutosizeTextDown(Deploy,8);
   TitleEndDate.htmlText = "#CSGO_Journal_Badge_EndDate_Title";
   EndDate.htmlText = "#CSGO_Journal_Badge_EndDate_" + numSeason;
   if(numSeason == _global.CScaleformComponent_GameTypes.GetActiveSeasionIndexValue())
   {
      LoadStampActive();
   }
}
function LoadMedalIcon(ItemId)
{
   var _loc4_ = _global.CScaleformComponent_Inventory.GetItemInventoryImage(m_PlayerXuid,ItemId) + ".png";
   if(MedalIcon != undefined)
   {
      MedalIcon.unloadMovie();
   }
   var _loc3_ = new Object();
   _loc3_.onLoadInit = function(target_mc)
   {
      target_mc._width = 75;
      target_mc._height = 55;
      target_mc.forceSmoothing = true;
   };
   var _loc2_ = new MovieClipLoader();
   _loc2_.addListener(_loc3_);
   _loc2_.loadClip(_loc4_,MedalIcon);
}
function LoadOperationIcon(numSeason)
{
   var _loc3_ = "econ/season_icons/season_" + numSeason + ".png";
   if(OperationLogo != undefined)
   {
      OperationLogo.unloadMovie();
   }
   var _loc2_ = new Object();
   _loc2_.onLoadInit = function(target_mc)
   {
      target_mc._width = 120;
      target_mc._height = 92;
      target_mc.forceSmoothing = true;
   };
   var _loc1_ = new MovieClipLoader();
   _loc1_.addListener(_loc2_);
   _loc1_.loadClip(_loc3_,OperationLogo);
}
function LoadStampActive()
{
   var _loc3_ = "images/journal/badge-active.png";
   if(StampActive != undefined)
   {
      StampActive.unloadMovie();
   }
   var _loc2_ = new Object();
   _loc2_.onLoadInit = function(target_mc)
   {
      target_mc._width = 300;
      target_mc._height = 60;
      target_mc.forceSmoothing = true;
   };
   var _loc1_ = new MovieClipLoader();
   _loc1_.addListener(_loc2_);
   _loc1_.loadClip(_loc3_,StampActive);
}
function SetRank()
{
   var _loc2_ = _global.CScaleformComponent_FriendsList.GetFriendCompetitiveRank(m_PlayerXuid);
   var _loc3_ = _global.CScaleformComponent_FriendsList.GetFriendCompetitiveWins(m_PlayerXuid);
   TitleRank.htmlText = "#CSGO_Journal_Badge_RankTitle";
   if(_loc2_ < 1 && _loc3_ >= 10)
   {
      Rank.htmlText = "#CSGO_Journal_Badge_SkillGroup_Expired";
      return undefined;
   }
   if(_loc2_ < 1)
   {
      Rank.htmlText = "#CSGO_Journal_Badge_SkillGroup_NoRank";
      return undefined;
   }
   if(_loc2_ > 0)
   {
      Rank.htmlText = _global.GameInterface.Translate(aRankNames[_loc2_]);
      return undefined;
   }
}
function SetText(numSeason)
{
   CardDesc.htmlText = "#CSGO_Journal_Badge_Card_Desc";
   Status.htmlText = "#CSGO_Journal_Badge_Status_Title_" + numSeason;
   Text.Title.htmlText = "#CSGO_Journal_Badge_Title";
   var _loc2_ = _global.CScaleformComponent_GameTypes.GetActiveSeasionIndexValue();
   if(numSeason == _loc2_)
   {
      Active.htmlText = "#CSGO_Journal_Badge_Active";
      SetCompleteStamp(true);
   }
   else
   {
      Active.htmlText = "#CSGO_Journal_Badge_Not_Active";
      SetCompleteStamp(false);
   }
}
function SetCompleteStamp(bIsActiveSeason)
{
   CompleteStamp;
   if(!bIsActiveSeason)
   {
      CompleteStamp._alpha = 100;
      CompleteStamp2._alpha = 100;
      CompleteStamp._visible = true;
      CompleteStamp2._visible = true;
   }
   else
   {
      CompleteStamp._visible = false;
      CompleteStamp2._visible = false;
   }
}
stop();
var m_PlayerXuid = _global.CScaleformComponent_MyPersona.GetXuid();
var aRankNames = new Array();
i = 1;
while(i <= 18)
{
   aRankNames[i] = "#SFUI_ELO_RankName_" + i;
   i++;
}
