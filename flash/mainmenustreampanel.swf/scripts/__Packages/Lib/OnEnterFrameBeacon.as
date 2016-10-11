class Lib.OnEnterFrameBeacon
{
   function OnEnterFrameBeacon()
   {
   }
   static function init()
   {
      var _loc4_ = _global.MovieClip;
      if(!_root.__OnEnterFrameBeacon)
      {
         Lib.BroadcasterMX.initialize(_loc4_);
         var _loc3_ = _root.createEmptyMovieClip("__OnEnterFrameBeacon",9876);
         _loc3_.onEnterFrame = function()
         {
            if(_global.MovieClip.broadcastMessage != undefined)
            {
               _global.MovieClip.broadcastMessage("onEnterFrame");
            }
         };
      }
   }
}
