/**
 * draws an image to the console!
 * if either the width or the height is not defined, the console.log entry will be asynchronious
 *
 * @author JTBrinkmann
 * @license MIT License
 * @param {string} src       - url to the image (relative to the current page; data-URIs work too)
 * @param {int} [customWidth]  - width of the image
 * @param {int} [customHeight] - height of th eimage
 * @return {Object} jQuery Promise that resolves when the image is drawn
 */
console.logImg = function(src, customWidth, customHeight){
  var def, drawImage, x$;
  def = $.Deferred();
  drawImage = function(w, h){
    if (window.chrome) {
      console.log("%c\u200B", "color: transparent;line-height: " + h + "px;font-size: 1px;background: none,url(" + src + ");padding: " + h / 2 + "px " + w / 2 + "px");
    } else {
      console.log("%c", "background: url(" + src + ") no-repeat; display: block;width: " + w + "px; height: " + h + "px;");
    }
    def.resolve();
  };
  if (isFinite(customWidth) && isFinite(customHeight)) {
    drawImage(+customWidth, +customHeight);
  } else {
    x$ = new Image;
    x$.onload = function(){
      drawImage(this.width, this.height);
    };
    x$.onerror = function(){
      console.log("[couldn't load image %s]", src);
      def.reject();
    };
    x$.src = src;
  }
  return def.promise();
};