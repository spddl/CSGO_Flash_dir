if(_global.OptionsMovie.bShowResize == true)
{
   _global.OptionsMovie.ResizeTop._visible = true;
   _global.OptionsMovie.ResizeTop.gotoAndPlay("StartShow");
}
else
{
   _global.RemoveElement(_global.OptionsMovie);
}
stop();
