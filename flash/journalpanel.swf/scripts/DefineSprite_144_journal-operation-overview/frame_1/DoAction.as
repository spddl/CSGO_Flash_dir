function SetUpPage(numSeason)
{
   SetUpOverview(numSeason);
}
function SetUpOverview(numSeason)
{
   Text.Title.htmlText = "#CSGO_Journal_Overview_Title";
   JournalName.htmlText = "#CSGO_Journal_CoverTitle_" + numSeason;
   Desc.htmlText = "#CSGO_Journal_Overview_Desc";
   LoadLogo(numSeason);
}
function LoadLogo(numSeason)
{
   var _loc2_ = new Object();
   _loc2_.onLoadInit = function(target_mc)
   {
      target_mc._width = 400;
      target_mc._height = 422;
      target_mc.forceSmoothing = true;
   };
   var _loc3_ = "images/journal/op_pic_" + numSeason + ".png";
   var _loc1_ = new MovieClipLoader();
   _loc1_.addListener(_loc2_);
   _loc1_.loadClip(_loc3_,OpImage);
}
stop();
