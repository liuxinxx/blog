//= require jquery
//= require jquery_ujs
//= require jquery.tagsinput
//= require bootstrap-sprockets
//= require turbolinks
//= require bootstrap
//= require_tree .
$(document).on("turbolinks:load", function() {
 
})

// function initCheck() {
//   if (Browser.isFirefox || Browser.isChrome) {
//     App.initWeb3();
//   } else {
//     console.log("You can only play Million Block on a desktop browser like Chrome or Firefox.");
//   }
// }
// App = {
//   web3Provider: null,
//   contracts: {},

//   checkNetwork: function() {
//     var network = web3.version.network

//     switch (network) {
//       case "1":
//         console.log("This is mainnet.");
//         break
//       case "2":
//         console.log("This is the deprecated Morden test network.");
//         break
//       case "3":
//         console.log("This is the ropsten test network.");
//         break
//       case "4":
//         console.log("This is the Rinkeby test network.");
//         return App.initContract();
//         break
//       case "42":
//         console.log("This is the Kovan test network.");
//         break
//       default:
//         console.log("This is an unknown network.");
//     }
//     console.log("Oops, you’re on the wrong network, please choose the Rinkeby test network.");

//   },

//   initWeb3: function() {
//     if (typeof web3 !== 'undefined') {
//       App.web3Provider = web3.currentProvider;
//       web3 = new Web3(web3.currentProvider);
//     } else {
//       console.log("You’ll need a safe place to store all of your adorable Million Block! Please install MetaMask");
//       App.web3Provider = new web3.providers.HttpProvider('http://localhost:8545');
//       web3 = new Web3(App.web3Provider);
//     }
//     return App.checkNetwork();
//   },

//   login: function(ads) {
//     console.log(ads);
//     $.ajax({
//       url: "/check?user=" + ads,
//       dataType: "json",
//       success: function(data) {
//         if (data.result == 1) {
//           console.log(data.message);
//         } else {
//           console.log("This user is not an administrator!" + data.message);
//         }
//       }
//     });
//   },
//   initUser: function() {
//     if (web3.eth.accounts[0] == undefined) {
//       console.log("Your MetaMask is locked");
//     } else {
//       App.log in(web3.eth.accounts[0]);
//     };
//   }
// }