function onLoaded()
{
   updateAmmo(0,0);
   var _loc1_ = HudPanel.WeaponPanel;
   _loc1_.AmmoAnim.gotoAndStop("FullClip");
   _loc1_.AmmoAnimFast.gotoAndStop("FullClip");
   _loc1_.Kill_Icon_1._visible = false;
   _loc1_.Kill_Icon_2._visible = false;
   _loc1_.Kill_Icon_3._visible = false;
   _loc1_.Kill_Icon_4._visible = false;
   _loc1_.Kill_Icon_5._visible = false;
   _loc1_.KillCount._visible = false;
   _loc1_.KillEater._visible = false;
   _loc1_.WeaponName._visible = false;
   _loc1_.AmmoCountTotal.defaultPos = _loc1_.AmmoCountTotal._x;
   _loc1_.BurstTypeSingle.defaultPos = _loc1_.BurstTypeSingle._x;
   _loc1_.BurstTypeBurst.defaultPos = _loc1_.BurstTypeBurst._x;
   _loc1_.AmmoCountClip.defaultPos = _loc1_.AmmoCountClip._x;
   _loc1_.Kill_Icon_1.defaultPos = _loc1_.Kill_Icon_1._x;
   _loc1_.Kill_Icon_2.defaultPos = _loc1_.Kill_Icon_2._x;
   _loc1_.Kill_Icon_3.defaultPos = _loc1_.Kill_Icon_3._x;
   _loc1_.Kill_Icon_4.defaultPos = _loc1_.Kill_Icon_4._x;
   _loc1_.Kill_Icon_5.defaultPos = _loc1_.Kill_Icon_5._x;
   _loc1_.KillCount.defaultPos = _loc1_.KillCount._x;
   _loc1_.KillEater.defaultPos = _loc1_.KillEater._x;
   m_bGotDefaultColors = false;
   gameAPI.OnReady();
}
function setVisible(bShow)
{
   HudPanel._visible = bShow;
   if(!bShow)
   {
      HudPanel.gotoAndStop("Hide");
   }
   AmmoStyleUpdate();
}
function onUnload(mc)
{
   _global.tintManager.DeregisterAll(this);
   _global.resizeManager.RemoveListener(this);
   return true;
}
function onResize(rm)
{
   rm.ResetPositionByPercentage(HudPanel,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_SAFE_RIGHT,0,Lib.ResizeManager.ALIGN_RIGHT,Lib.ResizeManager.REFERENCE_SAFE_BOTTOM,0,Lib.ResizeManager.ALIGN_CENTER);
   var _loc2_ = _global.WeaponSelectedAnchor;
   if(_loc2_ != null && _loc2_ != undefined)
   {
      _loc2_.resizeRelative(HudPanel);
   }
}
function hideNow()
{
   HudPanel.gotoAndPlay("StartHide");
}
function showNow()
{
   HudPanel.gotoAndPlay("StartShow");
   AmmoStyleUpdate();
}
function updateKillEater(KillEaterCount)
{
   if(KillEaterCount == 0)
   {
      HudPanel.WeaponPanel.KillEater._visible = false;
   }
   else
   {
      HudPanel.WeaponPanel.KillEater._visible = true;
      HudPanel.WeaponPanel.KillEater.TextBox.htmlText = KillEaterCount;
   }
}
function updateAmmo(newAmmoType, newClipCount, maxClipCount, itemName)
{
   var _loc6_ = HudPanel.WeaponPanel;
   var _loc4_ = _loc6_.AmmoAnim;
   var _loc7_ = newClipCount / maxClipCount;
   _loc4_._visible = newAmmoType == 0;
   if(_loc4_._visible)
   {
      _loc4_.Bullet1._visible = newClipCount >= 1;
      _loc4_.Bullet2._visible = newClipCount >= 2;
      _loc4_.Bullet3._visible = newClipCount >= 3;
      _loc4_.Bullet4._visible = newClipCount >= 4;
      _loc4_.Bullet5._visible = newClipCount >= 5;
      if(_loc7_ <= 0.2)
      {
         transformBulletEject.setTransform(redColorTransform);
         transformClip.setTransform(redColorTransform);
      }
      else
      {
         updateAmmoColor();
      }
   }
   var _loc2_ = _loc6_.Grenades;
   _loc2_._visible = newAmmoType > 0 && newClipCount > 0;
   if(_loc2_._visible)
   {
      if(newAmmoType == 10)
      {
         itemName = "healthshotammo";
      }
      else
      {
         var _loc5_ = itemName.indexOf("_");
         if(_loc5_ >= 0)
         {
            itemName = itemName.substr(_loc5_ + 1);
         }
      }
      itemName = "icon-" + itemName;
      _loc2_.AmmoGrenade.attachMovie(itemName,"Image",0);
      _loc2_.AmmoGrenade._visible = true;
      if(newClipCount > 1)
      {
         _loc2_.AmmoGrenade2.attachMovie(itemName,"Image",0);
      }
      if(newClipCount > 2)
      {
         _loc2_.AmmoGrenade3.attachMovie(itemName,"Image",0);
      }
      if(newClipCount > 3)
      {
         _loc2_.AmmoGrenade4.attachMovie(itemName,"Image",0);
      }
      _loc2_.AmmoGrenade2._visible = newClipCount > 1;
      _loc2_.AmmoGrenade3._visible = newClipCount > 2;
      _loc2_.AmmoGrenade4._visible = newClipCount > 3;
      colorGrenades();
   }
}
function playUpgradeAnim()
{
   var _loc1_ = HudPanel.WeaponPanel;
   _loc1_.UpgradeText.gotoAndPlay("start");
}
function setNumberKills(nKills, nHeadshotKills, nGGKillsNeeded)
{
   trace("************ m_nLastNumRoundKills = " + m_nLastNumRoundKills + ", setNumberKills = " + nKills);
   if(m_nLastNumRoundKills > nKills || m_nLastHeadshotKills > nHeadshotKills)
   {
      m_nLastNumRoundKills = nKills;
      m_nLastHeadshotKills = nHeadshotKills;
   }
   var _loc10_ = HudPanel.WeaponPanel.Kill_Icon_1;
   var _loc12_ = HudPanel.WeaponPanel.Kill_Icon_2;
   var _loc13_ = HudPanel.WeaponPanel.Kill_Icon_3;
   var _loc8_ = HudPanel.WeaponPanel.Kill_Icon_4;
   var _loc11_ = HudPanel.WeaponPanel.Kill_Icon_5;
   var _loc9_ = HudPanel.WeaponPanel.KillCount;
   if(!_loc10_)
   {
      trace("Did not find HudPanel.WeaponPanel.Kill_Icon_1!!!!!!!");
   }
   if(nKills <= 0)
   {
      _loc10_._visible = false;
      _loc12_._visible = false;
      _loc13_._visible = false;
      _loc8_._visible = false;
      _loc11_._visible = false;
      _loc9_._visible = false;
   }
   else
   {
      if(m_nLastNumRoundKills == nKills)
      {
         trace("************ m_nLastNumRoundKills = nKills, aborting!");
         return undefined;
      }
      if(nKills > 5)
      {
         _loc10_._visible = false;
         _loc12_._visible = false;
         _loc13_._visible = false;
         _loc8_._visible = true;
         _loc11_._visible = false;
         _loc9_._visible = true;
         _loc8_.gotoAndPlay("Start");
         _loc9_.Text.htmlText = "x" + nKills;
      }
      else
      {
         var _loc6_ = false;
         var _loc1_ = 1;
         while(_loc1_ <= 5)
         {
            var _loc5_ = "Kill_Icon_" + _loc1_;
            var _loc2_ = HudPanel.WeaponPanel[_loc5_];
            if(_loc2_)
            {
               if(_loc1_ <= nKills)
               {
                  if(nHeadshotKills > m_nLastHeadshotKills)
                  {
                     trace("******** setNumberKills [" + _loc1_ + "] StartHeadshot");
                     _loc2_.gotoAndPlay("StartHeadshot");
                     m_nLastHeadshotKills = nHeadshotKills;
                     _loc6_ = true;
                  }
                  else if(_loc1_ <= nHeadshotKills)
                  {
                     trace("******** setNumberKills [" + _loc1_ + "] ShowHeadshot");
                     _loc2_.gotoAndStop("ShowHeadshot");
                  }
                  else if(_loc2_._visible == false && _loc6_ == false)
                  {
                     _loc2_.gotoAndPlay("Start");
                     trace("******** setNumberKills [" + _loc1_ + "] Start");
                  }
                  else
                  {
                     _loc2_.gotoAndStop("ShowNormal");
                     trace("******** setNumberKills [" + _loc1_ + "] ShowNormal");
                  }
                  _loc2_._visible = true;
               }
               else
               {
                  _loc2_._visible = false;
               }
            }
            _loc1_ = _loc1_ + 1;
         }
      }
   }
   m_nLastNumRoundKills = nKills;
   m_nLastHeadshotKills = nHeadshotKills;
   _loc1_ = nGGKillsNeeded;
   while(_loc1_ > 0)
   {
      _loc5_ = "Kill_Icon_" + _loc1_;
      _loc2_ = HudPanel.WeaponPanel[_loc5_];
      if(_loc2_ && nKills < _loc1_)
      {
         _loc2_.gotoAndStop("ShowBlank");
         _loc2_._visible = true;
         trace("******** setNumberKills [" + _loc1_ + "] ShowBlank");
      }
      _loc1_ = _loc1_ - 1;
   }
}
function AmmoStyleUpdate()
{
   var _loc2_ = _global.GameInterface.GetConvarNumber("cl_hud_healthammo_style");
   if(m_nAmmostyle != _loc2_)
   {
      SetStyle(_loc2_);
   }
   m_nAmmostyle = _loc2_;
}
function SetStyle(nStyle)
{
   var _loc1_ = HudPanel.WeaponPanel;
   if(nStyle == 1)
   {
      _loc1_.AmmoAnim._visible = false;
      _loc1_.AmmoAnim.gotoAndStop("clear");
      _loc1_.AmmoCountTotal._x = _loc1_.AmmoCountTotal.defaultPos + AMMO_SIMPLE_OFFSET;
      _loc1_.BurstTypeSingle._x = _loc1_.BurstTypeSingle.defaultPos + AMMO_SIMPLE_OFFSET;
      _loc1_.BurstTypeBurst._x = _loc1_.BurstTypeBurst.defaultPos + AMMO_SIMPLE_OFFSET;
      _loc1_.AmmoCountClip._x = _loc1_.AmmoCountClip.defaultPos + AMMO_SIMPLE_OFFSET;
      _loc1_.Kill_Icon_1._x = _loc1_.Kill_Icon_1.defaultPos + AMMO_SIMPLE_OFFSET;
      _loc1_.Kill_Icon_2._x = _loc1_.Kill_Icon_2.defaultPos + AMMO_SIMPLE_OFFSET;
      _loc1_.Kill_Icon_3._x = _loc1_.Kill_Icon_3.defaultPos + AMMO_SIMPLE_OFFSET;
      _loc1_.Kill_Icon_4._x = _loc1_.Kill_Icon_4.defaultPos + AMMO_SIMPLE_OFFSET;
      _loc1_.Kill_Icon_5._x = _loc1_.Kill_Icon_5.defaultPos + AMMO_SIMPLE_OFFSET;
      _loc1_.KillCount._x = _loc1_.KillCount.defaultPos + AMMO_SIMPLE_OFFSET;
      _loc1_.KillEater._x = _loc1_.KillEater.defaultPos + AMMO_SIMPLE_OFFSET;
   }
   else
   {
      _loc1_.AmmoAnim._visible = true;
      _loc1_.AmmoAnim.gotoAndPlay("StartShow");
      _loc1_.AmmoCountTotal._x = _loc1_.AmmoCountTotal.defaultPos;
      _loc1_.BurstTypeSingle._x = _loc1_.BurstTypeSingle.defaultPos;
      _loc1_.BurstTypeBurst._x = _loc1_.BurstTypeBurst.defaultPos;
      _loc1_.AmmoCountClip._x = _loc1_.AmmoCountClip.defaultPos;
      _loc1_.Kill_Icon_1._x = _loc1_.Kill_Icon_1.defaultPos;
      _loc1_.Kill_Icon_2._x = _loc1_.Kill_Icon_2.defaultPos;
      _loc1_.Kill_Icon_3._x = _loc1_.Kill_Icon_3.defaultPos;
      _loc1_.Kill_Icon_4._x = _loc1_.Kill_Icon_4.defaultPos;
      _loc1_.Kill_Icon_5._x = _loc1_.Kill_Icon_5.defaultPos;
      _loc1_.KillCount._x = _loc1_.KillCount.defaultPos;
      _loc1_.KillEater._x = _loc1_.KillEater.defaultPos;
   }
}
function ShowBomb(bShow)
{
   HudPanel.WeaponPanel.BombCarrierIcon._visible = bShow;
   if(m_bBombVisible == false && bShow == true)
   {
      HudPanel.WeaponPanel.BombCarrierIcon.gotoAndPlay("Highlight");
   }
   m_bBombVisible = bShow;
}
function weaponFired()
{
   var _loc1_ = HudPanel.WeaponPanel;
   if(m_nAmmostyle == 1)
   {
      _loc1_.AmmoAnim.gotoAndStop("clear");
      _loc1_.AmmoAnim._visible = false;
      return undefined;
   }
   _loc1_.AmmoAnim.gotoAndPlay("StartShow");
   _loc1_.AmmoAnim._visible = true;
   var _loc2_ = undefined;
   var _loc3_ = undefined;
   if(AmmoEjectAnimList.length < 16)
   {
      _loc3_ = "Animation" + AmmoEjectAnimList.length.toString();
      _loc2_ = _loc1_.AmmoAnimFast.attachMovie("ammo-left-fast",_loc3_,_loc1_.AmmoAnimFast.getNextHighestDepth());
      AmmoEjectAnimList.push(_loc2_);
   }
   else
   {
      _loc3_ = "Animation" + CurrentEjectAnimIndex.toString();
      _loc2_ = _loc1_.AmmoAnimFast[_loc3_];
      CurrentEjectAnimIndex++;
      if(CurrentEjectAnimIndex >= AmmoEjectAnimList.length)
      {
         CurrentEjectAnimIndex = 0;
      }
   }
   _loc2_.gotoAndPlay("StartShow");
}
function updateAmmoColor()
{
   var _loc2_ = 13887384;
   if(_global.SFRadar)
   {
      _loc2_ = _global.SFRadar.GetBGHudTextHexColor(0.85,0.75);
   }
   transformBulletEject.setRGB(_loc2_);
   transformClip.setRGB(_loc2_);
}
function setColorText()
{
   var _loc2_ = 13887384;
   var _loc3_ = 13887384;
   if(_global.SFRadar)
   {
      _loc2_ = _global.SFRadar.GetHudTextHexColor();
      _loc3_ = _global.SFRadar.GetBGHudTextHexColor(0.85,0.75);
   }
   var _loc5_ = new Color(HudPanel.WeaponPanel.Grenades);
   var _loc6_ = new Color(HudPanel.WeaponPanel.BurstTypeBurst);
   var _loc4_ = new Color(HudPanel.WeaponPanel.BurstTypeSingle);
   if(m_bGotDefaultColors == false)
   {
      HudPanel.WeaponPanel.AmmoCountClip.TextBox.defaultTextColor = HudPanel.WeaponPanel.AmmoCountClip.TextBox.textColor;
      HudPanel.WeaponPanel.AmmoCountTotal.TextBox.defaultTextColor = HudPanel.WeaponPanel.AmmoCountTotal.TextBox.textColor;
      HudPanel.WeaponPanel.KillEater.TextBox.defaultTextColor = HudPanel.WeaponPanel.KillEater.TextBox.textColor;
      HudPanel.WeaponPanel.KillEater.TextBox2.defaultTextColor = HudPanel.WeaponPanel.KillEater.TextBox2.textColor;
      m_bGotDefaultColors = true;
   }
   var _loc7_ = _global.GameInterface.GetConvarNumber("cl_hud_color");
   if(_loc7_ == 0)
   {
      HudPanel.WeaponPanel.AmmoCountClip.TextBox.textColor = HudPanel.WeaponPanel.AmmoCountClip.TextBox.defaultTextColor;
      HudPanel.WeaponPanel.AmmoCountTotal.TextBox.textColor = HudPanel.WeaponPanel.AmmoCountTotal.TextBox.defaultTextColor;
      HudPanel.WeaponPanel.KillEater.TextBox.textColor = HudPanel.WeaponPanel.KillEater.TextBox.defaultTextColor;
      HudPanel.WeaponPanel.KillEater.TextBox2.textColor = HudPanel.WeaponPanel.KillEater.TextBox2.defaultTextColor;
      _loc5_.setTransform({ra:100,rb:0,ga:100,gb:0,ba:100,bb:0});
      _loc6_.setTransform({ra:100,rb:0,ga:100,gb:0,ba:100,bb:0});
      _loc4_.setTransform({ra:100,rb:0,ga:100,gb:0,ba:100,bb:0});
   }
   else
   {
      HudPanel.WeaponPanel.AmmoCountClip.TextBox.textColor = _loc2_;
      HudPanel.WeaponPanel.AmmoCountTotal.TextBox.textColor = _loc3_;
      HudPanel.WeaponPanel.KillEater.TextBox.textColor = _loc2_;
      HudPanel.WeaponPanel.KillEater.TextBox2.textColor = _loc3_;
      _loc5_.setRGB(_loc2_);
      _loc6_.setRGB(_loc2_);
      _loc4_.setRGB(_loc2_);
   }
   updateAmmoColor();
}
function colorGrenades()
{
   var _loc3_ = 13887384;
   var _loc4_ = _global.GameInterface.GetConvarNumber("cl_hud_color");
   var _loc2_ = new Color(HudPanel.WeaponPanel.Grenades);
   if(_global.SFRadar)
   {
      _loc3_ = _global.SFRadar.GetHudTextHexColor();
   }
   if(_loc4_ == 0)
   {
      _loc2_.setTransform({ra:100,rb:0,ga:100,gb:0,ba:100,bb:0});
   }
   else
   {
      _loc2_.setRGB(_loc3_);
   }
}
function switchWeaponName(newWeaponName)
{
}
_global.WeaponModule = this;
var m_nAmmostyle = 0;
var m_bBombVisible = false;
var m_bGotDefaultColors = false;
var AMMO_SIMPLE_OFFSET = 67.25;
var redColorTransform = new Object();
redColorTransform = {ra:"0",rb:"255",ga:"0",gb:"0",ba:"0",bb:"0",aa:"100",ab:"0"};
var defaultColorTransform = new Object();
defaultColorTransform = {ra:"100",rb:"0",ga:"100",gb:"0",ba:"100",bb:"0",aa:"100",ab:"0"};
var transformClip = new Color(HudPanel.WeaponPanel.AmmoAnim);
var transformBulletEject = new Color(HudPanel.WeaponPanel.AmmoAnimFast);
var m_nLastNumRoundKills = 0;
var m_nLastHeadshotKills = 0;
var AmmoEjectAnimList = new Array();
var CurrentEjectAnimIndex = 0;
_global.resizeManager.AddListener(this);
stop();
