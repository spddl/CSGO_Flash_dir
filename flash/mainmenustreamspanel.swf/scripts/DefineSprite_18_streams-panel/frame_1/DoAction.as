function InitStreamsPanel()
{
   var _loc2_ = _global.CScaleformComponent_Streams.GetStreamCount();
   if(_loc2_ > 0)
   {
      ShowStreamsSubPanel();
   }
   else
   {
      HideStreamsSubPanel();
   }
}
function ShowStreamsSubPanel()
{
   var _loc13_ = _global.CScaleformComponent_Streams.GetStreamCount();
   i = 0;
   while(i < _loc13_)
   {
      var _loc3_ = StreamsSubPanel["Stream" + i];
      var _loc4_ = _global.CScaleformComponent_Streams.GetStreamNameByIndex(i);
      var _loc11_ = _global.CScaleformComponent_Streams.GetStreamTextDescriptionByName(_loc4_);
      var _loc9_ = _global.CScaleformComponent_Streams.GetStreamDisplayNameByName(_loc4_);
      var _loc7_ = _global.CScaleformComponent_Streams.GetStreamViewersByName(_loc4_);
      var _loc10_ = _global.CScaleformComponent_Streams.GetStreamScaleformPreviewImageByName(_loc4_);
      var _loc12_ = _global.CScaleformComponent_Streams.GetStreamVideoFeedByName(_loc4_);
      var _loc5_ = _global.CScaleformComponent_Streams.GetStreamCountryByName(_loc4_);
      trace("-------------strCountry---------" + _loc5_);
      var _loc6_ = "<img src=\'flag_" + _loc5_ + ".png\' width=\'12\' height=\'7\'/>";
      var _loc8_ = _global.GameInterface.Translate("#SFUI_MainMenu_Streams_Viewers");
      _loc3_.Info.Desc.htmlText = _loc11_;
      _loc3_.Info.viewers.htmlText = _loc7_ + _loc8_ + _loc9_;
      _loc3_.Country.htmlText = _loc6_;
      _loc3_._StreamNum = i;
      _loc3_._Image = _loc10_;
      _loc3_.Action = function()
      {
         onSelectStream(this);
      };
      SetStreamImage(_loc3_);
      i++;
   }
   StreamsSubPanel._visible = true;
}
function SetStreamImage(objSelectedStream)
{
   var _loc2_ = objSelectedStream._Image;
   var _loc1_ = objSelectedStream.Preview;
   if(_loc2_ != "" && _loc2_ != undefined)
   {
      _loc1_.DefaultItemImage._visible = false;
      _loc1_.DynamicItemImage._visible = true;
      if(_loc1_.DynamicItemImage.Image != undefined)
      {
         _loc1_.DynamicItemImage.Image.unloadMovie();
      }
      var _loc4_ = new Object();
      _loc4_.onLoadInit = function(target_mc)
      {
         target_mc._width = 92;
         target_mc._height = 52;
      };
      var _loc5_ = _loc2_;
      var _loc3_ = new MovieClipLoader();
      _loc3_.addListener(_loc4_);
      _loc3_.loadClip(_loc5_,_loc1_.DynamicItemImage.Image);
   }
   else
   {
      _loc1_.DynamicItemImage._visible = false;
   }
}
function onSelectStream(objSelectedStream)
{
   var _loc3_ = _global.CScaleformComponent_Streams.GetStreamNameByIndex(objSelectedStream._StreamNum);
   var _loc2_ = _global.CScaleformComponent_Streams.GetStreamVideoFeedByName(_loc3_);
   _global.CScaleformComponent_SteamOverlay.OpenURL(_loc2_);
}
function HideStreamsSubPanel()
{
   StreamsSubPanel._visible = false;
}
function HideStreamsPanel()
{
   this._visible = false;
}
function ShowStreamsPanel()
{
   this._visible = true;
}
this.stop();
