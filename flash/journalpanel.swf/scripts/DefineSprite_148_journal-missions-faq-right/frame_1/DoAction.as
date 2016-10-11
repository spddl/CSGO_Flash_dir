function SetUpPage(m_numSeason)
{
   SetStrings(m_numSeason,numFaqSection);
}
function SetStrings(m_numSeason, numFaqSection)
{
   Text.htmlText = "#CSGO_Journal_Mission_Faq" + (m_numSeason + 1);
   _global.AutosizeTextDown(Text.htmlText,7);
   Text.autoSize = "left";
   LoadLogo(m_numSeason);
}
function LoadLogo(numSeason)
{
   var _loc2_ = new Object();
   _loc2_.onLoadInit = function(target_mc)
   {
      target_mc._width = 400;
      target_mc._height = 290;
      target_mc.forceSmoothing = true;
   };
   var _loc3_ = "econ/season_icons/season_" + numSeason + ".png";
   var _loc1_ = new MovieClipLoader();
   _loc1_.addListener(_loc2_);
   _loc1_.loadClip(_loc3_,OperationLogo);
   OperationLogo._alpha = 10;
}
stop();
