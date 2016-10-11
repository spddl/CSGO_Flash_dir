function createIconPack(index, packtype)
{
   var _loc1_ = undefined;
   var _loc2_ = undefined;
   if(packtype == 0)
   {
      _loc1_ = 150 - index;
      _loc2_ = "Player";
   }
   else if(packtype == 1)
   {
      _loc1_ = 100 - index;
      _loc2_ = "Hostage";
   }
   else if(packtype == 2)
   {
      _loc1_ = 50 - index;
      _loc2_ = "Decoy";
   }
   else if(packtype == 3)
   {
      _loc1_ = 200 - index;
      _loc2_ = "Defuser";
   }
   var _loc5_ = attachMovie("icons-radar",_loc2_ + _loc1_,_loc1_);
   return _loc5_;
}
function removeIconPack(movie)
{
   movie.removeMovieClip();
}
function createBombPack()
{
   return attachMovie("icons-bomb","BombIconPackage",250);
}
function removeBombPack()
{
   BombIconPackage.removeMovieClip();
}
function createDefuserPack()
{
   return attachMovie("icons-defuser","DefuserIconPackage",201);
}
function removeDefuserPack()
{
   DefuserIconPackage.removeMovieClip();
}
stop();
