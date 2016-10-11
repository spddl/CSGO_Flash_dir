class Lib.ElementLoader
{
   function ElementLoader()
   {
   }
   function onLoadComplete(mc)
   {
      mc.gameAPI = this.gameAPI;
      mc.elementName = this.elementName;
      mc.elementLevel = this.elementLevel;
      this.movieClip = mc;
   }
   function onLoadInit(mc)
   {
      this.gameAPI.OnLoadFinished(this.movieClip,_global.UISlot);
      _global.elementLoaderList.RemoveLoader(this);
      mc.onLoaded();
   }
   function onLoadProgress(mc, loadedBytes, totalBytes)
   {
      this.gameAPI.OnLoadProgress(mc,loadedBytes,totalBytes);
   }
   function onLoadError(mc, errorCode)
   {
      this.gameAPI.OnLoadError(mc,errorCode);
      _global.elementLoaderList.RemoveLoader(this);
   }
}
