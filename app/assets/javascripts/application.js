//= require jquery3
//= require rails-ujs
//= require turbolinks
//= require popper
//= require bootstrap-sprockets
//= require_tree .
var Browser=new Object();
Browser.isMozilla=(typeof document.implementation!='undefined')&&(typeof document.implementation.createDocument!='undefined')&&(typeof HTMLDocument!='undefined');
Browser.isIE=window.ActiveXObject ? true : false;
Browser.isFirefox=(navigator.userAgent.toLowerCase().indexOf("firefox")!=-1);
Browser.isSafari=(navigator.userAgent.toLowerCase().indexOf("safari")!=-1);
Browser.isOpera=(navigator.userAgent.toLowerCase().indexOf("opera")!=-1);
Browser.isChrome = (navigator.userAgent.indexOf("Chrome") > -1);
$(document).on("turbolinks:load", function(){
  App.initUser();
})
function initCheck(){
  if(Browser.isFirefox || Browser.isChrome){
    App.initWeb3();
  }else{
    $('#title').text("What's this?!");
    $('#description').text("You can only play Million Block on a desktop browser like Chrome or Firefox.");
    $('#loginForm').hide();
  }
}
App = {
  web3Provider: null,
  contracts: {},

  checkNetwork: function(){
    var network = web3.version.network

    switch (network) {
      case "1":
      $('#description').text("This is mainnet.");
      break
      case "2":
      $('#description').text("This is the deprecated Morden test network.");
      break
      case "3":
      $('#description').text("This is the ropsten test network.");
      break
      case "4":
      return App.initContract();
      $('#description').text("This is the Rinkeby test network.");
      break
      case "42":
      $('#description').text("This is the Kovan test network.");
      break
      default:
      $('#description').text("This is an unknown network.");
    }
    $('#title').text("Oops, you’re on the wrong network, please choose the Rinkeby test network.");
    $('#loginForm').hide();

  },

  initWeb3: function() {
    if (typeof web3 !== 'undefined') {
      App.web3Provider = web3.currentProvider;
      web3 = new Web3(web3.currentProvider);
    } else {
      $('#title').text("What's this?!");
      $('#description').text("You’ll need a safe place to store all of your adorable Million Block! Please install MetaMask");
      $('#loginForm').hide();
      App.web3Provider = new web3.providers.HttpProvider('http://localhost:8545');
      web3 = new Web3(App.web3Provider);
    }
    return App.checkNetwork();
  },

  login: function(ads){
    console.log(ads);
    $.ajax({
      url: "check?user="+ads,
      dataType: "json",
      success: function(data){
        if (data.result == 1){
          alert(data.message);
        }else{
          window.location.href = "signin";
        }
      }
    });
  },
  initUser: function() {
    App.login(web3.eth.accounts[0]);
  }
}