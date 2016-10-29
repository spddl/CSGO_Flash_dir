function InitWatchPanel(bShowLive)
{
   bShowLive = true;
   ShowWatchPanel(bShowLive);
}
function ShowWatchPanel(bShowLive)
{
   ResetGlobals();
   ShowWatchAnim();
   SetUpTopBarMenu();
   LoadingPanel.onRollOver = function()
   {
   };
   ErrorPanel.onRollOver = function()
   {
   };
   mcAccordianMenu.Bounds._visible = false;
   if(bShowLive)
   {
      var _loc2_ = mcTopBarMenu.TopMenuMaster.cat - button2;
      OnPressTopMenuBtn(_loc2_,"live");
   }
   else
   {
      _loc2_ = mcTopBarMenu.TopMenuMaster.cat - button0;
      OnPressTopMenuBtn(_loc2_,"tournament");
   }
   Close.dialog = this;
   Close.Action = function()
   {
      ClosePanel();
   };
   Refresh.dialog = this;
   Refresh.Action = function()
   {
      onReloadData();
   };
   SetUpScrollButtons();
}
function ResetGlobals()
{
   m_TypeOfLister = "";
   m_aOpenAccordianBtns = [];
   m_objSelectedTopBarMenuBtn = null;
   m_objSelectedAccodianMenuBtn = null;
   m_objSelectedTournamentBtn = null;
   m_objSelectedTournamentSubMenuBtn = null;
   m_objSelectedMatchBtn = null;
   m_NoMatchesLoaded = false;
   LoadingPanel._visible = false;
   ErrorPanel._visible = false;
   MatchData._visible = false;
   TournamentPanel._visible = false;
   StreamsPanel._visible = false;
}
function ClosePanel()
{
   CloseWatchAnim();
   _global.MainMenuMovie.Panel.SelectPanel.onSelectedButton(_global.MainMenuMovie.Panel.SelectPanel.MainMenuTopBar.HomeButton);
}
function onReloadData()
{
   if(StreamsPanel._visible)
   {
      _global.CScaleformComponent_Streams.UpdateMyTwitchTvState();
   }
   else
   {
      _global.CScaleformComponent_MatchList.Refresh(m_TypeOfLister);
   }
}
function ShowWatchAnim()
{
   this._visible = true;
   if(m_panelOpen == false)
   {
      var _loc2_ = new Lib.Tween(this,"_alpha",mx.transitions.easing.Strong.easeOut,0,100,0.5,true);
      _loc2_.onMotionFinished = function()
      {
         m_panelOpen = true;
      };
   }
}
function CloseWatchAnim()
{
   m_panelOpen = false;
   var _loc2_ = this;
   _loc2_._visible = false;
}
function SetUpTopBarMenu()
{
   mcTopBarMenu.MakeTopBarLayout(SetUpTopBarMenuNodes(),902,mcTopBarMenu);
}
function SetUpTopBarMenuNodes()
{
   var _loc3_ = new Array({type:"tournament",btn:"top-bar-btn",nametag:"#CSGO_Watch_Cat_Tournament_0",action:this.OnPressTopMenuBtn},{type:m_PlayerXuid,btn:"top-bar-btn",nametag:"#CSGO_Watch_Cat_YourMatches",action:this.OnPressTopMenuBtn},{type:"live",btn:"top-bar-btn",nametag:"#CSGO_Watch_Cat_LiveMatches",action:this.OnPressTopMenuBtn},{type:"downloaded",btn:"top-bar-btn",nametag:"#CSGO_Watch_Cat_Downloaded",action:this.OnPressTopMenuBtn},{type:"streams",btn:"top-bar-btn",nametag:"#CSGO_Watch_Cat_Streams",action:this.OnPressTopMenuBtn});
   var _loc4_ = _global.CScaleformComponent_MyPersona.GetLauncherType() != "perfectworld"?false:true;
   if(_loc4_)
   {
      _loc3_.splice(4,1);
   }
   BackToTournament.dialog = this;
   BackToTournament.Action = function()
   {
      BackToTournamentAccordian();
   };
   return _loc3_;
}
function OnPressTopMenuBtn(objBtn, strType, bSkipAnim)
{
   if(mcAccordianMenu.m_bIsAnimating)
   {
      return undefined;
   }
   if(m_objSelectedTopBarMenuBtn == objBtn)
   {
      bSkipAnim = true;
   }
   m_objSelectedTopBarMenuBtn.Selected._visible = false;
   m_objSelectedTopBarMenuBtn = objBtn;
   objBtn.Selected._visible = true;
   BgSections._visible = true;
   FadeEdge._visible = true;
   mcAccordianMenu._visible = true;
   BackToTournament._visible = false;
   switch(strType)
   {
      case "live":
         HideScrollBtns();
         SetUpListerData(strType,bSkipAnim);
         break;
      case "downloaded":
         SetUpListerData(strType,bSkipAnim);
         break;
      case "streams":
         HideScrollBtns();
         OnSelectSteamsPanel();
         break;
      case "tournament":
         HideScrollBtns();
         AnimMatchListerTransitionBack(false,bSkipAnim);
         break;
      default:
         SetUpListerData(strType,bSkipAnim);
   }
}
function TopMenuChangeAnim(objBtn, strType)
{
   if(m_objSelectedTopBarMenuBtn._Type != "tournament")
   {
      new Lib.Tween(MatchData,"_alpha",mx.transitions.easing.Strong.easeOut,0,100,2,true);
   }
   else
   {
      new Lib.Tween(TournamentPanel,"_alpha",mx.transitions.easing.Strong.easeOut,0,100,2,true);
   }
}
function SetUpListerData(TypeOfLister, bSkipAnim)
{
   var _loc4_ = false;
   var _loc8_ = "";
   var _loc3_ = null;
   clearTimeout(MatchData.MatchInfo.m_numTimerDelay);
   clearTimeout(m_numTimerDelay);
   _loc4_ = IsTournamentLister(TypeOfLister);
   if(_loc4_)
   {
      _loc3_ = GetEventIdFromListerType(TypeOfLister);
      TypeOfLister = "tournament:" + _loc3_;
   }
   _loc8_ = m_TypeOfLister;
   m_TypeOfLister = TypeOfLister;
   var _loc6_ = _global.CScaleformComponent_MatchList.GetState(TypeOfLister);
   ErrorPanel._visible = false;
   LoadingPanel._visible = false;
   if("none" == _loc6_)
   {
      m_bHasLoadedData = false;
      if(_loc4_)
      {
         LoadingPanel.Text.htmlText = "#CSGO_Watch_Loading_Tournament_" + _loc3_;
      }
      else
      {
         LoadingPanel.Text.htmlText = "#CSGO_Watch_Loading_" + GetMatchListingType(TypeOfLister);
      }
      LoadingPanel._visible = true;
      new Lib.Tween(LoadingPanel,"_alpha",mx.transitions.easing.Strong.easeOut,0,100,2,true);
      _global.CScaleformComponent_MatchList.Refresh(TypeOfLister);
   }
   if("loading" == _loc6_)
   {
      m_bHasLoadedData = false;
      if(_loc4_)
      {
         LoadingPanel.Text.htmlText = "#CSGO_Watch_Loading_Tournament_" + _loc3_;
      }
      else
      {
         LoadingPanel.Text.htmlText = "#CSGO_Watch_Loading_" + GetMatchListingType(TypeOfLister);
      }
      LoadingPanel._visible = true;
      new Lib.Tween(LoadingPanel,"_alpha",mx.transitions.easing.Strong.easeOut,0,100,2,true);
   }
   if(_loc6_ == "ready" && m_bHasLoadedData == false)
   {
      bSkipAnim = m_bHasLoadedData;
      m_bHasLoadedData = true;
   }
   if(_loc6_ == "ready")
   {
      LoadingPanel._visible = false;
      if(_loc4_)
      {
         var _loc5_ = "";
         if(_loc3_ < 4)
         {
            _loc5_ = TypeOfLister;
         }
         else
         {
            _loc5_ = PickDefaultTournamentTab(_loc3_);
            SelectTeamPickEmAsDefault(_loc5_);
         }
         SetErrorStates(TypeOfLister,_loc3_,_loc5_,_loc4_);
      }
      else
      {
         var _loc7_ = SetAccordianNodes(TypeOfLister);
         AnimMatchListerTransition(_loc7_,bSkipAnim);
         if(_loc7_.length > 9)
         {
            ShowScrollButtons();
         }
         SetErrorStates(TypeOfLister,_loc3_,"matches",_loc4_);
      }
      if(3 <= _global.CScaleformComponent_MatchList.HowManyMinutesAgoCached(TypeOfLister) && (TypeOfLister == "live" || _loc4_))
      {
         onReloadData();
      }
   }
}
function PickDefaultTournamentTab(numEventId)
{
   if(numEventId >= 8)
   {
      return "fantasy";
   }
   return "team";
}
function IsTournamentLister(TypeOfLister)
{
   if(TypeOfLister.indexOf("tournament:") != -1)
   {
      return true;
   }
   return false;
}
function GetEventIdFromListerType(TypeOfLister)
{
   if(TypeOfLister.indexOf("tournament:") != -1)
   {
      var _loc2_ = TypeOfLister.split(":");
      if(_loc2_[1] == undefined || _loc2_[1] == null || _loc2_[1] == "0")
      {
         return _global.CScaleformComponent_News.GetActiveTournamentEventID();
      }
      return _loc2_[1];
   }
}
function MakeDefaultSelectionForTournamentLister(TypeOfLister)
{
   mcAccordianMenu.AnimateAcoordianMenu(mcAccordianMenu.Parent0);
   OnPressAccordianCatagory(mcAccordianMenu.Parent0.Node,TypeOfLister);
   TopMenuChangeAnim();
}
function SelectTeamPickEmAsDefault(BtnType)
{
   OnPressAccordianChild(m_objSelectedTournamentBtn._parent.Catagory.Parent0.Node,BtnType);
   m_objSelectedTournamentBtn._parent.Catagory.Parent0.Node.Selected._visible = true;
}
function MakeDefaultSelectionForMatchesListers(MatchId)
{
   m_objSelectedMatchBtn = mcAccordianMenu.Parent0.Node;
   OnSelectMatch(m_objSelectedMatchBtn,MatchId);
   m_objSelectedMatchBtn.Selected._visible = true;
   TopMenuChangeAnim();
}
function SetErrorStates(TypeOfLister, numEventId, TypeOfBtn, bIsTournament, numDayIndex)
{
   if(TypeOfBtn == "team" || TypeOfBtn == "player" || TypeOfBtn == "fantasy")
   {
      var _loc3_ = _global.CScaleformComponent_Predictions.GetEventSectionsCount(TypeOfLister);
      var _loc7_ = _global.CScaleformComponent_Predictions.GetMyPredictionsLoaded(TypeOfLister);
      if(!_loc7_)
      {
         if(_loc3_ == 0 || _loc3_ == undefined || _loc3_ == null)
         {
            ShowErrorPanel("#CSGO_Watch_Error_PickEm_None");
         }
         else
         {
            LoadingPanel.Text.htmlText = "#CSGO_Watch_Loading_PickEm";
            LoadingPanel._visible = true;
         }
         return true;
      }
   }
   else
   {
      var _loc8_ = _global.CScaleformComponent_Predictions.GetEventSectionIDByIndex(TypeOfLister,numDayIndex);
      var _loc4_ = _global.CScaleformComponent_Predictions.GetSectionMatchesCount(TypeOfLister,_loc8_);
      if(bIsTournament)
      {
         _loc3_ = _global.CScaleformComponent_Predictions.GetEventSectionsCount(TypeOfLister);
         if(_loc3_ == 0 || _loc3_ == undefined || _loc3_ == null)
         {
            if(!(numEventId < 4 && _loc4_ > 0))
            {
               ShowErrorPanel("#CSGO_Watch_NoMatch_Tournament_" + numEventId);
               return true;
            }
         }
         else if(_loc4_ == 0)
         {
            ShowErrorPanel("#CSGO_Watch_NoMatch_Tournament_" + numEventId);
            return true;
         }
      }
      else if(_global.CScaleformComponent_MatchList.GetCount(TypeOfLister) == 0)
      {
         ShowErrorPanel("#CSGO_Watch_NoMatch_" + GetMatchListingType(TypeOfLister));
         return true;
      }
   }
   ErrorPanel._visible = false;
   return false;
}
function ShowErrorPanel(strText)
{
   MatchData._visible = false;
   TournamentPanel._visible = false;
   StreamsPanel._visible = false;
   ErrorPanel._visible = true;
   ErrorPanel.Text.htmlText = strText;
   new Lib.Tween(ErrorPanel,"_alpha",mx.transitions.easing.Strong.easeOut,0,100,2,true);
}
function RemakeAccordianMenu(AccordianNodeGraph)
{
   if(mcAccordianMenu.m_bIsAnimating)
   {
      return undefined;
   }
   mcAccordianMenu.SetClickBlocker(ClickBlocker);
   mcAccordianMenu.MakeAccordianLayout(AccordianNodeGraph,0,0,mcAccordianMenu);
}
function GetMatchListingType(TypeOfLister)
{
   if(TypeOfLister == m_PlayerXuid)
   {
      return "your";
   }
   return TypeOfLister;
}
function SetTournamentAccordianNodes(bOnlyTournamentCatagories)
{
   var _loc4_ = "econ/tournaments/tournament_logo_";
   var _loc3_ = "#CSGO_Watch_Cat_Tournament_";
   var _loc2_ = new Array({id:"tournament:10",btn:"accordian-image-text-btn",nametag:_loc3_ + "10",image:_loc4_ + "10.png",width:32,height:32,action:this.OnPressAccordianCatagory,setup:this.LoadDataForTextImageBtn},{id:"tournament:9",btn:"accordian-image-text-btn",nametag:_loc3_ + "9",image:_loc4_ + "9.png",width:86,height:32,action:this.OnPressAccordianCatagory,setup:this.LoadDataForTextImageBtn},{id:"tournament:8",btn:"accordian-image-text-btn",nametag:_loc3_ + "8",image:_loc4_ + "8.png",width:32,height:32,action:this.OnPressAccordianCatagory,setup:this.LoadDataForTextImageBtn},{id:"tournament:7",btn:"accordian-image-text-btn",nametag:_loc3_ + "7",image:_loc4_ + "7.png",width:32,height:32,action:this.OnPressAccordianCatagory,setup:this.LoadDataForTextImageBtn},{id:"tournament:6",btn:"accordian-image-text-btn",nametag:_loc3_ + "6",image:_loc4_ + "6.png",width:32,height:32,action:this.OnPressAccordianCatagory,setup:this.LoadDataForTextImageBtn},{id:"tournament:5",btn:"accordian-image-text-btn",nametag:_loc3_ + "5",image:_loc4_ + "5.png",width:86,height:32,action:this.OnPressAccordianCatagory,setup:this.LoadDataForTextImageBtn},{id:"tournament:4",btn:"accordian-image-text-btn",nametag:_loc3_ + "4",image:_loc4_ + "4.png",width:32,height:32,action:this.OnPressAccordianCatagory,setup:this.LoadDataForTextImageBtn},{id:"tournament:3",btn:"accordian-image-text-btn",nametag:_loc3_ + "3",image:_loc4_ + "3.png",width:86,height:32,action:this.OnPressAccordianCatagory,setup:this.LoadDataForTextImageBtn},{id:"tournament:1",btn:"accordian-image-text-btn",nametag:_loc3_ + "1",image:_loc4_ + "1.png",width:86,height:32,action:this.OnPressAccordianCatagory,setup:this.LoadDataForTextImageBtn});
   var _loc5_ = new Array();
   _loc5_.push({id:"fantasy",btn:"accordian-image-slim-text-btn",nametag:"#CSGO_Fantasy_PickEm_Title",image:"images/ui_icons/fantasy.png",width:32,height:32,action:this.OnPressAccordianChild,setup:this.LoadDataForTextImageBtn});
   _loc5_.push({id:"team",btn:"accordian-image-slim-text-btn",nametag:"#CSGO_Team_PickEm_Title",image:"images/ui_icons/team.png",width:32,height:32,action:this.OnPressAccordianChild,setup:this.LoadDataForTextImageBtn});
   _loc5_.push({id:"0",btn:"accordian-text-btn",nametag:"#CSGO_Tournament_Match_Day_0",action:this.OnPressAccordianChild,setup:this.LoadDataForTextButton});
   _loc5_.push({id:"1",btn:"accordian-text-btn",nametag:"#CSGO_Tournament_Match_Day_1",action:this.OnPressAccordianChild,setup:this.LoadDataForTextButton});
   _loc5_.push({id:"2",btn:"accordian-text-btn",nametag:"#CSGO_Tournament_Match_Day_2",action:this.OnPressAccordianChild,setup:this.LoadDataForTextButton});
   _loc5_.push({id:"3",btn:"accordian-text-btn",nametag:"#CSGO_Tournament_Matches_Quarter",action:this.OnPressAccordianChild,setup:this.LoadDataForTextButton});
   _loc5_.push({id:"4",btn:"accordian-text-btn",nametag:"#CSGO_Tournament_Matches_Semis",action:this.OnPressAccordianChild,setup:this.LoadDataForTextButton});
   _loc5_.push({id:"5",btn:"accordian-text-btn",nametag:"#CSGO_Tournament_Matches_Finals",action:this.OnPressAccordianChild,setup:this.LoadDataForTextButton});
   _loc2_[0].submenu = _loc5_;
   _loc5_ = new Array();
   _loc5_.push({id:"fantasy",btn:"accordian-image-slim-text-btn",nametag:"#CSGO_Fantasy_PickEm_Title",image:"images/ui_icons/fantasy.png",width:32,height:32,action:this.OnPressAccordianChild,setup:this.LoadDataForTextImageBtn});
   _loc5_.push({id:"team",btn:"accordian-image-slim-text-btn",nametag:"#CSGO_Team_PickEm_Title",image:"images/ui_icons/team.png",width:32,height:32,action:this.OnPressAccordianChild,setup:this.LoadDataForTextImageBtn});
   _loc5_.push({id:"0",btn:"accordian-text-btn",nametag:"#CSGO_Tournament_Match_Day_0",action:this.OnPressAccordianChild,setup:this.LoadDataForTextButton});
   _loc5_.push({id:"1",btn:"accordian-text-btn",nametag:"#CSGO_Tournament_Match_Day_1",action:this.OnPressAccordianChild,setup:this.LoadDataForTextButton});
   _loc5_.push({id:"2",btn:"accordian-text-btn",nametag:"#CSGO_Tournament_Match_Day_2",action:this.OnPressAccordianChild,setup:this.LoadDataForTextButton});
   _loc5_.push({id:"3",btn:"accordian-text-btn",nametag:"#CSGO_Tournament_Matches_Quarter",action:this.OnPressAccordianChild,setup:this.LoadDataForTextButton});
   _loc5_.push({id:"4",btn:"accordian-text-btn",nametag:"#CSGO_Tournament_Matches_Semis",action:this.OnPressAccordianChild,setup:this.LoadDataForTextButton});
   _loc5_.push({id:"6",btn:"accordian-text-btn",nametag:"#CSGO_Tournament_Matches_Finals",action:this.OnPressAccordianChild,setup:this.LoadDataForTextButton});
   _loc5_.push({id:"5",btn:"accordian-text-btn",nametag:"#CSGO_Tournament_Matches_Allstar",action:this.OnPressAccordianChild,setup:this.LoadDataForTextButton});
   _loc2_[1].submenu = _loc5_;
   _loc5_ = new Array();
   _loc5_.push({id:"fantasy",btn:"accordian-image-slim-text-btn",nametag:"#CSGO_Fantasy_PickEm_Title",image:"images/ui_icons/fantasy.png",width:32,height:32,action:this.OnPressAccordianChild,setup:this.LoadDataForTextImageBtn});
   _loc5_.push({id:"team",btn:"accordian-image-slim-text-btn",nametag:"#CSGO_Team_PickEm_Title",image:"images/ui_icons/team.png",width:32,height:32,action:this.OnPressAccordianChild,setup:this.LoadDataForTextImageBtn});
   _loc5_.push({id:"0",btn:"accordian-text-btn",nametag:"#CSGO_Tournament_Match_Day_0",action:this.OnPressAccordianChild,setup:this.LoadDataForTextButton});
   _loc5_.push({id:"1",btn:"accordian-text-btn",nametag:"#CSGO_Tournament_Match_Day_1",action:this.OnPressAccordianChild,setup:this.LoadDataForTextButton});
   _loc5_.push({id:"2",btn:"accordian-text-btn",nametag:"#CSGO_Tournament_Match_Day_2",action:this.OnPressAccordianChild,setup:this.LoadDataForTextButton});
   _loc5_.push({id:"3",btn:"accordian-text-btn",nametag:"#CSGO_Tournament_Matches_Quarter",action:this.OnPressAccordianChild,setup:this.LoadDataForTextButton});
   _loc5_.push({id:"4",btn:"accordian-text-btn",nametag:"#CSGO_Tournament_Matches_Semis_Finals",action:this.OnPressAccordianChild,setup:this.LoadDataForTextButton});
   _loc2_[2].submenu = _loc5_;
   _loc5_ = new Array();
   _loc5_.push({id:"team",btn:"accordian-image-slim-text-btn",nametag:"#CSGO_Team_PickEm_Title",image:"images/ui_icons/team.png",width:32,height:32,action:this.OnPressAccordianChild,setup:this.LoadDataForTextImageBtn});
   _loc5_.push({id:"player",btn:"accordian-image-slim-text-btn",nametag:"#CSGO_Player_PickEm_Title",image:"images/ui_icons/signature.png",width:32,height:32,action:this.OnPressAccordianChild,setup:this.LoadDataForTextImageBtn});
   _loc5_.push({id:"0",btn:"accordian-text-btn",nametag:"#CSGO_Tournament_Match_Day_0",action:this.OnPressAccordianChild,setup:this.LoadDataForTextButton});
   _loc5_.push({id:"1",btn:"accordian-text-btn",nametag:"#CSGO_Tournament_Match_Day_1",action:this.OnPressAccordianChild,setup:this.LoadDataForTextButton});
   _loc5_.push({id:"2",btn:"accordian-text-btn",nametag:"#CSGO_Tournament_Matches_Quarter",action:this.OnPressAccordianChild,setup:this.LoadDataForTextButton});
   _loc5_.push({id:"3",btn:"accordian-text-btn",nametag:"#CSGO_Tournament_Matches_Semis_Finals",action:this.OnPressAccordianChild,setup:this.LoadDataForTextButton});
   _loc2_[3].submenu = _loc5_;
   _loc5_ = new Array();
   _loc5_.push({id:"team",btn:"accordian-image-slim-text-btn",nametag:"#CSGO_Team_PickEm_Title",image:"images/ui_icons/team.png",width:32,height:32,action:this.OnPressAccordianChild,setup:this.LoadDataForTextImageBtn});
   _loc5_.push({id:"0",btn:"accordian-text-btn",nametag:"#CSGO_Tournament_Matches_Groups",action:this.OnPressAccordianChild,setup:this.LoadDataForTextButton});
   _loc5_.push({id:"1",btn:"accordian-text-btn",nametag:"#CSGO_Tournament_Matches_Quarter",action:this.OnPressAccordianChild,setup:this.LoadDataForTextButton});
   _loc5_.push({id:"2",btn:"accordian-text-btn",nametag:"#CSGO_Tournament_Matches_Semis",action:this.OnPressAccordianChild,setup:this.LoadDataForTextButton});
   _loc5_.push({id:"3",btn:"accordian-text-btn",nametag:"#CSGO_Tournament_Matches_Finals",action:this.OnPressAccordianChild,setup:this.LoadDataForTextButton});
   _loc2_[4].submenu = _loc5_;
   _loc5_ = new Array();
   _loc5_.push({id:"team",btn:"accordian-image-slim-text-btn",nametag:"#CSGO_Team_PickEm_Title",image:"images/ui_icons/team.png",width:32,height:32,action:this.OnPressAccordianChild,setup:this.LoadDataForTextImageBtn});
   _loc5_.push({id:"0",btn:"accordian-text-btn",nametag:"#CSGO_Tournament_Matches_Groups",action:this.OnPressAccordianChild,setup:this.LoadDataForTextButton});
   _loc5_.push({id:"1",btn:"accordian-text-btn",nametag:"#CSGO_Tournament_Matches_Quarter",action:this.OnPressAccordianChild,setup:this.LoadDataForTextButton});
   _loc5_.push({id:"2",btn:"accordian-text-btn",nametag:"#CSGO_Tournament_Matches_Semis_Finals",action:this.OnPressAccordianChild,setup:this.LoadDataForTextButton});
   _loc2_[5].submenu = _loc5_;
   _loc5_ = new Array();
   _loc5_.push({id:"team",btn:"accordian-image-slim-text-btn",nametag:"#CSGO_Team_PickEm_Title",image:"images/ui_icons/team.png",width:32,height:32,action:this.OnPressAccordianChild,setup:this.LoadDataForTextImageBtn});
   _loc5_.push({id:"0",btn:"accordian-text-btn",nametag:"#CSGO_Tournament_Match_Day_0",action:this.OnPressAccordianChild,setup:this.LoadDataForTextButton});
   _loc5_.push({id:"1",btn:"accordian-text-btn",nametag:"#CSGO_Tournament_Match_Day_1",action:this.OnPressAccordianChild,setup:this.LoadDataForTextButton});
   _loc5_.push({id:"2",btn:"accordian-text-btn",nametag:"#CSGO_Tournament_Matches_Quarter",action:this.OnPressAccordianChild,setup:this.LoadDataForTextButton});
   _loc5_.push({id:"3",btn:"accordian-text-btn",nametag:"#CSGO_Tournament_Matches_Semis_Finals",action:this.OnPressAccordianChild,setup:this.LoadDataForTextButton});
   _loc2_[6].submenu = _loc5_;
   _loc5_ = new Array();
   _loc5_.push({id:"matches",btn:"accordian-text-btn",nametag:"#CSGO_Tournament_Matches_All",action:this.OnPressAccordianChild,setup:this.LoadDataForTextButton});
   _loc2_[7].submenu = _loc5_;
   _loc5_ = new Array();
   _loc5_.push({id:"matches",btn:"accordian-text-btn",nametag:"#CSGO_Tournament_Matches_All",action:this.OnPressAccordianChild,setup:this.LoadDataForTextImageBtn});
   _loc2_[8].submenu = _loc5_;
   return _loc2_;
}
function SetAccordianNodes(strTypeOfLister)
{
   var _loc9_ = new Array();
   var _loc8_ = _global.CScaleformComponent_MatchList.GetCount(strTypeOfLister);
   if(_loc8_ == 0 || _loc8_ == undefined || _loc8_ == null)
   {
      return undefined;
   }
   var _loc6_ = 0;
   while(_loc6_ < _loc8_)
   {
      var _loc5_ = _global.CScaleformComponent_MatchList.GetMatchByIndex(strTypeOfLister,_loc6_);
      var _loc3_ = "";
      var _loc4_ = null;
      if(IsTournament(_loc5_))
      {
         _loc4_ = LoadDataForTournmentMatchBtn;
         _loc3_ = "accordian-match-tournament-btn";
      }
      else if(strTypeOfLister == "live")
      {
         _loc4_ = LoadDataForLiveMatchBtn;
         _loc3_ = "accordian-match-live-btn";
      }
      else if(GetMatchListingType(strTypeOfLister) == "your")
      {
         HideScrollBtns();
         _loc4_ = LoadDataForYourMatchBtn;
         _loc3_ = "accordian-match-yours-btn";
      }
      else
      {
         HideScrollBtns();
         _loc4_ = LoadDataForYourMatchBtn;
         _loc3_ = "accordian-match-yours-btn";
      }
      _loc9_.push({id:_loc5_,btn:_loc3_,nametag:_loc5_,action:this.OnSelectMatch,setup:_loc4_});
      _loc6_ = _loc6_ + 1;
   }
   if(strTypeOfLister == "live")
   {
      _loc9_.push({id:"theater",btn:"accordian-image-text-btn",nametag:"#CSGO_Watch_Gotv_Theater",image:"images/ui_icons/gotv.png",width:32,height:32,action:this.OnPressAccordianCatagory,setup:this.LoadDataForTextImageBtn});
   }
   return _loc9_;
}
function SetAccordianTournamentMatchNodes(strTypeOfLister, numDayIndex)
{
   var _loc13_ = new Array();
   var _loc14_ = _global.CScaleformComponent_Predictions.GetEventSectionsCount(strTypeOfLister);
   var _loc3_ = 0;
   while(_loc3_ < _loc14_)
   {
      if(_loc3_ == numDayIndex)
      {
         var _loc5_ = _global.CScaleformComponent_Predictions.GetEventSectionIDByIndex(strTypeOfLister,_loc3_);
      }
      _loc3_ = _loc3_ + 1;
   }
   var _loc12_ = _global.CScaleformComponent_Predictions.GetSectionMatchesCount(strTypeOfLister,_loc5_);
   if(_loc12_ < 1)
   {
      return undefined;
   }
   if(_loc12_ > 0)
   {
      _loc3_ = 0;
      while(_loc3_ < _loc12_)
      {
         var _loc4_ = _global.CScaleformComponent_Predictions.GetSectionMatchByIndex(strTypeOfLister,_loc5_,_loc3_);
         _loc13_.push({id:_loc4_,btn:"accordian-match-tournament-btn",nametag:_loc4_,action:this.OnSelectMatch,setup:LoadDataForTournmentMatchBtn});
         _loc3_ = _loc3_ + 1;
      }
   }
   return _loc13_;
}
function IsTournament(strMatchId)
{
   var _loc3_ = _global.CScaleformComponent_MatchInfo.GetMatchTournamentName(strMatchId);
   if(_loc3_ == "" || _loc3_ == null || _loc3_ == undefined)
   {
      this._Tournament = "";
      return false;
   }
   this._Tournament = _loc3_;
   return true;
}
function OnPressAccordianCatagory(objBtn, Type)
{
   if(m_objSelectedTournamentBtn != objBtn)
   {
      m_objSelectedTournamentBtn.Selected._visible = false;
   }
   m_objSelectedTournamentBtn = objBtn;
   objBtn.Selected._visible = true;
   if(objBtn._parent._id == "theater")
   {
      StartGotvTheater();
   }
   else
   {
      SetUpListerData(Type);
   }
}
function OnPressAccordianChild(objBtn, Type)
{
   if(m_objSelectedTournamentSubMenuBtn != objBtn)
   {
      m_objSelectedTournamentSubMenuBtn.Selected._visible = false;
   }
   m_objSelectedTournamentSubMenuBtn = objBtn;
   var _loc7_ = GetEventIdFromListerType(m_TypeOfLister);
   trace("----------------------Active Tournament ID ---------------------------" + _global.CScaleformComponent_News.GetActiveTournamentEventID());
   if(Type == "team")
   {
      OnSelectPickEm(objBtn,false,false);
   }
   else if(Type == "player")
   {
      OnSelectPickEm(objBtn,true,false);
   }
   else if(Type == "fantasy")
   {
      OnSelectPickEm(objBtn,false,true);
   }
   else
   {
      var _loc6_ = Number(Type);
      var _loc3_ = SetAccordianTournamentMatchNodes(m_TypeOfLister,_loc6_);
      if(_loc3_.length > 0)
      {
         AnimMatchListerTransition(_loc3_);
         BackToTournament._objMenuBack = m_objSelectedTournamentBtn;
         var _loc4_ = _global.GameInterface.Translate("#CSGO_Tournament_Day_Tournament");
         var _loc9_ = _global.GameInterface.Translate("#CSGO_Watch_Cat_Tournament_" + _loc7_);
         var _loc8_ = _global.GameInterface.Translate("#CSGO_Tournament_Day_" + _loc6_);
         _loc4_ = _global.ConstructString(_loc4_,_loc9_,_loc8_);
         BackToTournament.SetText(_loc4_);
         BackToTournament._visible = true;
         if(_loc3_.length > 9)
         {
            ShowScrollButtons();
         }
         new Lib.Tween(BackToTournament,"_y",mx.transitions.easing.Strong.easeOut,25,0,0.5,true);
         new Lib.Tween(BackToTournament,"_alpha",mx.transitions.easing.Strong.easeOut,0,100,0.5,true);
      }
   }
   SetErrorStates(m_TypeOfLister,_loc7_,Type,true,_loc6_);
}
function OnSelectMatch(objBtn, strMatchId)
{
   trace("------------------------------------OnSelectMatch-objBtn: " + objBtn);
   if(objBtn == null || strMatchId == undefined || strMatchId == "")
   {
      MatchData._visible = false;
      return undefined;
   }
   objBtn._MatchId = strMatchId;
   if(m_objSelectedMatchBtn != objBtn)
   {
      m_objSelectedMatchBtn.Selected._visible = false;
   }
   m_objSelectedMatchBtn = objBtn;
   ErrorPanel._visible = false;
   TournamentPanel._visible = false;
   StreamsPanel._visible = false;
   if(!IsMatchMetadataLoaded(strMatchId))
   {
      _global.CScaleformComponent_MatchInfo.DownloadWithShareToken(strMatchId);
      LoadingPanel.Text.htmlText = "#CSGO_Watch_Loading_MatchData";
      m_numTimerDelay = setTimeout(ShowLoadingMatchDataError,8000);
      LoadingPanel._visible = true;
      MatchData._visible = false;
   }
   else
   {
      MatchData.Scoreboard.SetUpScoreBoard(strMatchId,0,m_PlayerXuid,m_TypeOfLister,true);
      MatchData.Scoreboard.SetUpScoreBoard(strMatchId,1,m_PlayerXuid,m_TypeOfLister,true);
      MatchData.MatchInfo.SetUpMatchInfo(strMatchId,m_PlayerXuid,m_TypeOfLister,true);
      MatchData._visible = true;
      LoadingPanel._visible = false;
   }
}
function ShowLoadingMatchDataError()
{
   LoadingPanel._visible = false;
   ShowErrorPanel("#CSGO_Watch_NoMatchData");
}
function OnSelectPickEm(objBtn, bIsPlayerPickEm, bIsFantasyGame)
{
   TournamentPanel.SetUpTournamentInfo(m_PlayerXuid,m_TypeOfLister,bIsPlayerPickEm,bIsFantasyGame);
   MatchData._visible = false;
   StreamsPanel._visible = false;
}
function BackToTournamentAccordian()
{
   AnimMatchListerTransitionBack(true);
   HideScrollBtns();
}
function IsMatchMetadataLoaded(strMatchId)
{
   trace("--------------------------------_global.CScaleformComponent_MatchInfo.GetMatchMetadataFullState():" + _global.CScaleformComponent_MatchInfo.GetMatchMetadataFullState(strMatchId));
   if(_global.CScaleformComponent_MatchInfo.GetMatchMetadataFullState(strMatchId))
   {
      return true;
   }
   return false;
}
function AnimMatchListerTransition(MenuArray, bSkipAnim)
{
   ResetMenuToTop();
   HideScrollBtns();
   if(bSkipAnim)
   {
      RemakeAccordianMenu(MenuArray);
      MakeDefaultSelectionForMatchesListers(MenuArray[0].id);
      if(MenuArray.length > 9)
      {
         ShowScrollButtons();
      }
      return undefined;
   }
   mcAccordianMenu.EnableClickBlocker(ClickBlocker);
   new Lib.Tween(mcAccordianMenu,"_alpha",mx.transitions.easing.Strong.easeOut,100,0,1,true);
   var _loc1_ = new Lib.Tween(mcAccordianMenu,"_x",mx.transitions.easing.Strong.easeIn,0,-132,0.25,true);
   _loc1_.onMotionFinished = function()
   {
      RemakeAccordianMenu(MenuArray);
      MakeDefaultSelectionForMatchesListers(MenuArray[0].id);
      if(MenuArray.length > 9)
      {
         ShowScrollButtons();
      }
      new Lib.Tween(mcAccordianMenu,"_x",mx.transitions.easing.Strong.easeOut,132,0,0.5,true);
      new Lib.Tween(mcAccordianMenu,"_alpha",mx.transitions.easing.Strong.easeOut,0,100,1,true);
      mcAccordianMenu.DisableClickBlocker(ClickBlocker);
   };
}
function AnimMatchListerTransitionBack(bIsBackBtn, bSkipAnim)
{
   ResetMenuToTop();
   HideScrollBtns();
   if(bSkipAnim)
   {
      RemakeAccordianMenu(SetTournamentAccordianNodes());
      MakeDefaultSelectionForTournamentLister(DEFAULT_TOURNAMENT_ID);
      if(MenuArray.length > 9)
      {
         ShowScrollButtons();
      }
      return undefined;
   }
   mcAccordianMenu.EnableClickBlocker(ClickBlocker);
   new Lib.Tween(mcAccordianMenu,"_alpha",mx.transitions.easing.Strong.easeOut,100,0,1,true);
   var _loc1_ = new Lib.Tween(mcAccordianMenu,"_x",mx.transitions.easing.Strong.easeIn,0,132,0.25,true);
   _loc1_.onMotionFinished = function()
   {
      RemakeAccordianMenu(SetTournamentAccordianNodes());
      if(MenuArray.length > 9)
      {
         ShowScrollButtons();
      }
      if(bIsBackBtn)
      {
         mcAccordianMenu.AnimateAcoordianMenu(BackToTournament._objMenuBack._parent);
         OnPressAccordianCatagory(BackToTournament._objMenuBack,m_TypeOfLister);
         BackToTournament._visible = false;
         TopMenuChangeAnim();
         var _loc1_ = GetEventIdFromListerType(m_TypeOfLister);
         SelectTeamPickEmAsDefault(PickDefaultTournamentTab(_loc1_));
      }
      else
      {
         MakeDefaultSelectionForTournamentLister(DEFAULT_TOURNAMENT_ID);
      }
      new Lib.Tween(mcAccordianMenu,"_x",mx.transitions.easing.Strong.easeOut,-100,0,0.5,true);
      new Lib.Tween(mcAccordianMenu,"_alpha",mx.transitions.easing.Strong.easeOut,0,100,1,true);
      mcAccordianMenu.DisableClickBlocker(ClickBlocker);
   };
}
function OnSelectSteamsPanel()
{
   MatchData._visible = false;
   TournamentPanel._visible = false;
   LoadingPanel._visible = false;
   ErrorPanel._visible = false;
   var _loc3_ = new Array();
   RemakeAccordianMenu(_loc3_);
   var _loc2_ = _global.CScaleformComponent_Streams.GetStreamCount();
   if(_loc2_ == 0 || _loc2_ == undefined)
   {
      ShowErrorPanel("#CSGO_Watch_NoSteams");
      return undefined;
   }
   StreamsPanel.InitStreamsPanel();
   new Lib.Tween(StreamsPanel,"_alpha",mx.transitions.easing.Strong.easeOut,0,100,1,true);
   StreamsPanel._visible = true;
   BgSections._visible = false;
   FadeEdge._visible = false;
   mcAccordianMenu._visible = false;
}
function SetDataForTypeOfBtn(objParent, btnType)
{
   trace("------------------------------btnType ----------------------" + btnType);
   switch(btnType)
   {
      case "accordian-match-tournament-btn":
         LoadDataForTournmentMatchBtn(objParent.Node);
         break;
      case "accordian-match-live-btn":
         LoadDataForLiveMatchBtn(objParent.Node);
         break;
      case "accordian-match-yours-btn":
         LoadDataForYourMatchBtn(objParent.Node);
   }
}
function LoadDataForTextImageBtn(objBtn, objData)
{
   var _loc3_ = true;
   if(objData.id == "team" || objData.id == "player" || objData.id == "fantasy")
   {
      _loc3_ = false;
   }
   LoadImage(objData.image,objBtn.ImageHolder,objData.width,objData.height,_loc3_);
   objBtn.ButtonText.Text.htmlText = _global.GameInterface.Translate(objData.nametag);
}
function LoadDataForTextButton(objBtn, objData)
{
   objBtn.ButtonText.Text.htmlText = _global.GameInterface.Translate(objData.nametag);
}
function LoadDataForTournmentMatchBtn(objBtn)
{
   var _loc2_ = objBtn._parent._id;
   trace("----------------------RefreshSelected:MatchId---------------------------" + _loc2_);
   LoadImage(GetMatchTournamentTeamIconPath(GetTeamTag(0,_loc2_).toLowerCase()),objBtn.TeamImage0,28,28,false);
   LoadImage(GetMatchTournamentTeamIconPath(GetTeamTag(1,_loc2_).toLowerCase()),objBtn.TeamImage1,28,28,false);
   LoadStatusIcon(objBtn,_loc2_);
   objBtn.Stage.htmlText = GetMatchTournamentStageName(_loc2_);
   var _loc4_ = _global.GameInterface.Translate("#SFUI_Scoreboard_Viewers");
   _loc4_ = _global.ConstructString(_loc4_,_global.FormatNumberToString(int(GetViewers(_loc2_))));
   objBtn.Viewers.htmlText = _loc4_;
   objBtn.Map.htmlText = "#SFUI_Map_" + GetMatchMap(_loc2_);
   objBtn.Score0.htmlText = GetMatchRoundScoreForTeam(0,_loc2_);
   objBtn.Score1.htmlText = GetMatchRoundScoreForTeam(1,_loc2_);
}
function LoadDataForLiveMatchBtn(objBtn, objData)
{
   var _loc2_ = objBtn._parent._id;
   LoadImage(GetMatchSkillGroup(_loc2_),objBtn.ImageHolder,64,28,false);
   LoadStatusIcon(objBtn,_loc2_);
   var _loc4_ = _global.GameInterface.Translate("#SFUI_Scoreboard_Viewers");
   _loc4_ = _global.ConstructString(_loc4_,_global.FormatNumberToString(int(GetViewers(_loc2_))));
   objBtn.Viewers.htmlText = _loc4_;
   objBtn.Map.htmlText = "#SFUI_Map_" + GetMatchMap(_loc2_);
   objBtn.Score0.htmlText = GetMatchRoundScoreForTeam(0,_loc2_);
   objBtn.Score1.htmlText = GetMatchRoundScoreForTeam(1,_loc2_);
   SetFriendNumber(objBtn,_loc2_);
}
function LoadDataForYourMatchBtn(objBtn, objData)
{
   var _loc2_ = objBtn._parent._id;
   var _loc4_ = _global.CScaleformComponent_GameTypes.GetMapGroupAttribute("mg_" + GetMatchMap(_loc2_),"show_season_icon");
   trace("----------------SeasonImageName--------------" + _loc4_);
   if(_loc4_ != "" && _loc4_ != undefined)
   {
      LoadImage("econ/season_icons/" + _loc4_ + ".png",objBtn.ImageHolder,42,32,false);
   }
   else
   {
      LoadImage("images/map_icons/collection_icon_" + GetMatchMap(_loc2_) + ".png",objBtn.ImageHolder,32,32,false);
   }
   LoadStatusIcon(objBtn,_loc2_);
   var _loc5_ = _global.GameInterface.Translate("#SFUI_Scoreboard_Viewers");
   _loc5_ = _global.ConstructString(_loc5_,_global.FormatNumberToString(int(GetViewers(_loc2_))));
   objBtn.Date.htmlText = GetMatchTimestamp(_loc2_);
   objBtn.Map.htmlText = "#SFUI_Map_" + GetMatchMap(_loc2_);
   objBtn.Score0.htmlText = GetMatchRoundScoreForTeam(0,_loc2_);
   objBtn.Score1.htmlText = GetMatchRoundScoreForTeam(1,_loc2_);
   objBtn.CTWin._visible = MatchData.MatchInfo.DidUserWinTheMatch(_loc2_,m_TypeOfLister,m_PlayerXuid,0);
   objBtn.TWin._visible = MatchData.MatchInfo.DidUserWinTheMatch(_loc2_,m_TypeOfLister,m_PlayerXuid,1);
   SetFriendNumber(objBtn,_loc2_);
}
function StartGotvTheater()
{
   _global.CScaleformComponent_MatchList.StartGOTVTheater("live");
}
function LoadStatusIcon(objBtn, strMatchId)
{
   var _loc4_ = "images/ui_icons/";
   var _loc3_ = _global.CScaleformComponent_MatchInfo.GetMatchState(strMatchId);
   objBtn.downloading._visible = false;
   if(_loc3_ == "downloaded" || _loc3_ == "live")
   {
      objBtn.ImageHolderStatus._visible = true;
      LoadImage(_loc4_ + _loc3_ + ".png",objBtn.ImageHolderStatus,24,24,false);
   }
   else if(_loc3_ == "downloading")
   {
      objBtn.downloading._visible = true;
      objBtn.ImageHolderStatus._visible = false;
   }
   else
   {
      objBtn.ImageHolderStatus._visible = false;
   }
}
function LoadImage(imagePath, objImage, numWidth, numHeight, bCenterImage)
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
   var _loc4_ = imagePath;
   var _loc2_ = new MovieClipLoader();
   _loc2_.addListener(_loc1_);
   _loc2_.loadClip(_loc4_,objImage.Image);
   if(bCenterImage)
   {
      objImage._x = (objImage._parent._width - numWidth) * 0.5;
   }
}
function RefreshWatchMatchList(Type)
{
   var _loc3_ = _global.CScaleformComponent_MatchList.GetState(Type);
   if(_loc3_ != "ready")
   {
      return undefined;
   }
   if(Type == m_TypeOfLister)
   {
      if(Type.indexOf("tournament:") != -1)
      {
         if(m_objSelectedTournamentBtn == null)
         {
            m_objSelectedTournamentBtn = mcAccordianMenu.Parent0.Node;
         }
         OnPressAccordianCatagory(m_objSelectedTournamentBtn,Type);
         m_objSelectedTournamentBtn.Selected._visible = true;
      }
      else
      {
         OnPressTopMenuBtn(m_objSelectedTopBarMenuBtn,m_TypeOfLister,true);
         m_objSelectedMatchBtn = mcAccordianMenu.Parent0.Node;
         OnSelectMatch(m_objSelectedMatchBtn,m_objSelectedMatchBtn._parent._id);
         m_objSelectedMatchBtn.Selected._visible = true;
      }
   }
}
function RefreshSelectedMatch(MatchId)
{
   trace("---------------------------Refresh Match--------------------------------");
   if(IsMatchMetadataLoaded(m_objSelectedMatchBtn._MatchId))
   {
      var _loc1_ = LoadingPanel._visible;
      ErrorPanel._visible = false;
      LoadingPanel._visible = false;
      MatchData._visible = true;
      clearTimeout(m_numTimerDelay);
      MatchData.Scoreboard.SetUpScoreBoard(m_objSelectedMatchBtn._MatchId,0,m_PlayerXuid,m_TypeOfLister,_loc1_);
      MatchData.Scoreboard.SetUpScoreBoard(m_objSelectedMatchBtn._MatchId,1,m_PlayerXuid,m_TypeOfLister,_loc1_);
      MatchData.MatchInfo.SetUpMatchInfo(m_objSelectedMatchBtn._MatchId,m_PlayerXuid,m_TypeOfLister,_loc1_);
   }
   RefreshSelectedbtn();
}
function RefreshSelectedbtn()
{
   var _loc4_ = _global.CScaleformComponent_MatchList.GetCount(m_TypeOfLister);
   var _loc2_ = 0;
   while(_loc2_ < _loc4_)
   {
      var _loc3_ = mcAccordianMenu["Parent" + _loc2_];
      SetDataForTypeOfBtn(_loc3_,_loc3_._btnType);
      _loc2_ = _loc2_ + 1;
   }
}
function GetMatchTournamentStageName(strMatchId)
{
   return _global.CScaleformComponent_MatchInfo.GetMatchTournamentStageName(strMatchId);
}
function GetMatchTournamentTeamName(Team, strMatchId)
{
   return _global.CScaleformComponent_MatchInfo.GetMatchTournamentTeamName(strMatchId,Team);
}
function GetMatchTournamentTeamIconPath(TeamId)
{
   return "econ/tournaments/teams/" + TeamId + ".png";
}
function GetViewers(strMatchId)
{
   return _global.CScaleformComponent_MatchInfo.GetMatchSpectators(strMatchId);
}
function GetTeamTag(Team, strMatchId)
{
   return _global.CScaleformComponent_MatchInfo.GetMatchTournamentTeamTag(strMatchId,Team);
}
function GetMatchMap(strMatchId)
{
   return _global.CScaleformComponent_MatchInfo.GetMatchMap(strMatchId);
}
function GetMatchRoundScoreForTeam(Team, strMatchId)
{
   return _global.CScaleformComponent_MatchInfo.GetMatchRoundScoreForTeam(strMatchId,Team);
}
function GetMatchDuration(strMatchId)
{
   var _loc5_ = "";
   var _loc2_ = _global.CScaleformComponent_MatchInfo.GetMatchDuration(strMatchId);
   var _loc3_ = _global.GameInterface.Translate("#CSGO_competitive_Time_Played");
   if(_loc2_ == 0)
   {
      return "#CSGO_Watch_JustStarted";
   }
   if(_loc2_ > 60)
   {
      var _loc4_ = Math.ceil(_loc2_ / 60);
      _loc2_ = Math.ceil(_loc2_ - _loc4_ * 60);
      _loc3_ = _loc4_ + " " + _global.GameInterface.Translate("#CSGO_Watch_Minutes");
   }
   else
   {
      _loc3_ = "1 " + _global.GameInterface.Translate("#CSGO_Watch_Minute");
   }
   return _loc3_;
}
function GetMatchSkillGroup(strMatchId)
{
   var _loc2_ = "econ/status_icons/skillgroup" + _global.CScaleformComponent_MatchInfo.GetMatchSkillGroup(strMatchId) + ".png";
   return _loc2_;
}
function GetMatchTimestamp(strMatchId)
{
   return _global.CScaleformComponent_MatchInfo.GetMatchTimestamp(strMatchId);
}
function GetMatchFriendsByIndexForTeam(Team, strMatchId)
{
   var _loc4_ = 0;
   var _loc2_ = 0;
   while(_loc2_ <= 4)
   {
      var _loc3_ = _global.CScaleformComponent_MatchInfo.GetMatchPlayerXuidByIndexForTeam(strMatchId,Team,_loc2_);
      if("friend" == _global.CScaleformComponent_FriendsList.GetFriendRelationship(_loc3_))
      {
         _loc4_ = _loc4_ + 1;
      }
      _loc2_ = _loc2_ + 1;
   }
   return _loc4_;
}
function SetFriendNumber(objBtn, strMatchId)
{
   var _loc1_ = GetMatchFriendsByIndexForTeam(0,strMatchId);
   _loc1_ = _loc1_ + GetMatchFriendsByIndexForTeam(1,strMatchId);
   if(_loc1_ <= 0)
   {
      objBtn.Friends._visible = false;
      objBtn.FriendIcon._visible = false;
   }
   else
   {
      objBtn.Friends.htmlText = "x " + _loc1_;
      objBtn.FriendIcon._visible = true;
   }
}
function SetUpScrollButtons()
{
   ButtonDown.dialog = this;
   ButtonDown.Action = function()
   {
      onDownBtn(DistToMove);
   };
   ButtonUp.dialog = this;
   ButtonUp.Action = function()
   {
      onUpBtn(DistToMove);
   };
}
function ShowScrollButtons()
{
   var _loc1_ = 24;
   var _loc2_ = 576;
   ButtonDown._visible = true;
   ButtonUp._visible = true;
   if(mcAccordianMenu._y + mcAccordianMenu._height - _loc1_ < _loc2_)
   {
      ButtonDown._visible = false;
   }
   if(mcAccordianMenu._y >= _loc1_)
   {
      ButtonUp._visible = false;
   }
}
function HideScrollBtns()
{
   ButtonDown._visible = false;
   ButtonUp._visible = false;
}
function ResetMenuToTop()
{
   mcAccordianMenu._y = 24;
}
function onDownBtn(DistToMove)
{
   var _loc3_ = 24;
   DistToMove = 576;
   mcAccordianMenu.EnableClickBlocker(ClickBlocker);
   var _loc1_ = new Lib.Tween(mcAccordianMenu,"_y",mx.transitions.easing.Strong.easeOut,mcAccordianMenu._y,mcAccordianMenu._y - DistToMove,1,true);
   _loc1_.onMotionFinished = function()
   {
      ShowScrollButtons();
      mcAccordianMenu.DisableClickBlocker(ClickBlocker);
   };
}
function onUpBtn(DistToMove)
{
   var _loc3_ = 24;
   DistToMove = 576;
   mcAccordianMenu.EnableClickBlocker(ClickBlocker);
   var _loc1_ = new Lib.Tween(mcAccordianMenu,"_y",mx.transitions.easing.Strong.easeOut,mcAccordianMenu._y,mcAccordianMenu._y + DistToMove,1,true);
   _loc1_.onMotionFinished = function()
   {
      ShowScrollButtons();
      mcAccordianMenu.DisableClickBlocker(ClickBlocker);
   };
}
var WATCH_PANEL_START_POS = this._y;
var DEFAULT_TOURNAMENT_ID = "tournament:10";
var m_panelOpen = false;
var m_PlayerXuid = _global.CScaleformComponent_MyPersona.GetXuid();
var m_objSelectedTopBarMenuBtn = null;
var m_objSelectedMenuBtn = null;
var m_objSelectedTournamentBtn = null;
var m_objSelectedTournamentSubMenuBtn = null;
var m_objSelectedMatchBtn = null;
var m_TypeOfLister = "";
var m_numTimerDelay = 0;
var m_bHasLoadedData = false;
stop();
