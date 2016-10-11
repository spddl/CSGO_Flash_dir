function GetTileInfo(Index)
{
   var _loc4_ = _global.CScaleformComponent_MyPersona.GetXuid();
   this._ItemIndex = Index;
   var _loc3_ = _global.CScaleformComponent_Inventory.GetInventoryItemIDByIndex(Index);
   SetItemInfo(_loc3_,_loc4_);
}
function SetItemInfo(strId, PlayerXuid)
{
   var _loc6_ = _global.CScaleformComponent_Inventory.GetItemName(PlayerXuid,strId);
   var _loc12_ = _global.CScaleformComponent_Inventory.GetItemDescription(PlayerXuid,strId);
   var _loc10_ = _global.CScaleformComponent_Inventory.GetItemTeam(PlayerXuid,strId);
   var _loc8_ = _global.CScaleformComponent_Inventory.IsTool(PlayerXuid,strId);
   _loc10_ = _global.CScaleformComponent_Inventory.GetItemTeam(PlayerXuid,strId);
   var _loc5_ = _global.CScaleformComponent_Inventory.GetItemRarityColor(PlayerXuid,strId);
   var _loc9_ = "";
   var _loc7_ = _global.CScaleformComponent_Inventory.GetWeaponCategory(PlayerXuid,strId);
   trace("***** strColor *******" + _loc5_);
   if(_loc8_)
   {
      _loc9_ = _global.CScaleformComponent_Inventory.GetItemCapabilityByIndex(PlayerXuid,strId,0);
   }
   trace("***** SetItemInfo: storing strId = " + strId + ", strName = " + _loc6_);
   this._ItemID = strId;
   this._ItemXuid = PlayerXuid;
   this._ItemIsTool = _loc8_;
   this._ItemCapability = _loc9_;
   DisplayTileText(SeperateName(_loc6_));
   SetTeamImage(_loc10_);
   SetColor(_loc5_);
   if(_loc7_ == "" || _loc7_ == undefined)
   {
      var _loc11_ = _global.CScaleformComponent_Inventory.GetItemInventoryImage(PlayerXuid,strId);
      LoadItemImage(_loc11_,true);
   }
   else
   {
      LoadItemImage(strId,false);
   }
}
function SetInfoForItemNotInPlayerInventory(DefIndex)
{
   var _loc4_ = _global.CScaleformComponent_ItemData.GetItemName(DefIndex);
   var _loc6_ = _global.CScaleformComponent_ItemData.GetItemDescription(DefIndex);
   var _loc5_ = _global.CScaleformComponent_ItemData.GetItemInventoryImage(DefIndex);
   trace("***** SetItemInfo: storing strId = " + DefIndex + ", strName = " + _loc4_ + ", strName = " + _loc5_);
   this._ItemID = DefIndex;
   RarityColor._visible = false;
   DisplayTileText(SeperateName(_loc4_));
   SetTeamImage("none");
   LoadItemImage(_loc5_,true);
}
function LoadItemImage(strId, bLoadNonModelPanelImage)
{
   if(strId != "0" && strId != "" && strId != undefined)
   {
      ItemImage.DefaultItemImage._visible = false;
      ItemImage.DynamicItemImage._visible = true;
      if(ItemImage.DynamicItemImage.Image != undefined)
      {
         ItemImage.DynamicItemImage.Image.unloadMovie();
      }
      _global.MainMenuAPI.EnsureInventoryImageCached(strId,this._ItemXuid);
      var _loc6_ = new Object();
      _loc6_.onLoadInit = function(target_mc)
      {
         target_mc._width = 90;
         target_mc._height = 90;
      };
      var _loc4_ = "";
      if(bLoadNonModelPanelImage)
      {
         _loc4_ = strId + ".png";
      }
      else
      {
         _loc4_ = "img://inventory_" + strId;
      }
      var _loc5_ = new MovieClipLoader();
      _loc5_.addListener(_loc6_);
      _loc5_.loadClip(_loc4_,ItemImage.DynamicItemImage.Image);
   }
   else
   {
      ItemImage.DefaultItemImage._visible = true;
      ItemImage.DynamicItemImage._visible = false;
   }
}
function RefreshItemImage()
{
   ItemImage.DynamicItemImage.Image.unloadMovie();
   _global.MainMenuAPI.EnsureInventoryImageCached(this._ItemID,this._ItemXuid);
   var _loc4_ = new Object();
   _loc4_.onLoadInit = function(target_mc)
   {
      target_mc._width = 90;
      target_mc._height = 90;
   };
   var _loc5_ = "img://inventory_" + this._ItemID;
   var _loc3_ = new MovieClipLoader();
   _loc3_.addListener(_loc4_);
   _loc3_.loadClip(_loc5_,ItemImage.DynamicItemImage.Image);
}
function SetTeamImage(strTeam)
{
   switch(strTeam)
   {
      case "#CSGO_Inventory_Team_CT":
         CTIcon._visible = true;
         TIcon._visible = false;
         break;
      case "#CSGO_Inventory_Team_T":
         TIcon._visible = true;
         CTIcon._visible = false;
         break;
      default:
         CTIcon._visible = false;
         TIcon._visible = false;
   }
}
function SetColor(strColor)
{
   strColor = strColor.substring(1,strColor.length);
   strColor = "0x" + strColor;
   parsedRGB = parseInt(strColor);
   var _loc2_ = new Color("this.RarityColor");
   _loc2_.setRGB(parsedRGB);
}
function SeperateName(strName)
{
   var _loc1_ = strName.split("|  ",2);
   trace(_loc1_);
   return _loc1_;
}
function DisplayTileText(aName)
{
   if(aName.length == 1)
   {
      ItemName.htmlText = "<b>" + aName[0] + "</b>";
   }
   else
   {
      ItemName.htmlText = "<b>" + aName[0] + "</b>" + "\n" + aName[1];
   }
}
function GetItemId()
{
   return this._ItemID;
}
function GetOwnerXuid()
{
   return this._ItemXuid;
}
function SetOwnedByLocalPlayer(bOwnedByLocal)
{
   bgLocalPlayer._visible = bOwnedByLocal;
}
this.stop();
