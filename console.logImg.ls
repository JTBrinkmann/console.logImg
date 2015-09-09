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
console.logImg = (src, customWidth, customHeight) !->
    def = $.Deferred!
    drawImage = (w, h) !->
        if window.chrome
            console.log "%c\u200B", "color: transparent;
                line-height: #{h}px;
                font-size: 1px;
                background: none,url(#src);
                padding: #{h / 2}px #{w / 2}px
            "
            # using `background: none,` to bypass a restriction in Chrome (added somewhere between v25 and v35) not allowing CSS values to start with `url(`
        else # apparently this once worked in Firefox
            console.log "%c", "background: url(#src) no-repeat; display: block;
                width: #{w}px; height: #{h}px;
            "
        def.resolve!
    if isFinite(customWidth) and isFinite(customHeight)
        drawImage(+customWidth, +customHeight)
    else
        new Image
            ..onload = !->
                drawImage(@width, @height)
            ..onerror = !->
                console.log "[couldn't load image %s]", src
                def.reject!
            ..src = src
    return def.promise!