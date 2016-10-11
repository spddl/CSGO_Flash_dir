_global.OverwatchResolutionMovie = this;
_global.OverwatchResolutionAPI = gameAPI;
function InitOverwatchResolutionNav()
{
   OverwatchResolutionNav.DenyInputToGame(true);
   OverwatchResolutionNav.ShowCursor(true);
   OverwatchResolutionNav.AddTabOrder([]);
   OverwatchResolutionNav.SetInitialHighlight(PPanel.Postpone);
   OverwatchResolutionNav.AddKeyHandlerTable({CANCEL:{onDown:function(button, control, keycode)
   {
      HideFromScript();
   },onUp:function(button, control, keycode)
   {
      return true;
   }}});
}
function onResize(rm)
{
   rm.DisableAdditionalScaling = true;
   rm.ResetPositionByPixel(Panel,Lib.ResizeManager.SCALE_USING_VERTICAL,Lib.ResizeManager.REFERENCE_CENTER_X,0,Lib.ResizeManager.ALIGN_CENTER,Lib.ResizeManager.REFERENCE_TOP,0,Lib.ResizeManager.ALIGN_NONE);
}
function onLoaded()
{
   InitOverwatchResolutionNav();
   gameAPI.OnReady();
}
function showPanel()
{
   _global.navManager.PushLayout(OverwatchResolutionNav,"OverwatchResolutionNav");
   Panel.SubmitStatus._visible = false;
   Panel.Grief_Major.dialog = this;
   Panel.Grief_Major.Action = function()
   {
      this.dialog.onRadioButtonGrief(this);
   };
   Panel.Grief_Major.SetText("#SFUI_Overwatch_Res_Major_Label");
   Panel.Grief_Major.Selected._visible = false;
   Panel.Grief_Major.cat = "grief";
   Panel.Grief_Major.type = "convict";
   Panel.Grief_No.dialog = this;
   Panel.Grief_No.Action = function()
   {
      this.dialog.onRadioButtonGrief(this);
   };
   Panel.Grief_No.SetText("#SFUI_Overwatch_Res_NotGuilty_Label");
   Panel.Grief_No.Selected._visible = false;
   Panel.Grief_No.cat = "grief";
   Panel.Grief_No.type = "dismiss";
   Panel.Aim_Major.dialog = this;
   Panel.Aim_Major.Action = function()
   {
      this.dialog.onRadioButtonAim(this);
   };
   Panel.Aim_Major.SetText("#SFUI_Overwatch_Res_Major_Label");
   Panel.Aim_Major.Selected._visible = false;
   Panel.Aim_Major.cat = "aimbot";
   Panel.Aim_Major.type = "convict";
   Panel.Aim_No.dialog = this;
   Panel.Aim_No.Action = function()
   {
      this.dialog.onRadioButtonAim(this);
   };
   Panel.Aim_No.SetText("#SFUI_Overwatch_Res_NotGuilty_Label");
   Panel.Aim_No.Selected._visible = false;
   Panel.Aim_No.cat = "aimbot";
   Panel.Aim_No.type = "dismiss";
   Panel.Speed_Major.dialog = this;
   Panel.Speed_Major.Action = function()
   {
      this.dialog.onRadioButtonSpeed(this);
   };
   Panel.Speed_Major.SetText("#SFUI_Overwatch_Res_Major_Label");
   Panel.Speed_Major.Selected._visible = false;
   Panel.Speed_Major.cat = "speedhack";
   Panel.Speed_Major.type = "convict";
   Panel.Speed_No.dialog = this;
   Panel.Speed_No.Action = function()
   {
      this.dialog.onRadioButtonSpeed(this);
   };
   Panel.Speed_No.SetText("#SFUI_Overwatch_Res_NotGuilty_Label");
   Panel.Speed_No.Selected._visible = false;
   Panel.Speed_No.cat = "speedhack";
   Panel.Speed_No.type = "dismiss";
   Panel.Wall_Major.dialog = this;
   Panel.Wall_Major.Action = function()
   {
      this.dialog.onRadioButtonWall(this);
   };
   Panel.Wall_Major.SetText("#SFUI_Overwatch_Res_Major_Label");
   Panel.Wall_Major.Selected._visible = false;
   Panel.Wall_Major.cat = "wallhack";
   Panel.Wall_Major.type = "convict";
   Panel.Wall_No.dialog = this;
   Panel.Wall_No.Action = function()
   {
      this.dialog.onRadioButtonWall(this);
   };
   Panel.Wall_No.SetText("#SFUI_Overwatch_Res_NotGuilty_Label");
   Panel.Wall_No.Selected._visible = false;
   Panel.Wall_No.cat = "wallhack";
   Panel.Wall_No.type = "dismiss";
   Panel.Postpone.dialog = this;
   Panel.Postpone.Action = function()
   {
      this.dialog.onPostpone(this);
   };
   Panel.Postpone.SetText("#SFUI_Overwatch_Res_Postpone_Label");
   Panel.Submit.dialog = this;
   Panel.Submit.Action = function()
   {
      this.dialog.onSubmit(this);
   };
   Panel.Submit.SetText("#SFUI_Overwatch_Submit_Label");
   Panel.Submit.setDisabled(true);
   Panel.Blocker.Black.onPress = function()
   {
   };
}
function onRadioButtonGrief(objButton)
{
   objButton.Selected._visible = true;
   if(objButton.type == "dismiss")
   {
      Panel.Grief_Major.Selected._visible = false;
   }
   else
   {
      Panel.Grief_No.Selected._visible = false;
   }
   onRadioButton(objButton);
}
function onRadioButtonAim(objButton)
{
   objButton.Selected._visible = true;
   if(objButton.type == "dismiss")
   {
      Panel.Aim_Major.Selected._visible = false;
   }
   else
   {
      Panel.Aim_No.Selected._visible = false;
   }
   onRadioButton(objButton);
}
function onRadioButtonSpeed(objButton)
{
   objButton.Selected._visible = true;
   if(objButton.type == "dismiss")
   {
      Panel.Speed_Major.Selected._visible = false;
   }
   else
   {
      Panel.Speed_No.Selected._visible = false;
   }
   onRadioButton(objButton);
}
function onRadioButtonWall(objButton)
{
   objButton.Selected._visible = true;
   if(objButton.type == "dismiss")
   {
      Panel.Wall_Major.Selected._visible = false;
   }
   else
   {
      Panel.Wall_No.Selected._visible = false;
   }
   onRadioButton(objButton);
}
function onRadioButton(objButton)
{
   m_categoryArray[objButton.cat] = objButton.type;
   if(CheckCanSubmit())
   {
      Panel.Submit.setDisabled(false);
   }
}
function CheckCanSubmit()
{
   for(var _loc1_ in m_categoryArray)
   {
      if(m_categoryArray[_loc1_] == 0)
      {
         return false;
      }
   }
   return true;
}
function onPostpone()
{
   HideFromScript();
}
function onSubmit()
{
   var _loc2_ = "";
   for(var _loc3_ in m_categoryArray)
   {
      trace("key is: " + _loc3_ + " and value " + m_categoryArray[_loc3_]);
      if(_loc2_ != "")
      {
         _loc2_ = _loc2_ + ",";
      }
      _loc2_ = _loc2_ + _loc3_ + ":" + m_categoryArray[_loc3_];
   }
   _global.CScaleformComponent_Overwatch.SubmitCaseVerdict(_loc2_);
   Panel.SubmitStatus._visible = true;
   Panel.SubmitStatus.gotoAndPlay("StartAnim");
   GameTimeInterval = setInterval(SubmitStatus,2000);
   Panel.Submit.setDisabled(true);
   Panel.Postpone.setDisabled(true);
   Panel.Grief_Major.setDisabled(true);
   Panel.Grief_No.setDisabled(true);
   Panel.Aim_Major.setDisabled(true);
   Panel.Aim_No.setDisabled(true);
   Panel.Speed_Major.setDisabled(true);
   Panel.Speed_No.setDisabled(true);
   Panel.Wall_Major.setDisabled(true);
   Panel.Wall_No.setDisabled(true);
   m_categoryArray.grief = 0;
   m_categoryArray.aimbot = 0;
   m_categoryArray.speedhack = 0;
   m_categoryArray.wallhack = 0;
}
function SubmitStatus()
{
   clearInterval(GameTimeInterval);
   HideFromScript();
}
function HideFromScript()
{
   gameAPI.HideFromScript();
}
function hidePanel()
{
   _global.navManager.RemoveLayout(OverwatchResolutionNav);
}
function onUnload(mc)
{
   _global.OverwatchResolutionMovie = null;
   _global.OverwatchResolutionAPI = null;
   _global.resizeManager.RemoveListener(this);
   _global.tintManager.DeregisterAll(this);
   return true;
}
if(_global.OverwatchResolutionNav != undefined)
{
   return undefined;
}
var objSelectedButton = null;
var OverwatchResolutionNav = new Lib.NavLayout();
_global.resizeManager.AddListener(this);
var m_categoryArray = new Array();
m_categoryArray.grief = 0;
m_categoryArray.aimbot = 0;
m_categoryArray.speedhack = 0;
m_categoryArray.wallhack = 0;
stop();
