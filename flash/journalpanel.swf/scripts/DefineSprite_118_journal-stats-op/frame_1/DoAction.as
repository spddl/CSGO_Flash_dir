function SetUpPage(numSeason, TypeOfScoreCard, CoinId)
{
   var _loc2_ = _global.CScaleformComponent_MyPersona.GetXuid();
   var _loc3_ = _global.CScaleformComponent_Inventory.ItemHasScorecardValues(_loc2_,CoinId,TypeOfScoreCard);
   SetUpIconsAndText(TypeOfScoreCard,numSeason);
   if(_loc3_ == 0)
   {
      ScorecardLayout(_loc2_,CoinId,numSeason,TypeOfScoreCard,false);
   }
   else if(_loc3_ >= 1)
   {
      ScorecardLayout(_loc2_,CoinId,numSeason,TypeOfScoreCard,true);
   }
}
function SetUpIconsAndText(TypeOfScoreCard, numSeason)
{
   if(OperationLogo != undefined)
   {
      OperationLogo.unloadMovie();
   }
   NoStats._visible = false;
   DescTop._visible = true;
   if(TypeOfScoreCard == "competitive")
   {
      OperationLogo._visible = false;
      CompLogo._visible = true;
      CompLogo._alpha = 100;
      Title.htmlText = "#CSGO_Scorecard_Title_Active";
      Desc.htmlText = "#CSGO_Operation_Scorecard_Desc_Tournament";
      DescBottom.htmlText = "#CSGO_Operation_Maps_Season_" + numSeason + "_Active";
   }
   else
   {
      var _loc4_ = "econ/season_icons/season_" + numSeason + ".png";
      CompLogo._visible = false;
      OperationLogo._visible = true;
      var _loc2_ = new Object();
      _loc2_.onLoadInit = function(target_mc)
      {
         target_mc._width = 78;
         target_mc._height = 60;
         target_mc.forceSmoothing = true;
      };
      var _loc1_ = new MovieClipLoader();
      _loc1_.addListener(_loc2_);
      _loc1_.loadClip(_loc4_,OperationLogo);
      Title.htmlText = "#CSGO_Scorecard_Title_Operation";
      Desc.htmlText = "#CSGO_Operation_Scorecard_Desc_Operation";
      DescBottom.htmlText = "#CSGO_Operation_Maps_Season_" + numSeason + "_Operation";
      Text.Title.htmlText = "#CSGO_Operation_scorecard_TitleActive";
   }
}
function ScorecardLayout(PlayerXuid, strId, numSeason, TypeOfScoreCard, bShowStats)
{
   var _loc8_ = 11;
   var _loc21_ = 15;
   var _loc18_ = 10;
   if(bShowStats)
   {
      PlayButton._visible = false;
      Rows._alpha = 100;
      var _loc11_ = 0;
      var _loc3_ = [];
      var _loc17_ = _global.CScaleformComponent_Inventory.GetScorecardAttributes(PlayerXuid,strId,TypeOfScoreCard);
      _loc3_ = _loc17_.split(",");
      var _loc9_ = _global.CScaleformComponent_Inventory.GetItemAttributeValue(PlayerXuid,strId,_loc3_[0]);
      var _loc15_ = math.floor(_loc9_ / 60);
      var _loc13_ = _global.GameInterface.Translate("#CSGO_competitive_Time_Played");
      if(_loc9_ > 60)
      {
         _loc15_ = Math.floor(_loc9_ / 60);
         _loc9_ = Math.ceil(_loc9_ - _loc15_ * 60);
         _loc13_ = _global.ConstructString(_loc13_,_loc15_,_loc9_);
      }
      else
      {
         _loc13_ = _global.ConstructString(_loc13_,"0",_loc9_);
      }
      Time.Time.htmlText = _loc13_;
      Time._visible = true;
      Time._alpha = 100;
      var _loc6_ = false;
      var _loc4_ = 1;
      while(_loc4_ <= _loc8_)
      {
         var _loc7_ = Rows["Row" + _loc4_];
         if(_loc4_ >= _loc3_.length)
         {
            _loc7_._visible = false;
         }
         else
         {
            var _loc5_ = _global.CScaleformComponent_Inventory.GetItemAttributeValue(PlayerXuid,strId,_loc3_[_loc4_]);
            _loc7_.Attribute.htmlText = "#CSGO_" + _loc3_[_loc4_];
            if(_loc3_[_loc4_] == "competitive_hsp" || _loc3_[_loc4_] == "operation_hsp")
            {
               _loc7_.Value.htmlText = Math.floor(_loc5_) + "%";
            }
            else
            {
               _loc7_.Value.htmlText = Math.floor(_loc5_);
            }
            _loc7_._visible = true;
            _loc7_.Bg._visible = !_loc6_;
            _loc6_ = !_loc6_;
            _loc11_ = _loc11_ + 1;
         }
         _loc4_ = _loc4_ + 1;
      }
      Private._visible = false;
   }
   else
   {
      PlayButton._visible = false;
      NoStats._visible = true;
      DescTop._visible = false;
      if(TypeOfScoreCard == "competitive")
      {
         NoStats.htmlText = "#CSGO_Operation_Scorecard_NotStats_Active";
         var MapGroup = "mg_de_dust2,mg_de_train,mg_de_mirage,mg_de_inferno,mg_de_cbble,mg_de_overpass,mg_de_cache";
      }
      else
      {
         NoStats.htmlText = "#CSGO_Operation_Scorecard_NotStats_Operation";
         var MapGroup = "mg_cs_cruise,mg_de_coast,mg_de_empire,mg_de_mikla,mg_de_nuke,mg_de_royal,mg_de_santorini,mg_de_tulip";
      }
      _loc4_ = 0;
      while(_loc4_ <= _loc8_)
      {
         _loc7_ = Rows["Row" + _loc4_];
         _loc7_._visible = false;
         _loc4_ = _loc4_ + 1;
      }
      var _loc14_ = _global.CScaleformComponent_GameTypes.GetActiveSeasionIndexValue();
      var _loc16_ = _global.CScaleformComponent_MyPersona.GetMyMedalRankByType(_loc14_ + 1 + "Operation$OperationCoin");
      if(_loc16_ > 1 && _loc14_ == numSeason)
      {
         PlayButton._alpha = 100;
         PlayButton._visible = true;
         PlayButton.dialog = this;
         PlayButton.Action = function()
         {
            if(_global.LobbyMovie)
            {
               if(!_global.LobbyMovie.bModalPrompt)
               {
                  _global.RemoveElement(_global.SinglePlayerMovie);
               }
            }
            else
            {
               _global.MainMenuMovie.Panel.SelectPanel.CloseAnyOpenMenus();
            }
            _global.MainMenuMovie.Panel.SelectPanel.MainMenuTopBar.QuitButton.setDisabled(true);
            _global.CScaleformComponent_CompetitiveMatch.ActionMatchmaking("competitive",MapGroup,"lobby");
            _global.MainMenuMovie.Panel.JournalPanel.Journal.HidePanel();
         };
         PlayButton.ButtonText.htmlText = "#CSGO_Operation_scorecard_play";
      }
      if(_loc14_ != numSeason)
      {
         NoStats.htmlText = "#CSGO_Journal_Stats_Not_Active";
      }
      Private._visible = false;
      Time._visible = false;
   }
}
stop();
