/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "/packs/";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 195);
/******/ })
/************************************************************************/
/******/ ({

/***/ 195:
/*!***********************************************************!*\
  !*** ./app/javascript/packs/components/intro/validate.js ***!
  \***********************************************************/
/*! exports provided: default */
/*! all exports used */
/***/ (function(module, __webpack_exports__, __webpack_require__) {

"use strict";
eval("Object.defineProperty(__webpack_exports__, \"__esModule\", { value: true });\nconst validate = values => {\n  const errors = {};\n  if (!values.full_street_address) {\n    errors.full_street_address = 'Required';\n  }\n  if (!values.local) {\n    errors.local = 'Required';\n  }\n  if (!values.birthday) {\n    errors.birthday = 'Required';\n  }\n  if (!values.country) {\n    errors.country = 'Required';\n  }\n  if (!values.phone) {\n    errors.phone = 'Required';\n  }\n  if (!values.education) {\n    errors.education = 'Required';\n  }\n  if (!values.job) {\n    errors.job = 'Required';\n  }\n  if (!values.avatar) {\n    errors.avatar = 'Required';\n  }\n\n  return errors;\n};\n\n/* harmony default export */ __webpack_exports__[\"default\"] = (validate);//# sourceURL=[module]\n//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiMTk1LmpzIiwic291cmNlcyI6WyJ3ZWJwYWNrOi8vLy4vYXBwL2phdmFzY3JpcHQvcGFja3MvY29tcG9uZW50cy9pbnRyby92YWxpZGF0ZS5qcz8zZTcyIl0sInNvdXJjZXNDb250ZW50IjpbImNvbnN0IHZhbGlkYXRlID0gdmFsdWVzID0+IHtcbiAgY29uc3QgZXJyb3JzID0ge307XG4gIGlmICghdmFsdWVzLmZ1bGxfc3RyZWV0X2FkZHJlc3MpIHtcbiAgICBlcnJvcnMuZnVsbF9zdHJlZXRfYWRkcmVzcyA9ICdSZXF1aXJlZCc7XG4gIH1cbiAgaWYgKCF2YWx1ZXMubG9jYWwpIHtcbiAgICBlcnJvcnMubG9jYWwgPSAnUmVxdWlyZWQnO1xuICB9XG4gIGlmICghdmFsdWVzLmJpcnRoZGF5KSB7XG4gICAgZXJyb3JzLmJpcnRoZGF5ID0gJ1JlcXVpcmVkJztcbiAgfVxuICBpZiAoIXZhbHVlcy5jb3VudHJ5KSB7XG4gICAgZXJyb3JzLmNvdW50cnkgPSAnUmVxdWlyZWQnO1xuICB9XG4gIGlmICghdmFsdWVzLnBob25lKSB7XG4gICAgZXJyb3JzLnBob25lID0gJ1JlcXVpcmVkJztcbiAgfVxuICBpZiAoIXZhbHVlcy5lZHVjYXRpb24pIHtcbiAgICBlcnJvcnMuZWR1Y2F0aW9uID0gJ1JlcXVpcmVkJztcbiAgfVxuICBpZiAoIXZhbHVlcy5qb2IpIHtcbiAgICBlcnJvcnMuam9iID0gJ1JlcXVpcmVkJztcbiAgfVxuICBpZiAoIXZhbHVlcy5hdmF0YXIpIHtcbiAgICBlcnJvcnMuYXZhdGFyID0gJ1JlcXVpcmVkJztcbiAgfVxuXG4gIHJldHVybiBlcnJvcnM7XG59O1xuXG5leHBvcnQgZGVmYXVsdCB2YWxpZGF0ZTtcblxuXG4vLy8vLy8vLy8vLy8vLy8vLy9cbi8vIFdFQlBBQ0sgRk9PVEVSXG4vLyAuL2FwcC9qYXZhc2NyaXB0L3BhY2tzL2NvbXBvbmVudHMvaW50cm8vdmFsaWRhdGUuanNcbi8vIG1vZHVsZSBpZCA9IDE5NVxuLy8gbW9kdWxlIGNodW5rcyA9IDAgMSAyIDQgNSA3IDExIDEyIDMwIl0sIm1hcHBpbmdzIjoiQUFBQTtBQUFBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBO0FBQ0E7QUFDQTtBQUNBIiwic291cmNlUm9vdCI6IiJ9\n//# sourceURL=webpack-internal:///195\n");

/***/ })

/******/ });