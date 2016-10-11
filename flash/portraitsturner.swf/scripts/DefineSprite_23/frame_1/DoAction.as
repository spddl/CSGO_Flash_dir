var t = 0;
var tf = Math.floor(Math.random() * 61) + 40;
var x0 = 0;
var x1 = Math.floor(Math.random() * 6) + 1;
var numLoop = 0;
onEnterFrame = function()
{
   this._rotation = (x0 - x1) * (Math.sin((t / tf - 0.5) * 3.141592653589793) + 1) / 2;
   t++;
};
