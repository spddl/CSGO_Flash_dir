function SetUpPage(numSeason, ItemId)
{
   SetUpToc(numSeason,ItemId);
}
function SetUpToc(numSeason, ItemId)
{
   if(numSeason == 3)
   {
      var _loc3_ = new Array(new Array("#CSGO_Journal_Toc_Badge_Title","EntryTitle","2","0"),new Array("#CSGO_Journal_Toc_Scorecard_Op","EntryTitle","3","2"),new Array("#CSGO_Journal_Toc_Scorecard_Active","EntryTitle","4","2"),new Array("#CSGO_Journal_Toc_Leaderboards1","EntryTitle","5","4"),new Array("#CSGO_Journal_Toc_Leaderboards2","EntryTitle","6","4"),new Array("#CSGO_Journal_Toc_Maps_Title","EntryTitle","7","6"));
      LayoutToc(_loc3_,ItemId,numSeason);
   }
   else if(numSeason == 4)
   {
      _loc3_ = new Array(new Array("#CSGO_Journal_Toc_Badge_Title","EntryTitle","1","0"),new Array("#csgo_campaign_vanguard","EntryTitle","3","2",2),new Array("#csgo_campaign_weapons","EntryTitle","5","4",4),new Array("#csgo_campaign_maghreb","EntryTitle","7","6",3),new Array("#csgo_campaign_eurasia","EntryTitle","9","8",1),new Array("#CSGO_Journal_Toc_Scorecard_Title","EntryTitle","11","10"),new Array("#CSGO_Journal_Toc_Leaderboards_Title","EntryTitle","13","12"),new Array("#CSGO_Journal_Toc_Maps_Title","EntryTitle","15","14"));
      LayoutToc(_loc3_,ItemId,numSeason);
   }
   else if(numSeason == 5)
   {
      _loc3_ = new Array(new Array("#CSGO_Journal_Toc_Badge_Title","EntryTitle","1","0"),new Array("#csgo_campaign_marksman","EntryTitle","3","2",5),new Array("#csgo_campaign_revolution","EntryTitle","5","4",6),new Array("#CSGO_Journal_Toc_Scorecard_Title","EntryTitle","7","6"),new Array("#CSGO_Journal_Toc_Leaderboards_Title","EntryTitle","9","8"),new Array("#CSGO_Journal_Toc_Maps_Title","EntryTitle","11","10"),new Array("#CSGO_Journal_Toc_MissionFaq_Title","EntryTitle","17","16"));
      LayoutToc(_loc3_,ItemId,numSeason);
   }
   else if(numSeason == 6)
   {
      _loc3_ = new Array(new Array("#CSGO_Journal_Toc_Badge_Title","EntryTitle","1","0"),new Array("#csgo_campaign_8","EntryTitle","3","2",8),new Array("#csgo_campaign_7","EntryTitle","5","4",7),new Array("#CSGO_Journal_Toc_Scorecard_Title","EntryTitle","7","6"),new Array("#CSGO_Journal_Toc_Leaderboards_Title","EntryTitle","9","8"),new Array("#CSGO_Journal_Toc_Maps_Title","EntryTitle","11","10"),new Array("#CSGO_Journal_Toc_MissionFaq_Title","EntryTitle","19","18"));
      LayoutToc(_loc3_,ItemId,numSeason);
   }
   LoadLogo(numSeason);
}
function LayoutToc(aTocSections, ItemId, numSeason)
{
   var _loc14_ = _global.CScaleformComponent_MyPersona.GetXuid();
   SectionEntry._visible = false;
   SectionTitle._visible = false;
   Text.JournalNumber.htmlText = "OJ-" + _loc14_;
   Text.Title.htmlText = "#CSGO_Journal_Toc_Title";
   Text.Distribution.htmlText = "#CSGO_Journal_Toc_Distribution";
   Text.Title.htmlText = "#CSGO_Journal_Toc_Title";
   var _loc12_ = _global.CScaleformComponent_Inventory.GetItemAttributeValue(_loc14_,ItemId,"deployment_date");
   if(_loc12_ == undefined || _loc12_ == null || _loc12_ == "")
   {
      Text.LastUpdated.htmlText = "";
   }
   else
   {
      var _loc13_ = _global.GameInterface.Translate("#CSGO_Journal_CoverDate_" + numSeason);
      _loc13_ = _global.ConstructString(_loc13_,_loc12_);
      Text.LastUpdated.htmlText = _loc13_;
   }
   var _loc3_ = 0;
   while(_loc3_ < aTocSections.length)
   {
      SectionEntry.duplicateMovieClip("SectionEntry" + _loc3_,this.getNextHighestDepth());
      this["SectionEntry" + _loc3_].dialog = this;
      this["SectionEntry" + _loc3_].EntryBtn._PageNum = aTocSections[_loc3_][3];
      this["SectionEntry" + _loc3_].EntryBtn.Action = function()
      {
         GoToPage(this);
      };
      this["SectionEntry" + _loc3_].EntryBtn.ButtonText.htmlText = _global.GameInterface.Translate(aTocSections[_loc3_][0]);
      this["SectionEntry" + _loc3_].PageNum.htmlText = aTocSections[_loc3_][2];
      this["SectionEntry" + _loc3_]._y = McHeight * _loc3_ + AnchorPosY;
      this["SectionEntry" + _loc3_]._alpha = 100;
      var _loc10_ = _global.CScaleformComponent_GameTypes.GetActiveSeasionIndexValue();
      if(aTocSections[_loc3_][4] > 0 && _global.CScaleformComponent_Inventory.CheckCampaignOwnership(aTocSections[_loc3_][4]) && _loc10_ == numSeason)
      {
         var _loc6_ = Math.floor(Math.random() * 7) + 1;
         this["SectionEntry" + _loc3_].CampaignStamp._visible = true;
         var _loc8_ = FindNumAccessibleMissions(aTocSections[_loc3_][4],"active");
         var _loc7_ = FindNumAccessibleMissions(aTocSections[_loc3_][4],"accessible");
         var _loc9_ = _global.CScaleformComponent_Inventory.GetMissionBacklog();
         var _loc4_ = "";
         if(_loc9_ <= 0 && GetNumMissionsInventory() <= 0)
         {
            _loc4_ = "#CSGO_Journal_Toc_CampaignWait";
         }
         else if(_loc8_ > 0)
         {
            _loc4_ = _global.GameInterface.Translate("#CSGO_Journal_Toc_CampaignActive");
            _loc4_ = _global.ConstructString(_loc4_,_loc8_);
         }
         else if(_loc7_ > 0)
         {
            _loc4_ = _global.GameInterface.Translate("#CSGO_Journal_Toc_CampaignAccessible");
            _loc4_ = _global.ConstructString(_loc4_,_loc7_);
         }
         this["SectionEntry" + _loc3_].CampaignStamp.Status.htmlText = _loc4_;
         if(_loc6_ < 3)
         {
            this["SectionEntry" + _loc3_].CampaignStamp._rotation = this["SectionEntry" + _loc3_].CampaignStamp._rotation + _loc6_;
         }
         else
         {
            this["SectionEntry" + _loc3_].CampaignStamp._rotation = this["SectionEntry" + _loc3_].CampaignStamp._rotation - _loc6_;
         }
      }
      else
      {
         this["SectionEntry" + _loc3_].CampaignStamp._visible = false;
      }
      _loc3_ = _loc3_ + 1;
   }
}
function GetNumMissionsInventory()
{
   _global.CScaleformComponent_Inventory.SetInventorySortAndFilters(_global.CScaleformComponent_MyPersona.GetXuid(),"",false,"not_base_item,only_quests","");
   return _global.CScaleformComponent_Inventory.GetInventoryCount();
}
function FindNumAccessibleMissions(CampaignIndex, strStatus)
{
   var _loc6_ = 0;
   var _loc7_ = _global.CScaleformComponent_Inventory.GetCampaignNodeCount(CampaignIndex);
   var _loc2_ = 0;
   while(_loc2_ < _loc7_)
   {
      var _loc4_ = _global.CScaleformComponent_Inventory.GetCampaignNodeIDbyIndex(CampaignIndex,_loc2_);
      var _loc3_ = _global.CScaleformComponent_Inventory.GetCampaignNodeState(CampaignIndex,_loc4_);
      if(_loc3_ == strStatus)
      {
         _loc6_ = _loc6_ + 1;
      }
      _loc2_ = _loc2_ + 1;
   }
   return _loc6_;
}
function GoToPage(Button)
{
   this._parent.OpenToPage(Button._PageNum,true);
}
function LoadLogo(numSeason)
{
   var _loc2_ = new Object();
   _loc2_.onLoadInit = function(target_mc)
   {
      target_mc._width = 400;
      target_mc._height = 290;
      target_mc.forceSmoothing = true;
   };
   var _loc3_ = "econ/season_icons/season_" + numSeason + ".png";
   var _loc1_ = new MovieClipLoader();
   _loc1_.addListener(_loc2_);
   _loc1_.loadClip(_loc3_,OperationLogo);
   OperationLogo._alpha = 20;
}
stop();
var AnchorPosY = 72;
var McHeight = 57;
