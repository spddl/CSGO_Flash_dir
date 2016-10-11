function SetUpPage(numSeason, mapGroup)
{
   if(OperationLogo != undefined)
   {
      OperationLogo.unloadMovie();
   }
   var _loc3_ = "econ/season_icons/season_" + numSeason + ".png";
   var _loc2_ = new Object();
   _loc2_.onLoadInit = function(target_mc)
   {
      target_mc._width = 40;
      target_mc._height = 32;
      target_mc.forceSmoothing = true;
   };
   var _loc1_ = new MovieClipLoader();
   _loc1_.addListener(_loc2_);
   _loc1_.loadClip(_loc3_,OperationLogo);
   Text.Title.htmlText = "#CSGO_Journal_Maps_Title";
   Desc.htmlText = "#CSGO_Journal_Maps_Desc";
   SetUpMapInfo(mapGroup);
}
function SetUpMapInfo(mapGroup)
{
   Tile0.Author.htmlText = _global.CScaleformComponent_GameTypes.GetMapGroupAttribute(mapGroup,"authorID");
   Tile0.Name.htmlText = _global.CScaleformComponent_GameTypes.GetMapGroupAttribute(mapGroup,"nameID");
   Tile0.Desc.htmlText = _global.CScaleformComponent_GameTypes.GetMapGroupAttribute(mapGroup,"descriptionID");
   _global.AutosizeTextDown(Tile0.Desc,8);
   LoadMapImage(Tile0,mapGroup);
   ModeImage(Tile0,mapGroup);
}
function LoadMapImage(Tile, mapGroup)
{
   var _loc3_ = _global.CScaleformComponent_GameTypes.GetMapGroupAttribute(mapGroup,"imagename");
   Tile.MapImage.attachMovie(_loc3_,"mapImage",1);
   Tile.MapImage._width = 400;
   Tile.MapImage._height = 300;
}
function ModeImage(Tile, mapGroup)
{
   var _loc2_ = _global.CScaleformComponent_GameTypes.GetMapGroupAttribute(mapGroup,"icontag");
   if(_loc2_ == "bomb")
   {
      Tile.GameModeImage.attachMovie("icon-" + _loc2_,"missionicon",1);
   }
   else if(_loc2_ == "hostage")
   {
      Tile.GameModeImage.attachMovie("icon-" + _loc2_,"missionicon",1);
   }
}
