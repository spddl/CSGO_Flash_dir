function onLoaded()
{
   gameAPI.OnReady();
}
function onUnload(mc)
{
   _global.tintManager.DeregisterAll(this);
   _global.resizeManager.RemoveListener(this);
   delete _global.WeaponSelectedAnchor;
   return true;
}
function resizeRelative(weaponModule)
{
   _global.resizeManager.ResetPositionByPercentage(Anchor,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_SAFE_RIGHT,0,Lib.ResizeManager.ALIGN_RIGHT,Lib.ResizeManager.REFERENCE_SAFE_BOTTOM,0,Lib.ResizeManager.ALIGN_BOTTOM);
   Anchor._y = weaponModule._y - weaponModule.scaledHeight + weaponModule.scaledHeight / 2.12;
}
function AddPanel()
{
   nextDynamicPanelLevel++;
   var _loc2_ = Anchor.attachMovie("weaponSelectSubPanel","WeaponSelectPanel" + nextDynamicPanelLevel,this.getNextHighestDepth() + nextDynamicPanelLevel);
   return _loc2_;
}
function AddNextPanel()
{
   nextDynamicPanelLevel++;
   var _loc2_ = Anchor.attachMovie("weaponSelectNEXTPanel","WeaponSelectNextPanel" + nextDynamicPanelLevel,this.getNextHighestDepth() + nextDynamicPanelLevel);
   return _loc2_;
}
function AddWeaponData(movieClip, team, itemName, colorStr)
{
   var _loc2_ = Anchor[movieClip._name];
   if(!_loc2_)
   {
      return NULL;
   }
   var _loc9_ = itemName.indexOf("_");
   if(_loc9_ >= 0)
   {
      itemName = itemName.substr(_loc9_ + 1);
   }
   if(itemName == "")
   {
      itemName = "weapon_mp7";
   }
   var _loc11_ = team == _global.TeamID_CounterTerrorist;
   if(itemName == "knife" || itemName == "knifegg")
   {
      itemName = "knife_t";
      if(_loc11_)
      {
         itemName = "knife_ct";
      }
   }
   itemName = "icon-" + itemName;
   if(_loc2_.Panel.iconSelected && _loc2_.Panel.iconSelected.Image != undefined)
   {
      delete _loc2_.Panel.iconSelected.Image;
   }
   if(_loc2_.Panel.iconNotSelected && _loc2_.Panel.iconNotSelected.Image != undefined)
   {
      delete _loc2_.Panel.iconNotSelected.Image;
   }
   _loc2_.Panel.iconSelected.attachMovie(itemName,"Image",0);
   _loc2_.Panel.iconNotSelected.attachMovie(itemName,"Image",0);
   var _loc7_ = 13041408;
   if(_global.SFRadar && _loc2_.Panel.iconNotSelected.Image)
   {
      _loc7_ = _global.SFRadar.GetBGHudTextHexColor(0.5,0.75);
      var _loc10_ = new Color(_loc2_.Panel.iconNotSelected.Image);
      var _loc12_ = _global.GameInterface.GetConvarNumber("cl_hud_color");
      if(_loc12_ == 0)
      {
         _loc10_.setRGB(9803127);
         _loc2_.Panel.iconNotSelected.Image._alpha = 85;
      }
      else
      {
         _loc10_.setRGB(_loc7_);
         _loc2_.Panel.iconNotSelected.Image._alpha = 75;
      }
      trace("AddWeaponData: transformNonSelWep : setRGB(pickcolor) = " + _loc7_);
   }
   var _loc8_ = 0;
   var _loc6_ = 0;
   _loc9_ = colorStr.indexOf("#");
   trace("AddWeaponData: colorStr = " + colorStr);
   if(colorStr != "#b0c3d9" && _loc9_ >= 0)
   {
      colorStr = "0x" + colorStr.substr(_loc9_ + 1);
      trace("AddWeaponData: colorStr = " + colorStr);
      _loc6_ = new Number(colorStr);
      trace("AddWeaponData: color = " + _loc6_);
      _loc8_ = 1;
   }
   var _loc5_ = _loc2_.Panel.iconSelected.filters[0];
   _loc5_.color = _loc6_;
   _loc5_.inner = false;
   _loc5_.alpha = _loc8_;
   _loc2_.Panel.iconSelected.filters = new Array(_loc5_);
   return _loc2_;
}
function AddNextWeaponData(movieClip, itemName, team, nIndexCur, nIndexMax, gren1Name, bIsGGProgMode, bShouldShowFlash, nextItemName1, nextItemName2, nextItemName3, nextItemName4, nextItemName5)
{
   var _loc5_ = Anchor[movieClip._name];
   if(!_loc5_)
   {
      return NULL;
   }
   if(itemName == "undefined")
   {
      return NULL;
   }
   if(itemName == "")
   {
      itemName = "weapon_mp7";
   }
   _loc5_.Panel.backgroundPanel._alpha = 0;
   _loc5_.Panel.iconWeapon2._visible = false;
   _loc5_.Panel.iconDrop.iconWeapon_drop1._visible = false;
   _loc5_.Panel.iconDrop.iconWeapon_drop2._visible = false;
   _loc5_.Panel.iconDrop.iconWeapon_drop3._visible = false;
   _loc5_.Panel.iconDrop.iconWeapon_drop4._visible = false;
   _loc5_.Panel.iconDrop.iconWeapon_drop5._visible = false;
   var _loc6_ = itemName.indexOf("_");
   if(_loc6_ >= 0)
   {
      itemName = itemName.substr(_loc6_ + 1);
   }
   var _loc8_ = team == _global.TeamID_CounterTerrorist;
   if(itemName == "knife" || itemName == "knifegg")
   {
      itemName = "knife_t";
      if(_loc8_)
      {
         itemName = "knife_ct";
      }
   }
   var _loc18_ = gren1Name.indexOf("_");
   if(_loc18_ >= 0)
   {
      gren1Name = gren1Name.substr(_loc18_ + 1);
      mainItemName = "outline-icon-" + itemName;
      _loc5_.Panel.iconWeapon2._visible = true;
      _loc5_.Panel.iconWeapon2.attachMovie(mainItemName,"Image",0);
      itemName = "outline-icon-" + gren1Name;
      trace("(@) itemName: " + itemName + ", gren1Name: " + gren1Name);
   }
   else
   {
      itemName = "outline-icon-" + itemName;
   }
   _loc5_.Panel.iconDrop.iconWeapon.attachMovie(itemName,"Image",0);
   _loc5_.Panel.iconDrop.iconWeapon._visible = true;
   _loc5_.Panel.iconDrop.iconWeapon.Text.htmlText = " ";
   if(bIsGGProgMode)
   {
      _loc5_.Panel.TextPanel._visible = false;
      _loc5_.Panel.TitlePanel._visible = false;
      _loc5_.Panel.backgroundPanel._alpha = 0;
      var _loc10_ = 5;
      var _loc3_ = 1;
      while(_loc3_ <= _loc10_)
      {
         itemName = nextItemName1;
         if(_loc3_ == 2)
         {
            itemName = nextItemName2;
         }
         else if(_loc3_ == 3)
         {
            itemName = nextItemName3;
         }
         else if(_loc3_ == 4)
         {
            itemName = nextItemName4;
         }
         else if(_loc3_ == 5)
         {
            itemName = nextItemName5;
         }
         _loc6_ = itemName.indexOf("_");
         if(_loc6_ >= 0)
         {
            itemName = itemName.substr(_loc6_ + 1);
         }
         if(itemName == "knife" || itemName == "knifegg")
         {
            itemName = "knife_t";
            if(_loc8_)
            {
               itemName = "knife_ct";
            }
         }
         var _loc4_ = _loc5_.Panel.iconDrop["iconWeapon_drop" + _loc3_];
         if(itemName != "")
         {
            itemName = "outline-icon-" + itemName;
            _loc4_.attachMovie(itemName,"Image",0);
            if(bIsGGProgMode)
            {
               _loc4_.Text.htmlText = " " + (nIndexCur + _loc3_);
            }
            else
            {
               _loc4_.Text.htmlText = " ";
            }
            _loc4_._visible = true;
         }
         else
         {
            _loc4_._visible = false;
         }
         _loc3_ = _loc3_ + 1;
      }
   }
   else
   {
      _loc5_.Panel.TextPanel._visible = true;
      _loc5_.Panel.TitlePanel._visible = true;
      _loc5_.Panel.backgroundPanel._alpha = 20;
   }
   var _loc21_ = nIndexCur / nIndexMax;
   var _loc19_ = 1 + _loc21_ * 50;
   _loc5_.Panel.Progress.gotoAndStop(_loc19_);
   _loc5_.Panel.Progress.TextMin.htmlText = "1";
   _loc5_.Panel.Progress.TextMax.htmlText = "" + nIndexMax;
   if(bShouldShowFlash && nIndexCur > 0)
   {
      var _loc15_ = "";
      if(bIsGGProgMode)
      {
         _loc5_.Panel.awardFlash.gotoAndPlay("flash");
         _loc15_ = _global.ConstructString(_global.GameInterface.Translate("#SFUI_ARFlashAlert_ReachedLevel"),nIndexCur,nIndexMax);
      }
      else
      {
         _loc5_.Panel.awardFlash.gotoAndPlay("flashDemo");
         if(_loc18_ >= 0)
         {
            _loc15_ = _global.GameInterface.Translate("#SFUI_ARFlashAlert_BonusGrenade");
         }
         else
         {
            _loc15_ = _global.GameInterface.Translate("#SFUI_ARFlashAlert_NextWeapon");
         }
      }
      _loc5_.Panel.awardFlash.EarnedWeapText.text.htmlText = _loc15_;
   }
   else
   {
      _loc5_.Panel.awardFlash.gotoAndStop("Hide");
   }
   if(bIsGGProgMode)
   {
      _loc5_.Panel.iconDrop.gotoAndPlay("drop");
   }
   else
   {
      _loc5_.Panel.iconDrop.gotoAndStop("InitDemo");
   }
   return _loc5_;
}
function RemovePanel(movieClip)
{
   Anchor[movieClip._name].removeMovieClip();
}
function SetWeaponName(panel, bWeaponIsItem, bIsSelected, bIsGrenade, weaponName)
{
   panel.TextPanel._visible = bIsSelected && bIsGrenade;
   panel.GrenadePanel._visible = bIsSelected && !bIsGrenade;
   if(!bWeaponIsItem)
   {
   }
   panel.TextPanel.htmlText = weaponName;
   panel.GrenadePanel.htmlText = weaponName;
   _global.AutosizeTextDown(panel.TextPanel,9);
   _global.AutosizeTextDown(panel.GrenadePanel,9);
}
function SeperateName(strName)
{
   var _loc1_ = strName.split("|  ",2);
   return _loc1_;
}
function GetSeperateNameString(aName)
{
   if(aName.length == 1)
   {
      return "<b>" + aName[0] + "</b>";
   }
   return "<b>" + aName[0] + "</b>" + "\n" + aName[1];
}
function onResize(rm)
{
   var _loc2_ = _global.WeaponModule;
   if(_loc2_ != null && _loc2_ != undefined)
   {
      resizeRelative(_loc2_.HudPanel);
   }
}
_global.WeaponSelectedAnchor = this;
var nextDynamicPanelLevel = 0;
var Y_OFFSET = 65;
var m_defaultColor = 0;
var weaponColorTransform = new Object();
weaponColorTransform = {ra:"0",rb:"255",ga:"0",gb:"255",ba:"0",bb:"255",aa:"255",ab:"0"};
_global.resizeManager.AddListener(this);
stop();
