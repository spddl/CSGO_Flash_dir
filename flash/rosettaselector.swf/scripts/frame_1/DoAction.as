function onResize(rm)
{
   rm.DisableAdditionalScaling = true;
   rm.ResetPositionByPixel(Panel,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_CENTER_X,0,Lib.ResizeManager.ALIGN_CENTER,Lib.ResizeManager.REFERENCE_CENTER_Y,0,Lib.ResizeManager.ALIGN_CENTER);
}
function ShowRosetta(type)
{
   AcknowledgeSprays();
   if(type == "spray")
   {
      SetUpSpray();
   }
   showPanel();
}
function SetUpSpray()
{
   m_bEnableCursor = false;
   _global.CScaleformComponent_Inventory.SetInventorySortAndFilters(xuid,"newest",false,"spray,item_definition:spraypaint","");
   m_numTotalSprays = _global.CScaleformComponent_Inventory.GetInventoryCount();
   if(m_numTotalSprays < 1)
   {
      PlayerHasNoSprays();
      return undefined;
   }
   var _loc3_ = "spray0";
   var _loc2_ = _global.CScaleformComponent_Loadout.GetItemID(xuid,"noteam",_loc3_);
   if(_loc2_ == undefined || _loc2_ <= 0 || _loc2_ == "" || _loc2_ == null)
   {
      NoSprayEquipped();
      return undefined;
   }
   SetSprayStrings();
   MakeCoolDownTimer();
   LoadSprayIcon(Panel.SprayRosetta.SprayIcon,_loc2_);
   HasCoolDown();
   ShowInv();
   MakeCursorHintString();
}
function HideRosetta(type)
{
   hidePanel();
}
function showPanel()
{
   if(bVisible == false)
   {
      new Lib.Tween(Panel,"_alpha",mx.transitions.easing.Strong.easeOut,0,100,0.1,true);
      Panel._visible = true;
      bVisible = true;
      _global.navManager.PushLayout(rosettaNav,"rosettaNav");
   }
}
function PlayerHasNoSprays()
{
   clearInterval(m_TimerCanSprayCheck);
   Panel.SprayRosetta.SprayText.Value.htmlText = _global.GameInterface.Translate("#CSGO_No_Sprays");
   Panel.SprayRosetta.SprayText.Hint._visible = false;
   Panel.SprayRosetta.Countdown._visible = false;
   Panel.SprayRosetta.TimerBg._visible = true;
   Panel.SprayRosetta.SprayIcon._visible = false;
   Panel.Inventory._visible = false;
}
function NoSprayEquipped()
{
   clearInterval(m_TimerCanSprayCheck);
   Panel.SprayRosetta.SprayText.Value.htmlText = _global.GameInterface.Translate("#CSGO_No_Spray_Equipped");
   Panel.SprayRosetta.SprayText.Hint._visible = false;
   Panel.SprayRosetta.Countdown._visible = false;
   Panel.SprayRosetta.TimerBg._visible = true;
   Panel.SprayRosetta.SprayIcon._visible = false;
   ShowInv();
   MakeCursorHintString();
}
function MakeCursorHintString()
{
   var _loc3_ = _global.GameInterface.Translate(gameAPI.GetMouseEnableBindingName());
   var _loc2_ = _global.GameInterface.Translate("#CSGO_Spray_Cursor_Hint");
   _loc2_ = _global.ConstructString(_loc2_,_loc3_);
   Panel.NavHint.Hint.htmlText = _loc2_;
   if(m_bEnableCursor || !Panel.Inventory._visible || m_numTotalSprays == 1 && InvItemAndEquippedItemAretheSame(0))
   {
      Panel.NavHint._visible = false;
   }
   else
   {
      Panel.NavHint._visible = true;
   }
}
function hidePanel()
{
   if(bVisible == true)
   {
      Panel._visible = false;
      bVisible = false;
      _global.navManager.RemoveLayout(rosettaNav);
      _global.navManager.RemoveLayout(rosettaCursorNav);
   }
   clearInterval(m_TimerCanSprayCheck);
   gameAPI.FlashHide();
}
function onUnload(mc)
{
   delete _global.RosettaPanel;
   delete _global.RosettaPanelAPI;
   _global.resizeManager.RemoveListener(this);
   return true;
}
function onLoaded()
{
   gameAPI.OnReady();
}
function AcknowledgeSprays()
{
   var _loc4_ = _global.CScaleformComponent_Inventory.GetUnacknowledgeItemsCount();
   trace("----------------------------------------numItemCount--------------------------------" + _loc4_);
   if(_loc4_ > 0)
   {
      var _loc2_ = 0;
      while(_loc2_ < _loc4_)
      {
         trace("----------------------------------------strId--------------------------------" + strId);
         var strId = _global.CScaleformComponent_Inventory.GetUnacknowledgeItemByIndex(_loc2_);
         var _loc3_ = _global.CScaleformComponent_Inventory.DoesItemMatchDefinitionByName(xuid,strId,"spraypaint");
         trace("----------------------------------------bIsSpray--------------------------------" + _loc3_);
         if(_loc3_)
         {
            _global.CScaleformComponent_Inventory.AcknowledgeNewItembyItemID(xuid,strId);
         }
         _loc2_ = _loc2_ + 1;
      }
   }
}
function LoadImage(imagePath, objImage, numWidth, numHeight, bIsTint)
{
   var _loc2_ = new Object();
   _loc2_.onLoadInit = function(target_mc)
   {
      target_mc._width = numWidth;
      target_mc._height = numHeight;
   };
   _loc2_.onLoadError = function(target_mc, errorCode, status)
   {
      trace("Error loading item image: " + errorCode + " [" + status + "] ----- ");
   };
   var _loc3_ = imagePath;
   var _loc1_ = new MovieClipLoader();
   _loc1_.addListener(_loc2_);
   if(bIsTint)
   {
      _loc1_.loadClip(_loc3_,objImage.Tint);
   }
   else
   {
      _loc1_.loadClip(_loc3_,objImage.Image);
   }
}
function UseSpray()
{
   _global.CScaleformComponent_Loadout.ActionSpray(0);
}
function AnimOnAction()
{
   HideRosetta();
}
function HasCoolDown()
{
   var _loc2_ = _global.CScaleformComponent_Loadout.GetSprayCooldownRemaining(0);
   clearInterval(m_TimerCanSprayCheck);
   CanSpray();
   m_TimerCanSprayCheck = setInterval(CanSpray,180);
   if(_loc2_ >= 1)
   {
      AnimRoundTimer();
      return undefined;
   }
   Panel.SprayRosetta.TimerBg._visible = false;
   Panel.SprayRosetta.mcTimer._visible = false;
   Panel.SprayRosetta.Countdown._visible = false;
}
function CanSpray()
{
   var _loc2_ = Panel.SprayRosetta.SprayText.Hint;
   var _loc3_ = _global.CScaleformComponent_Loadout.GetSprayApplicationError();
   _loc2_._visible = !m_bEnableCursor && !Panel.SprayRosetta.Countdown._visible;
   if(_loc3_ != "" && _loc3_ != undefined && _loc3_ != null)
   {
      _loc2_.htmlText = _global.GameInterface.Translate(_loc3_ + "_Short");
      _loc2_.textColor = "0xFF0000";
      Panel.SprayRosetta.SprayIcon._visible = Panel.SprayRosetta.SprayIcon.bHasIcon;
      Panel.SprayRosetta.SprayIcon._alpha = 100;
   }
   else
   {
      _loc2_.htmlText = "#Attrib_SpraysHint";
      _loc2_.textColor = "0x40fd40";
      if(Panel.SprayRosetta.mcTimer._visible)
      {
         Panel.SprayRosetta.SprayIcon._visible = true;
      }
      else
      {
         Panel.SprayRosetta.SprayIcon._visible = false;
      }
   }
}
function LoadSprayIcon(SprayImage, ItemId)
{
   var _loc3_ = _global.CScaleformComponent_Inventory.GetItemInventoryImage(xuid,ItemId);
   SprayImage.Tint._visible = false;
   SprayImage.IconHolder.blendMode = "normal";
   if(_loc3_ != "" && _loc3_ != null && _loc3_ != undefined && _loc3_ != 0)
   {
      SprayImage.bHasIcon = true;
      trace("----------------------------ShowSprayImage--------------------------" + _loc3_);
      LoadImage(_loc3_ + ".png",SprayImage.IconHolder,128,96,false);
      var _loc4_ = _global.CScaleformComponent_Inventory.GetSprayTintColorCode(ItemId);
      if(_loc4_ != "" && _loc4_ != null && _loc4_ != undefined)
      {
         SprayImage.IconHolder.blendMode = "multiply";
         SetColor(_loc4_,SprayImage.Tint);
         LoadImage(_loc3_ + ".png",SprayImage,128,96,true);
         SprayImage.Tint._visible = true;
      }
      return undefined;
   }
   SprayImage._visible = false;
   SprayImage.bHasIcon = false;
}
function SetColor(strColor, ObjToTint)
{
   strColor = strColor.substring(1,strColor.length);
   strColor = "0x" + strColor;
   var _loc3_ = new Number(strColor);
   trace("***** ItemTile:  strColor *******" + strColor);
   var _loc2_ = new Color(ObjToTint);
   _loc2_.setRGB(_loc3_);
}
function SetSprayStrings()
{
   var _loc5_ = Panel.SprayRosetta.SprayText;
   var _loc6_ = "spray0";
   var _loc3_ = _global.CScaleformComponent_Loadout.GetItemID(xuid,"noteam",_loc6_);
   var _loc4_ = _global.CScaleformComponent_Inventory.GetItemAttributeValue(xuid,_loc3_,"sprays remaining");
   var _loc2_ = _global.GameInterface.Translate("#Attrib_SpraysRemaining");
   _loc2_ = _global.ConstructString(_loc2_,_loc4_);
   _loc5_.Value.htmlText = _loc2_;
}
function MakeCoolDownTimer()
{
   var _loc2_ = Panel.SprayRosetta.CountDown;
   _loc2_._visible = false;
   Panel.SprayRosetta.TimerBg._visible = false;
   if(Panel.SprayRosetta.mcTimer)
   {
      Panel.SprayRosetta.mcTimer._visible = false;
      return undefined;
   }
   var _loc1_ = Panel.SprayRosetta.createEmptyMovieClip("mcTimer",Panel.SprayRosetta.getNextHighestDepth());
   _loc1_._x = Panel.SprayRosetta.TimerBg._width / 2 + Panel.SprayRosetta.TimerBg._x - 1;
   _loc1_._y = Panel.SprayRosetta.TimerBg._height / 2 + Panel.SprayRosetta.TimerBg._y - 1;
   _loc1_._rotation = -90;
   _loc1_._alpha = 30;
   _loc1_.blendMode = "add";
   _loc1_._visible = false;
   Panel.Blocker.onRollOver = function()
   {
   };
}
function AnimRoundTimer()
{
   var mcTimer = Panel.SprayRosetta.mcTimer;
   var mcCountDown = Panel.SprayRosetta.Countdown;
   var coolDown = 0;
   var _loc3_ = m_ApplyCoolDownMax;
   Panel.Blocker._visible = true;
   mcTimer._visible = true;
   mcCountDown._visible = true;
   Panel.SprayRosetta.SprayText.Hint._visible = false;
   Panel.SprayRosetta.TimerBg._visible = true;
   mcTimer.onEnterFrame = function()
   {
      coolDown = _global.CScaleformComponent_Loadout.GetSprayCooldownRemaining(0);
      if(coolDown <= 0)
      {
         Panel.SprayRosetta.TimerBg._visible = false;
         mcTimer._visible = false;
         mcCountDown._visible = false;
         delete mcTimer.onEnterFrame;
      }
      else
      {
         var _loc2_ = Math.ceil(coolDown);
         UpdateCoolDown(coolDown);
         UpdateTimerCountdown(_loc2_);
      }
   };
}
function UpdateCoolDown(coolDown)
{
   var _loc3_ = Panel.SprayRosetta.mcTimer;
   var _loc6_ = 6.283185307179586;
   var _loc5_ = 0.017453292519943295;
   var _loc7_ = -5;
   var _loc2_ = Panel.SprayRosetta.TimerBg._width / 2 + _loc7_;
   var _loc4_ = 360 * ((m_CoolDownMax - coolDown) / m_CoolDownMax);
   _loc4_ = _loc4_ * _loc5_;
   _loc3_.clear();
   _loc3_.lineStyle(1);
   _loc3_.beginFill(10066329);
   _loc3_.lineTo(_loc2_,0);
   var _loc1_ = _loc6_;
   while(_loc1_ > _loc4_)
   {
      _loc3_.lineTo(Math.cos(_loc1_) * _loc2_,Math.sin(_loc1_) * _loc2_);
      _loc1_ = _loc1_ - _loc5_;
   }
   _loc3_.lineTo(0,0);
   _loc3_.endFill();
}
function UpdateTimerCountdown(coolDown)
{
   var _loc2_ = Panel.SprayRosetta.Countdown;
   if(coolDown != m_CurrentCountDownValue)
   {
      m_CurrentCountDownValue = coolDown;
      _loc2_.Text.htmlText = "<i>" + coolDown + "</i>";
   }
}
function ShowInv()
{
   if(m_numTotalSprays >= 1)
   {
      Panel.Inventory._alpha = 100;
      Panel.Inventory._visible = true;
      ResetPages(m_numTotalSprays);
      SetItems(xuid);
      Panel.Inventory.ButtonNext.dialog = this;
      Panel.Inventory.ButtonNext.Action = function()
      {
         InvNext();
      };
      Panel.Inventory.ButtonPrev.dialog = this;
      Panel.Inventory.ButtonPrev.Action = function()
      {
         InvPrev();
      };
      EnableDisablePageBtns();
      return undefined;
   }
   Panel.Inventory._visible = false;
}
function SetItems()
{
   var _loc3_ = 0;
   while(_loc3_ < m_numItemTiles)
   {
      if(_loc3_ == 0)
      {
         if(m_numTotalSprays == 1)
         {
            Panel.Inventory["Item" + _loc3_]._x = m_TilePos + Panel.Inventory["Item" + _loc3_]._width * 2 - Panel.Inventory["Item" + _loc3_]._width / 2;
         }
         else if(m_numTotalSprays == 2)
         {
            Panel.Inventory["Item" + _loc3_]._x = m_TilePos + Panel.Inventory["Item" + _loc3_]._width;
         }
         else if(m_numTotalSprays == 3)
         {
            Panel.Inventory["Item" + _loc3_]._x = m_TilePos + Panel.Inventory["Item" + _loc3_]._width / 2;
         }
         else
         {
            Panel.Inventory["Item" + _loc3_]._x = m_TilePos;
         }
      }
      else
      {
         Panel.Inventory["Item" + _loc3_]._x = Panel.Inventory["Item" + (_loc3_ - 1)]._width + Panel.Inventory["Item" + (_loc3_ - 1)]._x;
      }
      var _loc4_ = Panel.Inventory["Item" + _loc3_];
      if(_loc3_ + m_numActiveIndex >= m_numTotalSprays)
      {
         _loc4_._visible = false;
      }
      else
      {
         var _loc5_ = _global.CScaleformComponent_Inventory.GetInventoryItemIDByIndex(m_numActiveIndex + _loc3_);
         var _loc6_ = _global.CScaleformComponent_Inventory.GetItemName(xuid,_loc5_);
         var _loc8_ = _global.CScaleformComponent_Inventory.GetItemRarityColor(xuid,_loc5_);
         _loc6_ = SeperateName(_loc6_);
         _loc4_.Text.Name.htmlText = "<font color=\'" + _loc8_ + "\'>" + _loc6_ + "</font>";
         _global.AutosizeTextDown(_loc4_.Text.Name,10);
         var _loc9_ = _global.CScaleformComponent_Inventory.GetItemAttributeValue(xuid,_loc5_,"sprays remaining");
         var _loc7_ = _global.GameInterface.Translate("#Attrib_SpraysRemaining");
         _loc7_ = _global.ConstructString(_loc7_,_loc9_);
         _loc4_.Text.Value.htmlText = _loc7_;
         _global.AutosizeTextDown(_loc4_.Text.Value,10);
         LoadSprayIcon(_loc4_.Image,_loc5_);
         _loc4_.dialog = this;
         _loc4_._visible = true;
         _loc4_._Id = _loc5_;
         _loc4_.Action = function()
         {
            EquipInSlot(this);
         };
         trace("-----------------------------EquippedItemId-------------------------" + EquippedItemId);
         trace("-----------------------------strId-------------------------" + _loc5_);
         _loc4_.setDisabled(InvItemAndEquippedItemAretheSame(_loc3_ + m_numActiveIndex));
         new Lib.Tween(_loc4_,"_alpha",mx.transitions.easing.Strong.easeOut,0,100,2,true);
      }
      _loc3_ = _loc3_ + 1;
   }
}
function SeperateName(strName)
{
   if(strName.indexOf("|  ") != -1)
   {
      var _loc2_ = strName.split("|  ",2);
   }
   else if(strName.indexOf("| ") != -1)
   {
      _loc2_ = strName.split("| ",2);
   }
   else
   {
      _loc2_ = new Array(strName);
   }
   if(_loc2_.length == 1)
   {
      return _loc2_[0];
   }
   return _loc2_[1];
}
function EquipInSlot(Item)
{
   _global.CScaleformComponent_Loadout.EquipItemInSlot("noteam",Item._Id,"spray0");
   OnShowCursorBindingPressed();
   SetUpSpray();
}
function InvNext()
{
   m_numActiveIndex = m_numActiveIndex + m_numItemTiles;
   m_numPage++;
   EnableDisablePageBtns();
   SetItems();
}
function InvPrev()
{
   m_numActiveIndex = m_numActiveIndex - m_numItemTiles;
   m_numPage--;
   EnableDisablePageBtns();
   SetItems();
}
function ResetPages(numSprayCount)
{
   var _loc1_ = Math.ceil(numSprayCount / m_numItemTiles);
   trace("-------------numSprayCount---------" + numSprayCount);
   trace("-------------m_numItemTiles---------" + m_numItemTiles);
   trace("-------------numCurrentPage---------" + _loc1_);
   trace("-------------m_numPage---------" + m_numPage);
   if(_loc1_ < m_numPage)
   {
      m_numPage = 1;
      m_numActiveIndex = 0;
   }
}
function EnableDisablePageBtns()
{
   var _loc1_ = Math.ceil(m_numTotalSprays / m_numItemTiles);
   if(m_numPage >= _loc1_)
   {
      Panel.Inventory.ButtonNext._visible = false;
   }
   else
   {
      Panel.Inventory.ButtonNext._visible = true;
   }
   if(m_numPage <= 1)
   {
      Panel.Inventory.ButtonPrev._visible = false;
   }
   else
   {
      Panel.Inventory.ButtonPrev._visible = true;
   }
}
function InvItemAndEquippedItemAretheSame(index)
{
   var _loc2_ = _global.CScaleformComponent_Loadout.GetItemID(xuid,"noteam","spray0");
   var _loc3_ = _global.CScaleformComponent_Inventory.GetInventoryItemIDByIndex(index);
   if(_loc2_ == _loc3_)
   {
      return true;
   }
   return false;
}
function OnShowCursorBindingPressed(bindingName)
{
   var _loc2_ = _global.CScaleformComponent_Loadout.GetItemID(xuid,"noteam","slot0");
   if(!m_bEnableCursor && m_numTotalSprays >= 1)
   {
      if(m_numTotalSprays == 1 && InvItemAndEquippedItemAretheSame(0))
      {
         return undefined;
      }
      m_bEnableCursor = true;
      Panel.NavHint._visible = false;
      Panel.Inventory._alpha = 100;
      _global.navManager.RemoveLayout(rosettaNav);
      _global.navManager.PushLayout(rosettaCursorNav,"rosettaCursorNav");
      return undefined;
   }
   trace("-------------m_numPage---------" + m_numPage);
   m_bEnableCursor = false;
   _global.navManager.RemoveLayout(rosettaCursorNav);
   _global.navManager.PushLayout(rosettaNav,"rosettaNav");
}
_global.RosettaSelctor = this;
_global.RosettaSelctorAPI = gameAPI;
_global.resizeManager.AddListener(this);
var rosettaNav = new Lib.NavLayout();
var rosettaCursorNav = new Lib.NavLayout();
var bVisible = false;
var m_CoolDownMax = _global.CScaleformComponent_Loadout.GetSprayCooldownSetting();
var m_bIsSpraySelected = false;
var m_CurrentCountDownValue = 0;
var m_ApplyCoolDownMax = 15;
var m_numItemTiles = 4;
var m_numTotalSprays = 0;
var m_numActiveIndex = 0;
var m_numPage = 1;
var xuid = _global.CScaleformComponent_MyPersona.GetXuid();
var m_numHintStartPos = Panel.SprayRosetta.SprayText.Hint._y;
var m_bEnableCursor = false;
var m_TimerCanSprayCheck;
var m_TilePos = 345;
rosettaNav.DenyInputToGame(false);
rosettaNav.ShowCursor(false);
rosettaNav.DisableAnalogStickNavigation(true);
rosettaCursorNav.DenyInputToGame(false);
rosettaCursorNav.ShowCursor(true);
rosettaCursorNav.DisableAnalogStickNavigation(true);
Panel._visible = false;
stop();
