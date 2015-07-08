// ar-mainpage.js: main page directive
// Standard formatting for a page with a sidebar.
angular.module("arachne")
.directive("arMainpage", function() {
    return {
        restrict: "E",
        templateUrl: "templates/directives/ar-mainpage.html",
        transclude: true,
        scope: {
            sidebar: "@"  // The sidebar template's URL
        }
    };
});