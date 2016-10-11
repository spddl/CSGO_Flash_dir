function onResize(rm)
{
   rm.ResetPosition(Panel,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.POSITION_CENTER,Lib.ResizeManager.POSITION_CENTER,Lib.ResizeManager.ALIGN_CENTER,Lib.ResizeManager.ALIGN_CENTER);
}
function onUIHide(mc, rm)
{
   hidePanel();
}
function onUIShow(mc, rm)
{
   showPanel();
}
function showPanel()
{
   Panel.onShow();
}
function hidePanel()
{
   Panel.onHide();
}
function restorePanel()
{
   Panel.restorePanel();
}
function onUnload(mc)
{
   _global.PauseMenuMovie = null;
   _global.PauseMenuAPI = null;
   _global.resizeManager.RemoveListener(this);
   _global.tintManager.DeregisterAll(this);
   _global.resizeManager.RemoveListener(_global.PauseBackgroundMovie);
   unloadMovie(_global.PauseBackgroundMovie);
   delete _global.PauseBackgroundMovie;
   return true;
}
function onLoaded()
{
   _global.PauseBackgroundMovie.showBackground();
   Panel.MainMenuNav.InitButtons();
   gameAPI.OnReady();
   AcknowledgedItemsByType();
   _global.KeyDownEvent = function(key, vkey, slot, binding)
   {
      Lib.SFKey.setKeyCode(key,vkey,slot,binding);
      var _loc2_ = Lib.SFKey.KeyName(Lib.SFKey.getKeyCode());
      if(_loc2_ == "MOUSE_RIGHT")
      {
         RightClickManager();
      }
      return _global.navManager.onKeyDown();
   };
}
function RightClickManager()
{
   var _loc2_ = Panel.MainMenuNav.InventoryPanel.Inventory;
   var _loc3_ = Panel.MainMenuNav.InventoryPanel.Loadout;
   var _loc4_ = Panel.MainMenuNav.InventoryPanel.Crafting;
   if(Panel.MainMenuNav.InventoryPanel.hitTest(_root._xmouse,_root._ymouse,true))
   {
      if(_loc2_._visible)
      {
         _loc2_.OpenContextMenu(_loc2_.m_objInvHoverSelection,true);
         _loc2_.FilterDropdown.HideList();
         _loc2_.SortDropdown.HideList();
      }
      else if(_loc3_._visible)
      {
         _loc3_.OpenLoadoutContextMenu(_loc3_.m_objLoadoutHoverSelection,true);
         _loc3_.SortDropdown.HideList();
      }
      else if(_loc4_._visible)
      {
         _loc4_.m_objCraftingHoverSelection.Action();
         _loc4_.SortDropdown.HideList();
      }
   }
   if(Panel.FriendsListerPanel.hitTest(_root._xmouse,_root._ymouse,true))
   {
      trace("-------------------MOUSE_RIGHT-FriendsListerPanel--------------------");
   }
}
function SetPlayerName(playerNameText)
{
}
function ScaleformComponent_GameState_PlayerSpawning()
{
}
function ScaleformComponent_GameState_RoundEnd()
{
}
function ScaleformComponent_Inventory_ModelPanelReady()
{
   Panel.MainMenuNav.InventoryPanel.Inventory.SetStickerSlotsInfo();
}
function AcknowledgedItemsByType()
{
   CheckForUnacknowledgedItemsByType("coupon_crate");
}
function ScaleformComponent_MyPersona_InventoryUpdated()
{
   AcknowledgedItemsByType();
   if(Panel.MainMenuNav.InventoryPanel.CanShowAcknowlegePanel())
   {
      Panel.MainMenuNav.InventoryPanel.InitInventoryPanelMaster();
   }
   else if(Panel.MainMenuNav.InventoryPanel.Inventory.IsInItemScroll() == false)
   {
      Panel.MainMenuNav.InventoryPanel.Inventory.RefreshItemTiles();
      Panel.MainMenuNav.InventoryPanel.Loadout.RefreshLoadoutItemTiles();
   }
   Panel.MainMenuNav.InventoryPanel.Inventory.CallbackStickerWearApplied();
}
function CheckForUnacknowledgedItemsByType(strType)
{
   var _loc6_ = _global.CScaleformComponent_Inventory.GetUnacknowledgeItemsCount();
   var _loc7_ = _global.CScaleformComponent_MyPersona.GetXuid();
   var _loc5_ = 0;
   if(_loc6_ > 0)
   {
      var _loc2_ = 0;
      while(_loc2_ < _loc6_)
      {
         var _loc3_ = _global.CScaleformComponent_Inventory.GetUnacknowledgeItemByIndex(_loc2_);
         var _loc4_ = _global.CScaleformComponent_Inventory.GetItemTypeFromEnum(_loc3_);
         if(strType == _loc4_)
         {
            _global.CScaleformComponent_Inventory.AcknowledgeNewItembyItemID(_loc7_,_loc3_);
            _loc5_ = _loc5_ + 1;
         }
         _loc2_ = _loc2_ + 1;
      }
      return _loc5_;
   }
   return 0;
}
function CheckForUnacknowlegedItems()
{
   var _loc2_ = _global.CScaleformComponent_Inventory.GetUnacknowledgeItemsCount();
   return _loc2_;
}
function ScaleformComponent_Inventory_CrateOpened()
{
   var _loc2_ = _global.PauseMenuAPI.GetScaleformComponentEventParamString("ScaleformComponent_Inventory_CrateOpened","itemid");
   Panel.MainMenuNav.InventoryPanel.Inventory.SetItemThatCameFromOpeningCrate(_loc2_);
   Panel.MainMenuNav.InventoryPanel.Crafting.SetCraftedItem(_loc2_);
}
function MakeActionFunction(action, button, nav)
{
   return function()
   {
      nav.lastHighlight = button;
      action();
   };
}
_global.PauseMenuMovie = this;
_global.PauseMenuAPI = gameAPI;
Panel.TooltipItemPreview._visible = false;
Panel.TooltipContextMenu._visible = false;
Panel.TooltipItem._visible = false;
Panel.MainMenuNav.InventoryPanel._visible = false;
Panel.MainMenuNav.LoadoutBlack._visible = false;
Panel.MainMenuNav.Close._visible = false;
_global.resizeManager.AddListener(this);
stop();
