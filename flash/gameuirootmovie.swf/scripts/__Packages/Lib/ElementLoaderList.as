class Lib.ElementLoaderList
{
   var loadingElements = new Array();
   function ElementLoaderList()
   {
   }
   function AddLoader(cl)
   {
      this.loadingElements.push(cl);
   }
   function RemoveLoader(cl)
   {
      var _loc2_ = 0;
      var _loc3_ = this.loadingElements.length - 1;
      while(_loc2_ <= _loc3_)
      {
         if(this.loadingElements[_loc2_] == cl)
         {
            if(_loc2_ == _loc3_)
            {
               this.loadingElements.length = _loc3_;
            }
            else if(_loc2_ == 0)
            {
               this.loadingElements.shift();
            }
            else
            {
               this.loadingElements = this.loadingElements.slice(0,_loc2_).concat(this.loadingElements.slice(_loc2_ + 1,_loc3_ + 1));
            }
            break;
         }
         _loc2_ = _loc2_ + 1;
      }
   }
   static function Init()
   {
      if(_global.elementLoaderList == null)
      {
         _global.elementLoaderList = new Lib.ElementLoaderList();
      }
   }
}
