function compare(inNewData, inOldData)
{
   var _loc1_ = 26;
   var _loc2_ = Math.max(Math.min(Math.floor(inNewData / 100 * (_loc1_ - 1) + 0.5) + 1,_loc1_),1);
   FrontBar.gotoAndStop(_loc2_);
}
stop();
