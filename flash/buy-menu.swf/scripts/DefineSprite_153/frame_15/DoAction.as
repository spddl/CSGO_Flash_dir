if(_global.BuyMenu.removeAfterHiding)
{
   trace("******* removing buy menu");
   _global.BuyMenu.removeAfterHiding = false;
   _global.RemoveElement(_global.BuyMenu);
}
stop();
this._visible = false;
