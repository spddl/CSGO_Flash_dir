function ShowAvatar(nTeamID, xuid, bShowFrame, bShowHealth)
{
   if(!DynamicAvatar.flLastLoadFlairImage || DynamicAvatar.flLastLoadFlairImage == undefined)
   {
      DynamicAvatar.flLastLoadFlairImage = 0;
   }
   ShowFrame(bShowFrame);
   SetFlairItem(xuid);
   SetFlairPosition(m_FlairPos);
   HideIcons();
   avatarWidth = DynamicAvatar._width;
   avatarHeight = DynamicAvatar._height;
   if(xuid == "0")
   {
      if(nTeamID == 3)
      {
         CTIcon._visible = true;
      }
      else
      {
         TIcon._visible = true;
      }
   }
   else
   {
      if(DynamicAvatar != undefined)
      {
         DynamicAvatar.unloadMovie();
      }
      _global.CScaleformComponent_ImageCache.EnsureAvatarCached(String(xuid));
      var _loc9_ = "img://avatar_" + xuid;
      var _loc4_ = new Object();
      _loc4_.onLoadInit = function(target_mc)
      {
         target_mc._width = avatarWidth;
         target_mc._height = avatarHeight;
      };
      var _loc3_ = new MovieClipLoader();
      _loc3_.addListener(_loc4_);
      _loc3_.loadClip(_loc9_,DynamicAvatar);
   }
   PlayerColor._visible = false;
   if(m_bShowPlayerColor)
   {
      if(PlayerColor.Inner)
      {
         var _loc8_ = new Color(PlayerColor.Inner);
         var _loc2_ = m_nPlayerIndex;
         if(m_nPlayerIndex >= 0)
         {
            _loc2_ = m_nPlayerIndex % 5;
         }
         var _loc10_ = _global.GetPlayerColorObject(_loc2_);
         _loc8_.setTransform(_loc10_);
         PlayerColor._visible = true;
         var _loc6_ = _global.GameInterface.GetConvarNumber("cl_teammate_colors_show") == 2;
         if(_loc6_)
         {
            var _loc7_ = _global.GetPlayerColorLetter(0,_loc2_);
            PlayerColor.PlayerNumber.Text.htmlText = _loc7_;
         }
         PlayerColor.PlayerNumber._visible = _loc6_;
      }
   }
}
function ShowTeamInsteadLogoForAvatar(TeamLogoPath)
{
   ShowFrame(false);
   PlayerColor._visible = false;
   m_bShowFlair = false;
   CTIcon._visible = false;
   TIcon._visible = false;
   if(DynamicAvatar != undefined)
   {
      DynamicAvatar.unloadMovie();
   }
   var _loc3_ = TeamLogoPath;
   var _loc2_ = new Object();
   _loc2_.onLoadInit = function(target_mc)
   {
      target_mc._width = avatarWidth;
      target_mc._height = avatarHeight;
   };
   var _loc1_ = new MovieClipLoader();
   _loc1_.addListener(_loc2_);
   _loc1_.loadClip(_loc3_,DynamicAvatar);
}
function SetShouldShowPlayerColor(bShouldShow, nPlayerIndex)
{
   m_bShowPlayerColor = bShouldShow;
   m_nPlayerIndex = nPlayerIndex;
}
function GetFlairItemName(PlayerXuid)
{
   if(PlayerXuid == "0" || m_bShowFlair == false)
   {
      return null;
   }
   var _loc2_ = _global.CScaleformComponent_Inventory.GetFlairItemName(PlayerXuid);
   return _loc2_;
}
function SetFlairItem(PlayerXuid)
{
   if(PlayerXuid == "0" || m_bShowFlair == false)
   {
      Medal._visible = false;
      return undefined;
   }
   if(DynamicAvatar.flLastLoadFlairImage > getTimer())
   {
      return undefined;
   }
   DynamicAvatar.flLastLoadFlairImage = getTimer() + 8000;
   var _loc4_ = true;
   var _loc3_ = "0";
   _loc3_ = _global.CScaleformComponent_Inventory.GetFlairItemId(PlayerXuid);
   if(_loc3_ == "0" || _loc3_ == "" || _loc3_ == undefined)
   {
      _loc4_ = false;
      _loc3_ = _global.CScaleformComponent_FriendsList.GetFriendDisplayItemDefFeatured(PlayerXuid);
   }
   this._ItemXuid = PlayerXuid;
   this._ItemID = _loc3_;
   var _loc5_ = "";
   if(_loc4_ == true)
   {
      _loc5_ = _global.CScaleformComponent_Inventory.GetSlot(PlayerXuid,_loc3_);
   }
   if(_loc4_ == false || _loc5_ == "" || _loc5_ == undefined || _loc5_ == "flair0")
   {
      var _loc7_ = "";
      if(_loc4_)
      {
         _loc7_ = _global.CScaleformComponent_Inventory.GetItemInventoryImage(PlayerXuid,_loc3_);
      }
      else
      {
         _loc7_ = _global.CScaleformComponent_ItemData.GetItemInventoryImage(_loc3_);
      }
      LoadFlairImage(_loc7_,true);
   }
   else
   {
      LoadFlairImage(_loc3_,false);
   }
}
function GetFlairImage(PlayerXuid, bGetSmall)
{
   if(PlayerXuid == "0")
   {
      return "";
   }
   var _loc2_ = _global.CScaleformComponent_Inventory.GetFlairItemId(PlayerXuid);
   var _loc3_ = _global.CScaleformComponent_Inventory.GetSlot(PlayerXuid,_loc2_);
   var _loc7_ = false;
   if(_loc3_ == "" || _loc3_ == undefined || _loc3_ == "flair0")
   {
      _loc2_ = _global.CScaleformComponent_Inventory.GetItemInventoryImage(PlayerXuid,_loc2_);
      if(_loc2_ == "0" || _loc2_ == "" || _loc2_ == undefined)
      {
         var _loc4_ = _global.CScaleformComponent_FriendsList.GetFriendDisplayItemDefFeatured(PlayerXuid);
         if(_loc4_ != undefined && Number(_loc4_) > 0)
         {
            _loc2_ = _global.CScaleformComponent_ItemData.GetItemInventoryImage(_loc4_);
         }
      }
      _loc7_ = true;
   }
   if(_loc2_ == "0" || _loc2_ == "" || _loc2_ == undefined)
   {
      return "";
   }
   if(bGetSmall)
   {
      _loc2_ = _loc2_ + "_small";
   }
   var _loc6_ = "";
   if(_loc7_)
   {
      _loc6_ = _loc2_ + ".png";
   }
   else
   {
      _loc6_ = "img://inventory_" + _loc2_;
   }
   return _loc6_;
}
function LoadFlairImage(strId, bLoadNonModelPanelImage)
{
   flairWidth = Medal._width;
   flairHeight = Medal._height;
   if(m_LastImageLoaded == strId)
   {
      return undefined;
   }
   if(strId != "0" && strId != "" && strId != undefined)
   {
      Medal._visible = true;
      Medal.Placeholder._visible = false;
      if(Medal != undefined)
      {
         Medal.unloadMovie();
      }
      _global.CScaleformComponent_ImageCache.EnsureInventoryImageCached(this._ItemID);
      var _loc4_ = new Object();
      _loc4_.onLoadInit = function(target_mc)
      {
         target_mc._width = flairWidth;
         target_mc._height = flairHeight;
      };
      _loc4_.onLoadStart = function(target_mc)
      {
      };
      _loc4_.onLoadError = function(target_mc, errorCode, status)
      {
         trace("Error loading image: " + errorCode + " [" + status + "] ----- You probably forgot to author a small version of your flair item (needs to end with _small).");
      };
      trace("!!!!!+++++++++++++++++++++++++  ShowAvatar:LoadFlairImage strId = " + strId + ", m_bUseSmallFlair = " + m_bUseSmallFlair);
      var _loc5_ = "";
      if(m_bUseSmallFlair)
      {
         strId = strId + "_small";
      }
      if(bLoadNonModelPanelImage)
      {
         _loc5_ = strId + ".png";
      }
      else
      {
         _loc5_ = "img://inventory_" + strId;
      }
      var _loc6_ = new MovieClipLoader();
      _loc6_.addListener(_loc4_);
      _loc6_.loadClip(_loc5_,Medal);
      trace("!!!!!+++++++++++++++++++++++++  ShowAvatar:LoadFlairImage strId = " + strId + ", m_bUseSmallFlair = " + m_bUseSmallFlair);
   }
   else
   {
      Medal._visible = false;
   }
}
function HideIcons()
{
   CTIcon._visible = false;
   TIcon._visible = false;
   DynamicAvatar._visible = false;
   Medal._visible = false;
   Medal.Placeholder._visible = false;
   DynamicAvatar.flLastLoadFlairImage = 0;
   m_LastImageLoaded = "";
}
function ShowHealthBar(bShow)
{
   trace("AVATAR: ShowHealthBar = " + bShow);
   HealthBar._visible = bShow;
}
function ShowFrame(bShow)
{
   Frame._visible = bShow;
}
function SetHealthBar(nHealthPercent)
{
   if(nHealthPercent == -1)
   {
      ShowHealthBar(false);
   }
   else
   {
      ShowHealthBar(true);
   }
   trace("AVATAR: ShowHealthBar fraction = " + nHealthPercent);
   HealthBar.HealthPanel.gotoAndStop(nHealthPercent + 2);
}
function SetShowFlairItem(bShow)
{
   m_bShowFlair = bShow;
   Medal._visible = false;
}
function SetUseSmallFlair(bSmall)
{
   m_bUseSmallFlair = bSmall;
}
function SetFlairPosition(position)
{
   m_FlairPos = position;
   gotoAndStop(position);
}
var avatarWidth = 59;
var avatarHeight = 59;
var flairWidth = 59;
var flairHeight = 59;
var m_bShowFlair = true;
var m_bUseSmallFlair = true;
var m_bShowPlayerColor = false;
var m_nPlayerIndex = 0;
var m_LastImageLoaded = "";
Medal.Placeholder._visible = false;
PlayerColor._visible = false;
HealthBar._visible = false;
stop();
