function onLoaded()
{
   var _loc1_ = HudPanel.HealthArmorPanel;
   _loc1_.HealthBar.HealthBarRed._visible = false;
   HudPanel.HealthArmorPanel.gotoAndStop("Init");
   m_nArmorIconDefaultPos = HudPanel.HealthArmorPanel.ArmorHelmetIcon._x;
   m_nArmorNumberDefaultPos = HudPanel.HealthArmorPanel.Armor._x;
   AmmoStyleUpdate(true);
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
   AmmoStyleUpdate(false);
}
function onUnload(mc)
{
   _global.tintManager.DeregisterAll(this);
   _global.resizeManager.RemoveListener(this);
   return true;
}
function onResize(rm)
{
   rm.ResetPositionByPixel(HudPanel,Lib.ResizeManager.SCALE_BIGGEST,Lib.ResizeManager.REFERENCE_SAFE_LEFT,0,Lib.ResizeManager.ALIGN_LEFT,Lib.ResizeManager.REFERENCE_SAFE_BOTTOM,0,Lib.ResizeManager.ALIGN_BOTTOM);
   var _loc3_ = _global.VoiceStatusMovie;
   if(_loc3_ != null && _loc3_ != undefined)
   {
      _loc3_.resizeRelative(HudPanel);
   }
   var _loc2_ = _global.Chat;
   if(_loc2_ != null && _loc2_ != undefined)
   {
      _loc2_.resizeRelative(HudPanel);
   }
}
function hideNow()
{
   HudPanel.gotoAndPlay("StartHide");
   HudPanel.HealthArmorPanel.gotoAndStop("Init");
}
function showNow()
{
   HudPanel.gotoAndPlay("StartShow");
   onResize(_global.resizeManager);
   AmmoStyleUpdate(false);
}
function AmmoStyleUpdate(force)
{
   var _loc2_ = _global.GameInterface.GetConvarNumber("cl_hud_healthammo_style");
   if(force || m_nAmmostyle != _loc2_)
   {
      SetStyle(_loc2_);
   }
   m_nAmmostyle = _loc2_;
}
function SetStyle(nStyle)
{
   if(nStyle == 1)
   {
      HudPanel.HealthArmorPanel.HeavyArmorIcon._x = m_nArmorIconDefaultPos + ARMOR_SIMPLE_OFFSET + HEAVY_ARMOR_OPFFSET;
      HudPanel.HealthArmorPanel.ArmorHelmetIcon._x = m_nArmorIconDefaultPos + ARMOR_SIMPLE_OFFSET;
      HudPanel.HealthArmorPanel.ArmorIcon._x = m_nArmorIconDefaultPos + ARMOR_SIMPLE_OFFSET;
      HudPanel.HealthArmorPanel.Armor._x = m_nArmorNumberDefaultPos + ARMOR_SIMPLE_OFFSET;
      HudPanel.HealthArmorPanel.HealthPanelBG._visible = false;
      HudPanel.HealthArmorPanel.HealthPanelBG_small._visible = true;
      HudPanel.HealthArmorPanel.HealthBar._visible = false;
      HudPanel.HealthArmorPanel.ArmorBar._visible = false;
      HudPanel.HealthArmorPanel.HealthPanelRed._visible = false;
      HudPanel.HealthArmorPanel.HealthPanelRed_small._visible = false;
   }
   else
   {
      HudPanel.HealthArmorPanel.HeavyArmorIcon._x = m_nArmorIconDefaultPos + HEAVY_ARMOR_OPFFSET;
      HudPanel.HealthArmorPanel.ArmorHelmetIcon._x = m_nArmorIconDefaultPos;
      HudPanel.HealthArmorPanel.ArmorIcon._x = m_nArmorIconDefaultPos;
      HudPanel.HealthArmorPanel.Armor._x = m_nArmorNumberDefaultPos;
      HudPanel.HealthArmorPanel.HealthPanelBG._visible = true;
      HudPanel.HealthArmorPanel.HealthPanelBG_small._visible = false;
      HudPanel.HealthArmorPanel.HealthBar._visible = true;
      HudPanel.HealthArmorPanel.ArmorBar._visible = true;
      HudPanel.HealthArmorPanel.HealthPanelRed._visible = false;
      HudPanel.HealthArmorPanel.HealthPanelRed_small._visible = false;
   }
   trace("AmmoStyleUpdate:SetStyle - nStyle =" + nStyle);
   trace("AmmoStyleUpdate:SetStyle - m_nArmorIconDefaultPos =" + m_nArmorIconDefaultPos + ", ArmorHelmetIcon._x = " + HudPanel.HealthArmorPanel.ArmorHelmetIcon._x);
   trace("AmmoStyleUpdate:SetStyle - m_nArmorNumberDefaultPos =" + m_nArmorNumberDefaultPos);
}
function updateValues(realHealth, percentHealth, newArmor, percentArmor, bHasHelmet, bHasHeavyArmor)
{
   var _loc2_ = HudPanel.HealthArmorPanel;
   var _loc3_ = _loc2_.HealthBar;
   if(_loc3_.HealthBar != undefined)
   {
      _loc3_.HealthBar.gotoAndStop(percentHealth);
   }
   if(_loc3_.HealthBarRed != undefined)
   {
      _loc3_.HealthBarRed.gotoAndStop(percentHealth);
   }
   if(_loc2_.ArmorBar.ArmorBar != undefined)
   {
      _loc2_.ArmorBar.ArmorBar.gotoAndStop(percentArmor);
   }
   if(bHasHelmet)
   {
      _loc2_.ArmorHelmetIcon._visible = true;
      _loc2_.ArmorIcon._visible = false;
   }
   else
   {
      _loc2_.ArmorHelmetIcon._visible = false;
      _loc2_.ArmorIcon._visible = true;
   }
   _loc2_.HeavyArmorIcon._visible = bHasHeavyArmor;
   var _loc4_ = 34;
   if(realHealth > 100)
   {
      _loc4_ = 18;
   }
   trace("HEALTH: updateValues: realHealth = " + realHealth);
   _global.AutosizeTextDown(HudPanel.HealthArmorPanel.HealthRed.TextBox,_loc4_);
   _global.AutosizeTextDown(HudPanel.HealthArmorPanel.Health.TextBox,_loc4_);
   HudPanel.HealthArmorPanel.HealthRed.TextBox._y = (HudPanel.HealthArmorPanel.HealthRed._height - HudPanel.HealthArmorPanel.HealthRed.TextBox.textHeight) * 0.5;
   HudPanel.HealthArmorPanel.Health.TextBox._y = (HudPanel.HealthArmorPanel.Health._height - HudPanel.HealthArmorPanel.Health.TextBox.textHeight) * 0.5;
}
function setColorText()
{
   var _loc3_ = 13887384;
   var _loc2_ = 13887384;
   if(_global.SFRadar)
   {
      _loc3_ = _global.SFRadar.GetHudTextHexColor();
      _loc2_ = _global.SFRadar.GetBGHudTextHexColor(0.9,0.9);
   }
   var _loc5_ = new Color(HudPanel.HealthArmorPanel.HealthIcon);
   var _loc8_ = new Color(HudPanel.HealthArmorPanel.ArmorIcon);
   var _loc4_ = new Color(HudPanel.HealthArmorPanel.ArmorHelmetIcon);
   var _loc6_ = new Color(HudPanel.HealthArmorPanel.HealthBar.HealthBar);
   var _loc7_ = new Color(HudPanel.HealthArmorPanel.ArmorBar.ArmorBar);
   if(m_bGotDefaultColors == false)
   {
      HudPanel.HealthArmorPanel.HealthRed.TextBox.defaultTextColor = HudPanel.HealthArmorPanel.HealthRed.TextBox.textColor;
      HudPanel.HealthArmorPanel.Health.TextBox.defaultTextColor = HudPanel.HealthArmorPanel.Health.TextBox.textColor;
      HudPanel.HealthArmorPanel.Armor.TextBox.defaultTextColor = HudPanel.HealthArmorPanel.Armor.TextBox.textColor;
      m_bGotDefaultColors = true;
   }
   var _loc9_ = _global.GameInterface.GetConvarNumber("cl_hud_color");
   if(_loc9_ == 0)
   {
      HudPanel.HealthArmorPanel.HealthRed.TextBox.textColor = HudPanel.HealthArmorPanel.HealthRed.TextBox.defaultTextColor;
      HudPanel.HealthArmorPanel.Health.TextBox.textColor = HudPanel.HealthArmorPanel.Health.TextBox.defaultTextColor;
      HudPanel.HealthArmorPanel.Armor.TextBox.textColor = HudPanel.HealthArmorPanel.Armor.TextBox.defaultTextColor;
      _loc5_.setTransform({ra:100,rb:0,ga:100,gb:0,ba:100,bb:0});
      _loc8_.setTransform({ra:100,rb:0,ga:100,gb:0,ba:100,bb:0});
      _loc4_.setTransform({ra:100,rb:0,ga:100,gb:0,ba:100,bb:0});
      _loc6_.setTransform({ra:100,rb:0,ga:100,gb:0,ba:100,bb:0});
      _loc7_.setTransform({ra:100,rb:0,ga:100,gb:0,ba:100,bb:0});
   }
   else
   {
      HudPanel.HealthArmorPanel.HealthRed.TextBox.textColor = _loc3_;
      HudPanel.HealthArmorPanel.Health.TextBox.textColor = _loc3_;
      HudPanel.HealthArmorPanel.Armor.TextBox.textColor = _loc3_;
      _loc5_.setRGB(_loc2_);
      _loc8_.setRGB(_loc2_);
      _loc4_.setRGB(_loc2_);
      _loc6_.setRGB(_loc2_);
      _loc7_.setRGB(_loc2_);
   }
}
_global.HAmodule = this;
var m_nAmmostyle = 0;
var m_nArmorIconDefaultPos = 0;
var m_nArmorNumberDefaultPos = 0;
var ARMOR_SIMPLE_OFFSET = -51.75;
var HEAVY_ARMOR_OPFFSET = -2.5;
var m_bGotDefaultColors = false;
_global.resizeManager.AddListener(this);
stop();
