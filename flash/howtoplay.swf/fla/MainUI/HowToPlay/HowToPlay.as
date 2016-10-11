class MainUI.HowToPlay.HowToPlay
{
   var mCurLabelIndex = 0;
   var mScrollIntervalId = null;
   var mInitialTextFieldHeight = 0;
   function HowToPlay(thePanel)
   {
      this.mDialogData = _global.GameInterface.LoadKVFile("resource/HowToPlayMenu.res");
      this.mPanel = thePanel;
   }
   function InitDialogData()
   {
   }
   function Init()
   {
      var _loc3_ = 0;
      while(_loc3_ < this.mPanel.buttonCount)
      {
         var _loc2_ = this.mPanel["Button" + _loc3_];
         _loc2_.dialog = this;
         _loc2_.howtoplaybuttonindex = _loc3_;
         _loc2_.MouseAction = function()
         {
            this.PlayActionSound();
         };
         _loc2_.Focus = function(hasFocus)
         {
            if(hasFocus)
            {
               this.dialog.LabelButtonOnPress(this.howtoplaybuttonindex);
            }
         };
         _loc2_._visible = false;
         _loc3_ = _loc3_ + 1;
      }
      this.mInitialTextFieldHeight = this.mPanel.HowToPlayText.TextField.TextField._height;
      this.mPanel.HowToPlayText.TextField.TextField.autoSize = true;
      this.UpdateLabels();
      this.UpdateContents();
   }
   function UpdateLabels()
   {
      var _loc2_ = 0;
      var _loc4_ = this.mDialogData["" + _loc2_];
      var _loc3_ = 0;
      while(_loc2_ < this.mPanel.buttonCount)
      {
         if(_loc4_.label != undefined && _loc4_.contents != undefined)
         {
            this.mPanel["Button" + _loc3_]._visible = true;
            this.mPanel["Button" + _loc3_].SetText(_loc4_.label);
            this.mPanel["Button" + _loc3_].howtoplaydataindex = _loc2_;
            _loc3_ = _loc3_ + 1;
         }
         _loc2_ = _loc2_ + 1;
         _loc4_ = this.mDialogData["" + _loc2_];
      }
   }
   function UpdateContents()
   {
      var _loc3_ = this.mPanel["Button" + this.mCurLabelIndex];
      var _loc4_ = _global.GameInterface.Translate(this.mDialogData["" + _loc3_.howtoplaydataindex].contents);
      if(_loc3_ == this.mPanel.Button3)
      {
         this.mPanel.KeyBindings._visible = true;
         this.mPanel.ScrollBar._visible = false;
      }
      else
      {
         this.mPanel.KeyBindings._visible = false;
         this.mPanel.ScrollBar._visible = true;
      }
      if(this.mDialogData["" + _loc3_.howtoplaydataindex].contents2 != undefined)
      {
         var _loc5_ = _global.GameInterface.Translate(this.mDialogData["" + _loc3_.howtoplaydataindex].contents2);
         _loc4_ = _loc4_ + _loc5_;
      }
      if(this.mDialogData["" + _loc3_.howtoplaydataindex].contents3 != undefined)
      {
         var _loc6_ = _global.GameInterface.Translate(this.mDialogData["" + _loc3_.howtoplaydataindex].contents3);
         _loc4_ = _loc4_ + _loc6_;
      }
      this.mPanel.HowToPlayText.SetText(_loc4_);
      this.mPanel.HowToPlayText.TextField.TextField._height = this.mPanel.HowToPlayText.TextField.TextField.textHeight + 8;
      this.mPanel.HowToPlayText.TextField.TextField._y = 0;
      _global.HowToPlayMovie.Panel.Panel.UpdateScrollBar();
      updateAfterEvent();
   }
   function ScrollContents(textField, delta, startTime, initialTextFieldHeight, dialog)
   {
      var _loc1_ = getTimer() - startTime;
      if(_loc1_ > 3000)
      {
         textField.HowToPlayScrollRateMultiplier = Math.min(Math.pow(_loc1_ - 2000,2) / 1000000,8);
      }
      dialog.JumpBy(delta * textField.HowToPlayScrollRateMultiplier);
      updateAfterEvent();
   }
   function JumpToEnd()
   {
      this.JumpTo(- this.mPanel.HowToPlayText.TextField.TextField._height);
   }
   function JumpToStart()
   {
      this.JumpTo(0);
   }
   function PageDown()
   {
      this.JumpBy(this.mInitialTextFieldHeight * -3 / 4);
   }
   function PageUp()
   {
      this.JumpBy(this.mInitialTextFieldHeight * 3 / 4);
   }
   function JumpBy(jumpsize)
   {
      this.JumpTo(this.mPanel.HowToPlayText.TextField.TextField._y + jumpsize);
   }
   function JumpTo(position)
   {
      if(this.mPanel.HowToPlayText.TextField._height >= this.mInitialTextFieldHeight)
      {
         var _loc3_ = this.mPanel.HowToPlayText.TextField.TextField;
         _loc3_._y = position;
         if(_loc3_._y > 0)
         {
            _loc3_._y = 0;
         }
         else if(_loc3_._y < - _loc3_._height - this.mInitialTextFieldHeight)
         {
            _loc3_._y = - _loc3_._height - this.mInitialTextFieldHeight;
         }
         _global.HowToPlayMovie.Panel.Panel.UpdateScrollBar();
      }
   }
   function SetSliderPercentage(pct)
   {
      var _loc3_ = this.mPanel.HowToPlayText.TextField.TextField;
      var _loc4_ = _loc3_._height - this.mInitialTextFieldHeight;
      if(_loc4_ <= 0)
      {
         this.JumpTo(0);
      }
      else
      {
         _loc3_._y = - _loc4_ * pct / 100;
         _global.HowToPlayMovie.Panel.Panel.UpdateScrollBar();
      }
   }
   function GetSliderPercentage(pct)
   {
      var _loc2_ = this.mPanel.HowToPlayText.TextField.TextField;
      var _loc3_ = _loc2_._height - this.mInitialTextFieldHeight;
      if(_loc3_ <= 0)
      {
         return 0;
      }
      return _loc2_._y * -100 / _loc3_;
   }
   function BeginScrollContents(delta)
   {
      this.mPanel.HowToPlayText.TextField.TextField.HowToPlayScrollRateMultiplier = 1;
      if(this.mScrollIntervalId == null)
      {
         this.mScrollIntervalId = setInterval(this.ScrollContents,50,this.mPanel.HowToPlayText.TextField.TextField,delta,getTimer(),this.mInitialTextFieldHeight,this);
      }
   }
   function EndScrollContents()
   {
      if(this.mScrollIntervalId != null)
      {
         clearInterval(this.mScrollIntervalId);
         this.mScrollIntervalId = null;
      }
   }
   function LabelButtonOnPress(index)
   {
      this.mCurLabelIndex = index;
      this.UpdateContents();
   }
}
