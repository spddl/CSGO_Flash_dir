class Lib.SFKey extends Key
{
   static var XSTICK2UP = 136;
   static var XSTICK2LEFT = 137;
   static var XSTICK2RIGHT = 138;
   static var XSTICK2DOWN = 139;
   static var BACKTAB = 10009;
   static var BACK = 219;
   static var START = 221;
   static var onDown = "onDown";
   static var onUp = "onUp";
   static var _keyNames = new Object();
   static var staticInitialized = Lib.SFKey.staticInitializer();
   function SFKey()
   {
      super();
   }
   static function staticInitializer()
   {
      Lib.SFKey._keyNames[8] = "BACKSPACE";
      Lib.SFKey._keyNames[20] = "CAPSLOCK";
      Lib.SFKey._keyNames[17] = "CONTROL";
      Lib.SFKey._keyNames[46] = "DELETEKEY";
      Lib.SFKey._keyNames[40] = "DOWN";
      Lib.SFKey._keyNames[35] = "END";
      Lib.SFKey._keyNames[13] = "ENTER";
      Lib.SFKey._keyNames[27] = "ESCAPE";
      Lib.SFKey._keyNames[36] = "HOME";
      Lib.SFKey._keyNames[45] = "INSERT";
      Lib.SFKey._keyNames[37] = "LEFT";
      Lib.SFKey._keyNames[34] = "PGDN";
      Lib.SFKey._keyNames[33] = "PGUP";
      Lib.SFKey._keyNames[39] = "RIGHT";
      Lib.SFKey._keyNames[16] = "SHIFT";
      Lib.SFKey._keyNames[32] = "SPACE";
      Lib.SFKey._keyNames[9] = "TAB";
      Lib.SFKey._keyNames[38] = "UP";
      Lib.SFKey._keyNames[Lib.SFKey.BACKTAB] = "BACKTAB";
      Lib.SFKey._keyNames[Lib.SFKey.BACK] = "BACK";
      Lib.SFKey._keyNames[Lib.SFKey.START] = "START";
      Lib.SFKey._keyNames[Lib.SFKey.XSTICK2UP] = "XSTICK2UP";
      Lib.SFKey._keyNames[Lib.SFKey.XSTICK2LEFT] = "XSTICK2LEFT";
      Lib.SFKey._keyNames[Lib.SFKey.XSTICK2RIGHT] = "XSTICK2RIGHT";
      Lib.SFKey._keyNames[Lib.SFKey.XSTICK2DOWN] = "XSTICK2DOWN";
      return true;
   }
   static function KeyName(key)
   {
      var _loc1_ = Lib.SFKey._keyNames[key];
      if(!_loc1_)
      {
         _loc1_ = String.fromCharCode(key);
      }
      return _loc1_;
   }
}
