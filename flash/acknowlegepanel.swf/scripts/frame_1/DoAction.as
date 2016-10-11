function InitInventoryPanelMaster(bOnlyGifts, ItemIdToPreview, CouponId)
{
   m_bOnlyGifts = bOnlyGifts;
   ShowInvMaster();
   DetectMouseSpeed(this);
   if(Acknowlege.CheckforUnacknowledgeItems())
   {
      Inventory._visible = false;
      Loadout._visible = false;
      Crafting._visible = false;
   }
   else
   {
      InitInventoryPanelMasterShowInventory(bOnlyGifts,ItemIdToPreview,CouponId);
      Inventory._visible = true;
   }
   if(!IsPauseMenuActive())
   {
      _global.MainMenuMovie.Panel.Blog.EnableInput(false);
      _global.MainMenuMovie.Panel.Blog.HideBlogPanel();
      _global.MainMenuMovie.Panel.BannerPanel._visible = false;
   }
   CheckIfInventoryIsValid();
}
function InitInventoryPanelMasterShowInventory(bOnlyGifts, ItemIdToPreview, CouponId)
{
   SetUpTitleBarButtons();
   Loadout.ResetLoadoutSettings();
   Inventory.ResetSettings(bOnlyGifts);
   Crafting.ResetCraftingSettings();
   onSelectTitleBarButton(InventoryButton);
   if(ItemIdToPreview != "" && ItemIdToPreview != null && ItemIdToPreview != undefined)
   {
      var _loc3_ = _global.CScaleformComponent_MyPersona.GetXuid();
      var _loc4_ = _global.CScaleformComponent_Inventory.DoesItemMatchDefinitionByName(_loc3_,ItemIdToPreview,"sticker");
      if(_loc4_)
      {
         var _loc5_ = _global.CScaleformComponent_Inventory.GetItemCapabilityByIndex(_loc3_,ItemIdToPreview,0);
         HideShowBarButtons(false);
         Inventory.InitStickerPreview(ItemIdToPreview,CouponId);
      }
   }
}
function CanShowAcknowlegePanel()
{
   var _loc3_ = _global.CScaleformComponent_Inventory.GetUnacknowledgeItemsCount();
   if(this._visible == true && _loc3_ > 0 && Inventory.IsInItemScroll() == false && Crafting.IsWaitingForCraftingItem() == false && !m_bOnlyGifts)
   {
      return true;
   }
   return false;
}
function ShowInvMaster()
{
   this._visible = true;
   HideShowBarButtons(true);
}
function HideInvMaster()
{
   this._visible = false;
}
function PushLayout()
{
   _global.navManager.PushLayout(inventoryNav,"inventoryNav");
}
function AddKeyHandlersForTextFields(Type)
{
   if(Type == "rename")
   {
      Inventory.ItemUsePanel.RenamePanel.FilterPanel.AddFilterKeyHandlers(inventoryNav);
   }
   else if(Type == "loadout")
   {
      Loadout.FilterCustomText.AddFilterKeyHandlers(inventoryNav);
   }
   else
   {
      Inventory.FilterCustomText.AddFilterKeyHandlers(inventoryNav);
   }
}
function RemoveLayout()
{
   _global.navManager.RemoveLayout(inventoryNav);
}
function HideShowBarButtons(bShow)
{
   InventoryButton._visible = bShow && !m_bOnlyGifts;
   LoadoutButton._visible = bShow && !m_bOnlyGifts;
   Market._visible = bShow && !m_bOnlyGifts;
   CloseButton._visible = bShow;
   var _loc4_ = _global.CScaleformComponent_PartyList.IsPartySessionActive();
   if(_loc4_)
   {
      var _loc5_ = _global.CScaleformComponent_PartyList.GetPartySessionSetting("members/numSlots");
      var _loc3_ = _global.CScaleformComponent_PartyList.GetPartySessionSetting("Game/mmqueue");
      CloseButton._visible = false;
      if(_loc5_ == 1 && (_loc3_ != "" && _loc3_ != undefined))
      {
         ToLobby._visible = false;
         return undefined;
      }
      ToLobby._x = numPosToLobbyButton;
      ToLobby._visible = !Inventory.ItemUsePanel._visible;
      return undefined;
   }
   ToLobby._visible = false;
   CloseButton._visible = bShow;
   ToLobby._visible = false;
}
function SetUpTitleBarButtons()
{
   var _loc2_ = "images/ui_icons/external_link.png";
   InventoryButton.dialog = this;
   InventoryButton.SetText("#SFUI_InvPanel_Inventory_Title");
   InventoryButton.Action = function()
   {
      this.dialog.onSelectTitleBarButton(this);
   };
   InventoryButton.Selected._visible = false;
   LoadoutButton.dialog = this;
   LoadoutButton.SetText("#SFUI_InvPanel_Loadout_Title");
   LoadoutButton.Action = function()
   {
      this.dialog.onSelectTitleBarButton(this);
   };
   LoadoutButton.Selected._visible = false;
   Market.dialog = this;
   Market.SetText("#SFUI_InvPanel_Market_Title");
   Market.Action = function()
   {
      this.dialog.onMarketPress(this);
   };
   Market.Selected._visible = false;
   Market.ButtonText.Text.autoSize = "left";
   Market.ButtonText.Text._x = 15;
   LoadImage(_loc2_,Market.ImageHolder,28,28,false);
   CloseButton.dialog = this;
   CloseButton.Action = function()
   {
      this.dialog.ClosePanel();
   };
   _loc2_ = "images/ui_icons/back.png";
   ToLobby.dialog = this;
   ToLobby.SetText("#SFUI_Back_To_Lobby");
   ToLobby.Action = function()
   {
      this.dialog.ClosePanel();
   };
   ToLobby.ButtonText.Text.autoSize = "left";
   ToLobby.ButtonText.Text._x = 15;
   LoadImage(_loc2_,ToLobby.ImageHolder,28,28,false);
}
function LoadImage(imagePath, objImage, numWidth, numHeight)
{
   var _loc1_ = new Object();
   _loc1_.onLoadInit = function(target_mc)
   {
      target_mc._width = numWidth;
      target_mc._height = numHeight;
   };
   _loc1_.onLoadError = function(target_mc, errorCode, status)
   {
      trace("Error loading item image: " + errorCode + " [" + status + "] ----- ");
   };
   var _loc3_ = imagePath;
   var _loc2_ = new MovieClipLoader();
   _loc2_.addListener(_loc1_);
   _loc2_.loadClip(_loc3_,objImage.Image);
}
function onSelectTitleBarButton(button)
{
   objSelectedTitleButton.Selected._visible = false;
   button.Selected._visible = true;
   objSelectedTitleButton = button;
   SetUpSelectedPanel(button);
}
function SetUpSelectedPanel(button)
{
   Loadout._visible = false;
   Inventory._visible = false;
   Crafting._visible = false;
   switch(button)
   {
      case InventoryButton:
         Inventory.InitInventoryPanel();
         ToLobby._x = PosToLobbyButton;
         break;
      case LoadoutButton:
         Loadout.InitLoadoutPanel();
         ToLobby._x = PosToLobbyButtonLoadout;
         break;
      case CraftingButton:
         Crafting.InitCraftingPanel();
   }
}
function onMarketPress()
{
   var _loc3_ = _global.CScaleformComponent_SteamOverlay.GetAppID();
   var _loc2_ = _global.CScaleformComponent_SteamOverlay.GetSteamCommunityURL();
   _global.CScaleformComponent_SteamOverlay.OpenURL(_loc2_ + "/market/search?q=&appid=" + _loc3_);
}
function ClosePanel()
{
   EndMouseSpeedLoop(this);
   Inventory.FilterCustomText.EndAutoExecuteTimer();
   if(IsPauseMenuActive())
   {
      var _loc3_ = _global.PauseMenuMovie.Panel.TooltipItemPreview;
   }
   else
   {
      _loc3_ = _global.MainMenuMovie.Panel.TooltipItemPreview;
   }
   _loc3_.ShowHidePreview(false);
   HideInvMaster();
   if(_global.LobbyMovie)
   {
      _global.LobbyMovie.ShowLobby();
   }
   if(!IsPauseMenuActive() && !_global.LobbyMovie)
   {
      _global.MainMenuMovie.Panel.Blog.EnableInput(true);
      _global.MainMenuMovie.ShowFloatingPanels();
      _global.MainMenuMovie.SetMainMenuNav("Default");
   }
}
function CheckIfInventoryIsValid()
{
   var _loc2_ = _global.CScaleformComponent_MyPersona.IsInventoryValid();
   if(_loc2_ == false)
   {
      Inventory.ShowMessageBox("InvError");
   }
   else
   {
      Inventory.ShowMessageBox._visible = false;
   }
}
var objSelectedTitleButton = null;
var CraftingButton = null;
var PosToLobbyButton = 260;
var PosToLobbyButtonLoadout = 15;
var m_bOnlyGifts = false;
var inventoryNav = new Lib.NavLayout();
inventoryNav.ShowCursor(true);
inventoryNav.AddCancelKeyHandlers({onDown:function(button, control, keycode)
{
   if(_global.PauseMenuMovie)
   {
      _global.PauseMenuMovie.Panel.MainMenuNav.OnCloseLoadout();
   }
   return true;
},onUp:function(button, control, keycode)
{
   return true;
}});
stop();
