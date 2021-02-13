// Generated by ReScript, PLEASE EDIT WITH CARE

import * as React from "react";
import * as Belt_Array from "bs-platform/lib/es6/belt_Array.mjs";
import * as Belt_MapString from "bs-platform/lib/es6/belt_MapString.mjs";
import * as RecipeList$RescriptReactIntro from "./RecipeList.bs.js";

function AllTags(Props) {
  var tags = Props.tags;
  var tagComponents = Belt_Array.map(Belt_MapString.toArray(tags), (function (param) {
          var tag = param[0];
          return React.createElement("div", {
                      key: tag
                    }, React.createElement("h2", undefined, tag), React.createElement(RecipeList$RescriptReactIntro.make, {
                          recipes: param[1]
                        }));
        }));
  return React.createElement("div", undefined, tagComponents);
}

var make = AllTags;

export {
  make ,
  
}
/* react Not a pure module */
