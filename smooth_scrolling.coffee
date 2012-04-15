scrolloffset = 0
scrolltiming = 1000

$(document).ready(->
    filterPath = (string) ->
        string.replace(/^\//,'')
        .replace(/(index|default).[a-zA-Z]{3,4}$/,'')
        .replace(/\/$/,'')
        
        return string

    locationPath = filterPath(location.pathname)
    scrollElem = scrollableElement('html', 'body')
    
    $('a[href*=#]').each(->
        thisPath = filterPath(this.pathname) or locationPath
        
        if( locationPath is thisPath and (location.hostname is this.hostname or !this.hostname) and this.hash.replace(/#/,''))
            $target = $(this.hash) 
            target = this.hash
            if(target)
                targetOffset = $target.offset().top-scrolloffset
                
                $(this).click((event) ->
                    console.log("Click", scrollElem)
                    event.preventDefault()
                    $(scrollElem).animate({
                        scrollTop: targetOffset
                    }, scrolltiming, ->
                        location.hash = target;
                        )
                )
        
    )
)

scrollableElement = (els) ->
    for i in arguments
        el = arguments[_i]
        $scrollElement = $(el)
        if($scrollElement.scrollTop()>0)
            return el
        else
            $scrollElement.scrollTop(1)
            isScrollable = $scrollElement.scrollTop()> 0
            $scrollElement.scrollTop(0)
            if isScrollable
                return el
    return []






