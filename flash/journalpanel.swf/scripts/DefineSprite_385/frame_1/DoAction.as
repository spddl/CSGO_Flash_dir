function ShowPanel(numPage, ItemId, numSeason, bOpenToPage)
{
   DoublePageDialogHide();
   m_numSeason = numSeason;
   m_ItemID = ItemId;
   SetUpTOCBAsedOnSeason(m_numSeason);
   InitialCoverLoadIntervalId = setInterval(InitialCoverLoad,1,Cover);
   OpenBook(numPage,bOpenToPage);
   this._parent.DoublePageDialog._visible = false;
   _global.MainMenuMovie.Panel.Blog.EnableInput(false);
   var _loc3_ = _global.MainMenuMovie.Panel.TooltipItemPreview;
   _loc3_.ShowHidePreview(false);
}
function OpenBook(numPage, bOpenToPage)
{
   this._x = CLOSED_JOURNAL_XPOS;
   this._parent.gotoAndPlay("StartShow");
   this._visible = true;
   OpenToPage(numPage,bOpenToPage);
}
function SetUpTOCBAsedOnSeason(numSeason)
{
   if(numSeason == NUM_OP_BREAKOUT_ID)
   {
      m_aPages = [];
      m_aPages = ["journal-toc","journal-badge","journal-operation-overview","journal-stats-op","journal-stats-comp","journalleaderboardsop","journalleaderboardscomp","journal-mapsinfo-castle","journal-mapsinfo-overgrown","journal-mapsinfo-blackgold","journal-mapsinfo-rush","journal-mapsinfo-mist","journal-mapsinfo-insertion"];
   }
   if(numSeason == NUM_OP_VANGAURD_ID)
   {
      m_aPages = [];
      m_aPages = ["journal-toc","journal-badge","journal-operation-overview","journal-campaign-left0","journal-campaign-right0","journal-campaign-left1","journal-campaign-right1","journal-campaign-left2","journal-campaign-right2","journal-campaign-left3","journal-campaign-right3","journal-stats-op","journal-stats-comp","journalleaderboardsop","journalleaderboardscomp","journal-mapsinfo-workout","journal-mapsinfo-backalley","journal-mapsinfo-marquis","journal-mapsinfo-facade","journal-mapsinfo-season","journal-mapsinfo-bazaar"];
   }
   if(numSeason == NUM_OP_BLOODHOUND_ID)
   {
      m_aPages = [];
      m_aPages = ["journal-toc","journal-badge","journal-operation-overview","journal-campaign-left4","journal-campaign-right4","journal-campaign-left5","journal-campaign-right5","journal-stats-op","journal-stats-comp","journalleaderboardsop","journalleaderboardscomp","journal-mapsinfo-rails","journal-mapsinfo-resort","journal-mapsinfo-log","journal-mapsinfo-agency","journal-mapsinfo-season","journal-mapsinfo-zoo","journal-emptypage","journal-missions-faq"];
   }
   if(numSeason == NUM_OP_SEVENJAN_ID)
   {
      m_aPages = [];
      m_aPages = ["journal-toc","journal-badge","journal-operation-overview","journal-campaign-left7","journal-campaign-right7","journal-campaign-left6","journal-campaign-right6","journal-stats-op","journal-stats-comp","journalleaderboardsop","journalleaderboardscomp","journal-mapsinfo-cruise","journal-mapsinfo-coast","journal-mapsinfo-empire","journal-mapsinfo-mikla","journal-mapsinfo-royal","journal-mapsinfo-santorini","journal-mapsinfo-tulip","journal-mapsinfo-nuke","journal-emptypage","journal-missions-faq"];
   }
}
function HidePanel()
{
   CloseBook();
   clearInterval(SetUpIntervalId);
   clearInterval(InitialCoverLoadIntervalId);
   this._parent.gotoAndPlay("StartHide");
   if(!m_BookIsClosed)
   {
      m_NumPage;
   }
   _global.MainMenuMovie.Panel.Blog.EnableInput(true);
}
function InitialCoverLoad(Cover)
{
   Cover.SetUpPage(m_numSeason,m_ItemID);
   EnableDisablePageTurnButtons();
   clearInterval(InitialCoverLoadIntervalId);
}
function OpenToPage(numPage, bOpenToPage)
{
   if(bOpenToPage)
   {
      m_NumPage = numPage;
      Cover.onPress = function()
      {
      };
      if(m_BookIsClosed)
      {
         PageAnim(true);
         clearInterval(SetUpIntervalId);
         SetUpIntervalId = setInterval(AnimToPage,10);
      }
      else
      {
         PageAnim(true);
      }
   }
   else
   {
      m_NumPage = 0;
      LoadVisiblePages(m_NumPage,1);
      Cover.onPress = function()
      {
         GoToToc();
      };
   }
}
function AnimToPage()
{
   m_OpenToPageAnim = true;
   PageAnim(true);
   clearInterval(SetUpIntervalId);
}
function GoToToc()
{
   if(m_BookIsClosed)
   {
      PageAnim(true);
   }
   if(m_NumPage == 0)
   {
      return undefined;
   }
   m_NumPage = 2;
   PageAnim(false);
}
function CloseBook()
{
   if(m_BookIsClosed)
   {
      return undefined;
   }
   m_NumPage = 0;
   LoadVisiblePages(0,1);
   AnimLine._x = JOURNAL_RIGHT_EDGE;
   BackPage._x = AnimLine._x;
   BackPageShadowLower._x = AnimLine._x;
   BackPage.Page._x = - JOURNAL_RIGHT_EDGE - AnimLine._x;
   BackPage._rotation = 90 * (AnimLine._x - JOURNAL_SPINE) / PageBounds._width;
   BackPageShadowLower._rotation = 90 * (AnimLine._x - JOURNAL_SPINE) / PageBounds._width;
   AnimLine._rotation = 45 * (AnimLine._x - JOURNAL_SPINE) / PageBounds._width;
   PageAnim(false);
}
function SetUpPage(aPagesToLoad)
{
   var _loc1_ = 0;
   while(_loc1_ < aPagesToLoad.length)
   {
      trace("-------------------------SET UP PAGE objPage------------------------" + aPagesToLoad[_loc1_]);
      trace("-------------------------m_NumPage------------------------" + m_NumPage);
      switch(aPagesToLoad[_loc1_]._Type)
      {
         case "journal-toc":
            aPagesToLoad[_loc1_].SetUpPage(m_numSeason,m_ItemID);
            break;
         case "journal-operation-overview":
            aPagesToLoad[_loc1_].SetUpPage(m_numSeason);
            break;
         case "journal-mapsinfo-workout":
            aPagesToLoad[_loc1_].SetUpPage(m_numSeason,"mg_cs_workout");
            break;
         case "journal-mapsinfo-backalley":
            aPagesToLoad[_loc1_].SetUpPage(m_numSeason,"mg_cs_backalley");
            break;
         case "journal-mapsinfo-marquis":
            aPagesToLoad[_loc1_].SetUpPage(m_numSeason,"mg_de_marquis");
            break;
         case "journal-mapsinfo-facade":
            aPagesToLoad[_loc1_].SetUpPage(m_numSeason,"mg_de_facade");
            break;
         case "journal-mapsinfo-season":
            aPagesToLoad[_loc1_].SetUpPage(m_numSeason,"mg_de_season");
            break;
         case "journal-mapsinfo-bazaar":
            aPagesToLoad[_loc1_].SetUpPage(m_numSeason,"mg_de_bazaar");
            break;
         case "journal-mapsinfo-castle":
            aPagesToLoad[_loc1_].SetUpPage(m_numSeason,"mg_de_castle");
            break;
         case "journal-mapsinfo-overgrown":
            aPagesToLoad[_loc1_].SetUpPage(m_numSeason,"mg_de_overgrown");
            break;
         case "journal-mapsinfo-blackgold":
            aPagesToLoad[_loc1_].SetUpPage(m_numSeason,"mg_de_blackgold");
            break;
         case "journal-mapsinfo-rush":
            aPagesToLoad[_loc1_].SetUpPage(m_numSeason,"mg_cs_rush");
            break;
         case "journal-mapsinfo-mist":
            aPagesToLoad[_loc1_].SetUpPage(m_numSeason,"mg_de_mist");
            break;
         case "journal-mapsinfo-insertion":
            aPagesToLoad[_loc1_].SetUpPage(m_numSeason,"mg_cs_insertion");
            break;
         case "journal-mapsinfo-rails":
            aPagesToLoad[_loc1_].SetUpPage(m_numSeason,"mg_de_rails");
            break;
         case "journal-mapsinfo-resort":
            aPagesToLoad[_loc1_].SetUpPage(m_numSeason,"mg_de_resort");
            break;
         case "journal-mapsinfo-zoo":
            aPagesToLoad[_loc1_].SetUpPage(m_numSeason,"mg_de_zoo");
            break;
         case "journal-mapsinfo-log":
            aPagesToLoad[_loc1_].SetUpPage(m_numSeason,"mg_de_log");
            break;
         case "journal-mapsinfo-agency":
            aPagesToLoad[_loc1_].SetUpPage(m_numSeason,"mg_cs_agency");
            break;
         case "journal-mapsinfo-cruise":
            aPagesToLoad[_loc1_].SetUpPage(m_numSeason,"mg_cs_cruise");
            break;
         case "journal-mapsinfo-coast":
            aPagesToLoad[_loc1_].SetUpPage(m_numSeason,"mg_de_coast");
            break;
         case "journal-mapsinfo-empire":
            aPagesToLoad[_loc1_].SetUpPage(m_numSeason,"mg_de_empire");
            break;
         case "journal-mapsinfo-mikla":
            aPagesToLoad[_loc1_].SetUpPage(m_numSeason,"mg_de_mikla");
            break;
         case "journal-mapsinfo-royal":
            aPagesToLoad[_loc1_].SetUpPage(m_numSeason,"mg_de_royal");
            break;
         case "journal-mapsinfo-santorini":
            aPagesToLoad[_loc1_].SetUpPage(m_numSeason,"mg_de_santorini");
            break;
         case "journal-mapsinfo-tulip":
            aPagesToLoad[_loc1_].SetUpPage(m_numSeason,"mg_de_tulip");
            break;
         case "journal-mapsinfo-nuke":
            aPagesToLoad[_loc1_].SetUpPage(m_numSeason,"mg_de_nuke");
            break;
         case "journal-badge":
            aPagesToLoad[_loc1_].SetUpPage(m_numSeason,m_ItemID);
            break;
         case "journal-stats-comp":
            aPagesToLoad[_loc1_].SetUpPage(m_numSeason,"competitive",m_ItemID);
            break;
         case "journal-stats-op":
            aPagesToLoad[_loc1_].SetUpPage(m_numSeason,"operation",m_ItemID);
            break;
         case "journalleaderboardscomp":
            aPagesToLoad[_loc1_].SetUpPage(m_numSeason,"competitive",m_ItemID);
            break;
         case "journalleaderboardsop":
            aPagesToLoad[_loc1_].SetUpPage(m_numSeason,"operation",m_ItemID);
            break;
         case "journal-emptypage":
            break;
         case "journal-cover":
            aPagesToLoad[_loc1_].SetUpPage(m_numSeason,m_ItemID);
            break;
         case "journal-campaign-left0":
            aPagesToLoad[_loc1_].SetUpPage(m_numSeason,m_ItemID,2,false);
            break;
         case "journal-campaign-right0":
            aPagesToLoad[_loc1_].SetUpPage(m_numSeason,m_ItemID,2,true);
            break;
         case "journal-campaign-left1":
            aPagesToLoad[_loc1_].SetUpPage(m_numSeason,m_ItemID,4,false);
            break;
         case "journal-campaign-right1":
            aPagesToLoad[_loc1_].SetUpPage(m_numSeason,m_ItemID,4,true);
            break;
         case "journal-campaign-left2":
            aPagesToLoad[_loc1_].SetUpPage(m_numSeason,m_ItemID,3,false);
            break;
         case "journal-campaign-right2":
            aPagesToLoad[_loc1_].SetUpPage(m_numSeason,m_ItemID,3,true);
            break;
         case "journal-campaign-left3":
            aPagesToLoad[_loc1_].SetUpPage(m_numSeason,m_ItemID,1,false);
            break;
         case "journal-campaign-right3":
            aPagesToLoad[_loc1_].SetUpPage(m_numSeason,m_ItemID,1,true);
            break;
         case "journal-campaign-left4":
            aPagesToLoad[_loc1_].SetUpPage(m_numSeason,m_ItemID,5,false);
            break;
         case "journal-campaign-right4":
            aPagesToLoad[_loc1_].SetUpPage(m_numSeason,m_ItemID,5,true);
            break;
         case "journal-campaign-left5":
            aPagesToLoad[_loc1_].SetUpPage(m_numSeason,m_ItemID,6,false);
            break;
         case "journal-campaign-right5":
            aPagesToLoad[_loc1_].SetUpPage(m_numSeason,m_ItemID,6,true);
            break;
         case "journal-campaign-left6":
            aPagesToLoad[_loc1_].SetUpPage(m_numSeason,m_ItemID,7,false);
            break;
         case "journal-campaign-right6":
            aPagesToLoad[_loc1_].SetUpPage(m_numSeason,m_ItemID,7,true);
            break;
         case "journal-campaign-left7":
            aPagesToLoad[_loc1_].SetUpPage(m_numSeason,m_ItemID,8,false);
            break;
         case "journal-campaign-right7":
            aPagesToLoad[_loc1_].SetUpPage(m_numSeason,m_ItemID,8,true);
            break;
         case "journal-missions-faq":
            aPagesToLoad[_loc1_].SetUpPage(m_numSeason);
            break;
         case "journal-missions-faq-right":
            aPagesToLoad[_loc1_].SetUpPage(m_numSeason,1);
      }
      _loc1_ = _loc1_ + 1;
   }
}
function EnableDisablePageTurnButtons()
{
   var _loc2_ = this._parent.Controls;
   if(m_NumPage == 0 && m_BookIsClosed)
   {
      _loc2_.btnPrevPage.setDisabled(true);
   }
   else
   {
      _loc2_.btnPrevPage.setDisabled(false);
   }
   if(m_NumPage >= m_aPages.length - 1)
   {
      _loc2_.btnNextPage.setDisabled(true);
   }
   else
   {
      _loc2_.btnNextPage.setDisabled(false);
   }
}
function IsFirstPage(PageNum)
{
   if(PageNum == 0 || m_OpenToPageAnim)
   {
      LeftPage._visible = false;
      LeftPageShadow._visible = false;
      m_OpenToPageAnim = false;
      return true;
   }
   LeftPage._visible = true;
   LeftPageShadow._visible = true;
   return false;
}
function PageAnim(bForward)
{
   _global.MainMenuMovie.Panel.TooltipCampaign._visible = false;
   if(m_BookIsClosed && bForward)
   {
      OpenCloseBookAnim(true);
      m_BookIsClosed = false;
      CenterJournalAnim(m_BookIsClosed);
      EnableDisablePageTurnButtons();
      return undefined;
   }
   if(!m_BookIsClosed && m_NumPage == 0 && !bForward)
   {
      OpenCloseBookAnim(false);
      m_BookIsClosed = true;
      CenterJournalAnim(m_BookIsClosed);
      EnableDisablePageTurnButtons();
      return undefined;
   }
   var StopLoc;
   var Speed;
   var AlphaTarget;
   var AlphaChange;
   var ScaleTarget;
   var _loc3_ = undefined;
   var StopAnim = false;
   TopPage._visible = true;
   LeftPage._visible = true;
   if(bForward == false)
   {
      m_NumPage = m_NumPage - 2;
      AnimLine._x = JOURNAL_SPINE;
      BackPageShadowLower._xscale = 100;
      StopLoc = JOURNAL_RIGHT_EDGE;
      Speed = 0.19;
      AnimLine.Shadow._alpha = 25;
      AlphaTarget = 0;
      AlphaChange = -0.75;
      ScaleTarget = 0;
      this._parent.Controls.btnPrevPage.setDisabled(true);
   }
   else
   {
      AnimLine._x = JOURNAL_RIGHT_EDGE;
      BackPageShadowLower._xscale = 0;
      StopLoc = JOURNAL_SPINE;
      Speed = 0.5;
      AnimLine.Shadow._alpha = 0;
      AlphaTarget = 100;
      AlphaChange = 7;
      ScaleTarget = 100;
      this._parent.Controls.btnNextPage.setDisabled(true);
   }
   BackPageShadowLower._alpha = 100;
   LoadVisiblePages(m_NumPage,1);
   if(bForward)
   {
      m_NumPage = Number(m_NumPage);
      m_NumPage = m_NumPage + 2;
   }
   this._parent.ClickBlocker._visible = true;
   PageBounds.onEnterFrame = function()
   {
      if(bForward)
      {
         if(AnimLine.Shadow._alpha < AlphaTarget)
         {
            AnimLine.Shadow._alpha = AnimLine.Shadow._alpha + AlphaChange;
         }
         if(AnimLine._x == StopLoc)
         {
            StopAnim = true;
         }
      }
      else
      {
         if(AnimLine.Shadow._alpha > AlphaTarget)
         {
            AnimLine.Shadow._alpha = AnimLine.Shadow._alpha + AlphaChange;
         }
         if(AnimLine._x > StopLoc - 10)
         {
            StopAnim = true;
         }
      }
      BackPageShadowLower._xscale = BackPageShadowLower._xscale + (ScaleTarget - BackPageShadowLower._xscale) * Speed;
      AnimLine._x = AnimLine._x + (StopLoc - AnimLine._x) * Speed;
      if(StopAnim)
      {
         AnimLine._x = StopLoc;
         EnableDisablePageTurnButtons();
         if(bForward)
         {
            TopPage._visible = false;
            LeftPage._visible = false;
         }
         _global.MainMenuMovie.Panel.JournalPanel.ClickBlocker._visible = false;
         BackPageShadowLower._alpha = 0;
         delete PageBounds.onEnterFrame;
      }
      BackPage._x = AnimLine._x;
      BackPageShadowLower._x = AnimLine._x;
      BackPage.Page._x = - JOURNAL_RIGHT_EDGE - AnimLine._x;
      BackPage._rotation = 90 * (AnimLine._x - JOURNAL_SPINE) / PageBounds._width;
      BackPageShadowLower._rotation = 90 * (AnimLine._x - JOURNAL_SPINE) / PageBounds._width;
      AnimLine._rotation = 45 * (AnimLine._x - JOURNAL_SPINE) / PageBounds._width;
   };
}
function ReLoadVisiblePages()
{
   OpenToPage(m_NumPage - 2,true);
}
function LoadVisiblePages(PageNum, numDelayOverride)
{
   var aPagesToLoad = [];
   PageNum = Number(PageNum);
   TopPage.removeMovieClip();
   TopPage = this.attachMovie(m_aPages[PageNum],m_aPages[PageNum],TOP_PAGE_DEPTH,PagePos);
   TopPage._Type = m_aPages[PageNum];
   aPagesToLoad.push(TopPage);
   BottomPage.removeMovieClip();
   BottomPage = this.attachMovie(m_aPages[PageNum + 2],m_aPages[PageNum + 2],BOTTOM_PAGE_DEPTH,PagePos);
   BottomPage._Type = m_aPages[PageNum + 2];
   aPagesToLoad.push(BottomPage);
   if(!IsFirstPage(PageNum))
   {
      LeftPage.removeMovieClip();
      LeftPage = this.attachMovie(m_aPages[PageNum - 1],m_aPages[PageNum - 1],LEFT_PAGE_DEPTH,LeftPagePos);
      LeftPageShadow = this.attachMovie("journal-left-shadow","LeftPageShadow",LEFT_SHADOW_DEPTH,PagePos);
      LeftPage._Type = m_aPages[PageNum - 1];
      aPagesToLoad.push(LeftPage);
   }
   this.BackPage.Page.BackPageContents.removeMovieClip();
   this.BackPage.Page.BackPageContents.attachMovie(m_aPages[PageNum + 1],m_aPages[PageNum + 1],TOP_PAGE_DEPTH + 2);
   this.BackPage.Page.BackPageContents[m_aPages[PageNum + 1]]._Type = m_aPages[PageNum + 1];
   aPagesToLoad.push(this.BackPage.Page.BackPageContents[m_aPages[PageNum + 1]]);
   BackPage.Page.BackPageContents[m_aPages[PageNum + 1]].PageBg.SpineRightShadow._visible = false;
   LeftPage.PageBg.SpineRightShadow._visible = false;
   BottomPage.setMask(AnimLine.RightMask);
   this.onEnterFrame = function()
   {
      SetUpPage(aPagesToLoad);
      delete this.onEnterFrame;
   };
}
function OpenCloseBookAnim(bOpen)
{
   var StartScale;
   var StopScale;
   var numSkew = 0;
   var Speed = 0.45;
   var numAlpha;
   var tx = Cover._x;
   var ty = Cover._y;
   var my_matrix = Cover.transform.matrix;
   my_matrix.translate(- tx,- ty);
   Cover.Sheen._alpha = 0;
   if(bOpen)
   {
      StartScale = 1;
      StopScale = -1;
      numAlpha = -10;
      _global.navManager.PlayNavSound("BookOpen");
      Cover.onPress = function()
      {
      };
   }
   else
   {
      Speed = 0.5;
      StartScale = -1;
      StopScale = 1;
      numAlpha = 20;
      _global.navManager.PlayNavSound("BookClose");
      Cover.onPress = function()
      {
         GoToToc();
      };
   }
   Cover.Sheen._visible = true;
   Cover.onEnterFrame = function()
   {
      if(bOpen)
      {
         if(StartScale > 0.1)
         {
            Cover.Sheen._alpha = Cover.Sheen._alpha + 60;
         }
         else
         {
            Cover.Sheen._alpha = Cover.Sheen._alpha - 20;
         }
         if(StartScale > 0)
         {
            numSkew = numSkew + (-0.4 - numSkew) * Speed;
         }
         else if(StartScale < 0)
         {
            numSkew = numSkew + (- numSkew) * Speed;
         }
      }
      else
      {
         if(StartScale > 0.1 && StartScale < 0.4)
         {
            if(Cover.Sheen._alpha < 60)
            {
               Cover.Sheen._alpha = Cover.Sheen._alpha + 2;
            }
         }
         else if(StartScale > 0.5)
         {
            Cover.Sheen._alpha = Cover.Sheen._alpha - 30;
         }
         if(StartScale < 0)
         {
            numSkew = numSkew + (-0.4 - numSkew) * Speed;
         }
         else if(StartScale > 0)
         {
            numSkew = numSkew + (- numSkew) * Speed;
         }
      }
      Cover.Sheen._alpha = Cover.Sheen._alpha + numAlpha;
      StartScale = StartScale + (StopScale - StartScale) * Speed;
      my_matrix.identity();
      my_matrix.concat(new flash.geom.Matrix(my_matrix.a,numSkew,0,1,0,0));
      my_matrix.scale(StartScale,1);
      my_matrix.translate(tx,ty);
      Cover.transform.matrix = my_matrix;
      if(StartScale < 0.1 && StartScale > -0.1)
      {
         Cover.Text._visible = !bOpen;
         Cover.Lines._visible = !bOpen;
         Cover.Sheen._visible = !bOpen;
         Cover.BackOfCover._visible = bOpen;
         if(bOpen)
         {
            Cover.swapDepths(LEFT_PAGE_DEPTH - 1);
         }
         else
         {
            Cover.swapDepths(1000);
         }
      }
      if(bOpen)
      {
         if(StartScale <= StopScale)
         {
            DeleteAnimFromCoverMc(StopScale);
         }
      }
      else if(StartScale >= StopScale)
      {
         DeleteAnimFromCoverMc(StopScale);
      }
   };
}
function DeleteAnimFromCoverMc(StopScale)
{
   delete Cover.onEnterFrame;
}
function CenterJournalAnim(bIsClosed)
{
   var Speed = 0.3;
   trace("-------------------------------bIsClosed----" + bIsClosed);
   if(bIsClosed)
   {
      var StopPosition = CLOSED_JOURNAL_XPOS;
   }
   else
   {
      var StopPosition = OPEN_JOURNAL_XPOS;
   }
   var objAnim = this;
   this._parent.onEnterFrame = function()
   {
      objAnim._x = objAnim._x + (StopPosition - objAnim._x) * Speed;
      if(objAnim._x == StopPosition)
      {
         delete this._parent.onEnterFrame;
      }
   };
}
function DoublePageDialogHide()
{
   this._parent.DoublePageDialog._visible = false;
   Close._visible = true;
   this._parent.Controls._visible = true;
}
function SetDoublePageDialog(objMissionNode)
{
   var _loc2_ = false;
   if(objMissionNode._IsComicNode)
   {
      ShowDoublePageDialog("ComicViewer",objMissionNode);
      return undefined;
   }
   if(objMissionNode._bHasAudio)
   {
      ShowDoublePageDialog("PlayMissionAudio",objMissionNode);
      return undefined;
   }
   if(GetActiveMission() != 0)
   {
      _loc2_ = true;
   }
   SelectDoublePageLayout(_loc2_,objMissionNode);
}
function SelectDoublePageLayout(bHasActiveMission, objMissionNode)
{
   if(objMissionNode._bIsReplayingMission)
   {
      PlayMissionFromJournal(objMissionNode._QuestID,objMissionNode._bIsReplayingMission);
      return undefined;
   }
   if(!bHasActiveMission)
   {
      ShowDoublePageDialog("RequestMissionTimeout",objMissionNode);
   }
   else if(objMissionNode._NodeState == "active" && bHasActiveMission)
   {
      PlayMissionFromJournal();
   }
   else if(objMissionNode._NodeState == "accessible" && bHasActiveMission)
   {
      ShowDoublePageDialog("DeleteMission",objMissionNode);
   }
   else if(objMissionNode._NodeState == "accessible" && !bHasActiveMission)
   {
      ShowDoublePageDialog("RequestMissionTimeout",objMissionNode);
   }
}
function ShowDoublePageDialog(Type, objMission)
{
   var _loc4_ = 0;
   var _loc2_ = this._parent.DoublePageDialog;
   _loc2_._visible = true;
   _loc2_.Loading.Text.htmlText = strMessage;
   _loc2_.Loading.Warning._visible = false;
   _loc2_.Loading.Spinner._visible = false;
   _loc2_.Accept._visible = false;
   _loc2_.Accept._x = m_numAcceptButtonDefaultX;
   _loc2_.Delete._x = 412.6;
   _loc2_.Delete._visible = false;
   _loc2_.Portrait._visible = false;
   _loc2_.Comic._visible = false;
   _loc2_.Leaderboard._visible = false;
   _loc2_.Accept._y = m_numAcceptButtonDefaultY;
   _loc2_.Delete._y = m_numAcceptButtonDefaultY;
   switch(Type)
   {
      case "RequestMissionTimeout":
         RequestMissionTimeoutDialog(objMission);
         break;
      case "DeleteMission":
         DeleteMission(objMission);
         break;
      case "PlayMissionAudio":
         PlayMissionAudioDialog(objMission);
         break;
      case "ComicViewer":
         ComicViewerDialog(objMission);
         break;
      case "Leaderboard":
         LeaderboardDialog(objMission);
   }
   Close._visible = false;
   this._parent.Controls._visible = false;
}
function PlayMissionAudioDialog(objMission)
{
   var objDialog = this._parent.DoublePageDialog;
   var bHasActiveMission = false;
   objDialog._visible = true;
   objDialog.Loading.Text.htmlText = "";
   if(GetActiveMission() != 0)
   {
      bHasActiveMission = true;
   }
   objDialog.Accept.dialog = this;
   objDialog.Accept.ButtonText.Text.htmlText = "#SFUI_Missions_Play";
   if(IsClientInLobby())
   {
      objDialog.Accept.Action = function()
      {
         this.dialog.ShowDoublePageDialog("DeleteMission",objMission);
         _global.CScaleformComponent_Inventory.CancelQuestAudio();
      };
   }
   else if(objMission._NodeState == "accessible" && bHasActiveMission && ActiveIsCoop())
   {
      objDialog.Accept.Action = function()
      {
         this.dialog.ShowDoublePageDialog("RequestMissionTimeout",objMission);
         _global.CScaleformComponent_Inventory.CancelQuestAudio();
      };
   }
   else
   {
      objDialog.Accept.Action = function()
      {
         this.dialog.SelectDoublePageLayout(bHasActiveMission,objMission);
         _global.CScaleformComponent_Inventory.CancelQuestAudio();
      };
   }
   objDialog.Delete.dialog = this;
   objDialog.Delete.ButtonText.Text.htmlText = "#SFUI_Crafting_Cancel";
   objDialog.Delete.Action = function()
   {
      this.dialog.FadeOut(objDialog);
      _global.CScaleformComponent_Inventory.CancelQuestAudio();
   };
   Close._visible = false;
   this._parent.Controls._visible = false;
   LoadPortrait(objMission);
   FadeIn(objDialog);
   PlayMissionAudio(objMission);
}
function PlayMissionAudio(objMission)
{
   var objDialog = this._parent.DoublePageDialog;
   objDialog.Portrait._visible = true;
   var numLoop = 0;
   var numLoopsToWaitForPlay = 0;
   if(objMission._bIsReplayingMission)
   {
      numLoopsToWaitForPlay = 21;
   }
   else
   {
      numLoopsToWaitForPlay = 90;
   }
   this.onEnterFrame = function()
   {
      if(numLoop == 20)
      {
         _global.CScaleformComponent_Inventory.PlayAudioFile(objMission._File);
         objDialog.Portrait.Holder.Portrait.Still.gotoAndPlay("StartAnim");
      }
      if(numLoop == numLoopsToWaitForPlay)
      {
         objDialog.Delete._visible = true;
         if(objMission._NodeState == "complete" && !objMission._bIsReplayingMission)
         {
            objDialog.Delete._x = objDialog.Bg._width / 2 - objDialog.Delete._width / 2;
         }
         else
         {
            objDialog.Accept._visible = true;
            if(objMission._bIsReplayingMission)
            {
               objDialog.Accept.ButtonText.Text.htmlText = "#SFUI_Missions_Replay";
            }
            else
            {
               objDialog.Accept.ButtonText.Text.htmlText = "#SFUI_Missions_Play";
            }
            FadeIn(objDialog.Accept);
         }
         FadeIn(objDialog.Delete);
         delete this.onEnterFrame;
      }
      numLoop++;
   };
}
function LoadPortrait(objMission)
{
   var _loc3_ = this._parent.DoublePageDialog.Portrait;
   function onLoadInit(mc)
   {
      trace("content has been loaded into " + mc);
   }
   if(objMission._Character == "" || objMission._Character == undefined || objMission._Character == null)
   {
      _loc3_._visible = false;
   }
   else
   {
      var _loc5_ = new MovieClipLoader();
      _loc5_.addListener(this);
      _loc5_.loadClip("Portraits" + objMission._Character + ".swf",_loc3_.Holder);
   }
   _loc3_.Text._visible = true;
   _loc3_.Text.htmlText = _global.CScaleformComponent_Inventory.GetItemName(m_PlayerXuid,objMission._ItemID);
   _global.AutosizeTextDown(_loc3_.Text,10);
   _loc3_.Text.autoSize = "left";
   _loc3_.TextDialog._visible = true;
   _loc3_.TextDialog.htmlText = _global.GameInterface.Translate("#" + _global.CScaleformComponent_Inventory.GetCampaignNodeSubtitles(objMission._CampaignID,objMission._NodeID));
   _global.AutosizeTextDown(_loc3_.TextDialog,8);
   _loc3_.TextDialog.autoSize = "left";
   this._parent.DoublePageDialog.Accept._y = m_numAcceptButtonDefaultY + _loc3_.TextDialog._height;
   this._parent.DoublePageDialog.Delete._y = m_numAcceptButtonDefaultY + _loc3_.TextDialog._height;
   _loc3_.Text._y = _loc3_.Holder._y - 5 - _loc3_.Text._height;
}
function ComicViewerDialog(objMission)
{
   var _loc2_ = this._parent.DoublePageDialog;
   var _loc3_ = false;
   _loc2_._visible = true;
   _loc2_.Comic._visible = true;
   Close._visible = false;
   this._parent.Controls._visible = false;
   SetUpComicSectionNodes(objMission);
   FadeIn(_loc2_);
}
function SetUpComicSectionNodes(objMission)
{
   var _loc13_ = this._parent.DoublePageDialog.Comic;
   var objParentDialog = this._parent.DoublePageDialog;
   var _loc7_ = [];
   var numTiles = 6;
   var _loc12_ = 0;
   var _loc14_ = _global.CScaleformComponent_Inventory.GetCampaignNodeCount(objMission._CampaignID);
   var _loc4_ = 0;
   while(_loc4_ < _loc14_)
   {
      _loc12_ = _global.CScaleformComponent_Inventory.GetCampaignNodeIDbyIndex(objMission._CampaignID,_loc4_);
      var _loc11_ = _global.CScaleformComponent_Inventory.GetCampaignNodeContentFile(objMission._CampaignID,_loc12_);
      if(_loc11_ != "" && _loc11_ != undefined && _loc11_ != null)
      {
         var _loc8_ = new Object();
         var _loc10_ = _loc11_.split(",");
         var _loc5_ = 0;
         while(_loc5_ < _loc10_.length)
         {
            var _loc6_ = _loc10_[_loc5_].split(":");
            _loc8_[_loc6_[0]] = _loc6_[1];
            _loc5_ = _loc5_ + 1;
         }
         if(_loc8_.type == "comic")
         {
            _loc8_.nodeid = _loc12_;
            _loc7_.push(_loc8_);
         }
      }
      _loc4_ = _loc4_ + 1;
   }
   _loc4_ = 0;
   while(_loc4_ < numTiles)
   {
      var _loc3_ = _loc13_["Tile" + _loc4_];
      if(_loc4_ >= _loc7_.length)
      {
         _loc3_._visible = false;
      }
      else
      {
         _loc3_._visible = true;
         _loc3_.Name.htmlText = "#cp" + objMission._CampaignID + "_comicsection_title_" + _loc4_;
         if(_global.CScaleformComponent_Inventory.GetCampaignNodeState(objMission._CampaignID,_loc7_[_loc4_].nodeid) == "locked")
         {
            _loc3_.setDisabled(true);
            _loc3_._IsDisabled = true;
            _loc3_.Name._alpha = 50;
         }
         else
         {
            _loc3_.setDisabled(false);
            _loc3_._IsDisabled = false;
            _loc3_.Name._alpha = 100;
         }
         _loc3_.Selected._visible = false;
         _loc3_.dialog;
         _loc3_._IsComicNode = true;
         _loc3_._ComicSection = _loc7_[_loc4_].section;
         _loc3_._ComicPages = _loc7_[_loc4_].numpages;
         _loc3_._CampaignID = objMission._CampaignID;
         _loc3_.Action = function()
         {
            ShowComicSection(this,numTiles);
         };
         LoadImage(_loc3_.Image,_loc7_[_loc4_].file,48,48);
         if(_loc7_[_loc4_].nodeid == objMission._NodeID)
         {
            ShowComicSection(_loc3_,numTiles);
         }
      }
      _loc4_ = _loc4_ + 1;
   }
   _loc13_.AdvanceBtn.Action = function()
   {
      ShowNextComicPage(m_ComicSectionTile,++m_numComicPage,numTiles);
   };
   _loc13_.Back.Action = function()
   {
      ShowNextComicPage(m_ComicSectionTile,--m_numComicPage,numTiles);
   };
   _loc13_.Close.dialog;
   _loc13_.Close.Action = function()
   {
      FadeOut(objParentDialog);
      trace("------");
   };
}
function ShowComicSection(ComicSectionTile, numTiles, bIsBack)
{
   m_ComicSectionTile = ComicSectionTile;
   ComicSectionTile._parent.AdvanceBtn.setDisabled(false);
   var _loc1_ = 0;
   while(_loc1_ < numTiles)
   {
      if(ComicSectionTile._ComicSection == _loc1_)
      {
         ComicSectionTile.Selected._visible = true;
         if(bIsBack)
         {
            m_numComicPage = ComicSectionTile._ComicPages - 1;
         }
         else
         {
            m_numComicPage = 0;
         }
         ShowNextComicPage(ComicSectionTile,m_numComicPage,numTiles);
      }
      else
      {
         var _loc3_ = ComicSectionTile._parent["Tile" + _loc1_];
         _loc3_.Selected._visible = false;
      }
      _loc1_ = _loc1_ + 1;
   }
}
function ShowNextComicPage(ComicSectionTile, numComicPage, numTiles)
{
   var _loc7_ = "images/journal/campaign/comic/" + ComicSectionTile._CampaignID + "_" + ComicSectionTile._ComicSection + "_" + numComicPage + ".png";
   var _loc4_ = null;
   var _loc5_ = ComicSectionTile._parent.Hint;
   if(numComicPage < ComicSectionTile._ComicPages)
   {
      if(numComicPage % 2 == 0)
      {
         _loc4_ = ComicSectionTile._parent.ComicImage0;
         LoadImage(_loc4_,_loc7_,640,480);
         _loc4_.swapDepths(ComicSectionTile._parent.ComicImage1.getNextHighestDepth());
      }
      else
      {
         _loc4_ = ComicSectionTile._parent.ComicImage1;
         _loc4_._visible = true;
         LoadImage(_loc4_,_loc7_,640,480);
         _loc4_.swapDepths(ComicSectionTile._parent.ComicImage0.getNextHighestDepth());
      }
      if(numComicPage != 0)
      {
         new Lib.Tween(_loc4_,"_alpha",mx.transitions.easing.Strong.easeOut,0,100,0.5,true);
      }
      if(numComicPage > 0)
      {
         _loc5_.Hint._visible = false;
         ComicSectionTile._parent.Back.setDisabled(false);
         ComicSectionTile._parent.Back._visible = true;
      }
      else if(numComicPage == 0)
      {
         _loc5_.Hint.htmlText = "<i>" + _global.GameInterface.Translate("#CSGO_Journal_Comic_Instructions") + "</i>";
         _loc5_.Hint._visible = true;
         _loc5_.swapDepths(_root.getNextHighestDepth());
         ComicSectionTile._parent.ComicImage1._visible = false;
         if(ComicSectionTile._ComicSection == 0)
         {
            ComicSectionTile._parent.Back.setDisabled(true);
            ComicSectionTile._parent.Back._visible = false;
         }
      }
      else if(numComicPage < 0)
      {
         _loc4_ = ComicSectionTile._parent["Tile" + (Number(ComicSectionTile._ComicSection) - 1)];
         ShowComicSection(_loc4_,numTiles,true);
      }
   }
   else
   {
      _loc4_ = ComicSectionTile._parent["Tile" + (Number(ComicSectionTile._ComicSection) + 1)];
      if(_loc4_._visible)
      {
         if(_loc4_._IsDisabled == true)
         {
            _loc5_.Hint.htmlText = "<i>" + _global.GameInterface.Translate("#CSGO_Journal_Comic_TBC") + "</i>";
            _loc5_.Hint._visible = true;
            _loc5_.swapDepths(_root.getNextHighestDepth());
            ComicSectionTile._parent.AdvanceBtn.setDisabled(true);
         }
         else
         {
            ShowComicSection(_loc4_,numTiles);
         }
         return undefined;
      }
      _loc5_.Hint._visible = false;
      ComicSectionTile._parent.AdvanceBtn.setDisabled(true);
   }
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
function RequestMissionTimeoutDialog(objMission)
{
   var numCount = 0;
   var objDialog = this._parent.DoublePageDialog;
   var _loc4_ = _global.CScaleformComponent_Inventory.GetItemName(_global.CScaleformComponent_MyPersona.GetXuid(),objMission._ItemID);
   var _loc3_ = _global.GameInterface.Translate("#CSGO_Journal_Get_Mission");
   _loc3_ = _global.ConstructString(_loc3_,_loc4_);
   objDialog.Loading.Spinner._visible = true;
   objDialog.Loading.Text.htmlText = _loc3_;
   objDialog.Accept.dialog = this;
   objDialog.Accept.ButtonText.Text.htmlText = "#SFUI_PlayerDetails_Ok";
   objDialog.Accept.Action = function()
   {
      this.dialog.FadeOut(objDialog);
   };
   objDialog.Accept._x = objDialog.Bg._width / 2 - objDialog.Accept._width / 2;
   objDialog._alpha = 0;
   objDialog.onEnterFrame = function()
   {
      if(objDialog._alpha < 100)
      {
         objDialog._alpha = objDialog._alpha + 10;
      }
      numCount++;
      if(numCount == 15)
      {
         RequestMission(objMission._CampaignID,objMission._NodeID);
      }
      if(numCount == 60 || numCount == 90 || numCount == 120 || numCount == 158)
      {
         if(_global.CScaleformComponent_Inventory.DoesUserOwnQuest(objMission._CampaignID,objMission._NodeID))
         {
            PlayMissionFromJournal();
            delete objDialog.onEnterFrame;
         }
      }
      if(numCount == 160)
      {
         objDialog.Loading.Text.htmlText = "#CSGO_Journal_Get_Mission_Failed";
         objDialog.Loading.Warning._visible = true;
         objDialog.Loading.Spinner._visible = false;
         objDialog.Accept._visible = true;
         delete objDialog.onEnterFrame;
      }
   };
}
function DeleteMission(objMission, bHasActiveMission)
{
   var _loc3_ = "";
   var _loc5_ = _global.CScaleformComponent_Inventory.GetItemName(_global.CScaleformComponent_MyPersona.GetXuid(),objMission._ItemID);
   var _loc6_ = _global.CScaleformComponent_Inventory.GetItemName(m_PlayerXuid,SetActiveQuestID());
   var _loc4_ = _global.CScaleformComponent_Inventory.GetQuestGameMode(m_PlayerXuid,objMission._ItemID);
   _loc3_ = _global.GameInterface.Translate("#CSGO_Journal_Mission_Abandon_Warning");
   _loc3_ = _global.ConstructString(_loc3_,_loc5_,_loc6_);
   if(IsClientInLobby())
   {
      if(IsClientHost())
      {
         if(_loc4_ != "competitive" && _loc4_ != "cooperative" && _loc4_ != "coopmission")
         {
            _loc3_ = _global.GameInterface.Translate("#CSGO_Journal_Mission_Leave_Lobby_Warning");
         }
         else
         {
            ShowDoublePageDialog("RequestMissionTimeout",objMission);
            return undefined;
         }
      }
      else if(objMission._NodeID != _global.CScaleformComponent_PartyList.GetPartySessionSetting("game/questid"))
      {
         _loc3_ = _global.GameInterface.Translate("#CSGO_Journal_Mission_Leave_Lobby_Warning");
      }
      else if(objMission._NodeState == "accessible" && bHasActiveMission && ActiveIsCoop())
      {
         ShowDoublePageDialog("RequestMissionTimeout",objMission);
         return undefined;
      }
   }
   var objDialog = this._parent.DoublePageDialog;
   FadeIn(objDialog);
   objDialog.Loading.Warning._visible = true;
   objDialog.Loading.Text.htmlText = _loc3_;
   objDialog.Accept._visible = true;
   objDialog.Accept.dialog = this;
   objDialog.Accept.ButtonText.Text.htmlText = "#CSGO_Journal_Mission_Start_Mission";
   objDialog.Accept.Action = function()
   {
      this.dialog.ShowDoublePageDialog("RequestMissionTimeout",objMission);
   };
   objDialog.Delete._visible = true;
   objDialog.Delete.dialog = this;
   objDialog.Delete.ButtonText.Text.htmlText = "#SFUI_Crafting_Cancel";
   objDialog.Delete.Action = function()
   {
      this.dialog.FadeOut(objDialog);
   };
}
function LeaderboardDialog(objMission)
{
   var objDialog = this._parent.DoublePageDialog;
   objDialog._visible = true;
   objDialog.Leaderboard._visible = true;
   Close._visible = false;
   this._parent.Controls._visible = false;
   FadeIn(objDialog);
   objDialog.Leaderboard.SetUpMissionLeaderboard(objMission);
   objDialog.Leaderboard.Close.dialog;
   objDialog.Leaderboard.Close.Action = function()
   {
      FadeOut(objDialog);
   };
}
function RequestMission(CampaignID, NodeID)
{
   _global.CScaleformComponent_Inventory.RequestNewMission(CampaignID,NodeID);
}
function FadeIn(objDialog)
{
   objDialog._alpha = 0;
   objDialog.onEnterFrame = function()
   {
      if(objDialog._alpha < 100)
      {
         objDialog._alpha = objDialog._alpha + 10;
      }
      else
      {
         delete objDialog.onEnterFrame;
      }
   };
}
function FadeOut(objToFade)
{
   delete objToFade.onEnterFrame;
   objToFade.onEnterFrame = function()
   {
      if(objToFade._alpha > 0)
      {
         objToFade._alpha = objToFade._alpha - 10;
      }
      else
      {
         DoublePageDialogHide();
         delete objToFade.onEnterFrame;
      }
   };
}
function PlayMissionFromJournal(ReplayQuestId, bIsReplayingMission)
{
   _global.CScaledormComponent_Inventory.HACKCompleteCurrentQuestOnClient();
   var _loc3_ = "";
   var _loc5_ = 0;
   trace("------------------------------------ReplayQuestId-----------------------" + ReplayQuestId);
   trace("------------------------------------bIsReplayingMission-----------------------" + bIsReplayingMission);
   if(bIsReplayingMission)
   {
      _loc3_ = GetFakeQuestID(ReplayQuestId);
      _loc5_ = ReplayQuestId;
   }
   else
   {
      _loc3_ = SetActiveQuestID();
      _loc5_ = GetActiveMission();
   }
   var _loc2_ = _global.CScaleformComponent_Inventory.GetQuestGameMode(m_PlayerXuid,_loc3_);
   var _loc6_ = _global.CScaleformComponent_Inventory.GetQuestMapGroup(m_PlayerXuid,_loc3_);
   var _loc4_ = _global.CScaleformComponent_Inventory.GetQuestMap(m_PlayerXuid,_loc3_);
   if(_loc2_ == "competitive" || _loc2_ == "cooperative" || _loc2_ == "coopmission")
   {
      var _loc8_ = "lobby";
   }
   else
   {
      _loc8_ = "search";
   }
   if(_loc4_ != "" && _loc4_ != undefined && _loc4_ != null && _loc4_ != " ")
   {
      _loc6_ = "mg_" + _loc4_;
   }
   DoublePageDialogHide();
   delete objDialog.onEnterFrame;
   HidePanel();
   if(!IsClientHost() && _loc2_ != "coopmission" && _loc2_ != "cooperative" && _loc2_ != "competitive")
   {
      _global.MainMenuMovie.Panel.SelectPanel.CloseAnyOpenMenus();
      _global.MainMenuMovie.Panel.SelectPanel.MainMenuTopBar.QuitButton.setDisabled(true);
   }
   _global.CScaleformComponent_CompetitiveMatch.ActionMatchmaking(_loc2_,_loc6_,_loc8_,"Game { questid " + _loc5_ + " }");
}
function SetActiveQuestID()
{
   var _loc2_ = GetActiveMission();
   var _loc3_ = _global.CScaleformComponent_Inventory.GetCampaignFromQuestID(_loc2_);
   var _loc4_ = _global.CScaleformComponent_Inventory.GetCampaignNodeFromQuestID(_loc2_);
   var _loc5_ = _global.CScaleformComponent_Inventory.GetAQuestItemIDGivenCampaignNodeID(_loc4_,_loc3_);
   return _loc5_;
}
function GetFakeQuestID(numQuestID)
{
   var _loc2_ = _global.CScaleformComponent_Inventory.GetCampaignFromQuestID(numQuestID);
   var _loc3_ = _global.CScaleformComponent_Inventory.GetCampaignNodeFromQuestID(numQuestID);
   var _loc4_ = _global.CScaleformComponent_Inventory.GetAQuestItemIDGivenCampaignNodeID(_loc3_,_loc2_);
   return _loc4_;
}
function GetActiveMission()
{
   var _loc3_ = _global.CScaleformComponent_Inventory.GetActiveSeasonCoinItemId(m_PlayerXuid);
   var _loc2_ = _global.CScaleformComponent_Inventory.GetItemAttributeValue(m_PlayerXuid,_loc3_,"quest id");
   if(_loc2_ != 0 && _loc2_ != undefined && _loc2_ != null)
   {
      return _loc2_;
   }
   return 0;
}
function ActiveIsCoop()
{
   var _loc2_ = _global.CScaleformComponent_Inventory.GetQuestGameMode(m_PlayerXuid,SetActiveQuestID());
   if(_loc2_ == "coopmission" || _loc2_ == "cooperative")
   {
      return true;
   }
   return false;
}
function IsClientInLobby()
{
   return _global.CScaleformComponent_PartyList.IsPartySessionActive();
}
function IsClientHost()
{
   if(m_PlayerXuid == _global.CScaleformComponent_PartyList.GetPartySystemSetting("xuidHost"))
   {
      return true;
   }
   return false;
}
stop();
var CLOSED_JOURNAL_XPOS = -200;
var OPEN_JOURNAL_XPOS = 0;
var JOURNAL_SPINE = PageBounds._x;
var JOURNAL_RIGHT_EDGE = PageBounds._x + PageBounds._width;
var TurnAngle = 45;
var PagePos = {_x:PageBounds._x,_y:PageBounds._y};
var LeftPagePos = {_x:PageBounds._x - PageBounds._width,_y:PageBounds._y};
var BackPagePos = {_x:JOURNAL_RIGHT_EDGE,_y:PageBounds._y + PageBounds._height,_rotation:90};
var LinePos = {_x:JOURNAL_RIGHT_EDGE,_y:PageBounds._y + PageBounds._height,_rotation:TurnAngle};
var HideSpineShadowPos = {_x:JOURNAL_RIGHT_EDGE,_y:PageBounds._y};
var TOP_PAGE_DEPTH = this.getNextHighestDepth();
var BOTTOM_PAGE_DEPTH = TOP_PAGE_DEPTH + 1;
var BACK_PAGE_DEPTH = TOP_PAGE_DEPTH + 2;
var LEFT_PAGE_DEPTH = TOP_PAGE_DEPTH - 2;
var LEFT_SHADOW_DEPTH = TOP_PAGE_DEPTH - 1;
var m_NumPage = 0;
var m_BookIsClosed = true;
var m_OpenToPageAnim = false;
var InitialCoverLoadIntervalId;
var m_numAcceptButtonDefaultX = 287.65;
var m_numAcceptButtonDefaultY = 323.45;
var NUM_OP_BREAKOUT_ID = 3;
var NUM_OP_VANGAURD_ID = 4;
var NUM_OP_BLOODHOUND_ID = 5;
var NUM_OP_SEVENJAN_ID = 6;
var m_numComicPage = 0;
var m_ComicSectionTile = null;
var m_numSeason = 0;
var m_aPages = [];
var m_aloadedPageTypes = [];
var m_ItemID;
var TopPage;
var BottomPage;
var LeftPage;
var LeftPageShadow;
var BackPage = this.attachMovie("journal-back-page","BackPage",BACK_PAGE_DEPTH,BackPagePos);
var BackPageShadowLower = this.attachMovie("journal-backpage-shadow","BackPageShadowLower",BACK_PAGE_DEPTH + 10,BackPagePos);
var AnimLine = this.attachMovie("journal-anim-line","AnimLine",this.getNextHighestDepth(),LinePos);
var Cover = this.attachMovie("journal-cover","Cover",1000,PagePos);
Cover.Sheen._visible = false;
Cover.BackOfCover._visible = false;
Cover.BackOfCover.Backpage.PageNumberRight._visible = false;
Cover.BackOfCover.Backpage.PageNumberLeft._visible = false;
Cover._Type = "journal-cover";
BackPageShadowLower._xscale = 0;
BackPage.setMask(AnimLine.LeftMask);
AnimLine.Shadow.setMask(BackPage.Page.ShadowMask);
this._parent.Controls.btnNextPage.dialog = this;
this._parent.Controls.btnNextPage.actionSound = "PageForward";
this._parent.Controls.btnNextPage.Action = function()
{
   this.dialog.PageAnim(true);
};
this._parent.Controls.btnPrevPage.dialog = this;
this._parent.Controls.btnPrevPage.actionSound = "PageBack";
this._parent.Controls.btnPrevPage.Action = function()
{
   this.dialog.PageAnim(false);
};
this._parent.Controls.btnToc.dialog = this;
this._parent.Controls.btnToc.actionSound = "PageScroll";
this._parent.Controls.btnToc.Action = function()
{
   this.dialog.GoToToc();
};
Close.btnClose.dialog = this;
Close.btnClose.Action = function()
{
   this.dialog.HidePanel();
};
this._parent.ClickBlocker.onRollOver = function()
{
};
this._parent.ClickBlocker._visible = false;
this._parent.DoublePageDialog.Bg.onRollOver = function()
{
};
var m_PlayerXuid = _global.CScaleformComponent_MyPersona.GetXuid();
