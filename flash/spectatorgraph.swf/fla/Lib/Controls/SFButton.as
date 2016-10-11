class Lib.Controls.SFButton extends MovieClip
{
   var navLayout = null;
   static var BUTTON_STATE_UP = 0;
   static var BUTTON_STATE_OVER = 1;
   static var BUTTON_STATE_DOWN = 2;
   static var BUTTON_STATE_DISABLED = 3;
   static var MAX_BUTTON_STATE = 4;
   static var imA = "SFButton";
   static var inittedPrototype = false;
   static var staticsInitted = Lib.Controls.SFButton.initStatics();
   function SFButton()
   {
      super();
   }
   function UnsetState()
   {
      this.setState(Lib.Controls.SFButton.BUTTON_STATE_UP);
   }
   function SuppressHighlightSound()
   {
      return true;
   }
   function PlayActionSound()
   {
      if(this.buttonState != Lib.Controls.SFButton.BUTTON_STATE_DISABLED && !this.isModalLockedOut())
      {
         _global.navManager.PlayNavSound(this.actionSound);
      }
   }
   function PlayHighlightSound()
   {
      if(this.buttonState != Lib.Controls.SFButton.BUTTON_STATE_DISABLED && !this.isModalLockedOut())
      {
         _global.navManager.PlayNavSound(this.highlightSound);
      }
   }
   function MouseAction()
   {
      if(this.buttonState != Lib.Controls.SFButton.BUTTON_STATE_DISABLED && !this.isModalLockedOut())
      {
         this.PlayActionSound();
         this.Action();
      }
   }
   function SetFocusFromMouse()
   {
      if(this.buttonState != Lib.Controls.SFButton.BUTTON_STATE_DISABLED && !this.isModalLockedOut())
      {
         _global.navManager.SetHighlightedObject(this.objectToHighlightOnMouseFocus);
      }
   }
   function Action()
   {
      trace("Pressed");
   }
   function Focus(hasFocus)
   {
   }
   function setGfxState(newState)
   {
      this.setGfxStateArray.newState(this);
   }
   function changeGfxState(oldState, newState)
   {
      this[oldState * Lib.Controls.SFButton.MAX_BUTTON_STATE + newState].call(this,this);
   }
   function setState(newState)
   {
      this.changeGfxState(this.buttonState,newState);
      this.buttonState = newState;
   }
   function setDisabled(disable)
   {
      if(disable && this.buttonState != Lib.Controls.SFButton.BUTTON_STATE_DISABLED)
      {
         this.setState(Lib.Controls.SFButton.BUTTON_STATE_DISABLED);
      }
      else if(!disable && this.buttonState == Lib.Controls.SFButton.BUTTON_STATE_DISABLED)
      {
         this.setState(Lib.Controls.SFButton.BUTTON_STATE_UP);
      }
   }
   function RolledOver()
   {
   }
   function onRollOver()
   {
      if(this.buttonState != Lib.Controls.SFButton.BUTTON_STATE_DISABLED && !this.isModalLockedOut())
      {
         _global.navManager.addMouseOverControl(this);
         _global.navManager.SetHighlightedObject(null);
         this.setState(Lib.Controls.SFButton.BUTTON_STATE_OVER);
         this.PlayHighlightSound();
         this.RolledOver();
      }
   }
   function RolledOut()
   {
   }
   function onRollOut()
   {
      if(this.buttonState != Lib.Controls.SFButton.BUTTON_STATE_DISABLED && !this.isModalLockedOut())
      {
         _global.navManager.removeMouseOverControl(this);
         this.setState(Lib.Controls.SFButton.BUTTON_STATE_UP);
         this.RolledOut();
      }
   }
   function DraggedOver()
   {
      this.RolledOver();
   }
   function onDragOver()
   {
      if(this.buttonState != Lib.Controls.SFButton.BUTTON_STATE_DISABLED && !this.isModalLockedOut())
      {
         if(this.mouseCaptured)
         {
            this.setState(Lib.Controls.SFButton.BUTTON_STATE_DOWN);
         }
         else
         {
            this.setState(Lib.Controls.SFButton.BUTTON_STATE_OVER);
            this.DraggedOver();
         }
      }
   }
   function DraggedOut()
   {
      this.RolledOut();
   }
   function onDragOut()
   {
      if(this.buttonState != Lib.Controls.SFButton.BUTTON_STATE_DISABLED && !this.isModalLockedOut())
      {
         this.setState(Lib.Controls.SFButton.BUTTON_STATE_UP);
         this.DraggedOut();
      }
   }
   function onPress()
   {
      if(this.buttonState != Lib.Controls.SFButton.BUTTON_STATE_DISABLED && !this.isModalLockedOut())
      {
         this.mouseCaptured = true;
         this.setState(Lib.Controls.SFButton.BUTTON_STATE_DOWN);
         this.SetFocusFromMouse();
      }
   }
   function onRelease()
   {
      if(this.buttonState != Lib.Controls.SFButton.BUTTON_STATE_DISABLED && !this.isModalLockedOut())
      {
         this.mouseCaptured = false;
         this.setState(Lib.Controls.SFButton.BUTTON_STATE_OVER);
         this.MouseAction();
      }
   }
   function onReleaseOutside()
   {
      if(this.buttonState != Lib.Controls.SFButton.BUTTON_STATE_DISABLED && !this.isModalLockedOut())
      {
         this.mouseCaptured = false;
         this.setState(Lib.Controls.SFButton.BUTTON_STATE_UP);
      }
   }
   function enterHighlight()
   {
      if(this.buttonState != Lib.Controls.SFButton.BUTTON_STATE_DISABLED && !this.isModalLockedOut())
      {
         if(this.buttonState != Lib.Controls.SFButton.BUTTON_STATE_DOWN)
         {
            this.setState(Lib.Controls.SFButton.BUTTON_STATE_OVER);
            this.PlayHighlightSound();
         }
         this.Focus(true);
      }
   }
   function exitHighlight()
   {
      if(this.buttonState != Lib.Controls.SFButton.BUTTON_STATE_DISABLED && !this.isModalLockedOut())
      {
         this.setState(Lib.Controls.SFButton.BUTTON_STATE_UP);
         this.Focus(false);
      }
   }
   function isModalLockedOut()
   {
      if(_global.navManager != null)
      {
         if(_global.navManager.IsTopLayoutModal())
         {
            return this.navLayout == null || !_global.navManager.IsTopLayoutEqualTo(this.navLayout);
         }
      }
      return false;
   }
   static function initStatics()
   {
      Lib.Controls.SFButton.standardStateNames = ["Up","Over","Down","Disabled"];
      return true;
   }
   static function GetStateName(state)
   {
      return Lib.Controls.SFButton.standardStateNames[state];
   }
   static function InitBasics(object)
   {
      if(!Lib.Controls.SFButton.inittedPrototype)
      {
         Lib.Controls.SFText.AddSFTextBehaviorToPrototype(Lib.Controls.SFButton.prototype);
         Lib.Controls.SFButton.inittedPrototype = true;
      }
      object.__proto__ = Lib.Controls.SFButton.prototype;
      Lib.Controls.SFButton.prototype.isNavigable = function()
      {
         if(!this._visible)
         {
            return false;
         }
         if(this.buttonState == Lib.Controls.SFButton.BUTTON_STATE_DISABLED)
         {
            return false;
         }
         return true;
      };
      object.buttonState = Lib.Controls.SFButton.BUTTON_STATE_UP;
      object.mouseCaptured = false;
      object.keyHandler = new Object();
      Lib.NavLayout.AddKeyHandlersToObject({onDown:function(button, control, keycode)
      {
         if(button.buttonState != Lib.Controls.SFButton.BUTTON_STATE_DISABLED)
         {
            button.setState(Lib.Controls.SFButton.BUTTON_STATE_DOWN);
            button.PlayActionSound();
            button.Action();
         }
         return true;
      },onUp:function(button, control, keycode)
      {
         if(button.buttonState != Lib.Controls.SFButton.BUTTON_STATE_DISABLED)
         {
            if(button != undefined && button != null)
            {
               button.setState(Lib.Controls.SFButton.BUTTON_STATE_OVER);
            }
         }
         return true;
      }},object.keyHandler,"KEY_SPACE","KEY_ENTER","KEY_XBUTTON_A","KEY_XBUTTON_TRIGGER");
      object.CollectTextBoxes();
      if(object.objectToHighlightOnMouseFocus == undefined || object.objectToHighlightOnMouseFocus == null)
      {
         object.objectToHighlightOnMouseFocus = object;
      }
      if(object.actionSound == undefined)
      {
         object.actionSound = "ButtonAction";
      }
      if(object.highlightSound == undefined)
      {
         object.highlightSound = "ButtonRollover";
      }
   }
   static function InitAsSFButton(object, navLayout)
   {
      Lib.Controls.SFButton.InitBasics(object);
      object.setGfxState(Lib.Controls.SFButton.BUTTON_STATE_UP);
      if(navLayout != null && navLayout != undefined)
      {
         object.navLayout = navLayout;
      }
   }
   static function InitAsStandardSFButton(object, navLayout)
   {
      Lib.Controls.SFButton.InitBasics(object);
      object.setGfxStateArray = [function(movie)
      {
         movie.gotoAndStop("Up");
      },function(movie)
      {
         movie.gotoAndStop("Over");
      },function(movie)
      {
         movie.gotoAndStop("Down");
      },function(movie)
      {
         movie.gotoAndStop("Disabled");
      }];
      object.changeGfxStateArray = [function(movie)
      {
      },function(movie)
      {
         movie.gotoAndPlay("StartOver");
      },function(movie)
      {
         movie.gotoAndStop("Down");
      },function(movie)
      {
         movie.gotoAndStop("Disabled");
      },function(movie)
      {
         movie.gotoAndPlay("StartUp");
      },function(movie)
      {
      },function(movie)
      {
         movie.gotoAndStop("Down");
      },function(movie)
      {
         movie.gotoAndStop("Disabled");
      },function(movie)
      {
         movie.gotoAndStop("Up");
      },function(movie)
      {
         movie.gotoAndStop("Over");
      },function(movie)
      {
      },function(movie)
      {
         movie.gotoAndStop("Disabled");
      },function(movie)
      {
         movie.gotoAndPlay("Up");
      },function(movie)
      {
         movie.gotoAndPlay("StartOver");
      },function(movie)
      {
         movie.gotoAndPlay("Down");
      },function(movie)
      {
      }];
      object.setGfxState(Lib.Controls.SFButton.BUTTON_STATE_UP);
      if(navLayout != null && navLayout != undefined)
      {
         object.navLayout = navLayout;
      }
   }
}
