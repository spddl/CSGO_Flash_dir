function CheckforUnacknowledgeItems()
{
   var _loc2_ = _global.CScaleformComponent_Inventory.GetUnacknowledgeItemsCount();
   if(_loc2_ > 0 && !IsFromPauseMenuGiveAGift())
   {
      SetUpAcknowlegePanel();
      ShowAcknowlegePanel();
      return true;
   }
   HideAcknowlegePanel();
   return false;
}
function IsFromPauseMenuGiveAGift()
{
   if(objParent.m_bOnlyGifts == false || objParent.m_bOnlyGifts == undefined || objParent.m_bOnlyGifts == null)
   {
      return false;
   }
   if(objParent.m_bOnlyGifts == true)
   {
      return true;
   }
}
function InitAcknowlegePanel()
{
   SetUpAcknowlegePanel();
   ShowAcknowlegePanel();
}
function ShowAcknowlegePanel()
{
   this._visible = true;
}
function HideAcknowlegePanel()
{
   this._visible = false;
}
function SetUpAcknowlegePanel()
{
   Ok.SetText("#SFUI_InvUse_Acknowledge_NextPage");
   Ok.Action = function()
   {
      onNextPageAcknowlegePanel();
   };
   Ok.setDisabled(false);
   Bg.onRollOver = function()
   {
   };
   SpecialPanel._visible = false;
   AcknowlegePanelInfo._m_numTopItemTile = 0;
   SetDataItemAcknowlege();
   NextPage.Action = function()
   {
      onNextPageAcknowlegePanel();
   };
   PrevPage.Action = function()
   {
      onPrevPageAcknowlegePanel();
   };
}
function SetDataItemAcknowlege()
{
   AcknowlegePanelInfo._m_numItems = _global.CScaleformComponent_Inventory.GetUnacknowledgeItemsCount();
   EnableDisableAcknowlegepageButton();
   var _loc4_ = 0;
   while(_loc4_ < AcknowlegePanelInfo._TotalTiles)
   {
      var _loc3_ = this["Item" + _loc4_];
      _loc3_.setDisabled(true);
      var _loc5_ = _loc4_ + AcknowlegePanelInfo._m_numTopItemTile;
      if(_loc5_ < 0 || _loc5_ > AcknowlegePanelInfo._m_numItems - 1)
      {
         _loc3_._visible = false;
      }
      else
      {
         var _loc6_ = _global.CScaleformComponent_Inventory.GetUnacknowledgeItemByIndex(_loc5_);
         _loc3_.SetItemInfo(_loc6_,m_PlayerXuid,"Acknowledge");
         _loc3_._visible = true;
      }
      _loc4_ = _loc4_ + 1;
   }
   gotoAndStop("StartAnim");
   play();
}
function ShowSpecialAcknowlege()
{
   if(objParent.Inventory.IsBuyKeyTileVisible() || IsPauseMenuActive())
   {
      return undefined;
   }
   var _loc3_ = 0;
   while(_loc3_ < AcknowlegePanelInfo._m_numItems)
   {
      var _loc2_ = _global.CScaleformComponent_Inventory.GetUnacknowledgeItemByIndex(_loc3_);
      if(_global.CScaleformComponent_Inventory.IsItemDefault(m_PlayerXuid,_loc2_))
      {
         var _loc8_ = _global.CScaleformComponent_Inventory.GetSlot(m_PlayerXuid,_loc2_);
         var _loc7_ = _global.CScaleformComponent_Inventory.GetSlotSubPosition(m_PlayerXuid,_loc2_);
         var _loc5_ = _global.CScaleformComponent_Inventory.GetItemDefinitionIndex(m_PlayerXuid,_loc2_);
         var _loc4_ = _global.CScaleformComponent_Inventory.IsEquipped(m_PlayerXuid,_loc2_,"t");
         var _loc6_ = _global.CScaleformComponent_Inventory.IsEquipped(m_PlayerXuid,_loc2_,"ct");
         if(_loc4_ == false && _loc6_ == false && _loc5_ == 64)
         {
            SetUpSpecialPanel(_loc2_);
            return true;
         }
      }
      _loc3_ = _loc3_ + 1;
   }
}
function SetUpSpecialPanel(strId)
{
   LoadImage("images/ui_images/revolver.png",SpecialPanel.BgImage,623,602);
   SpecialPanel.Name.htmlText = _global.CScaleformComponent_Inventory.GetItemName(m_PlayerXuid,strId);
   SpecialPanel.Desc.htmlText = "#CSGO_Item_Desc_Revolver";
   SpecialPanel.Warning.htmlText = "#SFUI_InvUse_Acknowledge_Equip_Revolver_Warning";
   SpecialPanel.BtnLoadout.dialog = this;
   SpecialPanel.BtnLoadout.SetText("#SFUI_InvUse_Acknowledge_Equip_Now");
   SpecialPanel.BtnLoadout.Action = function()
   {
      onEquipWeapon(strId);
   };
   SpecialPanel.BtnAccept.dialog = this;
   SpecialPanel.BtnAccept.SetText("#SFUI_InvUse_Acknowledge_Equip_Later");
   SpecialPanel.BtnAccept.Action = function()
   {
      onOkAcknowlegeSpecial(strId);
   };
   SpecialPanel._visible = true;
   new Lib.Tween(SpecialPanel,"_yscale",mx.transitions.easing.Strong.easeOut,120,100,1,true);
   new Lib.Tween(SpecialPanel,"_xscale",mx.transitions.easing.Strong.easeOut,120,100,1,true);
   _global.navManager.PlayNavSound("InspectItem");
}
function EnableDisableAcknowlegepageButton()
{
   UpdatePageCount(AcknowlegePanelInfo);
   var _loc1_ = GetPageCount(AcknowlegePanelInfo._m_numItems,AcknowlegePanelInfo._TotalTiles);
   var _loc2_ = GetCurrentPageNumber(AcknowlegePanelInfo._m_numTopItemTile,AcknowlegePanelInfo._TotalTiles);
   if(_loc1_ == _loc2_ || _loc1_ < 1)
   {
      Ok.SetText("#SFUI_PlayerDetails_Ok");
      Ok.Action = function()
      {
         onOkAcknowlege();
      };
   }
}
function onNextPageAcknowlegePanel()
{
   AcknowlegePanelInfo._m_numTopItemTile = AcknowlegePanelInfo._m_numTopItemTile + AcknowlegePanelInfo._TotalTiles;
   SetDataItemAcknowlege();
   EnableDisableAcknowlegepageButton();
}
function onOkAcknowlege()
{
   Ok.setDisabled(true);
   _global.MainMenuMovie.Panel.SelectPanel.HideNewItemAlert();
   if(objParent.Inventory.IsBuyKeyTileVisible() && ReceivedHasKey())
   {
      ShowInventoryTimeInterval = setInterval(ReturnToInspectCase,500);
   }
   else
   {
      ShowInventoryTimeInterval = setInterval(ShowInventory,500);
   }
   _global.CScaleformComponent_Inventory.AcknowledgeNewItems();
}
function onOkAcknowlegeSpecial(strId)
{
   CloseSpecialPanel();
   InitAcknowlegePanel();
}
function onEquipWeapon(strId)
{
   _global.CScaleformComponent_Loadout.EquipItemInSlot("ct",strId,"secondary4");
   _global.CScaleformComponent_Loadout.EquipItemInSlot("t",strId,"secondary4");
   CloseSpecialPanel();
   InitAcknowlegePanel();
}
function CloseSpecialPanel()
{
   m_HideSpecialPanel = true;
   SpecialPanel._visible = false;
}
function ReceivedHasKey()
{
   var _loc2_ = 0;
   while(_loc2_ < AcknowlegePanelInfo._m_numItems)
   {
      var _loc3_ = _global.CScaleformComponent_Inventory.GetUnacknowledgeItemByIndex(_loc2_);
      var _loc4_ = _global.CScaleformComponent_Inventory.IsTool(m_PlayerXuid,_loc3_);
      if(_loc4_)
      {
         return true;
      }
      _loc2_ = _loc2_ + 1;
   }
   return false;
}
function ReturnToInspectCase()
{
   objParent.Inventory.SetupUsePanel();
   HideAcknowlegePanel();
   clearInterval(ShowInventoryTimeInterval);
}
function ShowInventory()
{
   objParent.InitInventoryPanelMasterShowInventory();
   HideAcknowlegePanel();
   clearInterval(ShowInventoryTimeInterval);
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
function IsPauseMenuActive()
{
   if(_global.PauseMenuMovie)
   {
      return true;
   }
   return false;
}
function onScrollForward(objPanelInfo, RefreshTiles)
{
   if(objPanelInfo._m_numTopItemTile + objPanelInfo._SelectableTiles < objPanelInfo._m_numItems)
   {
      ScrollNext(objPanelInfo,RefreshTiles);
      objPanelInfo._NextButton.setDisabled(true);
   }
}
function onScrollBackward(objPanelInfo, RefreshTiles)
{
   if(objPanelInfo._m_numTopItemTile != 0)
   {
      ScrollPrev(objPanelInfo,RefreshTiles);
      objPanelInfo._PrevButton.setDisabled(true);
   }
}
function ScrollNext(objPanelInfo, RefreshTiles)
{
   var LoopCount = 0;
   var mcMovie = objPanelInfo._AnimObject;
   var SpeedOut = 0.6;
   var _loc1_ = 1;
   mcMovie.onEnterFrame = function()
   {
      if(LoopCount < 1)
      {
         mcMovie._x = mcMovie._x + (objPanelInfo._EndPos - 1 - mcMovie._x) * SpeedOut;
      }
      if(mcMovie._x < objPanelInfo._EndPos)
      {
         LoopCount++;
         mcMovie._x = objPanelInfo._StartPos;
         objPanelInfo._m_numTopItemTile = objPanelInfo._m_numTopItemTile + objPanelInfo._SelectableTiles;
         RefreshTiles();
         EnableDisableScrollButtons(objPanelInfo);
         UpdatePageCount(objPanelInfo);
         delete mcMovie.onEnterFrame;
      }
   };
}
function ScrollPrev(objPanelInfo, RefreshTiles)
{
   var LoopCount = 0;
   var mcMovie = objPanelInfo._AnimObject;
   var SpeedOut = 0.6;
   var _loc1_ = 1;
   mcMovie._x = objPanelInfo._EndPos;
   objPanelInfo._m_numTopItemTile = objPanelInfo._m_numTopItemTile - objPanelInfo._SelectableTiles;
   RefreshTiles();
   mcMovie.onEnterFrame = function()
   {
      if(LoopCount < 1)
      {
         mcMovie._x = mcMovie._x + (objPanelInfo._StartPos + 1 - mcMovie._x) * SpeedOut;
      }
      if(mcMovie._x > objPanelInfo._StartPos)
      {
         LoopCount++;
         mcMovie._x = objPanelInfo._StartPos;
         EnableDisableScrollButtons(objPanelInfo);
         UpdatePageCount(objPanelInfo);
         delete mcMovie.onEnterFrame;
      }
   };
}
function ScrollReset(objPanelInfo)
{
   if(GetCurrentPageNumber(objPanelInfo._m_numTopItemTile,objPanelInfo._SelectableTiles) > 1)
   {
      objPanelInfo._m_numTopItemTile = objPanelInfo._SelectableTiles;
      ScrollPrev(objPanelInfo);
   }
}
function EnableDisableScrollButtons(objPanelInfo)
{
   if(objPanelInfo._m_numTopItemTile != 0)
   {
      objPanelInfo._PrevButton.setDisabled(false);
   }
   else
   {
      objPanelInfo._PrevButton.setDisabled(true);
   }
   if(objPanelInfo._m_numTopItemTile + objPanelInfo._SelectableTiles < objPanelInfo._m_numItems)
   {
      objPanelInfo._NextButton.setDisabled(false);
   }
   else
   {
      objPanelInfo._NextButton.setDisabled(true);
   }
}
function UpdatePageCount(objPanelInfo)
{
   var _loc2_ = GetPageCount(objPanelInfo._m_numItems,objPanelInfo._SelectableTiles);
   var _loc3_ = GetCurrentPageNumber(objPanelInfo._m_numTopItemTile,objPanelInfo._SelectableTiles);
   if(_loc2_ > 1)
   {
      objPanelInfo._PageCountObject.htmlText = "Page " + _loc3_ + "/" + _loc2_;
   }
   else
   {
      objPanelInfo._PageCountObject.htmlText = "";
   }
}
function GetPageCount(numItems, NumTotalTiles)
{
   var _loc1_ = Math.ceil(numItems / NumTotalTiles);
   return _loc1_;
}
function GetCurrentPageNumber(numTopItemTile, NumTotalTiles)
{
   var _loc1_ = Math.ceil(numTopItemTile / NumTotalTiles);
   _loc1_ = _loc1_ + 1;
   return _loc1_;
}
var m_PlayerXuid = _global.CScaleformComponent_MyPersona.GetXuid();
var m_HideSpecialPanel = false;
var AcknowlegePanelInfo = new Object();
AcknowlegePanelInfo._TotalTiles = 9;
AcknowlegePanelInfo._SelectableTiles = 9;
AcknowlegePanelInfo._PrevButton = PrevPage;
AcknowlegePanelInfo._NextButton = NextPage;
AcknowlegePanelInfo._PageCountObject = Page;
AcknowlegePanelInfo._m_numItems = 0;
AcknowlegePanelInfo._m_numTopItemTile = 0;
var objParent = this._parent;
SpecialPanel._visible = false;
stop();
