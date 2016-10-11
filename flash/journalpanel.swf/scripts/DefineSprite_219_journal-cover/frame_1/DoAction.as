function SetUpPage(m_numSeason, ItemId)
{
   SetStrings(m_numSeason,ItemId);
}
function SetStrings(m_numSeason, ItemId)
{
   var _loc5_ = _global.CScaleformComponent_MyPersona.GetXuid();
   var _loc3_ = _global.GameInterface.Translate("#CSGO_Journal_IssuedTo");
   _loc3_ = _global.ConstructString(_loc3_,_global.CScaleformComponent_FriendsList.GetFriendName(_loc5_));
   Text.PlayerName.htmlText = _loc3_;
   Text.CoverId.htmlText = "#CSGO_Journal_CoverId_" + m_numSeason;
   Text.CoverDept.htmlText = "#CSGO_Journal_CoverDept";
   Text.CoverTitle.htmlText = "#CSGO_Journal_CoverTitle_" + m_numSeason;
   Text.CoverDesc.htmlText = "#CSGO_Journal_CoverDesc_" + m_numSeason;
   var _loc2_ = _global.CScaleformComponent_Inventory.GetItemAttributeValue(_loc5_,ItemId,"deployment_date");
   if(_loc2_ == undefined || _loc2_ == null || _loc2_ == "")
   {
      Text.CoverDate.htmlText = "";
   }
   else
   {
      var _loc4_ = _global.GameInterface.Translate("#CSGO_Journal_CoverDate_3");
      _loc4_ = _global.ConstructString(_loc4_,_loc2_);
      Text.CoverDate.htmlText = _loc4_;
   }
   BackOfCover.PaperType.htmlText = "#CSGO_Journal_PaperType";
   BackOfCover.CoverBackpageWarning.htmlText = "#CSGO_Journal_CoverWarning";
   BackOfCover.PublishDetail.htmlText = "#CSGO_Journal_CoverPublishInfo";
   BackOfCover.Title.htmlText = "#CSGO_Journal_CoverDesc";
}
stop();
