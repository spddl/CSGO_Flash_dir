class Lib.SFKey extends Key
{
   static var onDown = "onDown";
   static var onUp = "onUp";
   static var _keyNames = null;
   static var lastKeyCode = 0;
   static var lastVKeyCode = 0;
   static var lastKeySlot = 0;
   static var lastKeyBinding = null;
   function SFKey()
   {
      super();
   }
   static function KeyName(key)
   {
      return _global.ValveKeyTable[key];
   }
   static function KeyFromName(name)
   {
      return _global.ValveKeyTable[name];
   }
   static function setKeyCode(code, vkey, slot, binding)
   {
      Lib.SFKey.lastKeyCode = code;
      Lib.SFKey.lastVKeyCode = vkey;
      Lib.SFKey.lastKeySlot = slot;
      Lib.SFKey.lastKeyBinding = binding;
   }
   static function getKeyCode()
   {
      return Lib.SFKey.lastKeyCode;
   }
   static function getKeySlot()
   {
      return Lib.SFKey.lastKeySlot;
   }
   static function getKeyBinding()
   {
      return Lib.SFKey.lastKeyBinding;
   }
}
