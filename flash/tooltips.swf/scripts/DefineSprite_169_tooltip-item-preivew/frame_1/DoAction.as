function ShowHidePreview(bShow, strName, srtRarityColor)
{
   AcceptNewItemFromCratePanel._visible = false;
   Close._visible = true;
   if(bShow)
   {
      this._visible = true;
      Name.htmlText = strName;
      SetColor(srtRarityColor,"this.RarityColor");
      SetColor(srtRarityColor,"this.Sticker.Bg");
      _global.navManager.PlayNavSound("OpenCrate");
   }
   else
   {
      if(this._visible == false)
      {
         return undefined;
      }
      this._visible = false;
      StopMusicPreview();
      _global.CScaleformComponent_Inventory.LaunchWeaponPreviewPanel("");
   }
   this.gotoAndPlay("StartAnim");
}
function SetModel(strPath)
{
   Sticker._visible = false;
   _global.CScaleformComponent_Inventory.LaunchWeaponPreviewPanel(strPath);
}
function SetImage(Path)
{
   trace("--------SetModelPanelPath------------------------------->:" + Path);
   Sticker._visible = true;
   if(Sticker.Image != undefined)
   {
      Sticker.Image.unloadMovie();
   }
   var _loc1_ = new Object();
   _loc1_.onLoadInit = function(target_mc)
   {
      target_mc._width = 256;
      target_mc._height = 192;
      target_mc.forceSmoothing = true;
   };
   _loc1_.onLoadError = function(target_mc, errorCode, status)
   {
      trace("LoadSetSticker.Image: Error loading image: " + errorCode + " [" + status + "] ----- You probably forgot to author a small version of your flair item (needs to end with _small).");
   };
   var _loc3_ = Path;
   var _loc2_ = new MovieClipLoader();
   _loc2_.addListener(_loc1_);
   _loc2_.loadClip(_loc3_,Sticker.Image);
}
function SetColor(strColor, ClipToChange)
{
   strColor = strColor.substring(1,strColor.length);
   strColor = "0x" + strColor;
   parsedRGB = parseInt(strColor);
   var _loc2_ = new Color(ClipToChange);
   _loc2_.setRGB(parsedRGB);
}
function ShowNewItemAcceptButton(funcAction, bIsOpeningSpray)
{
   AcceptNewItemFromCratePanel.Accept.SetText("#SFUI_InvUse_Continue");
   AcceptNewItemFromCratePanel.Accept.Action = function()
   {
      onAcceptNewItemFromCrate(funcAction);
   };
   AcceptNewItemFromCratePanel.Text._visible = true;
   AcceptNewItemFromCratePanel._visible = true;
   Close._visible = false;
   if(bIsOpeningSpray)
   {
      AcceptNewItemFromCratePanel.Text.Text.htmlText = "#SFUI_InvError_Spray_Unpacked";
   }
   else
   {
      AcceptNewItemFromCratePanel.Text.Text.htmlText = "#SFUI_InvUse_Item_From_Crate";
   }
}
function onAcceptNewItemFromCrate(funcAction)
{
   _global.CScaleformComponent_Inventory.AcknowledgeNewItems();
   ShowHidePreview(false);
   funcAction();
}
function ShowNewItemBuyButton(CouponID, Xuid)
{
   var _loc3_ = _global.CScaleformComponent_Store.GetStoreItemSalePrice(CouponID,1);
   var _loc2_ = _global.GameInterface.Translate("#SFUI_InvUse_UsePreview_buy");
   _loc2_ = _global.ConstructString(_loc2_,_loc3_);
   AcceptNewItemFromCratePanel.Accept.SetText(_loc2_);
   AcceptNewItemFromCratePanel.Accept.Action = function()
   {
      BuyPreviewItem(CouponID);
   };
   AcceptNewItemFromCratePanel.Text._visible = false;
   AcceptNewItemFromCratePanel._visible = true;
}
function BuyPreviewItem(CouponID)
{
   ShowHidePreview(false);
   _global.CScaleformComponent_Store.PurchaseKeyAndOpenCrate(CouponID);
}
function StartMusicPreview(MusicKitID, Xuid)
{
   m_IsInspectingMusicKit = true;
   _global.CScaleformComponent_Inventory.PlayItemPreviewMusic(Xuid,MusicKitID);
}
function StopMusicPreview()
{
   if(m_IsInspectingMusicKit)
   {
      _global.CScaleformComponent_Inventory.StopItemPreviewMusic();
      m_IsInspectingMusicKit = false;
   }
}
Close.dialog = this;
Close.Action = function()
{
   this.dialog.ShowHidePreview(false);
};
bg.onRollOver = function()
{
};
var m_IsInspectingMusicKit = false;
stop();
