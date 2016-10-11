_global.ItemPickupMovie = this;
_global.ItemPickupAPI = gameAPI;
var avatarSize;
var m_selectedPlayerIndex = -1;
var m_selectedPlayerXuid = "";
var bHasPrevCommendation = false;
var bCommendationResponseFailed = false;
var bAskedServersForCommendation = false;
var bHasChangedCommendations = false;
var bIsServerReport = false;
var srtServerName = "";
function InitConfirmDeleteNav()
{
   navConfirmDelete.DenyInputToGame(true);
   navConfirmDelete.ShowCursor(true);
   itemPickupNav.AddTabOrder([Panel.SubmittedPanel.SubmitOkButton]);
}
function InitItemPickupNav()
{
   itemPickupNav.DenyInputToGame(true);
   itemPickupNav.ShowCursor(true);
   itemPickupNav.AddTabOrder([Panel.ViewProfile,Panel.MutePlayer,Panel.CommendTabButton,Panel.ReportTabButton]);
   itemPickupNav.SetInitialHighlight(Panel.ViewProfile);
   itemPickupNav.AddKeyHandlerTable({CANCEL:{onDown:function(button, control, keycode)
   {
      HideFromScript();
   },onUp:function(button, control, keycode)
   {
      return true;
   }}});
}
function onResize(rm)
{
   rm.ResetPosition(Panel,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.POSITION_CENTER,Lib.ResizeManager.POSITION_CENTER,Lib.ResizeManager.ALIGN_CENTER,Lib.ResizeManager.ALIGN_CENTER);
}
function showPanel()
{
   Panel._visible = true;
   _global.navManager.PushLayout(itemPickupNav,"itemPickupNav");
   Panel.ConfirmDeletePanel._visible = false;
}
function showConfirmDeletePanel(itemName)
{
   _global.navManager.RemoveLayout(itemPickupNav);
   InitConfirmDeleteNav();
   _global.navManager.PushLayout(navConfirmDelete,"navConfirmDelete");
   Panel.ConfirmDeletePanel.Cancel.ButtonText.SetText("#CancelDeleteItem");
   Panel.ConfirmDeletePanel.Cancel.Action = HideConfirmDeletePanel;
   Panel.ConfirmDeletePanel.ConfirmDelete.ButtonText.SetText("#YesDeleteItem");
   Panel.ConfirmDeletePanel.ConfirmDelete.Action = ConfirmDeleteItem;
   Panel.ConfirmDeletePanel.ConfirmTitleText.Text.SetText("#ConfirmDeleteItem");
   Panel.ConfirmDeletePanel.NameText.Text.htmlText = itemName;
   Panel.ConfirmDeletePanel._visible = true;
}
function ConfirmDeleteItem()
{
   _global.navManager.RemoveLayout(navConfirmDelete);
   Panel.ConfirmDeletePanel._visible = false;
   _global.navManager.PushLayout(itemPickupNav,"itemPickupNav");
   gameAPI.OnConfirmDelete();
}
function HideConfirmDeletePanel()
{
   _global.navManager.RemoveLayout(navConfirmDelete);
   Panel.ConfirmDeletePanel._visible = false;
   _global.navManager.PushLayout(itemPickupNav,"itemPickupNav");
}
function HideFromScript()
{
   gameAPI.HideFromScript();
}
function NextItem()
{
   gameAPI.NextItem();
}
function PrevItem()
{
   gameAPI.PrevItem();
}
function DiscardItem()
{
   gameAPI.DiscardItem();
}
function OpenLoadout()
{
   gameAPI.OpenLoadout();
}
function hidePanel()
{
   _global.navManager.RemoveLayout(itemPickupNav);
   _global.navManager.RemoveLayout(navConfirmDelete);
   Panel._visible = false;
}
function onUnload(mc)
{
   _global.ItemPickupMovie = null;
   _global.ItemPickupAPI = null;
   _global.resizeManager.RemoveListener(this);
   _global.tintManager.DeregisterAll(this);
   return true;
}
function onLoaded()
{
   InitItemPickupNav();
   SetUpButtons();
   gameAPI.OnReady();
}
function InitConfirmSelection()
{
   _global.navManager.RemoveLayout(itemPickupNav);
   InitConfirmNav();
   _global.navManager.PushLayout(navConfirm,"navConfirm");
}
function ShowSelectedItem(direction, bCanDiscard, bShowOpenLoadoutButton, szNewItemsStr, bReturnToGame, nItemSelected, nItemsCount)
{
   if(direction == 1 || direction == 2)
   {
      Panel.gotoAndPlay("ShowNextItem");
   }
   else if(direction == 3)
   {
      Panel.gotoAndPlay("ShowPrevItem");
   }
   Panel.Accept._visible = true;
   var _loc1_ = false;
   if(nItemSelected > 0)
   {
      _loc1_ = true;
   }
   Panel.PrevItem._visible = _loc1_;
   Panel.PrevItem.SetText("#PreviousItem");
   var _loc2_ = false;
   if(nItemsCount > 1)
   {
      _loc2_ = true;
   }
   Panel.ItemXofX._visible = _loc2_;
   Panel.ItemXofX.CountText.htmlText = "(" + (nItemSelected + 1) + "/" + nItemsCount + ")";
   Panel.Trashcan._visible = false;
   Panel.OpenLoadout._visible = bShowOpenLoadoutButton;
   Panel.OpenLoadout.SetText("#OpenBackpack");
   if(nItemSelected + 1 < nItemsCount)
   {
      Panel.Accept.SetText("#NextItem");
      Panel.Accept.Action = NextItem;
   }
   else if(bReturnToGame)
   {
      Panel.Accept.SetText("#CloseItemPanel");
      Panel.Accept.Action = HideFromScript;
   }
   else
   {
      Panel.Accept.SetText("#ItemOkClose");
      Panel.Accept.Action = HideFromScript;
   }
   trace("szNewItemsStr = " + szNewItemsStr);
   Panel.NewItemText.htmlText = szNewItemsStr;
}
function SetItemInSlot(nSlot, bShouldHide, bShowDiscardedLabel, szFoundMethodText, nUsableByTeam, xuid, itemID)
{
   var _loc1_ = Panel.Item1;
   if(nSlot == 1)
   {
      _loc1_ = Panel.Item2;
   }
   else if(nSlot == 2)
   {
      _loc1_ = Panel.Item3;
   }
   else if(nSlot == 3)
   {
      _loc1_ = Panel.Item4;
   }
   trace("nSlot = " + nSlot + ", bShouldHide = " + bShouldHide);
   if(bShouldHide)
   {
      _loc1_._visible = false;
      return undefined;
   }
   _loc1_._visible = true;
   _loc1_.DiscardedText._visible = bShowDiscardedLabel;
   trace("szFoundMethodText = " + szFoundMethodText);
   _loc1_.FoundText.htmlText = szFoundMethodText;
   _loc1_.IconTeam_Both._visible = false;
   _loc1_.IconTeam_T._visible = nUsableByTeam == 2;
   _loc1_.IconTeam_CT._visible = nUsableByTeam == 3;
   _loc1_.ModelPanel.SetItemInfo(itemID,xuid);
   _loc1_.ModelPanel._visible = true;
   _loc1_.ItemData.TooltipItemGetInfo(xuid,itemID);
}
function SetUpButtons()
{
   Panel.OpenLoadout.Action = OpenLoadout;
   Panel.Accept.Action = HideFromScript;
   Panel.PrevItem.Action = PrevItem;
   Panel.Trashcan.Action = DiscardItem;
   Panel.CloseButton.Action = HideFromScript;
}
if(_global.itemPickupNav != undefined)
{
   return undefined;
}
var itemPickupNav = new Lib.NavLayout();
var navConfirmDelete = new Lib.NavLayout();
_global.resizeManager.AddListener(this);
stop();
