function InitStreamsPanel()
{
   var _loc2_ = "images/ui_icons/";
   MoreTwitch.dialog = this;
   MoreTwitch.Action = function()
   {
      this.dialog._global.CScaleformComponent_SteamOverlay.OpenExternalBrowserURL("http://www.twitch.tv/directory/game/Counter-Strike%3A%20Global%20Offensive");
   };
   MoreTwitch.SetText("#CSGO_Watch_More_Twitch");
   MoreTwitch._visible = true;
   MoreTwitch.ButtonText.Text.autoSize = "left";
   MoreTwitch.ButtonText.Text._x = 20;
   this._parent.LoadImage(_loc2_ + "external_link.png",MoreTwitch.ImageHolder,28,28,false);
   ShowStreamsSubPanel();
}
function GetTwitchTvState()
{
   var _loc2_ = _global.CScaleformComponent_Streams.GetMyTwitchTvState();
   trace("------------------------------------------------strState" + _loc2_);
   if(_loc2_ == "linked" || _loc2_ == "nolink" || _loc2_ == "error" || _loc2_ == "loading" || _loc2_ == "none")
   {
      UpdateLinkButton(_loc2_);
      _global.CScaleformComponent_Streams.UpdateMyTwitchTvState();
   }
   else
   {
      _loc2_ = "nolink";
      UpdateLinkButton(_loc2_);
   }
}
function UpdateLinkButton(strState)
{
   var Link = _global.CScaleformComponent_Streams.GetMyTwitchTvChannel();
   LinkTwitch.dialog = this;
   if(strState == "error")
   {
      LinkTwitch.SetText("#CSGO_Watch_NotLinked_Twitch_Btn");
      LinkTwitch.setDisabled(true);
      SetTwitchStatusText("#CSGO_Watch_Error_Twitch");
      TwitchStatus.Text.textColor = 14795025;
      return undefined;
   }
   if(strState == "loading")
   {
      LinkTwitch.SetText("#CSGO_Watch_NotLinked_Twitch_Btn");
      LinkTwitch.setDisabled(true);
      SetTwitchStatusText("#CSGO_Watch_CheckWithTwitch");
      TwitchStatus.Text.textColor = 14795025;
      return undefined;
   }
   if(strState == "nolink" || strState == "none")
   {
      LinkTwitch.setDisabled(false);
      LinkTwitch.SetText("#CSGO_Watch_NotLinked_Twitch_Btn");
      SetTwitchStatusText("#CSGO_Watch_Not_Linked");
      TwitchStatus.Text.textColor = 14795025;
   }
   else if(strState == "linked")
   {
      LinkTwitch.setDisabled(false);
      LinkTwitch.SetText("#CSGO_Watch_Linked_Twitch_Btn");
      SetTwitchStatusText("#CSGO_Watch_Linked");
      TwitchStatus.Text.textColor = 9481800;
   }
   var _loc4_ = "images/ui_icons/";
   LinkTwitch.ButtonText.Text.autoSize = "left";
   LinkTwitch.ButtonText.Text._x = 20;
   LinkTwitch.x = MoreTwitch._x - (LinkTwitch._width + 5);
   this._parent.LoadImage(_loc4_ + "twitch.png",LinkTwitch.ImageHolder,28,28,false);
   LinkTwitch.Action = function()
   {
      this.dialog._global.CScaleformComponent_SteamOverlay.OpenExternalBrowserURL(Link);
   };
}
function SetTwitchStatusText(strToolTip)
{
   TwitchStatus._visible = true;
   TwitchStatus.Text.htmlText = strToolTip;
   TwitchStatus.Text.autoSize = "left";
   _global.AutosizeTextDown(TwitchStatus.Text,8);
}
function ShowStreamsSubPanel()
{
   var _loc13_ = _global.CScaleformComponent_Streams.GetStreamCount();
   i = 0;
   while(i <= 5)
   {
      var _loc3_ = this["Stream" + i];
      if(i > _loc13_ - 1)
      {
         _loc3_._visible = false;
      }
      else
      {
         var _loc4_ = _global.CScaleformComponent_Streams.GetStreamNameByIndex(i);
         var _loc11_ = _global.CScaleformComponent_Streams.GetStreamTextDescriptionByName(_loc4_);
         var _loc9_ = _global.CScaleformComponent_Streams.GetStreamDisplayNameByName(_loc4_);
         var _loc7_ = _global.CScaleformComponent_Streams.GetStreamViewersByName(_loc4_);
         var _loc10_ = _global.CScaleformComponent_Streams.GetStreamScaleformPreviewImageByName(_loc4_);
         var _loc12_ = _global.CScaleformComponent_Streams.GetStreamVideoFeedByName(_loc4_);
         var _loc5_ = _global.CScaleformComponent_Streams.GetStreamCountryByName(_loc4_);
         trace("-------------strCountry---------" + _loc5_);
         var _loc6_ = "<img src=\'flag_" + _loc5_ + ".png\' width=\'15\' height=\'10\'/>";
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
         _loc3_._visible = true;
      }
      i++;
   }
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
         target_mc._width = 172;
         target_mc._height = 97;
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
   _global.CScaleformComponent_SteamOverlay.OpenExternalBrowserURL(_loc2_);
}
function HideStreamsPanel()
{
   this._visible = false;
}
