// Change color scheme to dark/light
var colorTheme = Cookies.get('color_theme');
if (colorTheme == undefined) {
  if (window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches) {
    $('body').addClass('dark');
  } else {
    $('body').removeClass('dark');
  }
} else if (colorTheme == 'dark') {
  $('body').addClass('dark');
}

$(document).on('click', '.dark-light-switcher', function () {
  if ($('body').hasClass('dark')) {
    $('body').removeClass('dark');
    var colorTheme = 'light'
  } else {
    $('body').addClass('dark');
    var colorTheme = 'dark'
  }
  Cookies.set('color_theme', colorTheme, { expires: 1 });
  return false;
});

$(document).on('click', '.nav-link[role=tab]', function () {
  var currentTab = $('.nav-link.active').attr('id')
  Cookies.set('opened_details_sidebar_tab', currentTab);
  return false;
});

$('#bot-selector').on('change', function() {
  Cookies.set('current_bot', this.value);
  return false;
});

function setActiveTab() {
  var detailsSidebarTab = Cookies.get('opened_details_sidebar_tab');
  var tab = document.getElementById(detailsSidebarTab)

  if (tab) { tab.click() }
}

function setActiveBot() {
  var currentBot = Cookies.get('current_bot');

  if (currentBot) { $('#bot-selector').val(currentBot).change() }
}

$(document).ready(function() {
  setActiveTab();
  setActiveBot();
});
