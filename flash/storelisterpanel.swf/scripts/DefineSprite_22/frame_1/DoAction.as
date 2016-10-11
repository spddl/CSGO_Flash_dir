function SetCouponExpirationTime(ItemID)
{
   var numLoop = 0;
   var _loc4_ = _global.CScaleformComponent_Inventory.GetCacheTypeElementFieldByIndex("Coupons",0,"expiration_date");
   var _loc3_ = _global.CScaleformComponent_Store.GetSecondsUntilTimestamp(_loc4_);
   FormatCouponTime(_loc3_);
   this.onEnterFrame = function()
   {
      if(numLoop % 12 == 0)
      {
         var _loc4_ = _global.CScaleformComponent_Inventory.GetCacheTypeElementFieldByIndex("Coupons",0,"expiration_date");
         var _loc3_ = _global.CScaleformComponent_Store.GetSecondsUntilTimestamp(_loc4_);
         if(_loc3_ <= 0)
         {
            _global.MainMenuMovie.Panel.BannerPanel.PlaceStoreTiles();
            if(_global.MainMenuMovie.Panel.StoreListerPanel._visible)
            {
               _global.MainMenuMovie.Panel.StoreListerPanel.HidePanel();
            }
            this._visible = false;
            delete this.onEnterFrame;
         }
         FormatCouponTime(_loc3_);
      }
      numLoop++;
   };
}
function FormatCouponTime(numSec)
{
   var _loc14_ = numSec;
   var _loc4_ = 0;
   var _loc2_ = 0;
   var _loc3_ = 0;
   var _loc7_ = "00";
   var _loc6_ = "00";
   var _loc11_ = "00";
   var _loc12_ = "00";
   if(numSec > 60)
   {
      _loc4_ = numSec / 60;
   }
   if(_loc4_ > 60)
   {
      _loc2_ = _loc4_ / 60;
   }
   if(_loc2_ > 24)
   {
      _loc3_ = _loc2_ / 24;
   }
   _loc3_ = Math.floor(_loc3_);
   _loc2_ = Math.floor(_loc2_ - _loc3_ * 24);
   _loc4_ = Math.floor(_loc4_ - (_loc2_ + _loc3_ * 24) * 60);
   numSec = Math.ceil(numSec - (_loc4_ + (_loc2_ + _loc3_ * 24) * 60) * 60);
   _loc12_ = _loc3_.toString();
   _loc11_ = _loc2_.toString();
   _loc6_ = _loc4_.toString();
   _loc7_ = numSec.toString();
   var _loc13_ = undefined;
   var _loc10_ = undefined;
   var _loc8_ = undefined;
   var _loc9_ = undefined;
   if(_loc3_ > 1)
   {
      _loc13_ = _global.GameInterface.Translate("#SFUI_Store_Timer_Days");
   }
   else
   {
      _loc13_ = _global.GameInterface.Translate("#SFUI_Store_Timer_Day");
   }
   if(_loc2_ > 1)
   {
      _loc10_ = _global.GameInterface.Translate("#SFUI_Store_Timer_Hours");
   }
   else
   {
      _loc10_ = _global.GameInterface.Translate("#SFUI_Store_Timer_Hour");
   }
   if(_loc4_ > 1)
   {
      _loc8_ = _global.GameInterface.Translate("#SFUI_Store_Timer_Mins");
   }
   else
   {
      _loc8_ = _global.GameInterface.Translate("#SFUI_Store_Timer_Min");
   }
   if(numSec > 1)
   {
      _loc9_ = _global.GameInterface.Translate("#SFUI_Store_Timer_Secs");
   }
   else
   {
      _loc9_ = _global.GameInterface.Translate("#SFUI_Store_Timer_Sec");
   }
   if(_loc3_ < 1)
   {
      if(_loc2_ < 1)
      {
         strEntry = "<b>" + _loc6_ + "</b>" + " " + _loc8_ + "  " + "<b>" + _loc7_ + "</b>" + " " + _loc9_;
      }
      else
      {
         strEntry = "<b>" + _loc11_ + "</b>" + " " + _loc10_ + "  " + "<b>" + _loc6_ + "</b>" + " " + _loc8_ + " " + "<b>" + _loc7_ + "</b>" + " " + _loc9_;
      }
   }
   else
   {
      strEntry = "<b>" + _loc12_ + "</b>" + " " + _loc13_ + "  " + "<b>" + _loc11_ + "</b>" + " " + _loc10_ + "  " + "<b>" + _loc6_ + "</b>" + " " + _loc8_ + "  " + "<b>" + _loc7_ + "</b>" + " " + _loc9_;
   }
   Time.htmlText = strEntry;
   if(_loc14_ < 43200)
   {
      Time.textColor = "0xFFCC33";
   }
}
stop();
