function onResize(rm)
{
   rm.DisableAdditionalScaling = true;
   rm.ResetPositionByPixel(Panel,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_CENTER_X,0,Lib.ResizeManager.ALIGN_CENTER,Lib.ResizeManager.REFERENCE_CENTER_Y,0,Lib.ResizeManager.ALIGN_CENTER);
}
function TryBuyFunction(fn)
{
   if(_global.BuyMenu != Undefined && _global.BuyMenu != Null && _global.BuyMenu.isVisible)
   {
      fn();
   }
}
function onUnload(mc)
{
   delete _global.BuyMenu;
   delete _global.BuyMenuAPI;
   _global.resizeManager.RemoveListener(this);
   _global.navManager.RemoveLayout(buyNav);
   _global.tintManager.DeregisterAll(this);
   return true;
}
function applyHotKeys()
{
   var _loc2_ = 0;
   while(_loc2_ < numSlices)
   {
      if(_global.wantControllerShown)
      {
         pieSlices[_loc2_].PieKey._visible = false;
      }
      else
      {
         pieSlices[_loc2_].PieKey._visible = true;
         pieSlices[_loc2_].PieKey.NumberMovie.NumberText.text = (_loc2_ + 1).toString();
      }
      _loc2_ = _loc2_ + 1;
   }
}
function UpdateNavString()
{
   trace("UpdateNavString");
   if(_global.BuyMenu.currentMenu.menuType == "parent")
   {
      _global.BuyMenu.Panel.Panel.NavigationMaster.ControllerNavl.NavLabel.ConfirmOrCancel.htmlText = "#SFUI_BuyMenu_Help_Select@15";
   }
   else
   {
      _global.BuyMenu.Panel.Panel.NavigationMaster.ControllerNavl.NavLabel.ConfirmOrCancel.htmlText = "#SFUI_BuyMenu_Help_Buy@15";
   }
}
function setUIDevice()
{
   applyHotKeys();
   if(_global.wantControllerShown)
   {
      _global.BuyMenu.UpdateNavString();
      _global.BuyMenu.Panel.Panel.NavigationMaster.gotoAndStop("ShowController");
   }
   else
   {
      _global.BuyMenu.Panel.Panel.NavigationMaster.gotoAndStop("HideController");
   }
}
function changeUIDevice()
{
   applyHotKeys();
   if(_global.wantControllerShown)
   {
      _global.BuyMenu.UpdateNavString();
      _global.BuyMenu.Panel.Panel.NavigationMaster.gotoAndPlay("StartShowController");
   }
   else
   {
      _global.BuyMenu.Panel.Panel.NavigationMaster.gotoAndPlay("StartHideController");
   }
}
function setRadialPanel(paneldata)
{
   if(radialPanel != paneldata.radialPanel)
   {
      radialPanel._visible = false;
      radialPanel = paneldata.radialPanel;
      pieSlices = paneldata.pieSlices;
      centerTextY = paneldata.centerTextY;
      centerTextX = paneldata.centerTextX;
      numSlices = paneldata.numSlices;
      var _loc1_ = 0;
      while(_loc1_ < numSlices)
      {
         pieSlices[_loc1_].exitHighlight(null);
         _loc1_ = _loc1_ + 1;
      }
      radialPanel._visible = true;
      applyHotKeys();
   }
}
function initRadialPanel(paneldata)
{
   radialPanel = paneldata.radialPanel;
   pieSlices = paneldata.pieSlices;
   numSlices = paneldata.numSlices;
   showTeamIcon();
   pieSlices.push(radialPanel.RadialWedge1);
   radialPanel.RadialWedge1.Action = function()
   {
      _global.BuyMenu.slicePressed(0);
   };
   radialPanel.RadialWedge1.RolledOver = function()
   {
      _global.BuyMenu.setMouseWedgeHighlight(0);
   };
   radialPanel.RadialWedge1.RolledOut = function()
   {
      _global.BuyMenu.setMouseWedgeHighlight(-1);
   };
   pieSlices.push(radialPanel.RadialWedge2);
   radialPanel.RadialWedge2.Action = function()
   {
      _global.BuyMenu.slicePressed(1);
   };
   radialPanel.RadialWedge2.RolledOver = function()
   {
      _global.BuyMenu.setMouseWedgeHighlight(1);
   };
   radialPanel.RadialWedge2.RolledOut = function()
   {
      _global.BuyMenu.setMouseWedgeHighlight(-1);
   };
   pieSlices.push(radialPanel.RadialWedge3);
   radialPanel.RadialWedge3.Action = function()
   {
      _global.BuyMenu.slicePressed(2);
   };
   radialPanel.RadialWedge3.RolledOver = function()
   {
      _global.BuyMenu.setMouseWedgeHighlight(2);
   };
   radialPanel.RadialWedge3.RolledOut = function()
   {
      _global.BuyMenu.setMouseWedgeHighlight(-1);
   };
   pieSlices.push(radialPanel.RadialWedge4);
   radialPanel.RadialWedge4.Action = function()
   {
      _global.BuyMenu.slicePressed(3);
   };
   radialPanel.RadialWedge4.RolledOver = function()
   {
      _global.BuyMenu.setMouseWedgeHighlight(3);
   };
   radialPanel.RadialWedge4.RolledOut = function()
   {
      _global.BuyMenu.setMouseWedgeHighlight(-1);
   };
   if(numSlices > 4)
   {
      pieSlices.push(radialPanel.RadialWedge5);
      radialPanel.RadialWedge5.Action = function()
      {
         _global.BuyMenu.slicePressed(4);
      };
      radialPanel.RadialWedge5.RolledOver = function()
      {
         _global.BuyMenu.setMouseWedgeHighlight(4);
      };
      radialPanel.RadialWedge5.RolledOut = function()
      {
         _global.BuyMenu.setMouseWedgeHighlight(-1);
      };
      pieSlices.push(radialPanel.RadialWedge6);
      radialPanel.RadialWedge6.Action = function()
      {
         _global.BuyMenu.slicePressed(5);
      };
      radialPanel.RadialWedge6.RolledOver = function()
      {
         _global.BuyMenu.setMouseWedgeHighlight(5);
      };
      radialPanel.RadialWedge6.RolledOut = function()
      {
         _global.BuyMenu.setMouseWedgeHighlight(-1);
      };
   }
   var _loc2_ = 0;
   while(_loc2_ < numSlices)
   {
      pieSlices[_loc2_].WeaponIcon.originalX = pieSlices[_loc2_].WeaponIcon._x;
      pieSlices[_loc2_].WeaponIcon.originalY = pieSlices[_loc2_].WeaponIcon._y;
      _loc2_ = _loc2_ + 1;
   }
   centerTextY = radialPanel.CategoryText._y;
   centerTextX = radialPanel.CategoryText._x + radialPanel.CategoryText._width / 2;
   paneldata.centerTextY = centerTextY;
   paneldata.centerTextX = centerTextX;
}
function showTeamIcon()
{
   Panel.Panel.TeamIcon_T._visible = false;
   Panel.Panel.TeamIcon_CT._visible = false;
   var _loc2_ = _global.GameInterface.GetConvarNumber("player_teamplayedlast") == _global.TeamID_CounterTerrorist;
   if(_loc2_)
   {
      Panel.Panel.TeamIcon_CT._visible = true;
   }
   else
   {
      Panel.Panel.TeamIcon_T._visible = true;
   }
}
function onLoaded()
{
   radialPanelData4.radialPanel = Panel.Panel.RadialPanel4;
   radialPanelData4.pieSlices = new Array();
   radialPanelData4.numSlices = 4;
   initRadialPanel(radialPanelData4);
   applyHotKeys();
   radialPanelData6.radialPanel = Panel.Panel.RadialPanel6;
   radialPanelData6.pieSlices = new Array();
   radialPanelData6.numSlices = 6;
   initRadialPanel(radialPanelData6);
   applyHotKeys;
   radialPanelData4.radialPanel._visible = false;
   _global.BuyMenu.Panel.Panel.NavigationMaster.PCButtons.AutoBuy.Action = function()
   {
      TryBuyFunction(function()
      {
         _global.BuyMenuAPI.Autobuy();
      }
      );
   };
   _global.BuyMenu.Panel.Panel.NavigationMaster.PCButtons.BuyPrevious.Action = function()
   {
      TryBuyFunction(function()
      {
         _global.BuyMenuAPI.BuyPrevious();
      }
      );
   };
   trace(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>gameAPI.AreWeaponsFree():" + gameAPI.AreWeaponsFree());
   if(gameAPI.AreWeaponsFree())
   {
      _global.BuyMenu.Panel.Panel.NavigationMaster.PCButtons.BuyPrevious.SetText("#SFUI_BuyMenu_Buyprev_dm");
      _global.BuyMenu.Panel.Panel.NavigationMaster.PCButtons.AutoBuy.SetText("#SFUI_BuyMenu_BuyRandom");
   }
   else
   {
      _global.BuyMenu.Panel.Panel.NavigationMaster.PCButtons.BuyPrevious.SetText("#SFUI_BuyMenu_Buyprev");
      _global.BuyMenu.Panel.Panel.NavigationMaster.PCButtons.AutoBuy.SetText("#SFUI_BuyMenu_Autobuy");
   }
   _global.BuyMenu.Panel.Panel.NavigationMaster.PCButtons.Done.Action = function()
   {
      gameAPI.OnCancel();
   };
   _global.BuyMenu.Panel.Panel.NavigationMaster.PCButtons.Done.SetText("#SFUI_BuyMenu_Done");
   loadoutPanel = Panel.Panel.PanelLoadOut;
   loadoutPanel._visible = false;
   invPanel = Panel.Panel.PanelInventory;
   invPanel._visible = true;
   var _loc2_ = 0;
   while(_loc2_ < 8)
   {
      loadoutEntries.push(loadoutPanel["LoadOutWeapon" + _loc2_]);
      loadoutEntries[_loc2_].WeaponIcon.originalX = loadoutEntries[_loc2_].WeaponIcon._x;
      loadoutEntries[_loc2_].WeaponIcon.originalY = loadoutEntries[_loc2_].WeaponIcon._y;
      _loc2_ = _loc2_ + 1;
   }
   _loc2_ = 0;
   while(_loc2_ < 7)
   {
      inventoryEntries.push(invPanel["InvWeapon" + _loc2_]);
      _loc2_ = _loc2_ + 1;
   }
   weaponPanel = Panel.Panel.PanelWeapon;
   weaponPanel._visible = false;
   weaponPanel.WeaponIcon.originalX = weaponPanel.WeaponIcon._x;
   weaponPanel.WeaponIcon.originalY = weaponPanel.WeaponIcon._y;
   descriptionPanel = Panel.Panel.PanelDescription;
   descriptionPanel._visible = false;
   trace("onLoaded:SetShowWeaponModel( -1 )");
   gameAPI.SetShowWeaponModel(-1);
   descriptionPanel.WeaponIcon.originalX = descriptionPanel.WeaponIcon._x;
   descriptionPanel.WeaponIcon.originalY = descriptionPanel.WeaponIcon._y;
   loadoutString = _global.GameInterface.Translate("#SFUI_BuyMenu_LoadoutNumber");
   helpText = Panel.Panel.ConfirmOrCancel;
   timerBlock = Panel.Panel.Timer;
   timerText = timerBlock.Time;
   timerDescription = timerBlock.Money;
   var _loc4_ = _global.GameInterface.GetConvarNumber("game_type");
   var _loc3_ = _global.GameInterface.GetConvarNumber("game_mode");
   if(_loc4_ == 1 && _loc3_ == 2)
   {
      timerDescription.htmlText = "#SFUI_BuyMenu_ImmunityTimerText";
   }
   setUIDevice();
   setRadialPanel(radialPanelData6);
   gameAPI.OnReady();
}
function getDataFromConfig(initData)
{
   if(initData != undefined && initData != null)
   {
      if(typeof initData == "object")
      {
         for(var _loc3_ in initData)
         {
            if(_loc3_ == "casual" && !_global.GameInterface.GetConvarBoolean("mp_forcecamera"))
            {
               return getDataFromConfig(initData[_loc3_]);
            }
            if(_loc3_ == "competitive" && _global.GameInterface.GetConvarBoolean("mp_forcecamera"))
            {
               return getDataFromConfig(initData[_loc3_]);
            }
            if(_loc3_ == "ct_hostage" && playerIsCT && isHostageMatch)
            {
               return getDataFromConfig(initData[_loc3_]);
            }
            if(_loc3_ == "ct" && playerIsCT)
            {
               return getDataFromConfig(initData[_loc3_]);
            }
            if(_loc3_ == "t" && !playerIsCT)
            {
               return getDataFromConfig(initData[_loc3_]);
            }
         }
      }
   }
   return initData;
}
function debugDumpLoadout(loadout)
{
   var _loc3_ = loadout.weapons;
   var _loc5_ = loadout.counts;
   trace("*******************************");
   _global.TraceObject(loadout);
   if(loadout.primary != undefined)
   {
      trace(" Primary - " + gameAPI.GetWeaponShortNameFromID(_loc3_[loadout.primary]));
   }
   if(loadout.secondary != undefined)
   {
      trace(" Secondary - " + gameAPI.GetWeaponShortNameFromID(_loc3_[loadout.secondary]));
   }
   if(loadout.taser != undefined)
   {
      trace(" Taser - " + gameAPI.GetWeaponShortNameFromID(_loc3_[loadout.taser]));
   }
   var _loc2_ = 0;
   while(_loc2_ < _loc3_.length)
   {
      _loc2_ = _loc2_ + 1;
   }
}
function InvalidateWeapon(pos)
{
   var _loc1_ = weaponDB[pos];
   if(_loc1_ == undefined && weapon != undefined)
   {
      weaponDB[pos] = undefined;
   }
   initSlices();
}
function GetWeapon(pos)
{
   var _loc1_ = undefined;
   trace("GetWeapon:: pos = " + pos);
   if(pos > -1 && pos != undefined && pos != "")
   {
      _loc1_ = weaponDB[pos];
      if(_loc1_ == undefined)
      {
         _loc1_ = gameAPI.InitWeapon(pos);
         if(_loc1_ != undefined)
         {
            weaponDB[pos] = _loc1_;
         }
      }
      trace("GetWeapon:: _ pos _ = " + pos);
   }
   return _loc1_;
}
function GetWeaponPrice(pos)
{
   var _loc1_ = GetWeapon(pos);
   if(_loc1_.weaponType == "taser")
   {
      return _loc1_.price;
   }
   if(_loc1_.weaponType == "equipment")
   {
      return gameAPI.GetWeaponPriceFromIDScript(_loc1_.wepid);
   }
   return gameAPI.GetWeaponPriceScript(pos);
}
function GetWeaponName(pos)
{
   var _loc1_ = undefined;
   var _loc2_ = GetWeapon(pos);
   if(_loc2_.weaponType == "taser" || _loc2_.weaponType == "equipment")
   {
      _loc1_ = _loc2_.name;
   }
   else
   {
      _loc1_ = gameAPI.GetWeaponName(pos);
   }
   trace("GetWeaponName:: result = " + _loc1_);
   if(_loc1_ == undefined || _loc1_ == null)
   {
      _loc1_ = "unnamed";
   }
   return _loc1_;
}
function getCarryLimit(name)
{
   return gameAPI.GetCarryLimit(name);
}
function canAquireWeapon(name, pos)
{
   return gameAPI.CanAcquire(name,pos);
}
function CanPurchaseWeapon(weaponName, weaponPosition)
{
   if(currentPlayerLoadout == undefined)
   {
      return true;
   }
   if(gameAPI.AreWeaponsFree())
   {
      return true;
   }
   var _loc2_ = getDataFromConfig(weaponName);
   var _loc1_ = getDataFromConfig(weaponPosition);
   if(_loc1_ < 0)
   {
      return false;
   }
   trace("CanPurchaseWeapon() name = " + _loc2_ + ", pos = " + _loc1_ + ", weaponName = " + weaponName + ", pos = " + _loc1_);
   if(GetWeaponPrice(_loc1_) > playerCash)
   {
      return false;
   }
   if(canAquireWeapon(_loc2_,_loc1_) != Lib.AcquireResult.CanAcquire)
   {
      return false;
   }
   return true;
}
function WeaponInLoadout(pos)
{
   var _loc2_ = currentPlayerLoadout.weapons_position;
   var _loc1_ = 0;
   while(_loc1_ < _loc2_.length)
   {
      if(weaponList[_loc1_] == pos)
      {
         return true;
      }
      _loc1_ = _loc1_ + 1;
   }
   return false;
}
function showPanel()
{
   trace(" showPanel ");
   if(!isVisible)
   {
      currentPlayerLoadout = gameAPI.GetPlayerLoadout();
      menuData = gameAPI.GetPlayerBuyMenuLoadout();
      var _loc3_ = _global.BuyMenu.Panel.Panel.NavigationMaster.PCButtons;
      _loc3_.AutoBuy.setGfxState(Lib.Controls.SFButton.BUTTON_STATE_UP);
      _loc3_.BuyPrevious.setGfxState(Lib.Controls.SFButton.BUTTON_STATE_UP);
      _loc3_.Done.setGfxState(Lib.Controls.SFButton.BUTTON_STATE_UP);
      setMenu(menuData.MainMenu);
      Panel.gotoAndPlay("StartShow");
      _global.navManager.PushLayout(buyNav,"buyNav");
      setWedgeHighlight(-1,-1);
      isVisible = true;
      var _loc2_ = 0;
      while(_loc2_ < numSlices)
      {
         pieSlices[_loc2_].exitHighlight(null);
         _loc2_ = _loc2_ + 1;
      }
      resetColors();
   }
   showTeamIcon();
   updatePlayerInventory(currentPlayerLoadout);
}
function hidePanelAndRemove()
{
   if(isVisible)
   {
      removeAfterHiding = true;
      hidePanel();
   }
   else
   {
      _global.RemoveElement(this);
   }
   var _loc3_ = _global.MoneyPanel;
   if(_loc3_ != undefined && _loc3_ != null)
   {
      _loc3_.setYPositionFromRadar();
   }
}
function hidePanel()
{
   if(isVisible)
   {
      Panel.gotoAndPlay("StartHide");
      _global.navManager.RemoveLayout(buyNav);
      isVisible = false;
   }
   var _loc2_ = _global.MoneyPanel;
   if(_loc2_ != undefined && _loc2_ != null)
   {
      _loc2_.setYPositionFromRadar();
   }
}
function setWedgeHighlight(wedgeIndex4, wedgeIndex6)
{
   trace("setWedgeHighlight");
   current4SliceIndex = wedgeIndex4;
   current6SliceIndex = wedgeIndex6;
   currentSliceIndex = numSlices != 4?current6SliceIndex:current4SliceIndex;
   if(currentSliceIndex == -1 || currentSliceIndex >= currentMenu.Slices.length || pieSlices[currentSliceIndex].invalidName)
   {
      _global.navManager.SetHighlightedObject(null);
   }
   else
   {
      _global.navManager.SetHighlightedObject(pieSlices[currentSliceIndex]);
      if(currentMenu.Slices[currentSliceIndex].InfoText != undefined)
      {
         if(Panel.Panel.InfoText._active == false)
         {
            Panel.Panel.InfoText.gotoAndPlay("StartShow");
         }
         trace(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>  Panel.Panel.InfoText.Text.SetText(currentMenu.Slices[currentSliceIndex].InfoText) ");
         Panel.Panel.InfoText.Text.SetText(currentMenu.Slices[currentSliceIndex].InfoText);
      }
      else if(Panel.Panel.InfoText._active)
      {
         Panel.Panel.InfoText.gotoAndPlay("StartHide");
      }
   }
   showSliceInfo(currentSliceIndex);
}
function setMouseWedgeHighlight(wedgeIndex)
{
   trace("setMouseWedgeHighlight = " + wedgeIndex);
   var _loc4_ = undefined;
   var _loc3_ = undefined;
   if(wedgeIndex == -1)
   {
      _loc4_ = -1;
      _loc3_ = -1;
   }
   else
   {
      var _loc2_ = {x:_xmouse,y:_ymouse};
      radialPanel.globalToLocal(_loc2_);
      _loc2_.x = _loc2_.x - centerTextX;
      _loc2_.y = _loc2_.y - centerTextY;
      var _loc9_ = undefined;
      var _loc1_ = Math.atan2(_loc2_.x,- _loc2_.y) * 57.29579143313326;
      if(_loc1_ < 0)
      {
         _loc1_ = 360 + _loc1_;
      }
      if(numSlices == 4)
      {
         _loc4_ = wedgeIndex;
         _loc1_ = _loc1_ / 60;
         var _loc5_ = _loc1_ - Math.floor(_loc1_);
         if(_loc5_ > 0.965 || _loc5_ < 0.035)
         {
            _loc3_ = -1;
         }
         else
         {
            _loc3_ = Math.floor(Math.floor(_loc1_) + 1) % 6;
         }
      }
      else
      {
         _loc3_ = wedgeIndex;
         _loc1_ = _loc1_ / 45;
         _loc5_ = _loc1_ - Math.floor(_loc1_);
         if(_loc5_ > 0.965 || _loc5_ < 0.035)
         {
            _loc4_ = -1;
         }
         else
         {
            _loc4_ = Math.floor((Math.floor(_loc1_) + 1) / 2) % 4;
         }
      }
   }
   setWedgeHighlight(_loc4_,_loc3_);
}
function setPlayerIsCT(value)
{
   playerIsCT = value;
}
function setIsHostageMatch(value)
{
   isHostageMatch = value;
}
function setPlayerCash(value)
{
   playerCash = value;
   Panel.Panel.Money.SetText("$" + value);
   resetColors();
}
function setBuyTimeLeft(timeLeft, vis)
{
   if(timeLeft > 5)
   {
      timerText._visible = true;
   }
   else
   {
      timerText._visible = vis;
   }
   if(timerText._visible)
   {
      var _loc1_ = new flash.geom.ColorTransform();
      if(timeLeft < 10)
      {
         timerText.htmlText = "0" + timeLeft;
      }
      else
      {
         timerText.htmlText = timeLeft;
      }
      if(timeLeft > 10)
      {
         _loc1_.ra = 100;
         _loc1_.rb = 0;
         _loc1_.ba = 100;
         _loc1_.bb = 0;
         _loc1_.ga = 100;
         _loc1_.gb = 0;
         _loc1_.aa = 100;
         _loc1_.ab = 0;
      }
      else
      {
         _loc1_.rgb = 16711680;
      }
      var _loc3_ = new flash.geom.Transform(timerBlock);
      _loc3_.colorTransform = _loc1_;
   }
}
function resetColors()
{
   resetSliceTextColors();
   resetSliceColorsByChildren();
}
function resetSliceHighlightColor()
{
}
function resetSliceColorsByChildren()
{
   trace("resetSliceColorsByChildren");
   var _loc11_ = currentMenu.Slices;
   var _loc5_ = 0;
   while(_loc5_ < numSlices)
   {
      var _loc2_ = getDataFromConfig(_loc11_[_loc5_].sliceType);
      if(_loc2_ == "subMenu")
      {
         var _loc10_ = menuData[getDataFromConfig(_loc11_[_loc5_].subMenu)];
         var _loc7_ = _loc10_.Slices;
         var _loc8_ = _loc7_.length;
         var _loc4_ = false;
         var _loc3_ = 0;
         while(_loc3_ < _loc8_)
         {
            var _loc1_ = _loc7_[_loc3_];
            _loc2_ = getDataFromConfig(_loc1_.sliceType);
            if(_loc2_ == "weapon" || _loc2_ == "equipment")
            {
               var _loc9_ = getWeaponNameFromConfig(_loc1_);
               if(CanPurchaseWeapon(_loc1_.weapon,_loc1_.weapon_position))
               {
                  _loc4_ = true;
                  break;
               }
            }
            else if(_loc2_ == "loadout")
            {
               var _loc6_ = gameAPI.GetPredefinedLoadout(_loc1_.index);
               trace("-------------------------- GetPredefinedLoadout ");
               if(_loc6_.price <= playerCash)
               {
                  _loc4_ = true;
                  break;
               }
            }
            _loc3_ = _loc3_ + 1;
         }
         if(!_loc4_)
         {
            color = new flash.geom.ColorTransform();
            color.rgb = 13185313;
            xform = new flash.geom.Transform(pieSlices[_loc5_].WeaponName);
            xform.colorTransform = color;
         }
      }
      _loc5_ = _loc5_ + 1;
   }
}
function resetSliceTextColors()
{
   var _loc6_ = undefined;
   var _loc13_ = undefined;
   var _loc2_ = undefined;
   var _loc4_ = undefined;
   var _loc5_ = undefined;
   var _loc14_ = undefined;
   var _loc7_ = 0;
   while(_loc7_ < numSlices)
   {
      _loc6_ = pieSlices[_loc7_];
      _loc5_ = currentMenu.Slices[_loc7_];
      _loc5_.InfoText = undefined;
      _loc2_ = new flash.geom.ColorTransform();
      if(_loc6_.price <= playerCash)
      {
         _loc2_.ra = 84;
         _loc2_.rb = 84;
         _loc2_.ba = 104;
         _loc2_.bb = 104;
         _loc2_.ga = 6;
         _loc2_.gb = 6;
         _loc2_.aa = 255;
         _loc2_.ab = 0;
      }
      else
      {
         _loc2_.rgb = 13185313;
      }
      _loc4_ = new flash.geom.Transform(_loc6_.WeaponDescription.TextBox);
      _loc4_.colorTransform = _loc2_;
      _loc2_.rgb = 13421772;
      _loc4_ = new flash.geom.Transform(_loc6_.WeaponName);
      _loc4_.colorTransform = _loc2_;
      var _loc10_ = getDataFromConfig(_loc5_.sliceType);
      var _loc12_ = false;
      if(_loc10_ == "weapon" || _loc10_ == "equipment")
      {
         var _loc8_ = getWeaponNameFromConfig(_loc5_);
         var _loc11_ = getItemPositionFromConfig(_loc5_);
         if(_loc8_ == null || _loc8_ == undefined)
         {
            trace(" invalid weapon name in slice : " + _loc11_);
         }
         else
         {
            var _loc3_ = undefined;
            var _loc9_ = canAquireWeapon(_loc8_,_loc11_);
            switch(_loc9_)
            {
               case Lib.AcquireResult.ReachedGrenadeTotalLimit:
                  _loc3_ = _global.GameInterface.Translate("#SFUI_BuyMenu_CanOnlyCarryXGrenades");
                  _loc3_ = _global.ConstructString(_loc3_,_global.GameInterface.GetConvarNumber("ammo_grenade_limit_total"));
                  break;
               case Lib.AcquireResult.ReachedGrenadeTypeLimit:
                  _loc3_ = _global.GameInterface.Translate("#SFUI_BuyMenu_MaxItemsOfType");
                  _loc3_ = _global.ConstructString(_loc3_,getCarryLimit(_loc8_));
                  break;
               case Lib.AcquireResult.AlreadyOwned:
                  _loc3_ = _global.GameInterface.Translate("#SFUI_BuyMenu_AlreadyCarrying");
                  break;
               case Lib.AcquireResult.AlreadyPurchased:
                  _loc3_ = _global.GameInterface.Translate("#SFUI_BuyMenu_AlreadyPurchased");
                  break;
               case Lib.AcquireResult.NotAllowedByMap:
                  _loc3_ = _global.GameInterface.Translate("#SFUI_BuyMenu_NotAllowedByMap");
                  break;
               case Lib.AcquireResult.NotAllowedByMode:
                  _loc3_ = _global.GameInterface.Translate("#SFUI_BuyMenu_NotAllowedByMode");
                  break;
               case Lib.AcquireResult.NotAllowedByTeam:
                  _loc3_ = _global.GameInterface.Translate("#SFUI_BuyMenu_NotAllowedByTeam");
            }
            if(_loc9_ != Lib.AcquireResult.CanAcquire)
            {
               _loc5_.InfoText = _loc3_;
               _loc12_ = true;
            }
         }
      }
      if(_loc12_)
      {
         _loc2_.rgb = 5592405;
         _loc4_ = new flash.geom.Transform(_loc6_.WeaponName.TextBoxName);
         _loc4_.colorTransform = _loc2_;
         _loc4_ = new flash.geom.Transform(_loc6_.WeaponDescription.TextBox);
         _loc4_.colorTransform = _loc2_;
      }
      _loc7_ = _loc7_ + 1;
   }
}
function clearSlice(slice, icon, text, name, catagory6, catagory4)
{
   if(icon.weaponImage != undefined && icon.weaponImage != null)
   {
      icon.weaponImage.removeMovieClip();
   }
   text._visible = false;
   icon._visible = false;
   name._visible = false;
   catagory4._visible = true;
   catagory6._visible = true;
   icon._alpha = 100;
   slice.price = 0;
   slice.loadout = null;
   slice.CurrentHighlight._visible = true;
   if(slice.invalidName != undefined)
   {
      delete slice.invalidName;
   }
}
function getWeaponNameFromConfig(initData)
{
   var _loc1_ = getDataFromConfig(initData.weapon);
   var _loc2_ = getDataFromConfig(initData.weapon_position);
   if(_loc1_ != undefined && gameAPI.WeaponIsValid(_loc2_))
   {
      trace("getWeaponNameFromConfig: returning = " + _loc1_);
      return _loc1_;
   }
   trace("getWeaponNameFromConfig: returning = NULL");
   return null;
}
function getItemPositionFromConfig(initData)
{
   trace("getItemPositionFromConfig");
   var _loc1_ = getDataFromConfig(initData.weapon_position);
   if(_loc1_ > -1 && gameAPI.WeaponIsValid(_loc1_))
   {
      return _loc1_;
   }
   return null;
}
function loadComparisonIcon(icon, imageName, bVisible)
{
   if(bVisible == false)
   {
      icon._visible = false;
      return undefined;
   }
   var _loc5_ = imageName + ".movie";
   if(icon.imageName != _loc5_)
   {
      icon._xscale = 100;
      icon._yscale = 100;
      icon._visible = false;
      icon.imageName = _loc5_;
      var movie = icon.attachMovieClip(_loc5_,"weaponName",10);
      movie.onLoad = function()
      {
         var _loc1_ = movie;
         var _loc2_ = icon;
         _loc1_._xscale = 100;
         _loc1_._yscale = 100;
         var _loc4_ = 400;
         var _loc3_ = _loc1_._height * _loc4_ / _loc1_._width;
         if(_loc3_ > 200)
         {
            _loc3_ = 200;
            _loc4_ = _loc1_._width * _loc3_ / _loc1_._height;
         }
         movie._width = _loc4_;
         movie._height = _loc3_;
         _loc2_._x = _loc2_.originalX - _loc4_ / 4;
         _loc2_._y = _loc2_.originalY - _loc3_ / 4;
         _loc2_._xscale = _loc2_._xscale * 0.5;
         _loc2_._yscale = _loc2_._yscale * 0.5;
         icon._visible = true;
      };
   }
   else
   {
      icon._visible = true;
   }
}
function ShowWeaponStickers(ItemID)
{
   var _loc6_ = gameAPI.GetLocalPlayerXuid();
   var _loc9_ = _global.CScaleformComponent_Inventory.GetItemStickerCount(_loc6_,ItemID);
   var _loc8_ = Panel.Panel.PanelWeapon.Stickers;
   if(_loc9_ > 0)
   {
      var _loc10_ = 7;
      var _loc2_ = 0;
      while(_loc2_ < _loc10_)
      {
         var _loc3_ = _loc8_["Tile" + _loc2_];
         if(_loc2_ >= _loc9_)
         {
            _loc3_._visible = false;
         }
         else
         {
            var _loc4_ = _global.CScaleformComponent_Inventory.GetItemStickerImageByIndex(_loc6_,ItemID,_loc2_);
            var _loc5_ = _global.CScaleformComponent_Inventory.GetItemStickerNameByIndex(_loc6_,ItemID,_loc2_);
            _loc3_._visible = true;
            LoadStickerImage(_loc3_,_loc4_,_loc5_);
         }
         _loc2_ = _loc2_ + 1;
      }
      _loc8_._visible = true;
   }
   else
   {
      _loc8_._visible = false;
   }
}
function LoadStickerImage(objTile, Path, Name)
{
   if(objTile.Image != undefined)
   {
      objTile.Image.unloadMovie();
   }
   var _loc1_ = new Object();
   _loc1_.onLoadInit = function(target_mc)
   {
      target_mc._width = 12;
      target_mc._height = 9;
      target_mc.forceSmoothing = true;
   };
   _loc1_.onLoadError = function(target_mc, errorCode, status)
   {
      trace("LoadSetImage: Error loading image: " + errorCode + " [" + status + "] ----- You probably forgot to author a small version of your flair item (needs to end with _small).");
   };
   var _loc4_ = Path + ".png";
   var _loc2_ = new MovieClipLoader();
   _loc2_.addListener(_loc1_);
   _loc2_.loadClip(_loc4_,objTile.Image);
   objTile.Text.htmlText = Name;
}
function loadIcon(icon, name)
{
}
function loadLoadoutIcon(panel, imageName, wepName, pos)
{
   var icon = panel.WeaponIcon;
   var _loc11_ = panel.TextBoxName;
   var _loc12_ = CanPurchaseWeapon(imageName,pos);
   var _loc7_ = canAquireWeapon(imageName,pos);
   if(icon.imageName != imageName)
   {
      icon._xscale = 100;
      icon._yscale = 100;
      icon._visible = false;
      icon.imageName = imageName;
      var _loc13_ = _global.GameInterface.GetConvarNumber("player_teamplayedlast") == _global.TeamID_CounterTerrorist;
      if(imageName == "knife" && _loc13_)
      {
         imageName = imageName + "-ct";
      }
      imageName = "icon-" + imageName;
      var movie = icon.attachMovieClip(imageName,"weaponName",10);
      movie.onLoad = function()
      {
         var _loc5_ = movie;
         var _loc4_ = icon;
         _loc5_._xscale = 100;
         _loc5_._yscale = 100;
         var _loc1_ = _loc5_._width;
         var _loc2_ = _loc5_._height;
         var _loc3_ = 1;
         while(_loc1_ > 135 || _loc2_ > 95)
         {
            _loc1_ = _loc1_ * _loc3_;
            _loc2_ = _loc2_ * _loc3_;
            if(_loc1_ > 135)
            {
               _loc3_ = 135 / _loc1_;
            }
            else if(_loc2_ > 95)
            {
               _loc3_ = 95 / _loc2_;
            }
         }
         movie._width = _loc1_;
         movie._height = _loc2_;
         _loc4_._x = _loc4_.originalX - _loc1_ * 0.8;
         _loc4_._y = _loc4_.originalY - _loc2_ / 2;
         _loc4_._xscale = _loc4_._xscale * 0.8;
         _loc4_._yscale = _loc4_._yscale * 0.8;
         icon._visible = true;
      };
   }
   else
   {
      icon._visible = true;
   }
   var _loc10_ = new Color(_loc11_);
   var _loc9_ = new Color(icon);
   if(_loc7_ == Lib.AcquireResult.ReachedGrenadeTotalLimit || _loc7_ == Lib.AcquireResult.ReachedGrenadeTypeLimit || _loc7_ == Lib.AcquireResult.AlreadyOwned || _loc7_ == Lib.AcquireResult.AlreadyPurchased)
   {
      _loc10_.setTransform(alreadyOwnedColorTransform);
      _loc9_.setTransform(alreadyOwnedColorTransform);
   }
   else if(_loc12_ == false)
   {
      _loc10_.setTransform(canNotBuyColorTransform);
      _loc9_.setTransform(canNotBuyColorTransform);
   }
   else
   {
      _loc10_.setTransform(canBuyColorTransform);
      _loc9_.setTransform(canBuyColorTransform);
   }
}
function loadInventoryIcon(panel, imageName, wepName)
{
   var _loc3_ = panel.iconSelected;
   _loc3_.imageName = imageName;
   var _loc4_ = _global.GameInterface.GetConvarNumber("player_teamplayedlast") == _global.TeamID_CounterTerrorist;
   if(imageName == "knife" && _loc4_)
   {
      imageName = imageName + "-ct";
   }
   imageName = "icon-" + imageName;
   var _loc5_ = _loc3_.attachMovieClip(imageName,"weaponName",10);
}
function initSlice(index, initData)
{
   var _loc4_ = getItemPositionFromConfig(slices[index]);
   var _loc1_ = pieSlices[index];
   var _loc9_ = _loc1_.WeaponIcon;
   var _loc3_ = _loc1_.WeaponDescription;
   var _loc5_ = _loc1_.WeaponName.TextBoxName;
   var slices = currentMenu.Slices;
   var _loc15_ = _loc1_.CatagoryName;
   var _loc12_ = _loc1_.CatagoryName4Wedge;
   var _loc16_ = getWeaponNameFromConfig(slices[index]);
   clearSlice(_loc1_,_loc9_,_loc3_,_loc5_,_loc15_,_loc12_);
   var _loc8_ = getDataFromConfig(initData.sliceType);
   if(_loc8_ == "weapon" || _loc8_ == "equipment")
   {
      var _loc2_ = getWeaponNameFromConfig(initData);
      _loc4_ = getItemPositionFromConfig(initData);
      if(_loc2_ == null || _loc2_ == undefined)
      {
         _loc1_.invalidName = true;
         trace(" setting slice invalid : " + index);
      }
      else
      {
         loadIcon(_loc9_,_loc2_);
         var _loc11_ = GetWeaponPrice(_loc4_);
         trace("@@@@@@@@@ price = " + _loc11_);
         if(gameAPI.AreWeaponsFree())
         {
            var _loc6_ = parseInt(gameAPI.CanAcquire(_loc16_,_loc4_));
            trace("******* nCanAcquire = " + _loc6_);
            var _loc10_ = "";
            if(_loc6_ == 2 || _loc6_ == 3)
            {
               _loc10_ = "#SFUI_BuyMenu_Owned_Short";
            }
            else if(_loc6_ == 4)
            {
               _loc10_ = "#SFUI_BuyMenu_AtLimit_Short";
            }
            else if(_loc6_ >= 5)
            {
               _loc10_ = "#SFUI_BuyMenu_NotAllowed_Short";
            }
            _loc3_.SetText(_loc10_);
         }
         else
         {
            _loc3_.SetText("$" + _loc11_);
         }
         _loc3_._visible = true;
         _loc1_.price = _loc11_;
         _loc5_.htmlText = GetSeperateNameString(SeperateName(GetWeaponName(_loc4_)));
         _loc5_._visible = true;
         _loc15_._visible = false;
         _loc12_._visible = false;
         if(WeaponInLoadout(_loc4_))
         {
            _loc1_.CurrentHighlight._visible = true;
         }
      }
   }
   else if(_loc8_ == "subMenu")
   {
      trace("slicetype == subMenu");
      var _loc17_ = getDataFromConfig(initData.image);
      loadIcon(_loc9_,_loc17_);
      _loc5_._visible = true;
      _loc5_.htmlText = getDataFromConfig(slices[index].name);
   }
   else if(_loc8_ == "loadout")
   {
      var _loc7_ = gameAPI.GetPredefinedLoadout(initData.index);
      trace("-------------------------- GetPredefinedLoadout ");
      _loc1_.loadout = _loc7_;
      _loc1_.price = _loc7_.price;
      _loc2_ = _loc7_.primary;
      if(_loc2_ == undefined || _loc2_ == null)
      {
         _loc2_ = _loc7_.secondary;
         if(_loc2_ == undefined || _loc2_ == null)
         {
            _loc2_ = _loc7_.taser;
            if(_loc2_ == undefined || _loc2_ == null)
            {
               _loc2_ = 0;
            }
         }
      }
      trace(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>  else if (slicetype == loadout ) ");
      _loc1_.WeaponName.TextBoxName.htmlText = GetWeaponName(_loc4_);
      loadIcon(_loc9_,weaponName);
      if(gameAPI.AreWeaponsFree())
      {
         _loc6_ = parseInt(gameAPI.CanAcquire(_loc16_,_loc4_));
         trace("******* nCanAcquire = " + _loc6_);
         _loc10_ = "";
         if(_loc6_ == 2 || _loc6_ == 3)
         {
            _loc10_ = "#SFUI_BuyMenu_Owned_Short";
         }
         else if(_loc6_ == 4)
         {
            _loc10_ = "#SFUI_BuyMenu_AtLimit_Short";
         }
         else if(_loc6_ >= 5)
         {
            _loc10_ = "#SFUI_BuyMenu_NotAllowed_Short";
         }
         _loc3_.SetText(_loc10_);
      }
      else
      {
         _loc3_.SetText("$" + _loc1_.price);
      }
      _loc3_._visible = true;
      _loc12_._visible = false;
   }
}
function slicePressed(index)
{
   var _loc1_ = currentMenu.Slices[index];
   var _loc2_ = getDataFromConfig(_loc1_.sliceType);
   if(_loc2_ == "subMenu")
   {
      setMenu(menuData[getDataFromConfig(_loc1_.subMenu)]);
   }
   else if(_loc2_ == "weapon" || _loc2_ == "equipment")
   {
      var _loc3_ = getWeaponNameFromConfig(_loc1_);
      if(_loc3_ == null || _loc3_ == undefined)
      {
         playBuzzSound();
      }
      else if(CanPurchaseWeapon(_loc1_.weapon,_loc1_.weapon_position))
      {
         var _loc4_ = getDataFromConfig(_loc1_.weapon_position);
         trace(">> Attempting to purchase: " + _loc3_ + " at position: " + _loc4_);
         gameAPI.BuyWeapon(_loc3_,_loc4_);
         if(gameAPI.ShouldCloseOnBuy())
         {
            gameAPI.OnCancel();
         }
         else if(currentMenu.autoReturn != "false")
         {
            setMenu(menuData.MainMenu);
         }
      }
      else
      {
         playBuzzSound();
      }
   }
   else if(_loc2_ == "loadout")
   {
      if(pieSlices[index].price <= playerCash)
      {
         gameAPI.BuyLoadout(_loc1_.index);
         setMenu(menuData.MainMenu);
      }
      else
      {
         playBuzzSound();
      }
   }
   else
   {
      playBuzzSound();
   }
}
function playBuzzSound()
{
   _global.navManager.PlayNavSound("NotYours");
}
function showSliceInfo(wedgeIndex)
{
   trace("showSliceInfo");
   if(wedgeIndex == -1 || pieSlices[wedgeIndex].invalidName)
   {
      clearLoadoutPanel();
   }
   else
   {
      slicetype = getDataFromConfig(currentMenu.Slices[wedgeIndex].sliceType);
      if(slicetype == "loadout")
      {
         fillLoadoutPanel(getDataFromConfig(pieSlices[wedgeIndex].loadout),_global.ConstructString(loadoutString,wedgeIndex + 1));
      }
      else if(slicetype == "subMenu")
      {
         describeSubPanel(wedgeIndex);
      }
      else if(slicetype == "weapon")
      {
         compareWeapons(wedgeIndex);
      }
      else if(slicetype == "equipment")
      {
         describeEquipment(wedgeIndex);
      }
      else
      {
         clearLoadoutPanel();
      }
   }
}
function fillLoadoutPanel(loadout, name, hidePrice)
{
   weaponPanel._visible = false;
   loadoutPanel._visible = true;
   descriptionPanel._visible = false;
   trace("fillLoadoutPanel:SetShowWeaponModel( -1 )");
   gameAPI.SetShowWeaponModel(-1);
   var _loc1_ = 0;
   var _loc6_ = loadout.weapons;
   var _loc7_ = loadout.weapons_position;
   var _loc5_ = loadout.counts;
   var _loc3_ = undefined;
   while(_loc1_ < _loc6_.length)
   {
      _loc3_ = gameAPI.GetWeaponShortNameFromID(_loc6_[_loc1_]);
      trace(">>>>>>>>>>>>>>>>>>>>>>>>>>>>> fillLoadoutPanel : weaponShortName");
      loadoutEntries[_loc1_]._visible = true;
      var _loc2_ = GetWeaponName(_loc7_[_loc1_]);
      if(hidePrice && loadout.armor && _loc3_ == "assaultsuit")
      {
         _loc2_ = _loc2_ + " (" + loadout.armor + ")";
      }
      else if(_loc5_[_loc1_] > 1)
      {
         _loc2_ = _loc2_ + " (" + _loc5_[_loc1_] + ")";
      }
      loadoutEntries[_loc1_].SetText(_loc2_);
      loadLoadoutIcon(loadoutEntries[_loc1_],_loc3_,_loc2_,_loc7_[_loc1_]);
      _loc1_ = _loc1_ + 1;
   }
   while(_loc1_ < 8)
   {
      loadoutEntries[_loc1_]._visible = false;
      _loc1_ = _loc1_ + 1;
   }
   trace(">>>>>>> loadoutPanel.Text.LoadOutName.htmlText = " + name);
   loadoutPanel.Text.LoadOutName.htmlText = name;
   if(loadout.price != undefined && !hidePrice)
   {
      loadoutPanel.Text.Cost._visible = true;
      loadoutPanel.Text.Cost.htmlText = "$" + loadout.price;
   }
   else
   {
      loadoutPanel.Text.Cost._visible = false;
   }
}
function fillInventoryPanel(loadout)
{
   inventoryPanel._visible = true;
   var _loc2_ = 0;
   var _loc7_ = loadout.weapons;
   var _loc9_ = loadout.weapons_position;
   var _loc4_ = _loc7_.length - 1;
   var _loc8_ = loadout.counts;
   var _loc5_ = undefined;
   invPanel.DefuseKitIcon._visible = loadout.defuse != true?false:true;
   invPanel.BombCarrierIcon._visible = loadout.bomb != true?false:true;
   var _loc10_ = _global.GameInterface.Translate("#SFUI_WPNHUD_DEFUSER");
   if(isHostageMatch)
   {
      _loc10_ = _global.GameInterface.Translate("#SFUI_WPNHUD_CUTTERS");
   }
   invPanel.DefuseKitIcon.TextBoxName.htmlText = _loc10_;
   while(_loc2_ < _loc7_.length)
   {
      _loc5_ = gameAPI.GetWeaponShortNameFromPosition(_loc9_[_loc4_],_loc7_[_loc4_]);
      inventoryEntries[_loc2_]._visible = true;
      var _loc3_ = GetWeaponName(_loc9_[_loc4_]);
      if(hidePrice && loadout.armor && _loc5_ == "assaultsuit")
      {
         _loc3_ = _loc3_ + " (" + loadout.armor + ")";
      }
      else if(_loc8_[_loc4_] > 1)
      {
         _loc3_ = _loc3_ + " (" + _loc8_[_loc4_] + ")";
      }
      trace("fillInventoryPanel - inventoryEntries[" + _loc2_ + "] = " + inventoryEntries[_loc2_] + ", weaponName = " + _loc3_ + ", weaponShortName = " + _loc5_);
      inventoryEntries[_loc2_].TextBoxName.htmlText = _loc3_;
      loadInventoryIcon(inventoryEntries[_loc2_],_loc5_,_loc3_);
      _loc2_ = _loc2_ + 1;
      _loc4_ = _loc4_ - 1;
   }
   while(_loc2_ < 8)
   {
      inventoryEntries[_loc2_]._visible = false;
      _loc2_ = _loc2_ + 1;
   }
}
function clearLoadoutPanel()
{
   weaponPanel._visible = false;
   loadoutPanel._visible = true;
   descriptionPanel._visible = false;
   trace("clearLoadoutPanel:SetShowWeaponModel( -1 )");
   gameAPI.SetShowWeaponModel(-1);
   var _loc1_ = 0;
   while(_loc1_ < 8)
   {
      loadoutEntries[_loc1_]._visible = false;
      _loc1_ = _loc1_ + 1;
   }
   trace(">> clearLoadoutPanel");
   loadoutPanel.Text.LoadOutName.htmlText = "";
   loadoutPanel.Text.Cost._visible = false;
}
function describeSubPanel(index)
{
   weaponPanel._visible = false;
   loadoutPanel._visible = true;
   descriptionPanel._visible = false;
   trace("describeSubPanel:SetShowWeaponModel( -1 )");
   gameAPI.SetShowWeaponModel(-1);
   var _loc12_ = menuData[getDataFromConfig(currentMenu.Slices[index].subMenu)];
   var _loc2_ = 0;
   var _loc7_ = _loc12_.Slices;
   var _loc4_ = undefined;
   var _loc8_ = undefined;
   var _loc10_ = undefined;
   var _loc11_ = _loc7_.length;
   loadoutPanel.Text.LoadOutName.htmlText = getDataFromConfig(_loc12_.centerText);
   loadoutPanel.Text.Cost._visible = false;
   if(_loc12_.menuType == "loadout")
   {
      _loc10_ = gameAPI.ReportLoadouts();
   }
   trace(">>>>>>>>>>>>>>>>>>>>>>>>>>>>> describeSubPanel( index )");
   index = 0;
   while(index < _loc11_)
   {
      var _loc5_ = getDataFromConfig(_loc7_[index].sliceType);
      if(_loc5_ == "weapon" || _loc5_ == "equipment")
      {
         _loc4_ = getWeaponNameFromConfig(_loc7_[index]);
         _loc8_ = getItemPositionFromConfig(_loc7_[index]);
         if(_loc4_ != null && _loc4_ != undefined)
         {
            loadoutEntries[_loc2_]._visible = true;
            var _loc6_ = GetWeaponName(_loc8_);
            loadoutEntries[_loc2_].SetText(_loc6_);
            loadLoadoutIcon(loadoutEntries[_loc2_],_loc4_,_loc6_,_loc8_);
            _loc2_ = _loc2_ + 1;
         }
      }
      else if(_loc5_ == "loadout")
      {
         loadoutEntries[_loc2_]._visible = true;
         _loc4_ = gameAPI.GetWeaponShortNameFromID(_loc10_.weapons[index]);
         loadLoadoutIcon(loadoutEntries[_loc2_],_loc4_,_loc6_,_loc10_.weapons_positions[index]);
         var _loc9_ = _global.ConstructString(loadoutString,index + 1);
         loadoutEntries[_loc2_].SetText(_loc9_);
         _loc2_ = _loc2_ + 1;
      }
      index = index + 1;
   }
   while(_loc2_ < 8)
   {
      loadoutEntries[_loc2_]._visible = false;
      _loc2_ = _loc2_ + 1;
   }
}
function compareWeapons(index)
{
   weaponPanel._visible = true;
   loadoutPanel._visible = false;
   descriptionPanel._visible = false;
   var _loc18_ = currentMenu.Slices;
   var _loc5_ = getWeaponNameFromConfig(_loc18_[index]);
   var _loc2_ = getItemPositionFromConfig(_loc18_[index]);
   if(_loc5_ != null && _loc5_ != undefined)
   {
      var _loc3_ = GetWeapon(_loc2_);
      var _loc23_ = undefined;
      var _loc20_ = undefined;
      var _loc12_ = undefined;
      var _loc24_ = undefined;
      var _loc10_ = undefined;
      var _loc19_ = undefined;
      if(_loc3_.weaponType == "taser" || _loc3_.weaponType == "equipment")
      {
         _loc23_ = _loc3_.firepower;
         _loc20_ = _loc3_.fireRate;
         _loc12_ = _loc3_.moveRate;
         _loc24_ = _loc3_.inaccuracy;
         _loc10_ = _loc3_.armorPen;
         _loc19_ = _loc3_.range;
      }
      else
      {
         _loc23_ = gameAPI.GetWeaponFirepower(_loc2_);
         _loc20_ = gameAPI.GetWeaponFireRate(_loc2_);
         _loc12_ = gameAPI.GetWeaponMoveRate(_loc2_);
         _loc24_ = gameAPI.GetWeaponHandling(_loc2_);
         _loc10_ = gameAPI.GetWeaponArmorPen(_loc2_);
         _loc19_ = gameAPI.GetEffectiveRange(_loc2_);
      }
      var _loc21_ = currentPlayerLoadout[_loc3_.weaponType];
      var _loc11_ = undefined;
      var _loc9_ = undefined;
      var _loc17_ = undefined;
      var _loc15_ = undefined;
      var _loc16_ = undefined;
      var _loc14_ = undefined;
      if(_loc21_ == undefined)
      {
         _loc11_ = 0;
         _loc9_ = 0;
         _loc17_ = 0;
         _loc15_ = 0;
         _loc16_ = 0;
         _loc14_ = 0;
      }
      else
      {
         var _loc34_ = currentPlayerLoadout.weapons_positions[_loc21_];
         var _loc4_ = GetWeapon(_loc34_);
         _loc11_ = _loc4_.firepower;
         _loc9_ = _loc4_.fireRate;
         _loc17_ = _loc4_.moveRate;
         _loc15_ = _loc4_.inaccuracy;
         _loc16_ = _loc4_.armorPen;
         _loc14_ = _loc4_.range;
      }
      weaponPanel.DataBarOne.compare(_loc23_,_loc11_);
      weaponPanel.DataBarTwo.compare(_loc20_,_loc9_);
      weaponPanel.DataBarFive.compare(_loc12_,_loc17_);
      weaponPanel.DataBarThree.compare(_loc24_,_loc15_);
      weaponPanel.DataBarSix.compare(_loc10_,_loc16_);
      weaponPanel.DataBarFour.compare(_loc19_,_loc14_);
      var _loc27_ = gameAPI.GetWeaponClipSize(_loc2_);
      var _loc25_ = gameAPI.GetWeaponMaxCarry(_loc2_);
      var _loc32_ = gameAPI.GetWeaponPriceScript(_loc2_);
      var _loc26_ = gameAPI.GetWeaponPenetration(_loc2_);
      var _loc22_ = gameAPI.GetWeaponDMPoints(_loc2_);
      var _loc6_ = Number(gameAPI.GetWeaponKillAward(_loc2_));
      var _loc29_ = gameAPI.GetWeaponFirepowerRaw(_loc2_);
      var _loc30_ = gameAPI.GetWeaponArmorPenRaw(_loc2_);
      var _loc36_ = gameAPI.GetEffectiveRangeRaw(_loc2_);
      var _loc35_ = gameAPI.GetWeaponRawMoveRatio(_loc2_);
      weaponPanel.Text.AmmoText.htmlText = _loc27_ + "/" + _loc25_;
      weaponPanel.Text.WeaponName.htmlText = GetWeaponName(_loc2_);
      weaponPanel.Text.Cost.htmlText = "$" + _loc32_;
      weaponPanel.Text.SpecialText.htmlText = _global.GameInterface.Translate("#SFUI_BuyMenu_InfoSpecial_" + _loc5_);
      weaponPanel.Text.CountryTextParent.CountryText.htmlText = _global.GameInterface.Translate("#SFUI_BuyMenu_InfoOrigin_" + _loc5_);
      weaponPanel.Text.DamageNumberText.htmlText = _loc29_;
      weaponPanel.Text.MovementText.htmlText = _loc35_;
      weaponPanel.Text.ArmorPenText.htmlText = _loc30_ / 100;
      weaponPanel.Text.RangeText.htmlText = _loc36_ + "m";
      if(_loc3_.penetration == 0)
      {
         weaponPanel.Text.PenetrationText.htmlText = _global.GameInterface.Translate("#SFUI_BuyMenu_Penetration_None");
      }
      else
      {
         weaponPanel.Text.PenetrationText.htmlText = "" + _loc26_ * 100;
      }
      if(gameAPI.AreWeaponsFree())
      {
         var _loc31_ = _loc22_;
         trace("newDMPoints = " + _loc22_);
         var _loc28_ = _global.GameInterface.Translate("#SFUI_BuyMenu_KillAward_DMPoints");
         var _loc7_ = _global.ConstructString(_loc28_,_loc31_);
         trace("weaponPanel.Text.KillAwardText.htmlText = info" + _loc7_);
         weaponPanel.Text.KillAwardText.htmlText = _loc7_;
      }
      else
      {
         trace("newKillAward = " + _loc6_);
         if(_loc6_ == 1)
         {
            weaponPanel.Text.KillAwardText.htmlText = _global.GameInterface.Translate("#SFUI_BuyMenu_KillAward_Default");
         }
         else
         {
            var _loc8_ = _loc6_ * 100;
            trace("nAwardMulti = " + _loc8_);
            if(flAward == 0)
            {
               weaponPanel.Text.KillAwardText.htmlText = _global.GameInterface.Translate("#SFUI_BuyMenu_KillAward_None");
            }
            else
            {
               weaponPanel.Text.KillAwardText.htmlText = _loc8_ + "%";
            }
         }
      }
      var _loc33_ = gameAPI.GetWeaponItemID(_loc2_);
      var _loc13_ = true;
      trace("clearLoadoutPanel:SetShowWeaponModel( weaponPosition ) = " + _loc2_);
      if(gameAPI.SetShowWeaponModel(_loc2_))
      {
         trace("SetShowWeaponModel == true");
         _loc13_ = false;
      }
      loadComparisonIcon(weaponPanel.WeaponIcon,_loc5_,_loc13_);
      ShowWeaponStickers(_loc33_);
   }
}
function describeEquipment(index)
{
   trace("describeEquipment");
   weaponPanel._visible = false;
   loadoutPanel._visible = false;
   descriptionPanel._visible = true;
   var _loc3_ = currentMenu.Slices;
   var _loc2_ = getWeaponNameFromConfig(_loc3_[index]);
   if(_loc2_ != null && _loc2_ != undefined)
   {
      var _loc4_ = getItemPositionFromConfig(_loc3_[index]);
      trace("describeEquipment: weapName = " + _loc2_ + ", pos = " + _loc4_);
      trace("describeEquipment:SetShowWeaponModel( -1 )");
      gameAPI.SetShowWeaponModel(-1);
      descriptionPanel.Text.WeaponName.htmlText = GetWeaponName(_loc4_);
      var _loc5_ = GetWeaponPrice(_loc3_[index].weapon_position);
      descriptionPanel.Text.Cost.htmlText = "$" + _loc5_;
      loadComparisonIcon(descriptionPanel.WeaponIcon,_loc2_,true);
      descriptionPanel.Text.DescriptionText.htmlText = _global.GameInterface.Translate("#SFUI_BuyMenu_InfoDescription_" + _loc2_);
   }
}
function setCenterText(newtext)
{
   var _loc1_ = radialPanel.CategoryText;
   _loc1_.SetText(newtext);
}
function initSlices()
{
   var _loc2_ = currentMenu.Slices;
   var _loc1_ = 0;
   while(_loc1_ < numSlices)
   {
      initSlice(_loc1_,_loc2_[_loc1_]);
      _loc1_ = _loc1_ + 1;
   }
   resetColors();
}
function setMenu(menu)
{
   trace("setMenu");
   currentMenu = menu;
   if(menu.Slices.length <= 4)
   {
      setRadialPanel(radialPanelData4);
   }
   else
   {
      setRadialPanel(radialPanelData6);
   }
   UpdateNavString();
   initSlices();
   setCenterText(currentMenu.centerText);
   setWedgeHighlight(current4SliceIndex,current6SliceIndex);
}
function updatePlayerInventory(loadout)
{
   trace("updatePlayerInventory");
   currentPlayerLoadout = loadout;
   fillInventoryPanel(currentPlayerLoadout);
   setWedgeHighlight(current4SliceIndex,current6SliceIndex);
}
function updatePlayerBuyMenuInventory(loadout)
{
   trace("updatePlayerBuyMenuInventory");
   menuData = loadout;
}
function GetShiftedMoneyPositionY()
{
   var _loc1_ = Panel.Panel.Money;
   var _loc2_ = {x:_loc1_._x,y:_loc1_._y};
   _loc1_._parent.localToGlobal(_loc2_);
   return _loc2_.y;
}
function GetShiftedMoneyPositionX()
{
   var _loc1_ = Panel.Panel.Money;
   var _loc2_ = {x:_loc1_._x,y:_loc1_._y};
   _loc1_._parent.localToGlobal(_loc2_);
   return _loc2_.x;
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
   return _loc2_;
}
function GetSeperateNameString(aName)
{
   if(aName.length == 1)
   {
      return "<b>" + aName[0] + "</b>";
   }
   return "<b>" + aName[0] + "</b>" + "\n" + "<font color=\'#888888\'>" + aName[1] + "</font>";
}
_global.BuyMenu = this;
_global.BuyMenuAPI = gameAPI;
var canNotBuyColorTransform = new Object();
canNotBuyColorTransform = {ra:"0",rb:"190",ga:"0",gb:"50",ba:"0",bb:"50",aa:"65",ab:"0"};
var canBuyColorTransform = new Object();
canBuyColorTransform = {ra:"0",rb:"130",ga:"0",gb:"130",ba:"0",bb:"130",aa:"90",ab:"0"};
var alreadyOwnedColorTransform = new Object();
alreadyOwnedColorTransform = {ra:"0",rb:"85",ga:"0",gb:"85",ba:"0",bb:"85",aa:"75",ab:"0"};
var buyNav = new Lib.NavLayout();
var isVisibile = false;
var removeAfterHiding = false;
var menuData = null;
var currentMenu = null;
var playerIsCT = true;
var isHostageMatch = true;
var playerCash = 0;
var weaponDB = new Object();
var currentPlayerLoadout;
var loadoutPanel;
var invPanel;
var weaponPanel;
var descriptionPanel;
var loadoutEntries = new Array();
var inventoryEntries = new Array();
var currentSliceIndex = -1;
var current4SliceIndex = -1;
var current6SliceIndex = -1;
var loadoutString;
var helpText;
var timerBlock;
var timerText;
var radialPanelData6 = new Object();
var radialPanelData4 = new Object();
var pieSlices = null;
var radialPanel = null;
var numSlices = 0;
var centerTextY;
var centerTextX;
var currentRadialPanel;
menuData = _global.GameInterface.LoadKVFile("resource/ui/BuyMenuConfig.txt");
buyNav.DenyInputToGame(true);
buyNav.ShowCursor(true);
buyNav.AddKeyHandlers({onDown:function(button, control, keycode)
{
   TryBuyFunction(function()
   {
      _global.BuyMenuAPI.BuyPrevious();
   }
   );
}},"KEY_XBUTTON_RIGHT_SHOULDER","rebuy");
buyNav.AddKeyHandlers({onDown:function(button, control, keycode)
{
   TryBuyFunction(function()
   {
      _global.BuyMenuAPI.Autobuy();
   }
   );
}},"KEY_XBUTTON_LEFT_SHOULDER","autobuy");
buyNav.AddKeyHandlers({onDown:function(button, control, keycode)
{
   if(_global.BuyMenu.currentMenu == _global.BuyMenu.menuData.MainMenu)
   {
      gameAPI.OnCancel();
   }
   else
   {
      _global.BuyMenu.setMenu(_global.BuyMenu.menuData.MainMenu);
   }
}},"CANCEL","buymenu","use","MOUSE_RIGHT");
buyNav.AddKeyHandlers({onDown:function(button, control, keycode)
{
   TryBuyFunction(function()
   {
      _global.BuyMenu.current4SliceIndex = -1;
      _global.BuyMenu.current6SliceIndex = -1;
      _global.BuyMenu.slicePressed(keycode - Lib.SFKey.KeyFromName("KEY_1"));
   }
   );
}},"KEY_1","KEY_2","KEY_3","KEY_4","KEY_5","KEY_6");
buyNav.AddKeyHandlers({onDown:function(button, control, keycode)
{
   TryBuyFunction(function()
   {
      _global.BuyMenu.current4SliceIndex = -1;
      _global.BuyMenu.current6SliceIndex = -1;
      _global.BuyMenu.slicePressed(keycode - Lib.SFKey.KeyFromName("KEY_PAD_1"));
   }
   );
}},"KEY_PAD_1","KEY_PAD_2","KEY_PAD_3","KEY_PAD_4","KEY_PAD_5","KEY_PAD_6");
_global.resizeManager.AddListener(this);
stop();
