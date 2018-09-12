// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

// let poolInterval = 30000;

// function poolVersion(el, url) {
//   fetch(url)
//     .then(function cluster_call(res) {
//       console.log(res);
//       el.innerHTML = res.response.version;
//     })
//     .catch(function error(err) {
//       console.error(err);
//     });
// }

// function replace_version(el) {
//   var url = el.getAttribute("data-url");
//   el.innerHTML = "...";

//   poolVersion(el, url);
//   setInterval(poolInterval, function tick() {
//     poolVersion(el, url);
//   });
// }

// document.addEventListener("DOMContentLoaded", function () {
//   let els = document.getElementsByClassName("cluster-version");

//   for(let i = 0; i < els.length; i++) {
//     let el = els[i];
//     replace_version(el);
//   }
// });
