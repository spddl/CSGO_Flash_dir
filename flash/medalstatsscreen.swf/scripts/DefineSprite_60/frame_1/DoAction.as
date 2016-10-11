function onShow()
{
   _visible = true;
   gotoAndStop("StartShow");
   play();
   _global.navManager.PushLayout(MedalsNav,"MedalsNav");
   CurrentCategoryIndex = Math.floor(_global.GameInterface.GetConvarNumber("player_last_medalstats_category"));
   if(CurrentCategoryIndex < 0)
   {
      CurrentCategoryIndex = 0;
   }
   if(CurrentCategoryIndex > MedalsData.medalCategories.length)
   {
      CurrentCategoryIndex = MedalsData.medalCategories.length - 1;
   }
   PopulateMedalCategory();
}
function onHide()
{
   if(_visible)
   {
      this.gotoAndPlay("StartHide");
      _global.navManager.RemoveLayout(MedalsNav);
   }
}
function cleanup()
{
   _global.navManager.RemoveLayout(MedalsNav);
}
function prevMedalCategory()
{
   CurrentCategoryIndex = DecFromOrder(CurrentCategoryIndex,MedalsData.medalCategories.order);
   PopulateMedalCategory();
   _global.navManager.ResetAllDownKeys();
   _global.GameInterface.SetConvar("player_last_medalstats_category",CurrentCategoryIndex);
}
function nextMedalCategory()
{
   CurrentCategoryIndex = IncFromOrder(CurrentCategoryIndex,MedalsData.medalCategories.order);
   PopulateMedalCategory();
   _global.navManager.ResetAllDownKeys();
   _global.GameInterface.SetConvar("player_last_medalstats_category",CurrentCategoryIndex);
}
function medalsUp()
{
   CurrentMedalRow--;
   if(CurrentMedalRow < 0)
   {
      CurrentMedalRow = Math.min(NumRows - 1,MaxRow);
   }
   if(CurrentMedalRow == MaxRow && CurrentMedalCol > MaxCol)
   {
      CurrentMedalCol = MaxCol;
   }
   PopulateMedalData();
}
function medalsDown()
{
   CurrentMedalRow++;
   if(CurrentMedalRow > Math.min(NumRows - 1,MaxRow))
   {
      CurrentMedalRow = 0;
   }
   if(CurrentMedalRow == MaxRow && CurrentMedalCol > MaxCol)
   {
      CurrentMedalCol = MaxCol;
   }
   PopulateMedalData();
}
function medalsLeft()
{
   CurrentMedalCol--;
   if(CurrentMedalCol < 0)
   {
      if(CurrentMedalRow == MaxRow)
      {
         CurrentMedalCol = MaxCol;
      }
      else
      {
         CurrentMedalCol = NumCols - 1;
      }
   }
   PopulateMedalData();
}
function medalsRight()
{
   CurrentMedalCol++;
   if(CurrentMedalRow == MaxRow)
   {
      if(CurrentMedalCol > MaxCol)
      {
         CurrentMedalCol = 0;
      }
   }
   else if(CurrentMedalCol > NumCols - 1)
   {
      CurrentMedalCol = 0;
   }
   PopulateMedalData();
}
function updateNavButtons()
{
   Medals.LBButton._visible = false;
   Medals.RBButton._visible = false;
   Medals.L1Button._visible = false;
   Medals.R1Button._visible = false;
   Medals.LeftButton._visible = false;
   Medals.RightButton._visible = false;
   if(_global.IsPS3())
   {
      PrevMedalsCatButton = Medals.L1Button;
      NextMedalsCatButton = Medals.R1Button;
   }
   else if(_global.IsXbox() || _global.IsPC() && _global.wantControllerShown)
   {
      PrevMedalsCatButton = Medals.LBButton;
      NextMedalsCatButton = Medals.RBButton;
   }
   else
   {
      PrevMedalsCatButton = Medals.LeftButton;
      NextMedalsCatButton = Medals.RightButton;
   }
   PrevMedalsCatButton._visible = true;
   NextMedalsCatButton._visible = true;
   PrevMedalsCatButton.Action = function()
   {
      _global.MedalStatsScreenMovie.prevMedalCategory();
   };
   NextMedalsCatButton.Action = function()
   {
      _global.MedalStatsScreenMovie.nextMedalCategory();
   };
}
function medalEnterHighlight()
{
   if(this.buttonState != Lib.Controls.SFButton.BUTTON_STATE_DISABLED && !this.isModalLockedOut())
   {
      if(this.buttonState != Lib.Controls.SFButton.BUTTON_STATE_DOWN)
      {
         this.setState(Lib.Controls.SFButton.BUTTON_STATE_OVER);
         this.PlayHighlightSound();
      }
      this.Focus(true);
   }
}
function medalExitHighlight(forceExit)
{
   var _loc2_ = "MedalIcon" + CurrentMedalRow + "" + CurrentMedalCol;
   var _loc3_ = Medals[_loc2_];
   if(CurrentMedalIcon != this || forceExit == true)
   {
      if(this.buttonState != Lib.Controls.SFButton.BUTTON_STATE_DISABLED && !this.isModalLockedOut())
      {
         this.setState(Lib.Controls.SFButton.BUTTON_STATE_UP);
         this.Focus(false);
      }
   }
}
function medalOnRollOver()
{
   if(this != CurrentMedalIcon)
   {
      if(this.buttonState != Lib.Controls.SFButton.BUTTON_STATE_DISABLED && !this.isModalLockedOut())
      {
         _global.navManager.addMouseOverControl(this);
         _global.navManager.SetHighlightedObject(null);
         this.setState(Lib.Controls.SFButton.BUTTON_STATE_OVER);
         this.PlayHighlightSound();
         this.RolledOver();
      }
   }
}
function medalOnRollOut()
{
   if(this != CurrentMedalIcon)
   {
      if(this.buttonState != Lib.Controls.SFButton.BUTTON_STATE_DISABLED && !this.isModalLockedOut())
      {
         _global.navManager.removeMouseOverControl(this);
         this.setState(Lib.Controls.SFButton.BUTTON_STATE_UP);
         this.RolledOut();
      }
   }
}
function InitPanel()
{
   _visible = false;
   var _loc5_ = 0;
   while(_loc5_ < NumRows)
   {
      var _loc4_ = 0;
      while(_loc4_ < NumCols)
      {
         var _loc6_ = "MedalIcon" + _loc5_ + "" + _loc4_;
         var _loc3_ = Medals[_loc6_];
         _loc3_.Action = function()
         {
            MedalSelectAction(this);
         };
         _loc3_.enterHighlight = medalEnterHighlight;
         _loc3_.exitHighlight = medalExitHighlight;
         _loc3_.onRollOver = medalOnRollOver;
         _loc3_.onRollOut = medalOnRollOut;
         _loc4_ = _loc4_ + 1;
      }
      _loc5_ = _loc5_ + 1;
   }
   MedalsData = _global.GameInterface.LoadKVFile("MedalsConfig.txt");
   CreateOrder(MedalsData.medalCategories);
}
function MedalSelectAction(SelectedButton)
{
   var _loc1_ = SelectedButton + "";
   var _loc2_ = parseInt(_loc1_.substr(_loc1_.length - 2,1));
   var _loc3_ = parseInt(_loc1_.substr(_loc1_.length - 1,1));
   CurrentMedalRow = _loc2_;
   CurrentMedalCol = _loc3_;
   PopulateMedalData();
}
function PopulateMedalCategory()
{
   var _loc18_ = Medals.Text;
   var _loc16_ = MedalsData.medalCategories.order[CurrentCategoryIndex];
   _loc18_.CategoryName.SetText(_loc16_.nameID);
   if(_loc16_.showRecentMedals != undefined)
   {
      var _loc17_ = _global.MedalStatsScreenAPI.GetRecentAchievementCount();
      if(_loc17_ > 0)
      {
         _loc16_.medals = new Array();
         var _loc9_ = 0;
         while(_loc9_ < _loc17_)
         {
            _loc16_.medals[_loc9_] = _global.MedalStatsScreenAPI.GetRecentAchievementName(_loc9_);
            _loc9_ = _loc9_ + 1;
         }
      }
   }
   var _loc14_ = _loc16_.medals;
   var _loc7_ = 0;
   var _loc13_ = _loc14_.length;
   var _loc15_ = 0;
   MaxRow = Math.floor(_loc13_ / NumCols);
   MaxCol = Math.max(0,_loc13_ % NumCols - 1);
   var _loc8_ = 0;
   while(_loc8_ < NumRows)
   {
      var _loc5_ = 0;
      while(_loc5_ < NumCols)
      {
         var _loc10_ = "MedalIcon" + _loc8_ + "" + _loc5_;
         var _loc3_ = Medals[_loc10_];
         var _loc2_ = _loc3_.Icon.MedalPicture;
         _loc3_._visible = false;
         _loc3_.NewUnlock._visible = false;
         _loc2_.DefaultImage._visible = false;
         if(_loc2_.Image != undefined)
         {
            _loc2_.Image.removeMovieClip();
            delete register2.Image;
         }
         if(_loc7_ < _loc13_)
         {
            _loc3_._visible = true;
            var _loc6_ = _loc14_[_loc7_].toLowerCase();
            var _loc4_ = _global.MedalStatsScreenAPI.GetAchievementStatus(_loc6_);
            if(_loc4_ == eAchievement_RecentUnlock)
            {
               _loc3_.NewUnlock._visible = true;
               _loc3_.NewUnlock.gotoAndPlay(0);
            }
            if(_loc4_ == eAchievement_Secret)
            {
               _loc2_.attachMovie("locked","Image",50);
            }
            else
            {
               var _loc11_ = _loc2_.attachMovie(_loc6_,"Image",50);
               if(_loc11_ == null)
               {
                  _loc2_.attachMovie("locked","Image",50);
               }
            }
            if(_loc4_ == eAchievement_Locked)
            {
               if(_loc2_.Image.transformData == undefined)
               {
                  var _loc12_ = new Color(_loc2_.Image);
                  _loc2_.Image.transformData = _loc12_;
               }
               _loc2_.Image.transformData.setTransform(lockedTransform);
            }
            else if(_loc2_.Image.transformData != undefined)
            {
               _loc2_.Image.transformData.setTransform(defaultTransform);
            }
            if(_loc4_ == eAchievement_Unlocked || _loc4_ == eAchievement_RecentUnlock)
            {
               _loc15_ = _loc15_ + 1;
            }
            _loc7_ = _loc7_ + 1;
         }
         _loc5_ = _loc5_ + 1;
      }
      _loc8_ = _loc8_ + 1;
   }
   CurrentMedalRow = 0;
   CurrentMedalCol = 0;
   PopulateMedalData();
   updateRankProgressBars();
}
function PopulateMedalData()
{
   var _loc4_ = CurrentMedalRow * NumCols + CurrentMedalCol;
   var _loc3_ = MedalsData.medalCategories.order[CurrentCategoryIndex];
   var _loc5_ = "MedalIcon" + CurrentMedalRow + "" + CurrentMedalCol;
   var _loc2_ = Medals[_loc5_];
   if(_loc2_ != CurrentMedalIcon && CurrentMedalIcon != undefined)
   {
      CurrentMedalIcon.exitHighlight(true);
   }
   CurrentMedalIcon = _loc2_;
   Medals.Notice._visible = _loc3_.medals.length <= 0;
   if(_loc4_ < _loc3_.medals.length)
   {
      _global.MedalStatsScreenAPI.UpdateCurrentAchievement(_loc3_.medals[_loc4_]);
      _global.navManager.SetHighlightedObject(_loc2_);
      Medals.Notice._visible = false;
   }
   else
   {
      _global.MedalStatsScreenAPI.UpdateCurrentAchievement("");
   }
}
function updateRankProgressBars()
{
   var _loc7_ = CurrentCategoryIndex - 1;
   if(_loc7_ < 0 || _loc7_ > 4)
   {
      Medals.Text.MedalTotalCount.MedalTotalCount.htmlText = "";
      Medals.Text.MedalTotalTitle.htmlText = "";
      Medals.MedalsProgressBar._visible = false;
      var _loc3_ = 0;
      while(_loc3_ < 3)
      {
         var _loc15_ = "MedalBarIcon_0" + _loc3_;
         var _loc2_ = Medals[_loc15_];
         _loc2_._visible = false;
         _loc3_ = _loc3_ + 1;
      }
      return undefined;
   }
   Medals.MedalsProgressBar._visible = true;
   var _loc6_ = _global.MedalStatsScreenAPI.GetRankForCurrentCatagory(_loc7_);
   var _loc19_ = _global.MedalStatsScreenAPI.GetMaxAwardsForCatagory(_loc7_);
   var _loc10_ = _global.MedalStatsScreenAPI.GetAchievedInCategory(_loc7_);
   Medals.Text.MedalTotalCount.MedalTotalCount.htmlText = _loc10_ + "/" + _loc19_;
   var _loc17_ = MedalsData.medalCategories.order[CurrentCategoryIndex];
   var _loc18_ = Medals.Text;
   _loc18_.CategoryName.SetText(_loc17_.nameID);
   Medals.Text.MedalTotalTitle.htmlText = _global.GameInterface.Translate(_loc17_.nameID) + "<font color=\'#cccccc\'> - " + _global.GameInterface.Translate("#SFUI_MedalCategory_StatusBar") + "</font>";
   _loc3_ = 0;
   while(_loc3_ < 3)
   {
      _loc15_ = "MedalBarIcon_0" + _loc3_;
      _loc2_ = Medals[_loc15_];
      _loc2_._visible = true;
      var _loc13_ = "bar0" + _loc3_;
      var _loc9_ = Medals.MedalsProgressBar[_loc13_];
      if(_loc2_.Image != undefined)
      {
         _loc2_.Image.removeMovieClip();
         delete register2.Image;
      }
      var _loc14_ = "rank_" + _loc7_ + "_0" + (_loc3_ + 1);
      _loc2_.attachMovie(_loc14_,"Image",50);
      if(_loc6_ < _loc3_ || _loc6_ == _loc3_)
      {
         if(_loc2_.Image.transformData == undefined)
         {
            var _loc16_ = new Color(_loc2_.Image);
            _loc2_.Image.transformData = _loc16_;
         }
         _loc2_.Image.transformData.setTransform(lockedTransform);
         if(_loc6_ < _loc3_)
         {
            _loc9_.gotoAndStop(0);
         }
         else
         {
            var _loc4_ = _global.MedalStatsScreenAPI.GetMinAwardNeededForRank(_loc7_,1);
            var _loc8_ = _global.MedalStatsScreenAPI.GetMinAwardNeededForRank(_loc7_,2) - _loc4_;
            var _loc12_ = _global.MedalStatsScreenAPI.GetMinAwardNeededForRank(_loc7_,3) - _loc4_ - _loc8_;
            var _loc5_ = 0;
            if(_loc6_ == 0)
            {
               _loc5_ = _loc10_ / _loc4_ * 1;
            }
            else if(_loc6_ == 1)
            {
               _loc5_ = (_loc10_ - _loc4_) / _loc8_ * 1;
            }
            else if(_loc6_ == 2)
            {
               _loc5_ = (_loc10_ - _loc4_ - _loc8_) / _loc12_ * 1;
            }
            else
            {
               _loc5_ = 100;
            }
            var _loc11_ = _loc5_ * 30;
            _loc9_.gotoAndStop(_loc11_);
         }
      }
      else
      {
         if(_loc2_.Image.transformData != undefined)
         {
            _loc2_.Image.transformData.setTransform(defaultTransform);
         }
         _loc9_.gotoAndStop(30);
      }
      _loc3_ = _loc3_ + 1;
   }
}
function CreateOrder(o)
{
   if(typeof o == "object")
   {
      o.order = new Array();
      o.ordername = new Array();
      for(var _loc3_ in o)
      {
         var _loc2_ = o[_loc3_];
         if(_loc2_ && typeof _loc2_ == "object")
         {
            o.order[o[_loc3_].value] = _loc2_;
            o.ordername[o[_loc3_].value] = _loc3_;
         }
      }
   }
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
var MedalsNav = new Lib.NavLayout();
MedalsNav.AddTabOrder([]);
MedalsNav.ShowCursor(true);
var MedalsData;
var CurrentCategoryIndex = 0;
var CurrentMedalRow = 0;
var CurrentMedalCol = 0;
var CurrentMedalIcon = undefined;
var eAchievement_Locked = 0;
var eAchievement_Unlocked = 1;
var eAchievement_Secret = 2;
var eAchievement_RecentUnlock = 3;
var PrevMedalsCatButton = undefined;
var NextMedalsCatButton = undefined;
var NumRows = 4;
var NumCols = 10;
var MaxRow = -1;
var MaxCol = -1;
var lockedTransform = new Object();
lockedTransform = {ra:"20",rb:"0",ga:"20",gb:"0",ba:"20",bb:"0",aa:"100",ab:"0"};
var defaultTransform = new Object();
defaultTransform = {ra:"100",rb:"0",ga:"100",gb:"0",ba:"100",bb:"0",aa:"100",ab:"0"};
MedalsNav.AddRepeatKeys("DOWN","UP","LEFT","RIGHT");
MedalsNav.AddKeyHandlerTable({CANCEL:{onDown:function(button, control, keycode)
{
   _global.MedalStatsScreenMovie.dismissPanel();
}},UP:{onDown:function(button, control, keycode)
{
   _global.MedalStatsScreenMovie.medalsUp();
}},DOWN:{onDown:function(button, control, keycode)
{
   _global.MedalStatsScreenMovie.medalsDown();
}},LEFT:{onDown:function(button, control, keycode)
{
   _global.MedalStatsScreenMovie.medalsLeft();
}},RIGHT:{onDown:function(button, control, keycode)
{
   _global.MedalStatsScreenMovie.medalsRight();
}}});
MedalsNav.AddKeyHandlers({onDown:function(button, control, keycode)
{
   if(PrevMedalsCatButton != undefined)
   {
      PrevMedalsCatButton.gotoAndPlay("StartOver");
   }
   _global.MedalStatsScreenMovie.prevMedalCategory();
   return true;
},onUp:function(button, control, keycode)
{
   if(PrevMedalsCatButton != undefined)
   {
      PrevMedalsCatButton.gotoAndPlay("StartUp");
   }
   return true;
}},"KEY_XBUTTON_LEFT_SHOULDER","KEY_PAGEUP");
MedalsNav.AddKeyHandlers({onDown:function(button, control, keycode)
{
   if(NextMedalsCatButton != undefined)
   {
      NextMedalsCatButton.gotoAndPlay("StartOver");
   }
   _global.MedalStatsScreenMovie.nextMedalCategory();
   return true;
},onUp:function(button, control, keycode)
{
   if(NextMedalsCatButton != undefined)
   {
      NextMedalsCatButton.gotoAndPlay("StartUp");
   }
   return true;
}},"KEY_XBUTTON_RIGHT_SHOULDER","KEY_PAGEDOWN");
this.stop();
