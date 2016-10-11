if(_global.SettingsMovie.IsResizeScreen == true)
{
   trace("show screen resize!");
   trace(_global.SettingsMovie.ResizeTop._visible);
   _global.SettingsMovie.ResizeTop._visible = true;
   _global.SettingsMovie.ResizeTop.gotoAndPlay("StartShow");
}
else
{
   _global.RemoveElement(_global.ControlsMovie);
}
stop();
