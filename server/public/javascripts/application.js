// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// Element render functions

function show_spinner(name) {
    Element.show('loading_' + name + '_spinner');
}

function hide_spinner(name) {
    Element.hide('loading_' + name + '_spinner');
}

// Checks whether an element is scrolled into view
function isScrolledIntoView(el) {
    var elemOffTop = $(el).offsetTop;
    var elemOffLeft = $(el).offsetLeft;

    var elemHeight = $(el).getHeight();

    var sOffTop = document.viewport.getScrollOffsets().top;
    var sHeight = document.viewport.getHeight();

    return((sOffTop + sHeight > elemOffTop) && (sOffTop <= elemOffTop + elemHeight));
}