function InitBlog()
{
   FillOutBlog();
   SetupScrollButtons();
}
function FillOutBlog()
{
   var _loc3_ = _global.CScaleformComponent_News.GetBlogTitle();
   var _loc2_ = _global.CScaleformComponent_News.GetBlogText();
   if(!_loc3_ || _loc3_ == "" || _loc3_ == undefined)
   {
      _loc3_ = "#SFUI_Blog_Title";
   }
   SetNewsTitle(_loc3_);
   if(!_loc2_ || _loc2_ == "" || _loc2_ == undefined)
   {
      _loc2_ = "#SFUI_Blog_Body";
   }
   SetNewsBody(_loc2_);
}
function SetNewsTitle(strNewsTitle)
{
   NewsScroll.HeaderText.htmlText = strNewsTitle;
}
function SetNewsBody(strNewsBody)
{
   NewsScroll.BodyText.htmlText = strNewsBody;
   NewsScroll.BodyText.autoSize = "left";
   EnableScrollButtons();
}
function SetupScrollButtons()
{
   ButtonPrev.dialog = this;
   ButtonPrev.Action = function()
   {
      this.dialog.onScrollPrev(this);
   };
   ButtonDown.setDisabled(true);
   ButtonNext.dialog = this;
   ButtonNext.Action = function()
   {
      this.dialog.onScrollNext(this);
   };
   ButtonUp.setDisabled(true);
}
function EnableScrollButtons()
{
   var _loc2_ = NUM_START_POS - NewsScroll._y;
   var _loc1_ = NewsScroll._height - _loc2_;
   if(NUM_VISIBLE_HEIGHT > _loc1_)
   {
      ButtonNext.setDisabled(true);
   }
   else
   {
      ButtonNext.setDisabled(false);
   }
   if(NewsScroll._y <= NUM_START_POS && NewsScroll._y > NUM_START_POS - 5)
   {
      ButtonPrev.setDisabled(true);
   }
   else
   {
      ButtonPrev.setDisabled(false);
   }
}
function onScrollPrev()
{
   ScrollPrev();
   ButtonPrev.setDisabled(true);
}
function onScrollNext()
{
   ScrollNext();
   ButtonNext.setDisabled(true);
}
function ScrollNext()
{
   var LoopCount = 0;
   var mcMovie = NewsScroll;
   var SpeedOut = 0.4;
   var numEndPos = mcMovie._y - NUM_UNITS_TO_MOVE;
   mcMovie.onEnterFrame = function()
   {
      if(LoopCount < 1)
      {
         mcMovie._y = mcMovie._y + (numEndPos - 1 - mcMovie._y) * SpeedOut;
      }
      if(mcMovie._y < numEndPos)
      {
         LoopCount++;
         mcMovie._y = numEndPos;
         EnableScrollButtons();
         delete mcMovie.onEnterFrame;
      }
   };
}
function ScrollPrev()
{
   var LoopCount = 0;
   var mcMovie = NewsScroll;
   var SpeedOut = 0.4;
   var numEndPos = mcMovie._y + NUM_UNITS_TO_MOVE;
   mcMovie.onEnterFrame = function()
   {
      if(LoopCount < 1)
      {
         mcMovie._y = mcMovie._y + (numEndPos + 1 - mcMovie._y) * SpeedOut;
      }
      if(mcMovie._y > numEndPos)
      {
         LoopCount++;
         mcMovie._y = numEndPos;
         EnableScrollButtons();
         delete mcMovie.onEnterFrame;
      }
   };
}
var NUM_VISIBLE_HEIGHT = 310;
var NUM_UNITS_TO_MOVE = 310;
var NUM_START_POS = NewsScroll._y;
this.stop();
